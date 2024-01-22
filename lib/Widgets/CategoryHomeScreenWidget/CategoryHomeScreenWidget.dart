// import 'dart:convert';
//
// import 'package:flutter/animation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_potu_user/Controller/ProductController/ProductController.dart';
// import 'package:go_potu_user/Controller/StoreController/StoreController.dart';
// import 'package:go_potu_user/Controller/SubCategoryController/SubCategoryController.dart';
// import 'package:go_potu_user/DeviceManager/Assets.dart';
// import 'package:go_potu_user/DeviceManager/Colors.dart';
// import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
// import 'package:go_potu_user/DeviceManager/TextStyles.dart';
// import 'package:go_potu_user/Router/RouteConstants.dart';
// import 'package:go_potu_user/Store/HiveStore.dart';
// import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartButtonWidget.dart';
// import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartNotShowButton.dart';
// import 'package:go_potu_user/Widgets/AppButtonWidget/ItemIncrementDecrementButton.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// import '../../Controller/CategoryController/CategoryController.dart';
//
// class CategoryHomeScreenWidget extends StatelessWidget {
//   final Function? onTap;
//   final int? index;
//   final List<dynamic>? categoryList;
//
//   CategoryHomeScreenWidget({this.onTap,this.index, this.categoryList});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(right: ScreenConstant.sizeSmall),
//       child: GestureDetector(
//         onTap: (){
//           final CategoryController categoryController =
//           Get.put(CategoryController());
//           categoryController.categoryId.value = categoryList![index!]['id'].toString();
//           Get.toNamed(shop);
//         },
//
//         child: Container(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: ScreenConstant.defaultHeightNinety,
//                 height: ScreenConstant.defaultHeightNinety,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                   // color: Color(0x4C2AC5B8),
//                   color: Colors.grey.shade100,
//                 ),
//                 child: CachedNetworkImage(
//             width: ScreenConstant.defaultHeightOneHundredTen,
//                   imageUrl: categoryList?[index!]['icon_path'] ?? 'default_image_url',
//
//
//                   fit: BoxFit.fill,
//           ),
//
//         ),
//               SizedBox(
//                 height: ScreenConstant.defaultHeightTen,
//               ), // Add some vertical spacing between the image and text
//               Container(
//                 width: ScreenConstant.defaultHeightOneHundred,
//                 height: ScreenConstant.defaultHeightthirty,
//                 child: Text(
//                   categoryList![index!]['name'],
//                   style: TextStyles.productDetailsProductName,
//                   maxLines: 1,
//                   textAlign: TextAlign.center,
//                   // overflow: TextOverflow.ellipsis,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/CategoryController/subcategorycontroller.dart';
import 'package:go_potu_user/Controller/DashboardController/DashboardController.dart';
import 'package:go_potu_user/Controller/ProductController/ProductController.dart';
import 'package:go_potu_user/Controller/SplashController/SplashController.dart';
import 'package:go_potu_user/Controller/StoreController/StoreController.dart';
import 'package:go_potu_user/Controller/SubCategoryController/SubCategoryController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Views/ProductListScreen/SubCategoryProductListScreen.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartButtonWidget.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartNotShowButton.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/ItemIncrementDecrementButton.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../Controller/CategoryController/CategoryController.dart';
import 'SubCategoryScreen.dart';

class CategoryHomeScreenWidget extends StatelessWidget {
  final Function? onTap;
  final int? index;
  final List<dynamic>? categoryList;

  CategoryHomeScreenWidget({this.onTap,this.index, this.categoryList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: ScreenConstant.sizeSmall),
      child: GestureDetector(
        onTap: () {
          final SubCategoryController subCategoryController = Get.put(SubCategoryController());
          // final DashboardController dashboardController = Get.put(DashboardController());
          subCategoryController.subcategoryId.value = categoryList![index!]['id'].toString();

          subCategoryController.subCategoryListPress(true);
          String categoryName = categoryList![index!]['name'];
          Get.to(SubCategoryWidgetScreen(categoryName: categoryName));
        },


        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: ScreenConstant.defaultHeightNinety,
                height: ScreenConstant.defaultHeightSixtySeven,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  // color: Color(0x4C2AC5B8),
                  color: Colors.grey.shade200,
                ),
                child: CachedNetworkImage(
                  width: ScreenConstant.defaultHeightOneHundredTen,
                  imageUrl: categoryList?[index!]['icon_path'] ?? 'default_image_url',


                  fit: BoxFit.fill,
                ),

              ),
              SizedBox(
                height: ScreenConstant.defaultHeightTen,
              ), // Add some vertical spacing between the image and text
              Container(
                width: ScreenConstant.defaultHeightOneHundred,
                height: ScreenConstant.defaultHeightthirty,
                child: Text(
                  categoryList![index!]['name'],
                  style: TextStyles.productDetailsProductName,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  // overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
