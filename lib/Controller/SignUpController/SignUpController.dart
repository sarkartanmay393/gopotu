import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Models/ResponseModels/RegistrationResponseModel/RegistrationResponseModel.dart';
import 'package:go_potu_user/Models/SendModels/RegistrationSendModel/RegistrationSendModel.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ScopeStorage.dart';
import 'package:go_potu_user/Store/ShareStore.dart';

import '../../Models/DefaultModels/DefaultSendModel/DefaultHeaderSendModel.dart';
import '../ProfileController/ProfileController.dart';

class SignUpController extends GetxController {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmController;
  late TextEditingController referralCodeController;
  var formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // TODO: implement onInit
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmController = TextEditingController();
    referralCodeController = TextEditingController();
    super.onInit();
  }

  signUpPress() {
    signUpApiCall().then((result) async {
      if (result is RegistrationResponseModel) {
        if (result.status == "success") {
          ShareStore().saveData(store: KeyStore.isLogin, object: 'Notreset');
          // Get.toNamed(otp);
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
          ShareStore().saveData(
              store: KeyStore.verificationToken,
              object: result.data['otp_token']);
          Get.snackbar("Success", result.message!,
            backgroundColor: AppColors.secondary,
            duration: Duration(seconds: 1),
            icon: Icon(
              Icons.done,
              color: Colors.greenAccent,
            ),
            titleText: Text(
              "Success",
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
        } else if (result.status == "error") {
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

  signUpApiCall() async {
    if (formKey.currentState!.validate()) {
      RegistrationSendModel model = RegistrationSendModel(
        name: firstNameController.text ,
        email: emailController.text,
        // mobile: phoneController.text,
        // password: passwordController.text,
        // passwordConfirmation: confirmController.text,
        referralCode: referralCodeController.text,
        // guestToken: HiveStore().get(
        //           Keys.guestToken,
        //         ) !=
        //         null
        //     ? HiveStore()
        //         .get(
        //           Keys.guestToken,
        //         )
        //         .toString()
        //     : null,

      );
      DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
        authorization: HiveStore().get(Keys.accessToken),
      );
      var result = await CoreService().apiService(
        header: headerModel.toHeader(),
        body: model.toJson(),
        baseURL: baseUrl,
        method: METHOD.POST,
        // endpoint: registerUrl,
        endpoint: nameUpdateUrl,
      );
      return RegistrationResponseModel.fromJson(result);
    } else {
      Get.snackbar("Sorry!", "Please check the error",
        backgroundColor: AppColors.secondary,
        duration: Duration(seconds: 1),
        icon: Icon(
          Icons.error_outline_sharp,
          color: Colors.red,
        ),titleText: Text(
          "Sorry!",
          style: TextStyle(
            fontFamily: 'Poppins',  // Replace with the desired font family for the title
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: Text(
          "Please check the error",
          style: TextStyle(
            fontFamily: 'Poppins',  // Replace with the desired font family for the message

          ),
        ),);
    }
  }
}
