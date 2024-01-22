import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';

class AppButton extends StatelessWidget {
  final String? buttonText;
  final Function? onPressed;
  final double? width;
  final Color? color;
  final TextStyle? textStyle;
  final double? elevation;

  AppButton(
      {this.buttonText,
      this.onPressed,
      this.width,
      this.color,
      this.textStyle,
      this.elevation});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenConstant.sizeXXXL,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.all(new Radius.circular(5))),
          elevation: elevation ?? 0,
          backgroundColor: color ?? AppColors.buttonColorSecondary,
        ),
        child: Text(
          buttonText ?? "Test",
          textAlign: TextAlign.center,
          style: textStyle ??
              TextStyle(
                  color: AppColors.secondary,
                  fontSize: FontSizeStatic.md,
                  /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
        ),
        onPressed: onPressed as void Function()?,
      ),
    );
  }
}
