import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';

class AddToCartNotShowButtonWidget1 extends StatelessWidget {
  final double? horizontalPadding;
  final double? verticalPadding;
  final Function? addToCart;

  AddToCartNotShowButtonWidget1(
      {this.horizontalPadding, this.verticalPadding, this.addToCart});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: addToCart as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.addressListWidgetBorderColor),
          borderRadius: BorderRadius.circular(5),
          color: AppColors.addressListWidgetBorderColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? ScreenConstant.sizeSmall,
            vertical: verticalPadding ?? ScreenConstant.sizeSmall,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ADD +",
                style: TextStyle(
                    color: AppColors.secondary,
                    letterSpacing: 2,
                    fontSize: FontSizeStatic.maxMd,
                    fontWeight: FontWeight.bold,
                    /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins'),
              ),
              Container(
                width: ScreenConstant.sizeExtraSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
