import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/ProfileController/ProfileController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';
import 'package:go_potu_user/Widgets/TextFieldWidgets/RequireTextField.dart';


class ChangePasswordScreen extends StatelessWidget {

  final ProfileController _profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          AppStrings.changePassword,
          style: TextStyles.appBarTitle,
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.all(ScreenConstant.sizeLarge),
        child: Form(
          key: _profileController.formKey,
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Container(
                height: ScreenConstant.sizeLarge,
              ),
              Center(
                child: Container(
                  height: ScreenConstant.defaultHeightSeventySix,
                  width: ScreenConstant.defaultHeightSeventySix,
                  child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage(
                      Assets.forgotPassword,
                    ),),
                ),
              ),
              Container(
                height: ScreenConstant.sizeLarge,
              ),
              Center(child: Text("Create New Password",style: TextStyle(
                fontSize: FontSizeStatic.xll,
                fontWeight: FontWeight.bold
              ),)),
              Container(
                height: ScreenConstant.sizeSmall,
              ),
              Text("Your new password must be different form\n previously used password.",textAlign: TextAlign.center,style: TextStyle(
              fontSize: FontSizeStatic.maxMd,color: AppColors.searchLevelText
              ),),
              Container(
                height: ScreenConstant.sizeXXXL,
              ),
              Text(AppStrings.oldPassword,style: TextStyles.textFieldHints,),
              Container(
                height: ScreenConstant.sizeExtraSmall,
              ),
              RequireTextField(
                controller: _profileController.oldPass,
                type: Type.passWord,
                hintText: AppStrings.password,
              ),
              Container(
                height: ScreenConstant.sizeLarge,
              ),
              Text(AppStrings.newPassword,style: TextStyles.textFieldHints,),
              Container(
                height: ScreenConstant.sizeExtraSmall,
              ),
              RequireTextField(
                controller: _profileController.newPass,
                type: Type.passWord,
                hintText: AppStrings.password,
              ),
              Container(
                height: ScreenConstant.sizeLarge,
              ),
              Text(AppStrings.confirmPassword,style: TextStyles.textFieldHints,),
              Container(
                height: ScreenConstant.sizeExtraSmall,
              ),
              RequireTextField(
                controller: _profileController.newConfirmPass,
                type: Type.passWord,
                hintText: AppStrings.password,
              ),
              Container(
                height: ScreenConstant.sizeXXL,
              ),
              AppButton(
                onPressed: (){
                  _profileController.changePasswordPress();
                },
                color: AppColors.buttonColorSecondary,
                buttonText: AppStrings.changePassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
