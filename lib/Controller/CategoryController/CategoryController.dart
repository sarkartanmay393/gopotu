import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddressController/AddressController.dart';
import 'package:go_potu_user/Controller/ChooseCategoryController/ChooseCategoryController.dart';
import 'package:go_potu_user/Controller/FavouriteController/FavouriteController.dart';
import 'package:go_potu_user/Controller/ProfileController/ProfileController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultResponseModel/DefaultResponseModel.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultSendModel/DefaultHeaderSendModel.dart';
import 'package:go_potu_user/Models/SendModels/GetDashboardSendModel/GetDashboardSendModel.dart';
import 'package:go_potu_user/Models/SendModels/StoreDetailsSendModel/StoreDetailsSendModel.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ScopeStorage.dart';
import 'package:go_potu_user/Store/ShareStore.dart';
import 'package:go_potu_user/Views/CategoryScreen/ChooseCategoryScreen.dart';

import '../../Models/ResponseModels/CategoryByShopResponseModel/CategoryByShopResponseModel.dart';
import '../../Models/SendModels/shopByCategorySendModel/ShopByCategorySendModel.dart';

class CategoryController extends GetxController {
  var shops = <dynamic>[].obs;
  var isLoading = false.obs;
  var categoryId = "".obs;
  var isCatChildLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    // storeByCategoryPress(false,storeId.value as int);

    super.onInit();
  }

  storeByCategoryPress(bool loader) {
    storeByCategoryApiCall(loader).then((result) async {
      if (result is CategoryByShopResponseModel) {
        if (result.status == "success") {
          isLoading.value=false;
          isCatChildLoading.value = false;

          shops.assignAll(result.data['shops']);
        } else {
          isCatChildLoading.value = false;
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

  storeByCategoryApiCall(bool loader) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
    );

    // ShopByCategorySendModel model = ShopByCategorySendModel(
    //   categoryId: categoryid,
    // );

    var result = await CoreService().apiService(
      // body: model.toJson(),
      header: headerModel.toHeader(),
      baseURL: baseUrl,
      loader: loader,
      method: METHOD.GET,
      endpoint: '$getShopByCategory/$categoryId',
    );
    return CategoryByShopResponseModel.fromJson(result);
  }
}
