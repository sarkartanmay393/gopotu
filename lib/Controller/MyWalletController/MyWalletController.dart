import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultResponseModel/DefaultResponseModel.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultSendModel/DefaultHeaderSendModel.dart';
import 'package:go_potu_user/Models/ResponseModels/MyWalletDashBoardResponseModel/MyWalletDashBoardResponseModel.dart';
import 'package:go_potu_user/Models/SendModels/MyEarningReportsSendModel/MyEarningReportsSendModel.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:intl/intl.dart';

class MyWalletController extends GetxController {
  var myWalletDashBoardData = WalletData().obs;

  var walletTransactionList = <dynamic>[].obs;

  var selectedFirstDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1).obs;
  var selectedSecondDate = DateTime.now().obs;
  var isWalletLoading = true.obs;
  var isWalletHistoryLoading = true.obs;

  myWalletPress(bool load) {
    myWalletApiCall(load).then((result) async {
      if (result is MyWalletDashBoardResponseModel) {
        if (result.status == "success") {
          isWalletLoading.value = false;
          myWalletDashBoardData.value = result.data!;
        } else {
          isWalletLoading.value = false;
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

  myWalletApiCall(bool load) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
    );

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      loader: load,
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: walletDashBoardUrl,
    );
    return MyWalletDashBoardResponseModel.fromJson(result);
  }

  getWalletTransactionListPress(bool load) {
    getWalletTransactionListApiCall(load).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          isWalletHistoryLoading.value = false;
          walletTransactionList.assignAll(result.data['statement']);
        } else {
          isWalletHistoryLoading.value = false;
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

  getWalletTransactionListApiCall(bool load) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
    );

    MyEarningReportsSendModel model = MyEarningReportsSendModel(
      startDate: DateFormat('yyyy-MM-dd').format(selectedFirstDate.value),
      endDate: DateFormat('yyyy-MM-dd').format(selectedSecondDate.value),
    );

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      loader: load,
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: walletTransactionHistoryUrl,
    );
    return DefaultResponseModel.fromJson(result);
  }
}
