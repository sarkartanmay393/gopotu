import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/SubCategoryController/SubCategoryController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultResponseModel/DefaultResponseModel.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultSendModel/DefaultHeaderSendModel.dart';
import 'package:go_potu_user/Models/ResponseModels/GetMyBucketResponseModel/GetMyBucketResponseModel.dart';
import 'package:go_potu_user/Models/ResponseModels/StoreDetailsResponseModel/StoreDetailsResponseModel.dart';
import 'package:go_potu_user/Models/SendModels/LoadProductsSendModel/LoadProductsSendModel.dart';
import 'package:go_potu_user/Models/SendModels/StoreDetailsSendModel/StoreDetailsSendModel.dart';
import 'package:go_potu_user/Models/SendModels/shopByCategorySendModel/ShopByCategorySendModel.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ScopeStorage.dart';
import 'package:go_potu_user/Store/ShareStore.dart';

import '../../Models/ResponseModels/CategoryByShopResponseModel/CategoryByShopResponseModel.dart';

class StoreController extends GetxController {
  var storeId = "".obs;
  var storeData = Data().obs;
  var itemList = <dynamic>[].obs;
  TextEditingController? searchKeyController;
  var isFavourite = false.obs;
  var loader = false.obs;
  var isLoading = true.obs;



  List<TopofferedProduct>? originalTopofferedProducts;
  List<TopofferedProduct> matchingProducts = [];
  @override
  void onInit() {
    // TODO: implement onInit
    searchKeyController = TextEditingController();
    var i = JsonDecoder().convert(Get.arguments);
    storeId.value = i["id"];
    isFavourite.value = i["isFavourite"];

    // SubCategoryController().subCategoryListPress(false);
    storeDetailsPress(false);

    super.onInit();


  }

  void filterProducts(String query, List items) {

    List<TopofferedProduct> matchingProducts = [];

    // Assuming storeData is accessible
    List<TopofferedProduct>? products = storeData?.value?.topofferedProducts;

    if (products != null) {
      for (TopofferedProduct product in matchingProducts) {
        if (product.details?.name?.toLowerCase().contains(query.toLowerCase()) ?? false) {
          if (items.contains(product)) {
            matchingProducts.add(product);
          }
        }
      }
      print("Matching Products: ${matchingProducts.length}");
      print("products ${products.length}");
    }
  }

  storeDetailsPress(bool loader) {
    storeDetailsApiCall(loader).then((result) async {
      if (result is StoreDetailsResponseModel) {
        if (result.status == "success") {
          storeData.value = result.data!;

          // SubCategoryController().subCategoryListPress(false);
          isLoading.value = false;
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

  storeDetailsApiCall(bool load) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      guestToken: HiveStore().get(Keys.guestToken),
    );
// print("kskks${HiveStore().get(Keys.shopType}");
    StoreDetailsSendModel model = StoreDetailsSendModel(

      shopId: storeId.value,
      type: ShareStore().getData(store: KeyStore.type) == null
          ? HiveStore().get(Keys.shopType)
          : ShareStore().getData(store: KeyStore.type),

    );
    var result = await CoreService().apiService(
      body: model.toJson(),
      header: headerModel.toHeader(),
      baseURL: baseUrl,
      loader: load,
      method: METHOD.POST,
      endpoint: getStoreDetails,
    );
    return StoreDetailsResponseModel.fromJson(result);
  }

  storeByCategoryPress(bool loader, int categoryid) {
    storeByCategoryApiCall(loader, categoryid).then((result) async {
      if (result is CategoryByShopResponseModel) {
        if (result.status == "success") {
          storeData.value = result.data! as Data;
          isLoading.value = false;
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

  storeByCategoryApiCall(bool loader, int categoryid) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
    );

    ShopByCategorySendModel model = ShopByCategorySendModel(
      categoryId: categoryid,
    );

    var result = await CoreService().apiService(
      body: model.toJson(),
      header: headerModel.toHeader(),
      baseURL: baseUrl,
      loader: loader,
      method: METHOD.GET,
      endpoint: '$productListBySubCategoryUrl/$categoryid/${this.storeId}',
    );
    return CategoryByShopResponseModel.fromJson(result);
  }

  searchListPress(bool load) {
    itemList.clear();
    loader.value = true;
    searchListApiCall(load).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          loader.value = false;
          itemList.assignAll(result.data['products']);
        } else {
          loader.value = false;
          itemList.clear();
        }
      }
    });
  }

  searchListApiCall(bool load) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      guestToken: HiveStore().get(Keys.guestToken),
    );

    LoadProductsSendModel model = LoadProductsSendModel(
      shopId: storeId.value.toString(),
      searchkey: searchKeyController!.text,
    );

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      loader: load,
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: productListBySubCategoryUrl,
    );
    return DefaultResponseModel.fromJson(result);
  }
}
