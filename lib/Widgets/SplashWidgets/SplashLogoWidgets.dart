import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';

//
class SplashLogoWidget extends StatelessWidget {
  final double? height, width;
  final String? image;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final tag;

  const SplashLogoWidget(
      {Key? key,
      this.margin,
      this.padding,
      this.height,
      this.width,
      this.image,
      this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag ?? AppStrings.appName,
      child: image == null
          ? Container(
              margin: margin ?? EdgeInsets.zero,
              padding: padding ??
                  EdgeInsets.symmetric(
                    horizontal: ScreenConstant.screenWidthThird,
                  ),
              child: Image.asset(image!),
            )
          : Container(
              padding: padding ??
                  EdgeInsets.all(
                    160.0,
                  ),
              child: Image(
                image: AssetImage(image!),
                height: height ?? ScreenConstant.defaultImageHeight,
                fit: BoxFit.contain,
              ),
            ),
    );
  }
}
