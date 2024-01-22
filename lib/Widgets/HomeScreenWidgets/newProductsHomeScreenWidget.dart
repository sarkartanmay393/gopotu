import 'dart:convert';
import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class newProductsHomeScreenWidget extends StatelessWidget {
  final int? index;
  final List<dynamic>? productList;
  LinearGradient generateRandomGradient() {
    List<List<Color>> colors = [
      [
        Color(0xFF80CE51), // #80CE51
        Color.fromRGBO(128, 206, 81, 0.672691), // rgba(128, 206, 81, 0.672691)
        Color.fromRGBO(128, 206, 81, 0),
      ],
      [
        Color(0xFFCE8551), // #80CE51
        Color.fromRGBO(206, 152, 81, 0.6745098039215687), // rgba(128, 206, 81, 0.672691)
        Color.fromRGBO(128, 206, 81, 0),
      ],
      // Add two more colors here
      [
        Color(0xFF5180CE), // Example color
        Color.fromRGBO(81, 206, 128, 0.8), // Example color
        Color.fromRGBO(81, 206, 128, 0), // Example color
      ],
      [
        Color(0xFFCE5180), // Example color
        Color.fromRGBO(206, 81, 128, 0.8), // Example color
        Color.fromRGBO(206, 81, 128, 0), // Example color
      ],
    ];

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: index! % 4 == 0 ? colors[0] :
      index! % 4 == 1 ? colors[1] :
      index! % 4 == 2 ? colors[2] : colors[3],
      stops: [0.164, 0.8108, 1.6561],
      transform: GradientRotation(206.02 * 3.14 / 180),
    );
  }


  newProductsHomeScreenWidget({this.index, this.productList});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(right: ScreenConstant.sizeMedium),
      child: GestureDetector(
        onTap: () {

          // Get.toNamed(storeDetails,
          //     arguments: JsonEncoder().convert({
          //       "id": productList![index!]['id'].toString(),
          //       "isFavourite": false
          //     }));
          final ProductController _productController =
              Get.put(ProductController());
          HiveStore().put(Keys.isHomeScreen, "true");
          _productController.productId.value =
              productList![index!]['id'].toString();
          Future.delayed(Duration(milliseconds: 500), () {
            _productController.productDetailsPress(false);
          });
          Get.toNamed(
            productDetails,
          );
        },
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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            // color: Color(0x4C2AC5B8),
            gradient: generateRandomGradient(),
          ),
          width: ScreenConstant.defaultHeightOneHundred,
          height: ScreenConstant.defaultHeightForty,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenConstant.sizeExtraSmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(

                  width: ScreenConstant.defaultHeightSeventy,
                  height: ScreenConstant.defaultHeightNinety,
                  child:
                  productList![index!]['details']?['image_path'] != null
                      ? CachedNetworkImage(
                          imageUrl: productList![index!]['details']?['image_path'],
                        )
                      :
                  Image.asset("assets/temporary/pampers.png"),
                ),
                // Add some vertical spacing between the image and text
                Container(
                  child: Text(
                    (productList?[index!]['details']?['name'] ?? "Product").toString(),
                    style: TextStyles.productDetailsProductName,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
