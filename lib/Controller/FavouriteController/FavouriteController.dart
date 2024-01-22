import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultResponseModel/DefaultResponseModel.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultSendModel/DefaultHeaderSendModel.dart';
import 'package:go_potu_user/Models/SendModels/FavouriteListSendModel/FavouriteListSendModel.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ScopeStorage.dart';
import 'package:go_potu_user/Store/ShareStore.dart';

class FavouriteController extends GetxController {
  var favouriteList = <dynamic>[].obs;

  favouriteListPress(bool load) {
    favouriteListApiCall(load).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          favouriteList.assignAll(result.data['wishlists']);
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

  favouriteListApiCall(bool load) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
    );

    FavouriteListSendModel model = FavouriteListSendModel(
      type: ShareStore().getData(store: KeyStore.type) == null
          ? HiveStore().get(Keys.shopType)
          : ShareStore().getData(store: KeyStore.type),
    );

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      loader: load,
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: favouriteListUrl,
    );
    return DefaultResponseModel.fromJson(result);
  }
}
