import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/OrderListController/OrderListController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultResponseModel/DefaultResponseModel.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultSendModel/DefaultHeaderSendModel.dart';
import 'package:go_potu_user/Models/SendModels/OrderRatingSendModel/OrderRatingSendModel.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';

class OrderRatingController extends GetxController {
  TextEditingController reviewController = TextEditingController();
  var ratingNumber = "".obs;

  OrderListController orderListController = Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    reviewController = TextEditingController();
    super.onInit();
  }

  ratingPress() {
    ratingApiCall().then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          reviewController.text = "";
          orderListController.getOrderDetailsPress(true);
          Get.back();
          Get.closeAllSnackbars();
          Get.snackbar(
            "Success",
            result.message!,
            backgroundColor: AppColors.secondary,
            duration: Duration(seconds: 1),
            icon: Icon(
              Icons.done,
              color: Colors.greenAccent,
            ),
            titleText: Text(
              "Success",
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

  ratingApiCall() async {
    if (ratingNumber.value == "") {
      Get.snackbar(
        "Sorry!",
        "Please select at least one rating",
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
          "Please select at least one rating",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the message
          ),
        ),
      );
    } else {
      OrderRatingSendModel model = OrderRatingSendModel(
        orderId: orderListController.orderId.toString(),
        shopRating: ratingNumber.toString(),
        shopReview: reviewController.text,
      );
      DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
        authorization: HiveStore().get(Keys.accessToken),
        //guestToken: HiveStore().get(Keys.guestToken),
      );

      var result = await CoreService().apiService(
        header: headerModel.toHeader(),
        body: model.toJson(),
        baseURL: baseUrl,
        method: METHOD.POST,
        endpoint: orderRatingUrl,
      );
      return DefaultResponseModel.fromJson(result);
    }
  }
}
