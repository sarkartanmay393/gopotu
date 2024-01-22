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

class DashboardController extends GetxController {
  var topStoreList = <dynamic>[].obs;
  var newProducts = <dynamic>[].obs;
  var nearestStore = <dynamic>[].obs;
  var offers_shop = <dynamic>[].obs;
  var shop_name = <dynamic>[].obs;
  var deal = <dynamic>[].obs;
  var offers_products = <dynamic>[].obs;
  var offers_delivery = <dynamic>[].obs;
  var featuredCategories = <dynamic>[].obs;
  var featuredProducts = <dynamic>[].obs;
  var featuredShop = <dynamic>[].obs;
  var appBannerMiddle = <dynamic>[].obs;
  var appBannerFooter = <dynamic>[].obs;
  var location = "".obs;
  var isLoading = false.obs;
  var shopId = "".obs;
  var address = "".obs;
  // var user = "".obs;
  final AddressController addressController = Get.put(AddressController());

  @override
  void onInit() {
    // TODO: implement onInit
    // final ProfileController profileController = Get.put(ProfileController());

    super.onInit();
  }

  getHomeDataPress(bool loader, bool isHome) {
    getHomeDataPressApiCall(loader, isHome).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          isLoading.value = true;
          topStoreList.assignAll(result.data['featured_shops']);
          nearestStore.assignAll(result.data['nearest_shops']);
          // nearestStore.assignAll(result.data['user']);
          newProducts.assignAll(result.data['new_products']);
          offers_shop.assignAll(result.data['offers']['shop']);
          offers_products.assignAll(result.data['offers']['product']);
          offers_delivery.assignAll(result.data['offers']['delivery']);
          featuredCategories.assignAll(result.data['fetured_categories']);
          featuredProducts.assignAll(result.data['showcase']);
          appBannerMiddle.assignAll(result.data['appbanners']['middle']);
          appBannerFooter.assignAll(result.data['appbanners']['footer']);
          location.value = result.data['default_address']['location'];
          bool isStoreOnline(int index) {
            return nearestStore[index]['online'] == '1';
          }
         
          // location.value = address.value;

          if (HiveStore().get(Keys.shopType) == null) {
            ChooseCategoryController chooseCategoryController =
                Get.put(ChooseCategoryController());
            chooseCategoryController.isBeforeDashboard.value = true;
            Get.offAll(() => ChooseCategoryScreen());
          }
        } else {
          isLoading.value = true;
          /*if(location.value == "" || location.value == null){
            Get.offAllNamed(addressList);}*/
          if (HiveStore().get(Keys.shopType) == null) {
            print(
                "HiveStore().get(Keys.shopType) : ${HiveStore().get(Keys.shopType)}");
            ChooseCategoryController chooseCategoryController =
                Get.put(ChooseCategoryController());
            chooseCategoryController.isBeforeDashboard.value = true;
            Get.offAll(() => ChooseCategoryScreen());
          }
          /*Get.snackbar("Sorry!", result.message,
              backgroundColor: AppColors.secondary,
              icon: Icon(
                Icons.error_outline_sharp,
                color: Colors.red,
              ));*/
        }
      }
    });
  }



  getHomeDataPressApiCall(bool loader, bool isHome) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      guestToken: HiveStore().get(Keys.guestToken),
    );
    GetDashboardSendModel model = GetDashboardSendModel(
      type: ShareStore().getData(store: KeyStore.type) == null
          ? HiveStore().get(Keys.shopType)
          : ShareStore().getData(store: KeyStore.type),
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      loader: loader,
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: getHomeData,
    );
    return DefaultResponseModel.fromJson(result);
  }



  setAsFavouritePress(bool loader) {
    setAsFavouritePressApiCall(loader).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          getHomeDataPress(true, false);
          final FavouriteController favouriteController =
              Get.put(FavouriteController());
          favouriteController.favouriteListPress(false);
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
    });
  }

  setAsFavouritePressApiCall(bool loader) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      guestToken: HiveStore().get(Keys.guestToken),
    );
    StoreDetailsSendModel model = StoreDetailsSendModel(
      type: ShareStore().getData(store: KeyStore.type) == null
          ? HiveStore().get(Keys.shopType)
          : ShareStore().getData(store: KeyStore.type),
      shopId: shopId.value,
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      loader: loader,
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: setAsFavouriteUrl,
    );

    return DefaultResponseModel.fromJson(result);
  }
}
