import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/CategoryController/CategoryController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultResponseModel/DefaultResponseModel.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultSendModel/DefaultHeaderSendModel.dart';
import 'package:go_potu_user/Models/ResponseModels/SearchResponseModel/SearchResponseModel.dart';
import 'package:go_potu_user/Models/SendModels/SearchSendModel/SearchSendModel.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ScopeStorage.dart';
import 'package:go_potu_user/Store/ShareStore.dart';

class MySearchController extends GetxController {
  TextEditingController? searchKeyController;
  var storeSelect = false.obs;
  var itemSelect = true.obs;
  var storeList = <dynamic>[].obs;
  var itemList = <dynamic>[].obs;
  var loader = false.obs;

  var search = <dynamic>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit

    searchKeyController = TextEditingController();
    super.onInit();
  }

  searchListPress(bool load) {
    loader.value = true;
    storeList.clear();
    itemList.clear();
    searchListApiCall(load).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          loader.value = false;
          storeList.assignAll(result.data['shops']);
          itemList.assignAll(result.data['products']);
        } else {
          loader.value = false;
          storeList.clear();
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

    SearchSendModel model = SearchSendModel(
        type: ShareStore().getData(store: KeyStore.type) == null
            ? HiveStore().get(Keys.shopType)
            : ShareStore().getData(store: KeyStore.type),
        searchkeyword: searchKeyController!.text);

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      loader: load,
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: searchListUrl,
    );
    return DefaultResponseModel.fromJson(result);
  }

  // CateGorysearchListPress(bool load) {
  //   loader.value = true;
  //   storeList.clear();
  //   itemList.clear();
  //   CategorysearchListApiCall(load).then((result) async {
  //     if (result is DefaultResponseModel) {
  //       if (result.status == "success") {
  //         loader.value = false;
  //         storeList.assignAll(result.data['shops']);
  //         itemList.assignAll(result.data['products']);
  //       } else {
  //         loader.value = false;
  //         storeList.clear();
  //         itemList.clear();
  //       }
  //     }
  //   });
  // }

  void searchLocalList(String searchKeyword) {
    print(searchKeyword);
    loader.value = true;
    storeList.clear();
    // itemList.clear();
    print("searching shop");

    print(search.length);

    // Assuming shops_List is a List<dynamic> containing JSON data for shops
    List<dynamic> shops = search.value;
    print("searchingshop = ${shops}");

    if (shops != null) {
      List<dynamic> filteredShops = shops
          .where((shop) => shop['shop_name']
              .toLowerCase()
              .contains(searchKeyword.toLowerCase()))
          .toList();

      loader.value = false;
      print("searchingshop = ${filteredShops}");
      storeList.assignAll(filteredShops);
    } else {
      loader.value = false;
      storeList.clear();
      itemList.clear();
    }
  }
}
