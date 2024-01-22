import 'dart:async';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/DashboardController/DashboardController.dart';
import 'package:go_potu_user/Controller/ProfileController/ProfileController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Models/ResponseModels/OTPVerifyResponseModel/OTPVerifyResponseModel.dart';
import 'package:go_potu_user/Models/SendModels/OTPVerifySendModel/OTPVerifySendModel.dart';
import 'package:go_potu_user/Views/DetailsScreen/DetailsScreen.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ScopeStorage.dart';
import 'package:go_potu_user/Store/ShareStore.dart';



class OTPController extends GetxController {
  otpVerifyPress(String verifyOtp, String mobile) {
    otpVerifyApiCall(verifyOtp, mobile).then((result) async {
      if (result is OtpVerifyResponseModel) {
        if (result.status == "success") {
          Get.snackbar("Success", result.message!,
            backgroundColor: AppColors.secondary,

            icon: Icon(
              Icons.done,
              color: Colors.greenAccent,
            ),titleText: Text(
              "Success!",
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
          // if (ShareStore().getData(store: KeyStore.isLogin) == "reset") {
          if (false) {
            Get.offAllNamed(signIn);
          } else {

            await HiveStore().delete(Keys.guestToken);
            await HiveStore().put(Keys.accessToken,
                "Bearer ${result.data['token']['access_token']}");
            await HiveStore()
                .put(Keys.userNumber, result.data['user']['mobile']);
            ShareStore().saveData(
                store: KeyStore.number, object: result.data['user']['mobile']);
            bool isNameNull = result.data['user']['name'] == null;
            bool isEmailNull = result.data['user']['email'] == null;

            // if (result.data['user']['parent_id'] == null) {
            //   Get.to(
            //         () => DetailsScreen(isNameNull: isNameNull, isEmailNull: isEmailNull),
            //   );
            // }else{
            //
            //   Get.offAllNamed(addressList);
            // }
            await Future.delayed(Duration(seconds: 3)); //adding await to wait before sending on any other page.
            if (result.data['user']['name'] == null) {
              Get.to(
                    () => DetailsScreen(isNameNull: isNameNull, isEmailNull: isEmailNull),
              );
            }else{

              if (HiveStore().get(Keys.shopType) == null) {

                ShareStore().saveData(
                    store: KeyStore.typeIndex, object: "0");
                HiveStore().put(Keys.typeSelectIndex, "0");
                ShareStore().saveData(
                    store: KeyStore.type, object: "mart");
                HiveStore().put(Keys.shopType, "mart");


                await HiveStore().put(Keys.isDefaultAddressSet, "false");
                await ProfileController().getAccountPress(false);
                Get.offAllNamed(loading);
                // ----------------------------
                // ChooseCategoryController chooseCategoryController =
                //     Get.put(ChooseCategoryController());
                // chooseCategoryController.isBeforeDashboard.value = true;
                // Get.to(ChooseCategoryScreen());
              } else {
                await HiveStore().put(Keys.isDefaultAddressSet, "false");
                await ProfileController().getAccountPress(false);
                Get.offAllNamed(loading);
              }
            }

            // ShareStore().saveData(
            //     store: KeyStore.verificationToken,
            //     object: result.data['otp_token']);
          }
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

  otpVerifyApiCall(String verifyOtp, String mobile) async {
    OtpVerifySendModel model = OtpVerifySendModel(
      otp: verifyOtp,
      mobile: mobile,
      verificationToken:
      ShareStore().getData(store: KeyStore.verificationToken).toString(),
      guestToken: HiveStore().get(
        Keys.guestToken,
      ) !=
          null
          ? HiveStore()
          .get(
        Keys.guestToken,
      )
          .toString()
          : null,
    );
    var result = await CoreService().apiService(
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      // endpoint: ShareStore().getData(store: KeyStore.isLogin) == "true"
      //     ? loginOTPVerifyUrl
      //     : ShareStore().getData(store: KeyStore.isLogin) == "reset"
      //         ? verifyOTPVerifyForResetUrl
      //         : registerOTPVerifyUrl,
      endpoint: otpLogin,
    );
    return OtpVerifyResponseModel.fromJson(result);
  }

  resendOTPPress() {
    print(
        "ShareStore().getData(store: KeyStore.isLogin :- ${ShareStore().getData(store: KeyStore.isLogin)}");
    resendOTPApiCall().then((result) {
      if (result is OtpVerifyResponseModel) {
        if (result.status == "success") {
          Get.snackbar("Done", result.message!,
            backgroundColor: AppColors.secondary,
            duration: Duration(seconds: 1),
            icon: Icon(
              Icons.done,
              color: Colors.greenAccent,
            ),titleText: Text(
              "Done",
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

  resendOTPApiCall() async {
    OtpVerifySendModel model = OtpVerifySendModel(
      verificationToken:
      ShareStore().getData(store: KeyStore.verificationToken).toString(),
      guestToken: HiveStore()
          .get(
        Keys.guestToken,
      )
          .toString(),
    );
    var result = await CoreService().apiService(
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: ShareStore().getData(store: KeyStore.isLogin) == "true"
          ? loginResendOTPVerifyUrl
          : ShareStore().getData(store: KeyStore.isLogin) == "reset"
          ? resendOTPVerifyForResetUrl
          : resendOTPVerifyUrl,
    );
    return OtpVerifyResponseModel.fromJson(result);
  }
}
