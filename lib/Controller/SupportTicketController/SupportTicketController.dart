import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultResponseModel/DefaultResponseModel.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultSendModel/DefaultHeaderSendModel.dart';
import 'package:go_potu_user/Models/SendModels/SupportSendModel/SupportSendModel.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';

class SupportTicketController extends GetxController {
  TextEditingController? nameController;
  TextEditingController? alternativePhoneController;
  TextEditingController? orderIdController;
  TextEditingController? issueTypeController;
  TextEditingController? issueDetailsController;
  var isCancel = false.obs;
  var cancelReason = "Cancel Order".obs;
  var formKey = GlobalKey<FormState>();
  var isReturn = false.obs;
  var returnRequest = "Return Request".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nameController = TextEditingController();
    alternativePhoneController = TextEditingController();
    orderIdController = TextEditingController();
    issueTypeController = TextEditingController();
    issueDetailsController = TextEditingController();
  }

  supportPress() {
    supportApiCall().then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          Get.back();
          isCancel.value = false;
          nameController!.text = "";
          alternativePhoneController!.text = "";
          orderIdController!.text = "";
          issueTypeController!.text = "";
          issueDetailsController!.text = "";
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

  supportApiCall() async {
    if (nameController!.text.isEmpty) {
      Get.snackbar(
        "Sorry!",
        "Name is required",
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
          "Name is required",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the message
          ),
        ),
      );
    } else if (issueDetailsController!.text.isEmpty) {
      Get.snackbar("Sorry!", "Details is required",
          backgroundColor: AppColors.secondary,
          duration: Duration(seconds: 1),
          icon: Icon(
            Icons.error_outline_sharp,
            color: Colors.red,
          ));
    } else if (alternativePhoneController!.text.isNotEmpty &&
        alternativePhoneController!.text.isNotEmpty &&
        alternativePhoneController!.text.isNumericOnly == false) {
      Get.snackbar(
        "Sorry!",
        "Phone number should be a number",
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
          "Phone number should be a number",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the message
          ),
        ),
      );
    } else {
      DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
        authorization: HiveStore().get(Keys.accessToken),
      );

      SupportSendModel model = SupportSendModel(
        mobile: HiveStore().get(Keys.userNumber).toString(),
        alternativeMobile: alternativePhoneController!.text,
        email: HiveStore().get(Keys.profileData)['email'].toString(),
        message: issueDetailsController!.text,
        name: nameController!.text,
        orderCode: orderIdController!.text,
        subject: isCancel.value
            ? cancelReason.value == "Cancel Order"
                ? "cancelorder"
                : "refundrequest"
            : "contactrequest",
      );

      var result = await CoreService().apiService(
        body: model.toJson(),
        header: headerModel.toHeader(),
        baseURL: baseUrl,
        method: METHOD.POST,
        endpoint: supportUrl,
      );
      return DefaultResponseModel.fromJson(result);
    }
  }

  returnReplaceRequestPress() {
    returnReplaceRequestApiCall().then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          Get.back();
          nameController!.text = "";
          alternativePhoneController!.text = "";
          orderIdController!.text = "";
          issueTypeController!.text = "";
          issueDetailsController!.text = "";
          returnRequest.value = "Return Request";
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

  returnReplaceRequestApiCall() async {
    if (nameController!.text.isEmpty) {
      Get.snackbar(
        "Sorry!",
        "Name is required",
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
          "Name is required",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the message
          ),
        ),
      );
    } else if (issueDetailsController!.text.isEmpty) {
      Get.snackbar(
        "Sorry!",
        "Details is required",
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
          "Details is required",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the message
          ),
        ),
      );
    } else if (alternativePhoneController!.text.isNotEmpty &&
        alternativePhoneController!.text.isNumericOnly == false) {
      Get.snackbar(
        "Sorry!",
        "Phone number should be a number",
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
          "Phone number should be a number",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the message
          ),
        ),
      );
    } else {
      DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
        authorization: HiveStore().get(Keys.accessToken),
      );

      SupportSendModel model = SupportSendModel(
        mobile: HiveStore().get(Keys.userNumber).toString(),
        alternativeMobile: alternativePhoneController!.text,
        email: HiveStore().get(Keys.profileData)['email'].toString(),
        message: issueDetailsController!.text,
        name: nameController!.text,
        orderCode: orderIdController!.text,
        subject: returnRequest.value == "Return Request"
            ? "returnorder"
            : "replaceorder",
      );

      var result = await CoreService().apiService(
        body: model.toJson(),
        header: headerModel.toHeader(),
        baseURL: baseUrl,
        method: METHOD.POST,
        endpoint: supportUrl,
      );
      return DefaultResponseModel.fromJson(result);
    }
  }
}
