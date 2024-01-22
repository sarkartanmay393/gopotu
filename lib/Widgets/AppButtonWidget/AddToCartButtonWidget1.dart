import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';

import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';

class AddToCartButtonWidget1 extends StatelessWidget {
  final Function? addToCart;

  AddToCartButtonWidget1({this.addToCart});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: addToCart as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.green)

        ),
        width: ScreenConstant.defaultWidthSixty,
        height: ScreenConstant.defaultWidthTwenty,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2,),
              child: Text(
                "ADD +",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: FontSizeStatic.sm,color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
