import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/SignUpController/SignUpController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextFieldValidators.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';
import 'package:go_potu_user/Widgets/TextFieldWidgets/RequireTextField.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _signUpController = Get.put(SignUpController());

  bool indicator1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: AppColors.accentColor),
        backgroundColor: AppColors.secondary,
      ),
      body: Form(
        key: _signUpController.formKey,
        child: ListView(
          padding: EdgeInsets.all(ScreenConstant.sizeLarge),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                color: AppColors.secondary,
                child: Image.asset(
                  Assets.splashLogo,
                  height: ScreenConstant.defaultHeightSeventySix,
                ),
              ),
            ),
            Container(
              height: ScreenConstant.sizeMedium,
            ),
            Text(
              AppStrings.hey,
              style: TextStyles.loginTitle,
            ),
            Text(
              AppStrings.registerNow,
              style: TextStyles.loginTitle,
            ),
            Container(
              height: ScreenConstant.sizeSmall,
            ),
            Text(
              AppStrings.ifYou,
              style: TextStyles.loginSubTitle,
            ),
            Container(
              height: ScreenConstant.sizeXL,
            ),
            Text(
              AppStrings.firstName,
              style: TextStyles.textFieldHints,
            ),
            Container(
              height: ScreenConstant.sizeExtraSmall,
            ),
            RequireTextField(
              controller: _signUpController.firstNameController,
              type: Type.userFName,
              hintText: AppStrings.firstName,
            ),
            Container(
              height: ScreenConstant.sizeMedium,
            ),
            Text(
              AppStrings.lastName,
              style: TextStyles.textFieldHints,
            ),
            Container(
              height: ScreenConstant.sizeExtraSmall,
            ),
            RequireTextField(
              controller: _signUpController.lastNameController,
              type: Type.userLName,
              hintText: AppStrings.lastName,
            ),
            Container(
              height: ScreenConstant.sizeMedium,
            ),
            Text(
              AppStrings.mobileNumber,
              style: TextStyles.textFieldHints,
            ),
            Container(
              height: ScreenConstant.sizeExtraSmall,
            ),
            RequireTextField(
              enable: true,
              controller: _signUpController.phoneController,
              type: Type.phone,
              hintText: AppStrings.mobileNumber,
            ),
            Container(
              height: ScreenConstant.sizeMedium,
            ),
            Text(
              AppStrings.email,
              style: TextStyles.textFieldHints,
            ),
            Container(
              height: ScreenConstant.sizeExtraSmall,
            ),
            RequireTextField(
              controller: _signUpController.emailController,
              type: Type.email,
              hintText: AppStrings.email,
            ),
            Container(
              height: ScreenConstant.sizeMedium,
            ),
            Text(
              "Referral Code",
              style: TextStyles.textFieldHints,
            ),
            Container(
              height: ScreenConstant.sizeExtraSmall,
            ),
            TextFormField(
              controller: _signUpController.referralCodeController,
              keyboardType: TextInputType.text,
              autofocus: false,
              style: TextStyles.textFieldText,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
                hintText: "Referral Code",
                hintStyle: TextStyles.hintTextFieldHints,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.textFieldBorderColor,
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.textFieldBorderColor,
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
              ),
            ),
            Container(
              height: ScreenConstant.sizeMedium,
            ),
            Text(
              AppStrings.password,
              style: TextStyles.textFieldHints,
            ),
            Container(
              height: ScreenConstant.sizeExtraSmall,
            ),
            RequireTextField(
              controller: _signUpController.passwordController,
              type: Type.passWord,
              hintText: AppStrings.password,
            ),
            Container(
              height: ScreenConstant.sizeMedium,
            ),
            Text(
              AppStrings.confirmPassword,
              style: TextStyles.textFieldHints,
            ),
            Container(
              height: ScreenConstant.sizeExtraSmall,
            ),
            TextFormField(
              controller: _signUpController.confirmController,
              keyboardType: TextInputType.text,
              autofocus: false,
              obscureText: indicator1,
              maxLines: 1,
              style: TextStyles.textFieldText,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return Validator.validateConfirmPassword(
                    _signUpController.passwordController!.text, value!);
              },
              decoration: InputDecoration(
                hintText: AppStrings.confirmPassword,
                hintStyle: TextStyles.hintTextFieldHints,
                contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
                suffixIcon: IconButton(
                  icon: Icon(
                    indicator1
                        ? Icons.visibility_off_rounded
                        : Icons.visibility,
                    color: Colors.black,
                    size: ScreenConstant.sizeLarge,
                  ),
                  onPressed: () {
                    setState(() {
                      indicator1 = !indicator1;
                    });
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.textFieldBorderColor,
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.textFieldBorderColor,
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
              ),
            ),
            Container(
              height: ScreenConstant.sizeXXXL,
            ),
            AppButton(
              elevation: 0,
              buttonText: AppStrings.register,
              onPressed: () {
                _signUpController.signUpPress();
              },
              textStyle: TextStyles.bottomTextStyle,
            ),
            Container(
              height: ScreenConstant.sizeLarge,
            ),
            RichText(
              text: TextSpan(
                text: AppStrings.alreadyHaveAccount,
                style: TextStyles.doNotAccount,
                children: <TextSpan>[
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.offAllNamed(signIn);
                      },
                    text: AppStrings.login,
                    style: TextStyles.newAccount,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
