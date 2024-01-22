import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';

class ItemIncrementDecrementButton extends StatelessWidget {
  final double? marginHorizontal;
  final double? marginVertical;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final Function? incrementCart;
  final Function? decrementCart;
  final String? quantity;

  ItemIncrementDecrementButton(
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
      height: ScreenConstant.defaultHeightThirtyFive,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.green),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
              onTap: decrementCart as void Function()?,
              child: Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 20,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: 1.0, bottom: 1),
            child: Container(
              // margin: EdgeInsets.symmetric(
              //     horizontal: marginHorizontal ?? 5,
              //     vertical: marginVertical ?? 0),
              // padding: EdgeInsets.symmetric(
              //     horizontal: paddingHorizontal ?? ScreenConstant.sizeMedium,
              //     vertical: paddingVertical ?? 5),
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(3), color: Colors.white),
              child: Text(
                quantity ?? "",
                style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.w600),
              ),
            ),
          ),
          InkWell(
              onTap: incrementCart as void Function()?,
              child: Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              )),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:go_potu_user/DeviceManager/Colors.dart';
// import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
//
// class ItemIncrementDecrementButton extends StatelessWidget {
//   final double? marginHorizontal;
//   final double? marginVertical;
//   final double? paddingHorizontal;
//   final double? paddingVertical;
//   final Function? incrementCart;
//   final Function? decrementCart;
//   final String? quantity;
//
//   ItemIncrementDecrementButton(
//       {this.marginHorizontal,
//         this.paddingHorizontal,
//         this.paddingVertical,
//         this.marginVertical,
//         this.incrementCart,
//         this.quantity,
//         this.decrementCart});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           color: AppColors.dashBoardChangeCategoryText),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           InkWell(
//               onTap: decrementCart as void Function()?,
//               child: Padding(
//                 padding: EdgeInsets.all(3.0),
//                 child: Icon(
//                   Icons.remove,
//                   color: Colors.white,
//                   size: 20,
//                 ),
//               )),
//           Padding(
//             padding: EdgeInsets.only(top: 1.0, bottom: 1),
//             child: Container(
//               margin: EdgeInsets.symmetric(
//                   horizontal: marginHorizontal ?? 5,
//                   vertical: marginVertical ?? 0),
//               padding: EdgeInsets.symmetric(
//                   horizontal: paddingHorizontal ?? ScreenConstant.sizeMedium,
//                   vertical: paddingVertical ?? 5),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3), color: Colors.white),
//               child: Text(
//                 quantity ?? "",
//                 style: TextStyle(color: Colors.black, fontSize: 16),
//               ),
//             ),
//           ),
//           InkWell(
//               onTap: incrementCart as void Function()?,
//               child: Padding(
//                 padding: EdgeInsets.all(3.0),
//                 child: Icon(
//                   Icons.add,
//                   color: Colors.white,
//                   size: 20,
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
// }