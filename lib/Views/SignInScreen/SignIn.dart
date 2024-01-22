// import 'dart:html';  ---->changes

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/SignInController/SignInController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Views/OTPScreen/OTPScreen.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';
import 'package:go_potu_user/Widgets/TextFieldWidgets/RequireTextField.dart';

import 'ForgetPassWordScreen.dart';

class SignIn extends StatelessWidget {
  final SignInController _signInController = Get.put(SignInController());
  var _signInControllerText = TextEditingController();
  String? number;
  //string number is used to send the number from sign in page to otp verification page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.secondary,
        iconTheme: IconThemeData(
            color: HiveStore().get(Keys.guestToken) == null
                ? AppColors.secondary
                : AppColors.accentColor),
        /*actions: [
          GestureDetector(
            onTap: (){
              Get.offAndToNamed(addressList);
            },
              child: Text("Skip",style: TextStyle(
                color: AppColors.accentColor
              ),)),
          Container(
            width: ScreenConstant.sizeXL,
          ),
        ],*/
      ),

      //Making these Changes------->

      // This body contains the initial code block of login page for Gopotu App
/*
      body: Form(

        key: _signInController.formKey,
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
              height: ScreenConstant.sizeXXL,
            ),
            Text(
              AppStrings.hey,
              style: TextStyles.loginTitle,
            ),
            Text(
              AppStrings.loginNowFirst,
              style: TextStyles.loginTitle,
            ),
            Container(
              height: ScreenConstant.sizeSmall,
            ),
            //Text(AppStrings.ifYou,style: TextStyles.loginSubTitle,),
            Container(
              height: ScreenConstant.sizeXL,
            ),
            Text(
              "User ID",
              style: TextStyles.textFieldHints,
            ),
            Container(
              height: ScreenConstant.sizeExtraSmall,
            ),
            RequireTextField(
              enable: true,
              controller: _signInController.numberController,
              type: Type.emailandphone,
              hintText: "Email or Mobile",
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
              controller: _signInController.passwordController,
              type: Type.passWord,
              hintText: AppStrings.password,
            ),
            Container(
              height: ScreenConstant.sizeSmall,
            ),
            GestureDetector(
                onTap: () {
                  Get.to(ForgetPasswordScreen());
                },
                child: Text(AppStrings.forgotPasswordReset,
                    style: TextStyles.textFieldHints)),
            Container(
              height: ScreenConstant.sizeXXXL,
            ),
            AppButton(
              elevation: 0,
              color: AppColors.buttonColorSecondary,
              buttonText: AppStrings.loginNow,
              onPressed: () {
                _signInController.signInPress();
              },
              textStyle: TextStyles.bottomTextStyle,
            ),
            Container(
              height: ScreenConstant.sizeMedium,
            ),
            HiveStore().get(Keys.guestToken) == null
                ? SizedBox(
                    height: ScreenConstant.sizeXXXL,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            side:
                            BorderSide(color: AppColors.buttonColorSecondary),
                            borderRadius:
                            new BorderRadius.all(new Radius.circular(5))),
                        elevation: 0,
                        backgroundColor: AppColors.secondary,
                      ),

                      child: Text(
                        AppStrings.continueWithOutLogin,
                        textAlign: TextAlign.center,
                        style: TextStyles.bottomTextStyle2,
                      ),
                      onPressed: () {
                        _signInController.guestLoginPress();
                      },
                    ),
                  )
                : Offstage(),
            Container(
              height: ScreenConstant.sizeLarge,
            ),
            RichText(
              text: TextSpan(
                text: AppStrings.doNotHaveAccount,
                style: TextStyles.doNotAccount,
                children: <TextSpan>[
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(signUp);
                      },
                    text: AppStrings.createNewAccount,
                    style: TextStyles.newAccount,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
*/
      // ----------------The body block mentioned below is the new UI of login ----------------

      body: Form(
        key: _signInController.formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(ScreenConstant.sizeLarge),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      color: AppColors.secondary,
                      child: Image.asset(
                        Assets.splashLogo,
                        height: ScreenConstant.defaultHeightSeventySix,
                      ),
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeXXL,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      AppStrings.intro1,
                      style: TextStyles.loginTitle.copyWith(fontSize: 20),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      AppStrings.intro2,
                      style: TextStyles.loginTitle.copyWith(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeSmall,
                  ),
                  //Text(AppStrings.ifYou,style: TextStyles.loginSubTitle,),
                  Container(
                    height: ScreenConstant.sizeXL,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Mobile Number",
                      style: TextStyles.textFieldHints,
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeExtraSmall,
                  ),
                  TextField(
                    controller: _signInController.numberController,
                    decoration: InputDecoration(
                      hintText: "Enter your Number",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 300.0,
                  // ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the radius value as desired
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_signInController != null &&
                        _signInController.numberController != null &&
                        _signInController.numberController!.text != null) {
                      print(_signInController.numberController!.text);

                      number = _signInController.numberController!.text;
                      print("Number is: $number");

                      if (number!.length < 10) {
                        // Display the snackbar with the validation message
                        Get.snackbar(
                          "Sorry!",
                          "Mobile Number less than 10 digits.",
                          backgroundColor: AppColors.secondary,
                          duration: Duration(seconds: 1),
                          icon: Icon(
                            Icons.error_outline_sharp,
                            color: Colors.red,
                          ),
                          titleText: Text(
                            "Sorry!",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          messageText: Text(
                            "Mobile Number less than 10 digits.",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          ),
                        );
                      } else {
                        // Mobile number is valid, proceed to sign in
                        _signInController.signInPress();

                        // Navigate to OTPScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OTPScreen(number: number),
                          ),
                        );
                      }
                    } else {
                      print("Error: Unable to get number");
                    }
                    // The number will be passed from Signup screen to the Otp verification screen
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Same value as the container's borderRadius
                    ),
                    backgroundColor:
                        AppColors.buttonColorSecondary, // Background color
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      AppStrings.loginNow,
                      style: TextStyles.bottomTextStyle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
