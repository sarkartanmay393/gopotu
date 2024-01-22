import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/SignUpController/SignUpController.dart';
import 'package:go_potu_user/Controller/OTPController/OTPController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextFieldValidators.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Models/ResponseModels/ReturnRefundDetailsResponseModel/ReturnRefundDetailsResponseModel.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';
import 'package:go_potu_user/Widgets/TextFieldWidgets/RequireTextField.dart';

class DetailsScreen extends StatefulWidget{
  final bool isNameNull;
  final bool isEmailNull;

  DetailsScreen({required this.isNameNull, required this.isEmailNull});


  @override
  State<DetailsScreen> createState()=> _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>{
  final SignUpController _signUpController = Get.put(SignUpController());

  bool indicator1 = true;



  @override
  Widget build(BuildContext context) {
    bool isNameNull= widget.isNameNull;
    bool isEmailNull= widget.isEmailNull;
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: AppColors.accentColor),
        backgroundColor: AppColors.secondary,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Form(
          key: _signUpController.formKey,
          child: ListView(
            padding: EdgeInsets.all(ScreenConstant.sizeLarge),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Center(
                child: Text(
                  AppStrings.almostThere,
                  style: TextStyles.loginTitle.copyWith(fontSize: FontSizeStatic.xxl),
                ),
              ),
              Container(
                height: ScreenConstant.sizeExtraLarge,
              ),
              if (isNameNull) // Conditionally show the "Name" field only if isNameNull is true
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.fullName,
                      style: TextStyles.textFieldHints,
                    ),
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    RequireTextField(
                      controller: _signUpController.firstNameController,
                      type: Type.userFirstName,
                      hintText: "Enter Your Name",
                    ),
                    Container(
                      height: ScreenConstant.sizeMedium,
                    ),
                    if (isEmailNull) // Conditionally show the "Email" field only if isEmailNull is true
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.email,
                            style: TextStyles.textFieldHints,
                          ),
                          Container(
                            height: ScreenConstant.sizeExtraSmall,
                          ),
                          RequireTextField(
                            controller: _signUpController.emailController,
                            type: Type.useremail,
                            hintText: AppStrings.email,
                          ),
                          Container(
                            height: ScreenConstant.sizeMedium,
                          ),
                        ],
                      ),
                  ],
                )
              ,


              // Text(
              //   AppStrings.email,
              //   style: TextStyles.textFieldHints,
              // ),
              // Container(
              //   height: ScreenConstant.sizeExtraSmall,
              // ),
              // RequireTextField(
              //   controller: _signUpController.emailController,
              //   type: Type.useremail,
              //   hintText: AppStrings.email,
              // ),

              Text(
                "Referral Code (optional)",
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
                    borderRadius: BorderRadius.circular(50),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.textFieldBorderColor,
                        width: 1.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(50),
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


              AppButton(
                elevation: 0,
                buttonText: AppStrings.Continue,
                onPressed: () {
                  _signUpController.signUpPress();
                  // Get.offAllNamed(home);
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
