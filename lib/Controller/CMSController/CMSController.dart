import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Models/ResponseModels/CMSPageResponseModel/CMSPageResponseModel.dart';
import 'package:go_potu_user/Models/ResponseModels/GetCompanyDetailsResponseModel/GetCompanyDetailsResponseModel.dart';
import 'package:go_potu_user/Models/ResponseModels/GetSocialLinksResponseModel/GetSocialLinksResponseModel.dart';
import 'package:go_potu_user/Models/SendModels/CMSPageSendModel/CMSPageSendModel.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';

class CMSController extends GetxController {
  var aboutUsData = Data().obs;
  var privacyData = Data().obs;
  var cancelData = Data().obs;
  var termsData = Data().obs;
  var replacementData = Data().obs;
  var companyDetailsData = CompanyDetailsData().obs;
  var socialLinksData = SocialLinksData().obs;

  cmsAboutUsPress(bool load, String slugString) {
    cmsAboutUsApiCall(load, slugString).then((result) async {
      if (result is CmsPageResponseModel) {
        if (result.status == "success") {
          aboutUsData.value = result.data!;
          getCompanyDetailsPress(false);
          getSocialLinksPress(false);
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

  cmsAboutUsApiCall(bool load, String slugString) async {
    CmsPageSendModel model = CmsPageSendModel(
      slug: slugString,
    );

    var result = await CoreService().apiService(
      body: model.toJson(),
      baseURL: baseUrl,
      loader: load,
      method: METHOD.POST,
      endpoint: cmsUrl,
    );
    return CmsPageResponseModel.fromJson(result);
  }

  cmsPrivacyPress(bool load, String slugString) {
    cmsPrivacyApiCall(load, slugString).then((result) async {
      if (result is CmsPageResponseModel) {
        if (result.status == "success") {
          privacyData.value = result.data!;
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

  cmsPrivacyApiCall(bool load, String slugString) async {
    CmsPageSendModel model = CmsPageSendModel(
      slug: slugString,
    );

    var result = await CoreService().apiService(
      body: model.toJson(),
      baseURL: baseUrl,
      loader: load,
      method: METHOD.POST,
      endpoint: cmsUrl,
    );
    return CmsPageResponseModel.fromJson(result);
  }

  cmsTermsPress(bool load, String slugString) {
    cmsTermsApiCall(load, slugString).then((result) async {
      if (result is CmsPageResponseModel) {
        if (result.status == "success") {
          termsData.value = result.data!;
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

  cmsTermsApiCall(bool load, String slugString) async {
    CmsPageSendModel model = CmsPageSendModel(
      slug: slugString,
    );

    var result = await CoreService().apiService(
      body: model.toJson(),
      baseURL: baseUrl,
      loader: load,
      method: METHOD.POST,
      endpoint: cmsUrl,
    );
    return CmsPageResponseModel.fromJson(result);
  }

  cmsReplacementPress(bool load, String slugString) {
    cmsReplacementApiCall(load, slugString).then((result) async {
      if (result is CmsPageResponseModel) {
        if (result.status == "success") {
          replacementData.value = result.data!;
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

  cmsReplacementApiCall(bool load, String slugString) async {
    CmsPageSendModel model = CmsPageSendModel(
      slug: slugString,
    );

    var result = await CoreService().apiService(
      body: model.toJson(),
      baseURL: baseUrl,
      loader: load,
      method: METHOD.POST,
      endpoint: cmsUrl,
    );
    return CmsPageResponseModel.fromJson(result);
  }

  getCompanyDetailsPress(bool load) {
    getCompanyDetailsApiCall(load).then((result) async {
      if (result is GetCompanyDetailsResponseModel) {
        if (result.status == "success") {
          companyDetailsData.value = result.data!;
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

  getCompanyDetailsApiCall(bool load) async {
    var result = await CoreService().apiService(
      baseURL: baseUrl,
      loader: load,
      method: METHOD.POST,
      endpoint: companyDetailUrl,
    );
    return GetCompanyDetailsResponseModel.fromJson(result);
  }

  getSocialLinksPress(bool load) {
    getSocialLinksApiCall(load).then((result) async {
      if (result is GetSocialLinksResponseModel) {
        if (result.status == "success") {
          socialLinksData.value = result.data!;
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

  getSocialLinksApiCall(bool load) async {
    var result = await CoreService().apiService(
      baseURL: baseUrl,
      loader: load,
      method: METHOD.POST,
      endpoint: getSocialLinksUrl,
    );
    return GetSocialLinksResponseModel.fromJson(result);
  }

  cmsCancelPress(bool load, String slugString) {
    cmsCancelApiCall(load, slugString).then((result) async {
      if (result is CmsPageResponseModel) {
        if (result.status == "success") {
          cancelData.value = result.data!;
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

  cmsCancelApiCall(bool load, String slugString) async {
    CmsPageSendModel model = CmsPageSendModel(
      slug: slugString,
    );

    var result = await CoreService().apiService(
      body: model.toJson(),
      baseURL: baseUrl,
      loader: load,
      method: METHOD.POST,
      endpoint: cmsUrl,
    );
    return CmsPageResponseModel.fromJson(result);
  }
}
