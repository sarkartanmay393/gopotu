import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/ProductController/ProductController.dart';
import 'package:go_potu_user/Controller/StoreController/StoreController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultResponseModel/DefaultResponseModel.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultSendModel/DefaultHeaderSendModel.dart';
import 'package:go_potu_user/Models/ResponseModels/FetchCartCountResponseModel/FetchCartCountResponseModel.dart';
import 'package:go_potu_user/Models/SendModels/AddToCartSendModel/AddToCartSendModel.dart';
import 'package:go_potu_user/Models/SendModels/FetchCartCountSendModel/FetchCartCountSendModel.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ScopeStorage.dart';
import 'package:go_potu_user/Store/ShareStore.dart';

import '../../DeviceManager/Assets.dart';

class AddToCartController extends GetxController {
  var isCart = false.obs;
  var isStore = false.obs;
  var isProductDetails = false.obs;
  var isProductDetailsAdd = false.obs;
// Your existing variant ID

  // New properties for selected variant

  String selectedVariantId = '';
  double selectedPrice = 0.0;
  var variantType = "".obs;
  var variantOption = "".obs;
  var colorOption = "".obs;

  var cartCount = "".obs;
  var cartTotal = "".obs;
  var isStrictConfirm = false.obs;
  var shopId = "".obs;
  var variantId = "".obs;


  @override
  void onInit() {
    // TODO: implement onInit
    fetchCartCountPress(false);
    super.onInit();
  }

  addToCartPress(String quantity, BuildContext context) {
    addToCartPressApiCall(quantity).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          isStrictConfirm.value = false;
          shopId.value = "";
          variantId.value = "";
          if (isStore.value) {
            print("If statement");
            StoreController storeController = Get.find();
            storeController.storeDetailsPress(false);
            isStore.value = false;
          } else if (isProductDetails.value) {
            print("Else If 1 statement");
            ProductController productController = Get.find();
            Future.delayed(Duration(milliseconds: 500), () {
              productController.productDetailsPress(false);
            });
            isProductDetails.value = false;
          } else if (isProductDetailsAdd.value) {
            print("Else If 2 statement");
            ProductController productController = Get.find();
            productController.productVariantDetailsPress(variantType.value,
                variantOption.value, colorOption.value, false);
            isProductDetailsAdd.value = false;
          }
          fetchCartCountPress(false);
        } else if (result.status == "confirm") {
          isStrictConfirm.value = true;
          // set up the buttons
          Widget cancelButton = TextButton(
            child: Text(
              "Cancel",
              style: TextStyle(
                  color: AppColors.accentColor,
                  fontSize: FontSizeStatic.md,
                  fontWeight: FontWeight.bold,
                  /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins'),
            ),
            onPressed: () {
              isStrictConfirm.value = false;
              Get.back();
            },
          );
          Widget continueButton = TextButton(
            child: Text(
              "Yes",
              style: TextStyle(
                  color: AppColors.primary,
                  fontSize: FontSizeStatic.md,
                  fontWeight: FontWeight.bold,
                  /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins'),
            ),
            onPressed: () async {
              Get.back();
              addToCartPress("1", context);
            },
          );

          // set up the AlertDialog
          AlertDialog alert = AlertDialog(
            title: Text(
              "Replace cart item?",
              style: TextStyles.productPrice,
            ),
            content: Text(
              result.message!,
              style: TextStyles.chooseCategorySubTitle,
            ),
            actions: [
              cancelButton,
              continueButton,
            ],
          );

          // show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        } else {
          Get.snackbar("Sorry!", result.message!,
              backgroundColor: AppColors.secondary,
              duration: Duration(seconds: 1),
              icon: Icon(
                Icons.error_outline_sharp,
                color: Colors.red,
              ),
            titleText: Text(
              "Sorry!",
              style: TextStyle(
                fontFamily: 'Poppins',  // Replace with the desired font family for the title
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              result.message!,
              style: TextStyle(
                fontFamily: 'Poppins',  // Replace with the desired font family for the message

              ),
            ),);
        }
      }
    });
  }

  addToCartPressApiCall(String quantity) async {
    AddToCartSendModel model = AddToCartSendModel(
      quantity: quantity,
      shopId: shopId.value,
      type: ShareStore().getData(store: KeyStore.type) == null
          ? HiveStore().get(Keys.shopType)
          : ShareStore().getData(store: KeyStore.type),
      variantId: variantId.value,
      strictConfirm: isStrictConfirm.value.toString(),
    );
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      guestToken: HiveStore().get(Keys.guestToken),
    );

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      body: model.toJson(),
      baseURL: baseUrl,
      loader: true,
      method: METHOD.POST,
      endpoint: addToCart,
    );
    return DefaultResponseModel.fromJson(result);
  }

  fetchCartCountPress(bool loader) {
    fetchCartCountPressApiCall(loader).then((result) async {
      if (result is FetchCartCountResponseModel) {
        if (result.status == "success") {
          cartCount.value = result.data!.cartcount.toString();
          cartTotal.value = result.data!.carttotal.toString();
        } else {
          Get.snackbar("Sorry!", result.message!,
              backgroundColor: AppColors.secondary,
              duration: Duration(seconds: 1),
              icon: Icon(
                Icons.error_outline_sharp,
                color: Colors.red,
              ),
            titleText: Text(
              "Sorry!",
              style: TextStyle(
                fontFamily: 'Poppins',  // Replace with the desired font family for the title
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              result.message!,
              style: TextStyle(
                fontFamily: 'Poppins',  // Replace with the desired font family for the message

              ),
            ),);
        }
      }
    });
  }

  fetchCartCountPressApiCall(bool load) async {
    //final StoreController storeController = Get.find();
    FetchCartCountSendModel model = FetchCartCountSendModel(
      //shopId: storeController.storeId.value,
      type: ShareStore().getData(store: KeyStore.type) == null
          ? HiveStore().get(Keys.shopType)
          : ShareStore().getData(store: KeyStore.type),
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
      loader: load,
      endpoint: fetchCartCount,
    );
    return FetchCartCountResponseModel.fromJson(result);
  }
}
