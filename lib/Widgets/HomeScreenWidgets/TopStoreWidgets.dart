import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';

class TopStoreWidgets extends StatelessWidget {
  final int? index;
  final List<dynamic>? topStore;

  TopStoreWidgets({
    this.index,
    this.topStore,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(storeDetails,
            arguments: JsonEncoder().convert({
              "id": topStore![index!]['shop_id'].toString(),
              "isFavourite": false
            }));
      },

      child:  Container(


        width: ScreenConstant.defaultHeightOneHundredEifhty,
        height: ScreenConstant.defaultHeightOneHundredNighty,
          child:
          topStore![index!]['image'] != null
              ? CachedNetworkImage(
            imageUrl: topStore![index!]['image_path'],
            width: ScreenConstant.defaultHeightOneHundredEifhty,
            height: ScreenConstant.defaultHeightOneHundredNighty,

          )
              :
          Image.asset("assets/temporary/cashpay.png",
          fit: BoxFit.fill,),
        )

    );
  }
}
// child: Container(
//   decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       // color: AppColors.topStoreWidgets,
//       color: topStore![index!]['status'].toString() == '0'
//           ? Colors.grey.shade300
//           : AppColors.topStoreWidgets, //changes_new
//       border: Border.all(color: AppColors.topStoreWidgetsBorder)),
//   child: Padding(
//     padding: EdgeInsets.only(
//         right: ScreenConstant.defaultHeightNinety,
//         top: ScreenConstant.sizeSmall,
//         bottom: ScreenConstant.sizeSmall,
//         left: ScreenConstant.sizeLarge),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           topStore![index!]['shop_name'],
//           style: TextStyles.topStoreTitle,
//         ),
//         topStore![index!]['availableproducts'] == "0"
//             ? Offstage()
//             : Container(
//                 height: ScreenConstant.sizeExtraSmall,
//               ),
//         topStore![index!]['availableproducts'] == "0"
//             ? Offstage()
//             : Text(
//                 topStore![index!]['availableproducts'] == 1
//                     ? "${topStore![index!]['availableproducts']}  Product"
//                     : "${topStore![index!]['availableproducts'] - 1} + Products",
//                 style: TextStyles.topStoreSubTitle,
//               ),
//         topStore![index!]['availableproducts'] == "0"
//             ? Offstage()
//             : Container(
//                 height: ScreenConstant.sizeExtraSmall,
//               ),
//         topStore![index!]['availableproducts'] == "0"
//             ? Offstage()
//             : Text(
//                 "available",
//                 style: TextStyles.topStoreSubTitle,
//               ),
//       ],
//     ),
//   ),
// ),