import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/DashboardController/DashboardController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultResponseModel/DefaultResponseModel.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultSendModel/DefaultHeaderSendModel.dart';
import 'package:go_potu_user/Models/SendModels/ChangePasswordSendModel/ChangePasswordSendModel.dart';
import 'package:go_potu_user/Models/SendModels/EditProfileSendModel/EditProfileSendModel.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';

class ProfileController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController newConfirmPass = TextEditingController();
  var profileName = "".obs;
  var formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // TODO: implement onInit
    if (HiveStore().get(Keys.guestToken) == null) {
      getAccountPress(false);
    }
    super.onInit();
  }

  getAccountPress(bool isLoader) {
    getAccountApiCall(isLoader).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          await HiveStore().put(Keys.profileData, result.data['user']);
          name.text = HiveStore().get(Keys.profileData)['name'];
          userEmail.text = HiveStore().get(Keys.profileData)['email'];
          profileName.value = result.data['user']['name'];
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

  getAccountApiCall(bool loader) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      baseURL: baseUrl,
      method: METHOD.GET,
      loader: loader,
      endpoint: getAccount,
    );
    return DefaultResponseModel.fromJson(result);
  }

  editProfilePress() {
    editProfileApiCall().then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          HiveStore().put(Keys.profileData, result.data['user']);
          profileName.value = result.data['user']['name'];
          Get.back();
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

  editProfileApiCall() async {
    if (name.text.isEmpty) {
      Get.snackbar(
        "Sorry!",
        "Please enter your name",
        backgroundColor: AppColors.secondary,
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
          "Please enter your name",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the message
          ),
        ),
      );
    } else {
      EditProfileSendModel model = EditProfileSendModel(
        email: userEmail.text,
        name: name.text,
      );
      DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
        authorization: HiveStore().get(Keys.accessToken),
        guestToken: HiveStore().get(Keys.guestToken),
      );
      var result = await CoreService().apiService(
        body: model.toJson(),
        header: headerModel.toHeader(),
        baseURL: baseUrl,
        method: METHOD.POST,
        endpoint: editAccount,
      );
      return DefaultResponseModel.fromJson(result);
    }
  }

  changePasswordPress() {
    changePasswordApiCall().then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          Get.back();
          oldPass.clear();
          newPass.clear();
          newConfirmPass.clear();
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

  changePasswordApiCall() async {
    if (formKey.currentState!.validate()) {
      ChangePasswordSendModel model = ChangePasswordSendModel(
        currentPassword: oldPass.text,
        newPassword: newPass.text,
        newPasswordConfirmation: newConfirmPass.text,
      );
      DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
        authorization: HiveStore().get(Keys.accessToken),
        guestToken: HiveStore().get(Keys.guestToken),
      );
      var result = await CoreService().apiService(
        body: model.toJson(),
        header: headerModel.toHeader(),
        baseURL: baseUrl,
        method: METHOD.POST,
        endpoint: changePassword,
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
