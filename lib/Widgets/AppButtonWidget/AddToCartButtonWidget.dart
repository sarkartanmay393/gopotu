import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';

class AddToCartButtonWidget extends StatelessWidget {
  final double? horizontalPadding;
  final double? verticalPadding;
  final Function? addToCart;

  AddToCartButtonWidget(
      {this.horizontalPadding, this.verticalPadding, this.addToCart});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: addToCart as void Function()?,
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.green),
          borderRadius:
          BorderRadius.circular(10.0),

        ),
        child: Padding(
          padding:
              EdgeInsets.only(right: ScreenConstant.defaultHeightTwentyThree,top:10),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: ScreenConstant.defaultHeightTen,
                left: ScreenConstant.screenWidthFifteen),
            child: Text(
              "ADD +",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: FontSizeStatic.md,color: Colors.green),
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:go_potu_user/DeviceManager/Colors.dart';
// import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
// import 'package:go_potu_user/DeviceManager/TextStyles.dart';
//
// class AddToCartButtonWidget extends StatelessWidget {
//   final double? horizontalPadding;
//   final double? verticalPadding;
//   final Function? addToCart;
//
//   AddToCartButtonWidget(
//       {this.horizontalPadding, this.verticalPadding, this.addToCart});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: addToCart as void Function()?,
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: AppColors.dashBoardChangeCategoryText),
//           borderRadius: BorderRadius.circular(5),
//           color: AppColors.addToCart,
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: horizontalPadding ?? ScreenConstant.sizeSmall,
//             vertical: verticalPadding ?? ScreenConstant.sizeSmall,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "ADD",
//                 style: TextStyles.addToCart,
//               ),
//               Container(
//                 width: ScreenConstant.sizeExtraSmall,
//               ),
//               Icon(
//                 Icons.add,
//                 color: AppColors.dashBoardChangeCategoryText,
//                 size: ScreenConstant.sizeLarge,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }