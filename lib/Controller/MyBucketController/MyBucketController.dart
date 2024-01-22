import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddToCartController/AddToCartController.dart';
import 'package:go_potu_user/Controller/MyBucketController/TipsSendModel.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultResponseModel/DefaultResponseModel.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultSendModel/DefaultHeaderSendModel.dart';
import 'package:go_potu_user/Models/ResponseModels/GetMyBucketResponseModel/GetMyBucketResponseModel.dart';
import 'package:go_potu_user/Models/SendModels/AddToCartSendModel/AddToCartSendModel.dart';
import 'package:go_potu_user/Models/SendModels/ApplyCouponSendModel/ApplyCouponSendModel.dart';
import 'package:go_potu_user/Models/SendModels/CartCallBackSendModel/CartCallBackSendModel.dart';
import 'package:go_potu_user/Models/SendModels/GetMyBucketSendModel/GetMyBucketSendModel.dart';
import 'package:go_potu_user/Models/SendModels/MakeFinalOrderSendModel/MakeFinalOrderSendModel.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ScopeStorage.dart';
import 'package:go_potu_user/Store/ShareStore.dart';
import 'package:go_potu_user/Views/CartScreen/OrderPlacedScreen.dart';
import 'package:go_potu_user/Views/OrdersScreen/PaytmWebViewScreen.dart';
import 'package:go_potu_user/Widgets/CartWidgets/CustomDialog.dart';

import '../../DeviceManager/Assets.dart';
import '../../DeviceManager/ScreenConstants.dart';

class MyBucketController extends GetxController {
  var myBucketData = BucketData().obs;
  var successOrderCode = "".obs;
  var notAvailable = false.obs;
  var isStoreDetails = false.obs;
  var subCategoryProductList = false.obs;
  var productDetails = false.obs;
  var paymentMode = "cash".obs;
  var applyCouponCode = "".obs;
  var successOrderId = "".obs;
  TextEditingController thisController = TextEditingController();
  TextEditingController tips = TextEditingController();
  BuildContext? context;
  var walletUsed = false.obs;
  var isCouponApply = false.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    //getBucketPress(true);
    super.onInit();
  }

  Future<void> storeSelectedTip(int selectedTip) async {
    // Create a model for your API request
    TipsSendModel model = TipsSendModel(
      tips: selectedTip,
      type: "your_type_value", // Replace with the actual type value
    );

    // Create a header model
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      guestToken: HiveStore().get(Keys.guestToken),
    );

    // Call the API to store the selected tip
    var result = await CoreService().apiService(
      body: model.toJson(),
      header: headerModel.toHeader(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: fetchCartList,
    );

    // Handle the API response as needed
    if (result is DefaultResponseModel) {
      if (result.status == "success") {
        print("Tip stored successfully!");
      } else {
        print("Error storing tip: ${result.message}");
      }
    }
  }

  getBucketPress(bool isLoader, String couponCodeValue) {
    getBucketAPICall(isLoader, couponCodeValue).then((result) async {
      if (result is GetMyBucketResponseModel) {
        if (result.status == "success") {
          isLoading.value = false;
          myBucketData.value = result.data!;
          notAvailable.value = false;
        } else {
          isLoading.value = false;
          myBucketData.value = result.data!;
          notAvailable.value = true;
        }
      }
    });
  }

  getBucketAPICall(bool loader, String couponCodeValue) async {
    GetMyBucketSendModel model = GetMyBucketSendModel(
      type: ShareStore().getData(store: KeyStore.type) == null
          ? HiveStore().get(Keys.shopType)
          : ShareStore().getData(store: KeyStore.type),
      couponCode: couponCodeValue,
      walletUse: walletUsed.value.toString(),
    );

    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      guestToken: HiveStore().get(Keys.guestToken),
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      loader: loader,
      endpoint: fetchCartList,
    );
    return GetMyBucketResponseModel.fromJson(result);
  }

  addToCartPress(String shopId, String variantId, String quantity) {
    addToCartPressApiCall(shopId, variantId, quantity).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          getBucketPress(false, applyCouponCode.value);
          final AddToCartController addToCartController = Get.find();
          addToCartController.fetchCartCountPress(false);
        } else {
          Get.snackbar(
            "Sorry!",
            result.message!,
            backgroundColor: AppColors.secondary,
            duration: Duration(seconds: 1),
            icon: Icon(
              Icons.error_outline_sharp,
              color: Colors.red,
            ),
            titleText: Text(
              "Sorry!",
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the title
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              result.message!,
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the message
              ),
            ),
          );
        }
      }
    });
  }

  addToCartPressApiCall(
      String shopId, String variantId, String quantity) async {
    AddToCartSendModel model = AddToCartSendModel(
      quantity: quantity,
      shopId: shopId,
      type: ShareStore().getData(store: KeyStore.type) == null
          ? HiveStore().get(Keys.shopType)
          : ShareStore().getData(store: KeyStore.type),
      variantId: variantId,
    );
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      guestToken: HiveStore().get(Keys.guestToken),
    );

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      body: model.toJson(),
      loader: true,
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: addToCart,
    );
    return DefaultResponseModel.fromJson(result);
  }

  makeOrderInCashPress(String shopId, String addressId, String couponCode) {
    makeOrderInCashApiCall(shopId, addressId, couponCode).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          walletUsed.value = false;
          successOrderCode.value = result.data['order']['code'];
          Get.offAll(OrderPlacedScreen(
            oderId: successOrderCode.value,
          ));
        } else {
          Get.snackbar(
            "Sorry!",
            result.message!,
            backgroundColor: AppColors.secondary,
            duration: Duration(seconds: 1),
            icon: Icon(
              Icons.error_outline_sharp,
              color: Colors.red,
            ),
            titleText: Text(
              "Sorry!",
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the title
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              result.message!,
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the message
              ),
            ),
          );
        }
      }
    });
  }

  makeOrderInCashApiCall(
      String shopId, String addressId, String couponCode) async {
    MakeFinalOrderSendModel model = MakeFinalOrderSendModel(
      shopId: shopId,
      type: ShareStore().getData(store: KeyStore.type) == null
          ? HiveStore().get(Keys.shopType)
          : ShareStore().getData(store: KeyStore.type),
      addressId: addressId,
      paymentMode: "cash",
      couponCode: couponCode,
      walletUse: walletUsed.value.toString(),
    );
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      //guestToken: HiveStore().get(Keys.guestToken),
    );

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: makeFinalOrderUrl,
    );
    return DefaultResponseModel.fromJson(result);
  }

  makeOrderInOnlinePress(String shopId, String addressId) {
    makeOrderInOnlineApiCall(shopId, addressId).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "paymentinitiated") {
          successOrderCode.value = result.data['order']['code'];
          successOrderId.value = result.data['order']['id'].toString();
          walletUsed.value = false;
          Get.to(PaytmWebViewScreen(
            paymentUrl: result.data['paytm_document']['payment_url'].toString(),
            successUrl: result.data['paytm_document']['success_url'].toString(),
            failedUrl: result.data['paytm_document']['failed_url'].toString(),
            orderCode: result.data['order']['code'],
          ));
          /*UrlLauncher.launch(
              result.data['paytm_document']['payment_url'].toString());*/
          //PaytmConfig().generateTxnToken(double.parse(result.data['paytm_document']['amount']), result.data['paytm_document']['order_id'],);
          /*PaytmConfig().initiateTransaction(
              result.data['paytm_document']['order_id'],
              double.parse(result.data['paytm_document']['amount']),
              result.data['paytm_document']['txn_token'],
              result.data['paytm_document']['callbackurl'].toString(),
              result.data['paytm_document']['merchant_id']);*/
          //;
        } else {
          Get.snackbar(
            "Sorry!",
            result.message!,
            backgroundColor: AppColors.secondary,
            duration: Duration(seconds: 1),
            icon: Icon(
              Icons.error_outline_sharp,
              color: Colors.red,
            ),
            titleText: Text(
              "Sorry!",
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the title
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              result.message!,
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the message
              ),
            ),
          );
        }
      }
    });
  }

  makeOrderInOnlineApiCall(String shopId, String addressId) async {
    MakeFinalOrderSendModel model = MakeFinalOrderSendModel(
      shopId: shopId,
      type: ShareStore().getData(store: KeyStore.type).isBlank == null
          ? HiveStore().get(Keys.shopType)
          : ShareStore().getData(store: KeyStore.type),
      addressId: addressId,
      paymentMode: "online",
      couponCode: "",
      walletUse: walletUsed.value.toString(),
    );
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      //guestToken: HiveStore().get(Keys.guestToken),
    );

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: makeFinalOrderUrl,
    );
    return DefaultResponseModel.fromJson(result);
  }

  applyCouponPress(String couponCode) {
    applyCouponApiCall(couponCode).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          isCouponApply.value = true;
          thisController.text = "";
          applyCouponCode.value = couponCode.toString();
          Get.back();
          getBucketPress(false, applyCouponCode.value);
          showDialog(
              context: context!,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "${result.data['coupon_details']['code']} applied",
                  descriptions:
                      "You Saved Rs.${double.parse(result.data['coupon_discount'].toString()).toStringAsFixed(2)}",
                  text: "with this promo code",
                );
              });
        } else {
          Get.snackbar(
            "Sorry!",
            result.message!,
            backgroundColor: AppColors.secondary,
            duration: Duration(seconds: 1),
            icon: Icon(
              Icons.error_outline_sharp,
              color: Colors.red,
            ),
            titleText: Text(
              "Sorry!",
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the title
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              result.message!,
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the message
              ),
            ),
          );
        }
      }
    });
  }

  applyCouponApiCall(String couponCode) async {
    ApplyCouponSendModel model = ApplyCouponSendModel(
      type: ShareStore().getData(store: KeyStore.type) == null
          ? HiveStore().get(Keys.shopType)
          : ShareStore().getData(store: KeyStore.type),
      couponCode: couponCode,
    );
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      //guestToken: HiveStore().get(Keys.guestToken),
    );

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: applyCouponUrl,
    );
    return DefaultResponseModel.fromJson(result);
  }

  cartCallBackPress() {
    cartCallBackApiCall().then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          print("Success");
          Get.offAll(OrderPlacedScreen(
            oderId: successOrderCode.toString(),
          ));
        } else {
          Get.snackbar(
            "Sorry!",
            result.message!,
            backgroundColor: AppColors.secondary,
            duration: Duration(seconds: 1),
            icon: Icon(
              Icons.error_outline_sharp,
              color: Colors.red,
            ),
            titleText: Text(
              "Sorry!",
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the title
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              result.message!,
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the message
              ),
            ),
          );
        }
      }
    });
  }

  cartCallBackApiCall() async {
    CartCallBackSendModel model =
        CartCallBackSendModel(orderId: successOrderId.value);
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      //guestToken: HiveStore().get(Keys.guestToken),
    );

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: cartCallBackUrl,
    );
    return DefaultResponseModel.fromJson(result);
  }
}
