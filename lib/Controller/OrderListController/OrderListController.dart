import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultResponseModel/DefaultResponseModel.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultSendModel/DefaultHeaderSendModel.dart';
import 'package:go_potu_user/Models/ResponseModels/CancelReasonListResponseModel/CancelReasonListResponseModel.dart';
import 'package:go_potu_user/Models/ResponseModels/GetOrderDetailsResponseModel/GetOrderDetailsResponseModel.dart';
import 'package:go_potu_user/Models/ResponseModels/OrderListResponseModel/OrderListResponseModel.dart';
import 'package:go_potu_user/Models/SendModels/CancelOrderSendModel/CancelOrderSendModel.dart';
import 'package:go_potu_user/Models/SendModels/GetOrderDetailsSendModel/GetOrderDetailsSendModel.dart';
import 'package:go_potu_user/Models/SendModels/GetOrderFilterSendModel/GetOrderFilterSendModel.dart';
import 'package:go_potu_user/Models/SendModels/OnlinePaymentSendModel/OnlinePaymentSendModel.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Views/OrdersScreen/CancelOrderScreen.dart';
import 'package:go_potu_user/Views/OrdersScreen/PaytmWebViewScreen.dart';
import '../../Models/ResponseModels/ReturnRefundDetailsResponseModel/ReturnRefundDetailsResponseModel.dart';
import '../../Models/SendModels/ReturnRefundDetailsSendModel/ReturnRefundDetailsSendModel.dart';

class OrderListController extends GetxController {
  var advertisementBanner = AdvertisementBanner().obs;
  var orderList = <Order>[].obs;
  var orderId = "".obs;
  var orderDetailsData = OrderDetailsData().obs;
  TextEditingController? rejectionReasonController;
  var cancelReasonList = <Reason>[].obs;
  var cancelReason = "Got better price from somewhere else".obs;
  var isLoading = true.obs;
  var returnRefundDetailsData = Returnreplace().obs;
  var time = 0.obs;
  var returnRefundId = "".obs;
  var isDetailsLoading = true.obs;
  var secondsEstimated = 0.obs;
  var secondRemaining = 0.obs;
  var initialPosition = 0.obs;
  var isTimeApiDone = true.obs;
  var onDelay = "".obs;
  var loaderLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    rejectionReasonController = TextEditingController();
  }

  getOrderListPress(bool isLoader, String statusText) {
    getOrderListAPICall(isLoader, statusText).then((result) async {
      if (result is OrderListResponseModel) {
        if (result.status == "success") {
          isLoading.value = false;
          orderList.assignAll(result.data!.orders!);
        } else {
          isLoading.value = false;
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

  getOrderListAPICall(bool loader, String typeText) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      //guestToken: HiveStore().get(Keys.guestToken),
    );
    GetOrderFilterSendModel model = GetOrderFilterSendModel(
      status: typeText,
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      baseURL: baseUrl,
      method: METHOD.POST,
      loader: loader,
      body: model.toJson(),
      endpoint: orderListUrl,
    );
    return OrderListResponseModel.fromJson(result);
  }

  Future<void> getOrderDetailsPress(bool loader) async {
    // orderDetailsData.value.payableAmount = null;
    return getOrderDetailsAPICall(loader).then((result) async {
      if (result is GetOrderDetailsResponseModel) {
        if (result.status == "success") {
          loaderLoading.value = false;
          orderDetailsData.value = result.data!.order!;
          // advertisementBanner.value = result.data!.adv_banners!;
          getCancelReasonListPress(false);
        } else {
          loaderLoading.value = false;
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

  getOrderDetailsAPICall(bool load) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      //guestToken: HiveStore().get(Keys.guestToken),
    );

    GetOrderDetailsSendModel model =
        GetOrderDetailsSendModel(orderId: orderId.value);

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      baseURL: baseUrl,
      loader: load,
      body: model.toJson(),
      method: METHOD.POST,
      endpoint: orderDetailsUrl,
    );
    return GetOrderDetailsResponseModel.fromJson(result);
  }

  Future<void> getOrderTimeDetailsPress(bool loader) async {
    return getOrderTimeDetailsAPICall(loader).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          isTimeApiDone.value = false;
          secondRemaining.value = result.data['seconds_estimated'];
          secondsEstimated.value = result.data['seconds_remaining'];
          initialPosition.value = secondsEstimated.value;
          onDelay.value = result.data['deliverystatus_text'];

          /*==================================*/
          //Ata bhul kore ulto lagano ache. kintu kaj thik korchilo bole r change kora hoini. jodi remainingsecond
          // kaj korte chas tahole secondEstimated variable ta nia kaj korte habe and viseversa.
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

  getOrderTimeDetailsAPICall(bool load) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      //guestToken: HiveStore().get(Keys.guestToken),
    );

    GetOrderDetailsSendModel model =
        GetOrderDetailsSendModel(orderId: orderId.value);

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      baseURL: baseUrl,
      loader: load,
      body: model.toJson(),
      method: METHOD.POST,
      endpoint: getOrderTimeDetailsUrl,
    );
    return DefaultResponseModel.fromJson(result);
  }

  makeOrderInOnlinePress(String orderId) {
    makeOrderInOnlineApiCall(orderId).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          //PaytmConfig().generateTxnToken(double.parse(result.data['paytm_document']['amount']), result.data['paytm_document']['order_id'],);
          Get.to(PaytmWebViewScreen(
            paymentUrl: result.data['paytm_document']['payment_url'].toString(),
            successUrl: result.data['paytm_document']['success_url'].toString(),
            failedUrl: result.data['paytm_document']['failed_url'].toString(),
            orderCode: result.data['order']['code'],
          ));
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

  makeOrderInOnlineApiCall(String orderId) async {
    OnlinePaymentSendModel model = OnlinePaymentSendModel(orderId: orderId);

    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      //guestToken: HiveStore().get(Keys.guestToken),
    );

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: initiatePaymentUrl,
    );
    return DefaultResponseModel.fromJson(result);
  }

  cancelOrderPress(String orderId) {
    cancelOrderApiCall(orderId).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          rejectionReasonController?.text = "";
          getOrderDetailsPress(false);
          Get.to(CancelOrderSuccessScreen());
          // Get.snackbar("Success", result.message,
          //     backgroundColor: AppColors.secondary,
          //     duration: Duration(seconds: 1),
          //     icon: Icon(
          //       Icons.done,
          //       color: Colors.greenAccent,
          //     ));
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

  cancelOrderApiCall(String orderId) async {
    CancelOrderSendModel model = CancelOrderSendModel(
      orderId: orderId,
      cancelReason: cancelReason.value,
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
      endpoint: cancelOrderUrl,
    );
    return DefaultResponseModel.fromJson(result);
  }

  getCancelReasonListPress(bool isLoader) {
    getCancelReasonListApiCall(isLoader).then((result) async {
      if (result is CancelReasonListResponseModel) {
        if (result.status == "success") {
          cancelReasonList.assignAll(result.data!.reasons!);
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

  getCancelReasonListApiCall(bool loader) async {
    var result = await CoreService().apiService(
      baseURL: baseUrl,
      method: METHOD.POST,
      loader: loader,
      endpoint: fetchCancelReasonListUrl,
    );
    return CancelReasonListResponseModel.fromJson(result);
  }

  getReturnRefundDetailsPress(bool isLoader) {
    getReturnRefundDetailsAPICall(isLoader).then((result) async {
      if (result is ReturnRefundDetailsResponseModel) {
        if (result.status == "success") {
          isDetailsLoading.value = false;
          returnRefundDetailsData.value = result.data!.returnreplace!;
        } else {
          isDetailsLoading.value = false;
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

  getReturnRefundDetailsAPICall(bool loader) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      //guestToken: HiveStore().get(Keys.guestToken),
    );

    ReturnRefundDetailsSendModel model =
        ReturnRefundDetailsSendModel(returnreplacementId: returnRefundId.value);

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      baseURL: baseUrl,
      method: METHOD.POST,
      loader: loader,
      body: model.toJson(),
      endpoint: reurnDetailsUrl,
    );
    return ReturnRefundDetailsResponseModel.fromJson(result);
  }
}

