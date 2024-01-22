import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/CategoryController/CategoryController.dart';
import 'package:go_potu_user/Controller/DashboardController/DashboardController.dart';
import 'package:go_potu_user/Controller/ProductController/ProductController.dart';
import 'package:go_potu_user/Controller/SubCategoryController/SubCategoryController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartButtonWidget.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartNotShowButton.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/ItemIncrementDecrementButton.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../Controller/CategoryController/CategoryController.dart';

class ProductHomeScreenWidget extends StatelessWidget {
  final int? index;
  final List<dynamic>? productList;

  ProductHomeScreenWidget({
    this.index,
    this.productList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: ScreenConstant.sizeSmall),
      child: GestureDetector(
        onTap: () {
          final CategoryController categoryController =
          Get.put(CategoryController());
          categoryController.categoryId.value = productList![index!]['id'].toString();
          Get.toNamed(shop);
        },

        child: Container(
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.red)
          // ),
          // width: ScreenConstant.defaultHeightForty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: ScreenConstant.defaultHeightSeventySix,
                  height: ScreenConstant.defaultHeightSeventySix,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10.0),
                  //   border: Border.all(color:Color(0x4C2AC5B8) ),
                  //
                  // ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    // color: Color(0x4C2AC5B8),
                    color: Colors.grey.shade100,
                  ),
                  child: productList![index!]['icon_path'] != null
                      ? CachedNetworkImage(
                          imageUrl: productList![index!]['icon_path'],
                        )
                      : Image.asset("assets/temporary/onion.png")

                  // CachedNetworkImage(
                  //   imageUrl: productList![index!]['icon_path'],
                  // ),
                  ),
              // SizedBox(
              //   height: ScreenConstant.defaultHeightTen,
              // ), // Add some vertical spacing between the image and text
              Container(
                child: Text(
                  productList![index!]['name'],
                  style: TextStyles.productDetailsProductName
                      .copyWith(fontSize: FontSizeStatic.sm),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
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