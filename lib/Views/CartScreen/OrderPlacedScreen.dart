import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';

class OrderPlacedScreen extends StatelessWidget {
  final String? oderId;

  OrderPlacedScreen({this.oderId});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Get.offAllNamed(dashBoard);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: AppBar(
          backgroundColor: AppColors.secondary,
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
                      image: AssetImage(Assets.orderConfirmation),
                      fit: BoxFit.cover,
                    ),
                  )),
              Container(
                height: ScreenConstant.sizeLarge,
              ),
              Text(
                "Your order has been successfully\nPlaced. Wait for Approval.",
                style: TextStyles.orderPlaced,
                textAlign: TextAlign.center,
              ),
              Container(
                height: ScreenConstant.sizeXL,
              ),
              Text(
                "Your Order Id",
                style: TextStyles.orderPlacedOrderId,
              ),
              Container(
                height: ScreenConstant.sizeSmall,
              ),
              Text(
                oderId ?? "",
                style: TextStyles.orderPlacedId,
              ),
              Container(
                height: ScreenConstant.sizeXXL,
              ),
              AppButton(
                textStyle: TextStyle(color: AppColors.secondary),
                width: ScreenConstant.defaultWidthOneEighty,
                color: AppColors.buttonColorSecondary,
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
