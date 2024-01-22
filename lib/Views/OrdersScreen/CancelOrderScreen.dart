import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';

class CancelOrderSuccessScreen extends StatelessWidget {
  final String? oderId;

  CancelOrderSuccessScreen({this.oderId});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Get.offAllNamed(dashBoard);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: AppColors.buttonColorPrimary,
        appBar: AppBar(
          backgroundColor: AppColors.buttonColorPrimary,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                height: ScreenConstant.screenHeightTwelve,
              ),
              Container(
                  width: ScreenConstant.defaultHeightTwoHundredTen,
                  height: ScreenConstant.defaultHeightTwoHundredTen,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: AssetImage(Assets.orderCancel),
                      fit: BoxFit.cover,
                    ),
                  )),
              Container(
                height: ScreenConstant.sizeXL,
              ),
              AppButton(
                textStyle: TextStyle(color: AppColors.accentColor),
                width: ScreenConstant.defaultWidthOneEighty,
                color: AppColors.secondary,
                buttonText: AppStrings.ContinueShopping,
                onPressed: () {
                  Get.offAllNamed(dashBoard);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
