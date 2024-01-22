import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/SignInController/SignInController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';
import 'package:go_potu_user/Widgets/TextFieldWidgets/RequireTextField.dart';


class ForgetPasswordScreen extends StatelessWidget {

  final SignInController _signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          "Reset Password",
          style: TextStyles.appBarTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _signInController.formKey2,
          child: ListView(
            children: [
              Container(
                height: ScreenConstant.sizeXL,
              ),
              Text("Reset Password",style: TextStyle(
                fontSize: FontSizeStatic.xxl,
                fontWeight: FontWeight.bold,
                /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins',
                color: AppColors.primary,
              ),),
              Container(
                height: ScreenConstant.sizeSmall,
              ),
              Text("Enter the mobile number associated with your account and we'll send a new account password.",style: TextStyle(
                fontSize: FontSizeStatic.maxMd,
                /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
                color: AppColors.storeLocation,
              ),),
              Container(
                height: ScreenConstant.sizeXXXL,
              ),
              RequireTextField(
                enable: true,
                controller: _signInController.resetPasswordController,
                type: Type.phone,
                hintText: AppStrings.mobileNumber,
              ),
              Container(
                height: ScreenConstant.sizeXXL,
              ),
              AppButton(
                elevation: 0,
                buttonText: "Send Instructions",
                onPressed: (){
                  _signInController.resetPasswordPress();
                },
                textStyle: TextStyles.bottomTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
