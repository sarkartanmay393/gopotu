import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/ChooseCategoryController/ChooseCategoryController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultResponseModel/DefaultResponseModel.dart';
import 'package:go_potu_user/Models/ResponseModels/GuestLoginResponseModel/GuestLoginResponseModel.dart';
import 'package:go_potu_user/Models/ResponseModels/OTPVerifyResponseModel/OTPVerifyResponseModel.dart';
import 'package:go_potu_user/Models/SendModels/LoginSendModel/GuestLoginSendModel.dart';
import 'package:go_potu_user/Models/SendModels/LoginSendModel/LoginSendModel.dart';
import 'package:go_potu_user/Models/SendModels/ResetPasswordSendModel/ResetPasswordSendModel.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ScopeStorage.dart';
import 'package:go_potu_user/Store/ShareStore.dart';
import 'package:go_potu_user/Views/CategoryScreen/ChooseCategoryScreen.dart';

import '../../Models/ResponseModels/RegistrationResponseModel/RegistrationResponseModel.dart';

class SignInController extends GetxController {
  TextEditingController? numberController;
  TextEditingController? passwordController;
  var formKey = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  TextEditingController? resetPasswordController;
  @override
  void onInit() {
    // TODO: implement onInit
    numberController = TextEditingController();
    passwordController = TextEditingController();
    resetPasswordController = TextEditingController();
    super.onInit();
  }

  signInPress() {
    Get.closeAllSnackbars();
    signInApiCall().then((result) async {
      if (result is RegistrationResponseModel) {
        if (result.status == "otpverification") {
          ShareStore().saveData(store: KeyStore.isLogin, object: 'Notreset');
          Get.toNamed(otp);
          ShareStore().saveData(
              store: KeyStore.verificationToken,
              object: result.data['otp_token']);
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
        } else if (result.status == "error") {
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

  signInApiCall() async {
    if (formKey.currentState!.validate()) {
      HiveStore().put(Keys.loginUserId, numberController!.text);
      LoginSendModel model = LoginSendModel(
          mobile: numberController!.text,
          // password: passwordController.text,
          fcmToken: HiveStore().get(
            Keys.playerID,
          ),
          guestToken: HiveStore()
              .get(
                Keys.guestToken,
              )
              .toString());
      var result = await CoreService().apiService(
        body: model.toJson(),
        baseURL: baseUrl,
        method: METHOD.POST,
        endpoint: sendOtp,
      );
      return OtpVerifyResponseModel.fromJson(result);
    } else {
      Get.snackbar(
        "Sorry!",
        "Please check the error",
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
          "Please check the error",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the message
          ),
        ),
      );
    }
  }

  guestLoginPress() {
    guestLoginApiCall().then((result) async {
      if (result is GuestLoginResponseModel) {
        if (result.status == "success") {
          await HiveStore().put(Keys.guestToken, result.data['guest']['token']);
          print("result.data.guest : ${result.data['guest']['token']}");
          Get.offAllNamed(addressList);
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

  guestLoginApiCall() async {
    GuestLoginSendModel model = GuestLoginSendModel(
      fcmToken: HiveStore().get(Keys.deviceID),
    );
    var result = await CoreService().apiService(
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: guestLoginUrl,
    );
    return GuestLoginResponseModel.fromJson(result);
  }

  resetPasswordPress() {
    resetPasswordApiCall().then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "otpverification") {
          resetPasswordController!.text = "";
          ShareStore().saveData(
              store: KeyStore.verificationToken,
              object: result.data['otp_token']);
          ShareStore().saveData(store: KeyStore.isLogin, object: 'reset');
          Get.toNamed(otp);
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

  resetPasswordApiCall() async {
    if (formKey2.currentState!.validate()) {
      ResetPasswordSendModel model =
          ResetPasswordSendModel(mobile: resetPasswordController!.text);

      var result = await CoreService().apiService(
        body: model.toJson(),
        baseURL: baseUrl,
        method: METHOD.POST,
        endpoint: resetPasswordUrl,
      );

      return DefaultResponseModel.fromJson(result);
    } else {
      Get.snackbar(
        "Sorry!",
        "Please check the error",
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
          "Please check the error",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the message
          ),
        ),
      );
    }
  }
}
