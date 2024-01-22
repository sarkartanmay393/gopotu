import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddToCartController/AddToCartController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultResponseModel/DefaultResponseModel.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultSendModel/DefaultHeaderSendModel.dart';
import 'package:go_potu_user/Models/SendModels/AddToCartSendModel/AddToCartSendModel.dart';
import 'package:go_potu_user/Models/SendModels/GetDashboardSendModel/GetDashboardSendModel.dart';
import 'package:go_potu_user/Models/SendModels/LoadCategorySendModel/LoadCategorySendModel.dart';
import 'package:go_potu_user/Models/SendModels/LoadProductsSendModel/LoadProductsSendModel.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ScopeStorage.dart';
import 'package:go_potu_user/Store/ShareStore.dart';

import '../../DeviceManager/Assets.dart';

class SubCategoryController extends GetxController {
  var subCategoryList = <dynamic>[].obs;
  var categoryParentId = "".obs;
  var subCategoryChildList = <dynamic>[].obs;
  var isTapId = 0.obs;
  var subCategoryProductList = <dynamic>[].obs;
  var subcategoryId = "".obs;
  var shopId = "".obs;
  var isLoading = false.obs;
  var isStrictConfirm = false.obs;
  var shopIdForCart = "".obs;
  var variantId = "".obs;
  var allTap = false.obs;
  var isSubCatChildLoading = true.obs;

  void onInit() {
    // TODO: implement onInit


    super.onInit();
  }

  subCategoryListPress(bool load) {
    subCategoryListApiCall(load).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          isLoading.value = true;
          subCategoryList.assignAll(result.data['sub_categories']);
          print(subCategoryList.value);
        } else {
          isLoading.value = true;
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

  subCategoryListApiCall(bool load) async {
    // GetDashboardSendModel model = GetDashboardSendModel(
    //     type: ShareStore().getData(store: KeyStore.type) == null
    //         ? HiveStore().get(Keys.shopType)
    //         : ShareStore().getData(store: KeyStore.type),
    //     shopId: shopId.value.toString());
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
    );

    var result = await CoreService().apiService(
      // body: model.toJson(),
      header: headerModel.toHeader(),
      loader: load,
      baseURL: baseUrl,
      method: METHOD.GET,
      endpoint: '$subcategorycall/${subcategoryId.value}',
    );
    return DefaultResponseModel.fromJson(result);
  }

  loadCategoryListPress() async {
    // Show dialog after a short delay
    Future.delayed(Duration.zero, () {
      Get.dialog(
        Center(
          child: Container(
            height: ScreenConstant.sizeXXL,
            width: ScreenConstant.sizeXXL,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              border: Border.all(
                color: AppColors.secondary,
              ),
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 1.5,
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );
    });

    try {
      final result = await loadCategoryListApiCall();

      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          subCategoryChildList.assignAll(result.data['categories']);
          loadProductListPress(categoryParentId.toString(), false);
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
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              result.message!,
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
          );
        }
      }
    } finally {
      // Close the dialog after a delay regardless of success or failure
      await Future.delayed(Duration(seconds: 3));
      Get.back();
    }
  }


  loadCategoryListApiCall() async {
    LoadCategorySendModel model = LoadCategorySendModel(
        type: ShareStore().getData(store: KeyStore.type) == null
            ? HiveStore().get(Keys.shopType)
            : ShareStore().getData(store: KeyStore.type),
        parentId: categoryParentId.value,
        shopId: shopId.value.toString());
    var result = await CoreService().apiService(
      body: model.toJson(),
      baseURL: baseUrl,
      loader: false,
      method: METHOD.POST,
      endpoint: subCategoryListUrl,
    );
    return DefaultResponseModel.fromJson(result);
  }

  loadProductListPress(String id, bool loader) {
    loadProductListApiCall(id, loader).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          isSubCatChildLoading.value = false;

          subCategoryProductList.assignAll(result.data['products']);
        } else {
          isSubCatChildLoading.value = false;

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

  loadProductListApiCall(String id, bool loader) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      guestToken: HiveStore().get(Keys.guestToken),
    );
    LoadProductsSendModel model = LoadProductsSendModel(
      categoryId: id.toString(),
      shopId: shopId.value.toString(),
    );
    var result = await CoreService().apiService(
      body: model.toJson(),
      header: headerModel.toHeader(),
      loader: loader,
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: productListBySubCategoryUrl,
    );
    return DefaultResponseModel.fromJson(result);
  }

  subCategoryAddToCartPress(String quantity, BuildContext context) {
    subCategoryAddToCartPressApiCall(quantity).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          isStrictConfirm.value = false;
          shopIdForCart.value = "";
          variantId.value = "";

          if (allTap.value) {
            loadProductListPress(categoryParentId.toString(), false);
          } else {
            loadProductListPress(subcategoryId.toString(), false);
          }

          final AddToCartController addToCartController = Get.find();
          addToCartController.fetchCartCountPress(false);
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
              subCategoryAddToCartPress("1", context);
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

  subCategoryAddToCartPressApiCall(String quantity) async {
    AddToCartSendModel model = AddToCartSendModel(
        quantity: quantity,
        shopId: shopIdForCart.value,
        type: ShareStore()
            .getData(store: KeyStore.type)
            .isBlank == null
            ? HiveStore().get(Keys.shopType)
            : ShareStore().getData(store: KeyStore.type),
        variantId: variantId.value,
        strictConfirm: isStrictConfirm.value.toString());
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
}
