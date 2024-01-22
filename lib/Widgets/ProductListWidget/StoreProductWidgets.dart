import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddToCartController/AddToCartController.dart';

import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartButtonWidget.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartButtonWidget1.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartNotShowButton.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/ItemIncrementDecrementButton.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/ItemIncrementDecrementButtonWidget1.dart';
import 'package:http/http.dart';

import '../../Controller/DashboardController/DashboardController.dart';
import '../../Controller/ProductController/ProductController.dart';
import '../../DeviceManager/Assets.dart';
import '../../DeviceManager/Colors.dart';
import '../../DeviceManager/ScreenConstants.dart';
import '../../DeviceManager/TextStyles.dart';
import '../../Router/RouteConstants.dart';
import '../AppButtonWidget/AddToCartNotShowButton1.dart';

class StoreProductWidgets extends StatelessWidget {
  final String? productName;
  // final String listingPrice;
  final String? purchasePrice;
  final String? fakePrice;
  final String? variant;
  final String? productImage;
  final String? productId;
  final bool? addCart;
  final String? productCartQuantity;
  final String? shopId;
  final String? variantId;
  final bool? isStore;
  final bool? isProductDetails;
  final int? productQuantity;
  final bool? isProductVariant;
  final String? availability;
  final bool? isDeliverable;
  final bool? color;
  final String? id;
  final int? index;
  final int? createdAt;
  final String? food_type;
  final List<dynamic>? nearestStore;
  String seletedType;
  // final DashboardController _dashboardController = Get.find();
  final AddToCartController _cartController = Get.put(AddToCartController());
  final ProductController _productController = Get.put(ProductController());

  @override
  StoreProductWidgets(
      {this.food_type,
      // this.listingPrice,
      this.purchasePrice,
      this.productName,
      this.fakePrice,
      this.variant,
      this.productImage,
      this.productId,
      this.addCart,
      this.productCartQuantity,
      this.shopId,
      this.variantId,
      this.isStore = false,
      this.isProductDetails = false,
      this.productQuantity,
      this.isProductVariant,
      this.availability,
      this.color,
      this.isDeliverable,
      this.id,
      this.index,
      this.createdAt,
      this.nearestStore,
      this.productList,
      required this.seletedType});

  @override
  final List<dynamic>? productList;

  Widget build(BuildContext context) {
    var product = "₹${productName}";
    var productPrice = "₹${purchasePrice}";
    print("jskksks  ${food_type}");
    print(productId);
    print(productPrice);

    Color determineColor(String foodType) {
      String shopType = HiveStore().get(Keys.shopType);

      if (shopType == 'mart') {
        return Colors.green;
      } else if (shopType == 'restaurant') {
        return foodType == 'veg' ? Colors.green : Color(0xFFD80500);
      } else {
        throw Exception('Unsupported shop type: $shopType');
      }
    }

    int fakePriceInt = int.parse(fakePrice!);
    int purchasePriceInt = int.parse(purchasePrice!);
    double discountPercentage =
        ((fakePriceInt - purchasePriceInt) / fakePriceInt) * 100;
    print(_productController.productDetailsData.value.product?.createdAt
        .toString());
    return GestureDetector(
      // onTap: () {
      //   final ProductController _productController =
      //       Get.put(ProductController());
      //   _productController.productId.value = productId!;
      //   Future.delayed(Duration(milliseconds: 500), () {
      //     _productController.productDetailsPress(false);
      //   });
      //   Get.toNamed(
      //     productDetails,
      //   );
      // },

      child: Padding(
        padding: EdgeInsets.only(bottom: ScreenConstant.sizeSmall),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenConstant.sizeMedium),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0, 2),
                ),
              ],
            ),

            // height: ScreenConstant.defaultWidthOneNinety,
            width: ScreenConstant.defaultWidthOneEighty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // nearestStore![index!]['avg_rating'] == null
                    //     ? Offstage() :
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10.0),
                    //   child: Text(
                    //     // nearestStore![index!]['avg_rating'].toString() +
                    //     " 4.5⭐",
                    //     style: TextStyle(
                    //         fontSize: FontSizeStatic.md,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: ScreenConstant.sizeSmall),
                      child: Container(
                        width: ScreenConstant.defaultWidthTwenty,
                        height: ScreenConstant.defaultWidthTwenty,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: determineColor(food_type!),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              // Handle radio button tap
                              print('Radio button tapped');
                            },
                            child: Container(
                              width: ScreenConstant.defaultWidthTen,
                              height: ScreenConstant.defaultWidthTen,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: determineColor(
                                    food_type!), // Call a function to determine color
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      height: ScreenConstant.defaultHeightTwentyfive,
                      width: ScreenConstant.defaultHeightSixtyEight,
                      child:
                          // nearestStore![index!]['Offer'] != null
                          //     ? Offstage():
                          Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                            topRight:
                                Radius.circular(ScreenConstant.sizeMedium),
                            bottomLeft:
                                Radius.circular(ScreenConstant.sizeMedium),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Container(
                                  width: ScreenConstant.sizeXXXL,
                                  child: Text(
                                    "${discountPercentage.toStringAsFixed(0)}% off",
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenConstant.sizeSmall,
                ),
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Center(
                        child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(ScreenConstant.sizeExtraSmall),
                      ),
                      child: Container(
                        height: 80,
                        width: 80,
                        child: GestureDetector(
                            onTap: () {
                              final ProductController _productController =
                                  Get.put(ProductController());
                              _productController.productId.value = productId!;
                              Future.delayed(Duration(milliseconds: 500), () {
                                _productController.productDetailsPress(false);
                              });
                              Get.toNamed(
                                productDetails,
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl: productImage ??
                                  "https://corp.sellerscommerce.com//SCAssets/images/noimage.png",
                              placeholder: (context, url) =>
                                  Image.asset(Assets.loadingImageGif),
                              errorWidget: (context, url, error) => Image.network(
                                  "https://corp.sellerscommerce.com//SCAssets/images/noimage.png"),
                              height: ScreenConstant.defaultHeightFifty,
                              width: ScreenConstant.defaultHeightFifty,
                              fit: BoxFit.fill,
                            )),
                      ),
                    ))
                  ],
                ),
                Container(
                  height: ScreenConstant.sizeExtraSmall,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenConstant.sizeSmall,
                    //vertical: ScreenConstant.sizeSmall
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          child: Text(
                            // nearestStore![index!]['details']['name']?? "Nothing",
                            productName ?? "Nothing",

                            style: TextStyles.topStoreTitle
                                .copyWith(fontSize: FontSizeStatic.sm),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenConstant.sizeMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "₹${fakePrice}",
                            style: TextStyle(
                              fontSize: FontSizeStatic.maxMd,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "₹${purchasePrice}",
                            style: TextStyle(
                                fontSize: FontSizeStatic.maxMd,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    )),
                    Container(
                      padding: EdgeInsets.only(
                          right: ScreenConstant.defaultHeightFifteen),
                      child: availability == "comingsoon"
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenConstant.sizeSmall,
                                  right: ScreenConstant.sizeXXL),
                              child: Text(
                                "Coming Soon",
                                style: TextStyles.outOfStock,
                              ),
                            )
                          : isProductVariant!
                              ? Offstage()
                              : HiveStore().get(Keys.shopType) == "Mart"
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenConstant.sizeSmall,
                                          right: ScreenConstant.sizeXXL),
                                      child: addCart!
                                          ? !isDeliverable!
                                              ? AddToCartNotShowButtonWidget(
                                                  addToCart: () {},
                                                  horizontalPadding:
                                                      ScreenConstant.sizeLarge,
                                                  verticalPadding:
                                                      ScreenConstant
                                                          .sizeExtraSmall,
                                                )
                                              : ItemIncrementDecrementButton(
                                                  incrementCart: () {
                                                    _cartController.isStore
                                                        .value = isStore!;
                                                    _cartController
                                                            .isProductDetails
                                                            .value =
                                                        isProductDetails!;
                                                    _cartController
                                                        .shopId.value = shopId!;
                                                    _cartController.variantId
                                                        .value = variantId!;
                                                    _cartController
                                                        .addToCartPress(
                                                            "1", context);
                                                  },
                                                  decrementCart: () {
                                                    _cartController.isStore
                                                        .value = isStore!;
                                                    _cartController
                                                            .isProductDetails
                                                            .value =
                                                        isProductDetails!;
                                                    _cartController
                                                        .shopId.value = shopId!;
                                                    _cartController.variantId
                                                        .value = variantId!;
                                                    _cartController
                                                        .addToCartPress(
                                                            "-1", context);
                                                  },
                                                  quantity:
                                                      productCartQuantity!,
                                                )
                                          : !isDeliverable!
                                              ? AddToCartNotShowButtonWidget(
                                                  addToCart: () {},
                                                  horizontalPadding:
                                                      ScreenConstant.sizeLarge,
                                                  verticalPadding:
                                                      ScreenConstant
                                                          .sizeExtraSmall,
                                                )
                                              : AddToCartButtonWidget(
                                                  addToCart: () {
                                                    _cartController.isStore
                                                        .value = isStore!;
                                                    _cartController
                                                            .isProductDetails
                                                            .value =
                                                        isProductDetails!;
                                                    _cartController
                                                        .shopId.value = shopId!;
                                                    _cartController.variantId
                                                        .value = variantId!;
                                                    _cartController
                                                        .addToCartPress(
                                                            "1", context);
                                                  },
                                                  horizontalPadding:
                                                      ScreenConstant.sizeLarge,
                                                  verticalPadding:
                                                      ScreenConstant
                                                          .sizeExtraSmall,
                                                ),
                                    )
                                  : productQuantity != null &&
                                          productQuantity! < 1
                                      ? Text(
                                          "Out Of Stock",
                                          style: TextStyle(
                                              fontSize: FontSizeStatic.sm,
                                              color: Colors.red),
                                        )
                                      : addCart!
                                          ? !isDeliverable!
                                              ? AddToCartNotShowButtonWidget(
                                                  addToCart: () {},
                                                  horizontalPadding:
                                                      ScreenConstant.sizeLarge,
                                                  verticalPadding:
                                                      ScreenConstant
                                                          .sizeExtraSmall,
                                                )
                                              : ItemIncrementDecrementButton1(
                                                  incrementCart: () {
                                                    _cartController.isStore
                                                        .value = isStore!;
                                                    _cartController
                                                            .isProductDetails
                                                            .value =
                                                        isProductDetails!;
                                                    _cartController
                                                        .shopId.value = shopId!;
                                                    _cartController.variantId
                                                        .value = variantId!;
                                                    _cartController
                                                        .addToCartPress(
                                                            "1", context);
                                                  },
                                                  decrementCart: () {
                                                    _cartController.isStore
                                                        .value = isStore!;
                                                    _cartController
                                                            .isProductDetails
                                                            .value =
                                                        isProductDetails!;
                                                    _cartController
                                                        .shopId.value = shopId!;
                                                    _cartController.variantId
                                                        .value = variantId!;
                                                    _cartController
                                                        .addToCartPress(
                                                            "-1", context);
                                                  },
                                                  quantity:
                                                      productCartQuantity!,
                                                )
                                          : !isDeliverable!
                                              ? AddToCartNotShowButtonWidget1(
                                                  addToCart: () {},
                                                  horizontalPadding:
                                                      ScreenConstant.sizeLarge,
                                                  verticalPadding:
                                                      ScreenConstant
                                                          .sizeExtraSmall,
                                                )
                                              : AddToCartButtonWidget1(
                                                  addToCart: () {
                                                    _cartController.isStore
                                                        .value = isStore!;
                                                    _cartController
                                                            .isProductDetails
                                                            .value =
                                                        isProductDetails!;
                                                    _cartController
                                                        .shopId.value = shopId!;
                                                    _cartController.variantId
                                                        .value = variantId!;
                                                    _cartController
                                                        .addToCartPress(
                                                            "1", context);
                                                  },
                                                ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 8.0),
                    //   child: Container(
                    //     height: ScreenConstant.sizeXL,
                    //     width: ScreenConstant.defaultHeightSixty,
                    //     decoration: BoxDecoration(
                    //       color: Color(0xFF9CFCAC),
                    //       borderRadius: BorderRadius.circular(8),
                    //       border: Border.all(color: Color(0xFF37B24B))
                    //     ),
                    //     child: GestureDetector(
                    //       onTap: () {
                    //   if (availability == "comingsoon") {
                    //   // Handle "Coming Soon" case if needed
                    //   } else if (isProductVariant != null && isProductVariant!) {
                    //   // Handle product variant case if needed
                    //   } else {
                    //   // Perform the "Add to Cart" action
                    //   _cartController.isStore.value = isStore!;
                    //   _cartController.isProductDetails.value = isProductDetails!;
                    //   _cartController.shopId.value = shopId!;
                    //   _cartController.variantId.value = variantId!;
                    //   _cartController.addToCartPress("1", context);
                    //   }
                    //   },
                    //       child: Center(child: Text("ADD +",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),),
                    //     ),
                    //
                    //   ),
                    // ),
                  ],
                )
              ],
            )),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //         height: 250,
  //         decoration: BoxDecoration(
  //           color: Colors.grey.shade200,
  //           borderRadius: BorderRadius.circular(ScreenConstant.defaultHeightTen),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.white,
  //               blurRadius: 5.0,
  //               offset: Offset(0, 2),
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(left: 10.0),
  //                   child: Text(
  //                     "4.5 ⭐",
  //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
  //                   child: Container(
  //                     height: 40,
  //                     width: 90,
  //                     decoration: BoxDecoration(
  //                       color: Colors.green,
  //                       borderRadius: BorderRadius.only(
  //                         topRight: Radius.circular(10),
  //                         bottomLeft: Radius.circular(10),
  //                       ),
  //                     ),
  //                     child: Center(
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(right: 20.0),
  //                         child: Center(
  //                           child: Padding(
  //                             padding: const EdgeInsets.only(left: 10),
  //                             child: Text(
  //                               "20% off",
  //                               style: TextStyle(fontSize: 15, color: Colors.white),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //             SizedBox(height: 10),
  //             Container(
  //               height: 100,
  //               width: 200,
  //               child: Image.network(
  //                 "https://images.unsplash.com/photo-1533450718592-29d45635f0a9?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8anBnfGVufDB8fDB8fHww",
  //               ),
  //             ),
  //             SizedBox(height: 10),
  //             Container(
  //               child: Text(
  //                 "KP Mart",
  //                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //             SizedBox(height: 12),
  //             Container(
  //               height: 40,
  //               child: ElevatedButton(
  //                 style: ButtonStyle(
  //                   backgroundColor: MaterialStateProperty.all(Colors.green),
  //                 ),
  //                 child: Text(
  //                   "View Items",
  //                   style: TextStyle(fontSize: 18),
  //                 ),
  //                 onPressed: () {},
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //
  //
  //     ],
  //   );
  // }
}
