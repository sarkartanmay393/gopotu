import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';

class ItemIncrementDecrementButton1 extends StatelessWidget {
  final double? marginHorizontal;
  final double? marginVertical;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final Function? incrementCart;
  final Function? decrementCart;
  final String? quantity;

  ItemIncrementDecrementButton1(
      {this.marginHorizontal,
      this.paddingHorizontal,
      this.paddingVertical,
      this.marginVertical,
      this.incrementCart,
      this.quantity,
      this.decrementCart});

  @override
  Widget build(BuildContext context) {
    return Container(

      height: ScreenConstant.sizeExtraLarge,
      width: ScreenConstant.defaultHeightSixtySeven,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.green),
      child: Row(
        children: [
          Container(
            width: ScreenConstant.defaultHeightFifteen,
            height: ScreenConstant.screenWidthFifteen,
            child: InkWell(
                onTap: decrementCart as void Function()?,
                child: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 14,
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.0, bottom: 1),
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: marginHorizontal ?? 5,
                  vertical: marginVertical ?? 0),
              padding: EdgeInsets.symmetric(
                  horizontal: paddingHorizontal ?? 5,
                  vertical: paddingVertical ?? 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),),
              child: Text(
                quantity ?? "",
                style: TextStyle(
                    color: Colors.white, fontSize: FontSizeStatic.semiSm,fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Container(
            width: ScreenConstant.defaultHeightFifteen,
            height: ScreenConstant.screenWidthFifteen,
            child: InkWell(
                onTap: incrementCart as void Function()?,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 14,
                )),
          ),
        ],
      ),
    );
  }
}
