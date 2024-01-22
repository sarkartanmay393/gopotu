import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';

class TypeOfProductListWidget extends StatelessWidget {
  final String? id;
  final String? name;
  final bool? isTap;

  TypeOfProductListWidget({this.id,this.name,this.isTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenConstant.sizeExtraSmall,
          vertical: ScreenConstant.sizeSmall),
      child: Container(
        decoration: BoxDecoration(
            color: isTap! ?AppColors.primary :AppColors.gapColor,
            borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: ScreenConstant.sizeSmall,
              right: ScreenConstant.sizeSmall,
              top: ScreenConstant.sizeDefault,
              bottom: ScreenConstant.sizeDefault),
          child: Text(
           name ?? "",
            style: isTap!?TextStyle(fontSize: FontSizeStatic.md, color: AppColors.secondary,fontWeight: FontWeight.bold):TextStyle(fontSize: FontSizeStatic.md, color: AppColors.accentColor,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
