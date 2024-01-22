import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultSendModel/DefaultHeaderSendModel.dart';
import 'package:go_potu_user/Models/ResponseModels/ProductDetailsResponseModel/ProductDetailsResponseModel.dart';
import 'package:go_potu_user/Models/ResponseModels/ProductVariantDetailsResponseModel/ProductVariantDetailsResponseModel.dart';
import 'package:go_potu_user/Models/SendModels/ProductDetailsSendModel/ProductDetailsSendModel.dart';
import 'package:go_potu_user/Models/SendModels/ProductVariantDetailsSendModel/ProductVariantDetailsSendModel.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';

import '../../DeviceManager/ScreenConstants.dart';

class ProductController extends GetxController {
  var productId = "".obs;
  var productDetailsData = ProductData().obs;
  var productVariantDetailsData = ProductVariantData().obs;
  // var shop = Shop().obs;
  var purchasePrice = "0.00".obs;
  // var listingPrice = "0.00".obs; //listingPrice
  var fakePrice = "0.00".obs;
  // ignore: non_constant_identifier_names

  var discountAmount = "0.00".obs;
  var onTapIndexForVariant = 0.obs;
  var onTapIndexForColor = 0.obs;
  var isFirstCallVariant = 0.obs;
  var isSearch = false.obs;
  var isLoading = true.obs;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  productDetailsPress(bool loader) async {
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
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 1.5,
                ),
              ))),
      barrierDismissible: false,
    );
    onTapIndexForVariant.value = 0;
    onTapIndexForColor.value = 0;
    await productDetailsApiCall(loader).then((result) async {
      if (result is ProductDetailsResponseModel) {
        if (result.status == "success") {
          isLoading.value = false;
          productDetailsData.value = result.data!;
          // shop.value = result.data as Shop;

          productVariantDetailsPress(
            productDetailsData.value.product!.variant,
            productDetailsData.value.product!.variantOptions != null &&
                    productDetailsData.value.product!.variantOptions!.length !=
                        0
                ? productDetailsData.value.product!.variantOptions![0]
                : null,
            productDetailsData.value.product!.colors != null &&
                    productDetailsData.value.product!.colors!.length != 0
                ? productDetailsData.value.product!.colors![0]
                : null,
            false,
          );
          isFirstCallVariant.value = 1;
          print("isFirstCallVariant.value : ${isFirstCallVariant.value}");
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
      Future.delayed(Duration(seconds: 3), () {
        Get.back();
      });
    });
  }

  productDetailsApiCall(bool load) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      guestToken: HiveStore().get(Keys.guestToken),
    );
    ProductDetailsSendModel model = ProductDetailsSendModel(
      productId: productId.value.toString(),
    );
    var result = await CoreService().apiService(
      body: model.toJson(),
      header: headerModel.toHeader(),
      loader: load,
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: getProductDetails,
    );
    return ProductDetailsResponseModel.fromJson(result);
  }

  productVariantDetailsPress(
    String? variantType,
    String? variantName,
    String? color,
    bool? loader,
  ) {
    isFirstCallVariant.value = 2;
    productVariantDetailsApiCall(variantType, variantName, color, loader)
        .then((result) async {
      if (result is ProductVariantDetailsResponseModel) {
        if (result.status == "success") {
          productVariantDetailsData.value = result.data!;
          purchasePrice.value = result.data!.variantDetails!.purchasePrice!;

          // listingPrice.value = result.data.variantDetails.listingPrice;
          fakePrice.value = result.data!.variantDetails!.price!;
          discountAmount
              .value = (double.parse(result.data!.variantDetails!.price!) -
                  double.parse(result.data!.variantDetails!.purchasePrice!))
              // double.parse((result.data.variantDetails.listingPrice) == null ? (result.data.variantDetails.purchasePrice) : (result.data.variantDetails.listingPrice) ))

              .toStringAsFixed(2);
          print("discountAmount.value : ${discountAmount.value}");
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

  productVariantDetailsApiCall(String? variantType, String? variantName,
      String? color, bool? load) async {
    ProductVariantDetailsSendModel model = ProductVariantDetailsSendModel(
      productId: productId.value.toString(),
      color: color != null ? color : null,
      variant: variantType != null ? variantType + ":" + variantName! : null,
    );
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      guestToken: HiveStore().get(Keys.guestToken),
    );
    var result = await CoreService().apiService(
      body: model.toJson(),
      header: headerModel.toHeader(),
      loader: load!,
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: getProductVariantDetails,
    );
    return ProductVariantDetailsResponseModel.fromJson(result);
  }
}
