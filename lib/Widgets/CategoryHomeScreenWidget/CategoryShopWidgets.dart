import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_potu_user/Controller/CategoryController/CategoryController.dart';
import 'package:go_potu_user/Controller/StoreController/StoreController.dart';

import '../../Controller/DashboardController/DashboardController.dart';
import '../../DeviceManager/Assets.dart';
import '../../DeviceManager/Colors.dart';
import '../../DeviceManager/ScreenConstants.dart';
import '../../DeviceManager/TextStyles.dart';
import '../../Router/RouteConstants.dart';

class CategoryShopWidgets extends StatelessWidget {
  final Function? onTap;
  final int? index;
  final List<dynamic>? nearestStore;
  final DashboardController _dashboardController = Get.find();

  @override
  CategoryShopWidgets({this.onTap, this.index, this.nearestStore});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Padding(
        padding: EdgeInsets.only(
            bottom: ScreenConstant.sizeSmall, top: ScreenConstant.sizeSmall),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius:
                  BorderRadius.circular(ScreenConstant.sizeMedium),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 5.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),

            // height: ScreenConstant.defaultWidthOneNinety,
            width: ScreenConstant.defaultWidthOneNinety,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    nearestStore![index!]['rating'] == null
                        ? Offstage()
                        : Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              nearestStore![index!]['rating'].toString() +
                                  " ⭐",
                              style: TextStyle(
                                  fontSize: FontSizeStatic.md, fontWeight: FontWeight.bold),
                            ),
                          ),
                    Container(

                      height: ScreenConstant.defaultHeightThirtyFive,
                      width: ScreenConstant.defaultHeightEightyTwo,
                      child: nearestStore![index!]['Offer'] != null
                          ? Offstage()
                          : Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(
                                    ScreenConstant.sizeMedium),
                                bottomLeft: Radius.circular(
                                    ScreenConstant.sizeMedium),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "20% off",
                                      style: TextStyle(
                                          fontSize: FontSizeStatic.md,
                                          color: Colors.white),
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
                        child: CachedNetworkImage(
                          imageUrl: nearestStore![index!]['shop_logo_path'] ??
                              "https://corp.sellerscommerce.com//SCAssets/images/noimage.png",
                          placeholder: (context, url) =>
                              Image.asset(Assets.loadingImageGif),
                          errorWidget: (context, url, error) => Image.network(
                              "https://corp.sellerscommerce.com//SCAssets/images/noimage.png"),
                          height: ScreenConstant.defaultHeightOneHundred,
                          width: ScreenConstant.defaultHeightTwoHundred,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: ScreenConstant.sizeMedium,
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
                        child: Text(
                          nearestStore![index!]['shop_name'],
                          style: TextStyles.topStoreTitle.copyWith(fontSize: FontSizeStatic.lg),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   height: ScreenConstant.sizeExtraSmall,
                // ),
                GestureDetector(
                  // onTap: () {
                  //   // Handle the onTap action here
                  //   StoreController().storeByCategoryApiCall(false, 23);
                  // },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.buttonColorSecondary, // Set your desired background color
                      borderRadius: BorderRadius.circular(12.0), // Set your desired border radius
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "View Items",
                        style: TextStyle(
                          fontSize: FontSizeStatic.sm,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
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
