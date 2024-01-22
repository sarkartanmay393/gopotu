import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultResponseModel/DefaultResponseModel.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultSendModel/DefaultHeaderSendModel.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';

class NotificationController extends GetxController {
  var notificationList = <dynamic>[].obs;
  var isLoading = true.obs;

  getNotificationListPress(bool load) {
    getNotificationListApiCall(load).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          isLoading.value = false;
          notificationList.assignAll(result.data['notifications']);
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

  getNotificationListApiCall(bool load) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
    );

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      loader: load,
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: getNotificationListUrl,
    );
    return DefaultResponseModel.fromJson(result);
  }
}
