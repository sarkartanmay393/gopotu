import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/DashboardController/DashboardController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Store/HiveStore.dart';

import '../../Router/RouteConstants.dart';

class StoreListWidget extends StatelessWidget {
  final Function? onTap;
  final int? index;
  final List<dynamic>? nearestStore;
  final DashboardController _dashboardController = Get.find();

  StoreListWidget({this.onTap, this.index, this.nearestStore});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Padding(
        padding: EdgeInsets.only(bottom: 2),

        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        // child: Column(
        //   children: <Widget>[
        //     Stack(
        //       alignment: Alignment.topRight,
        //       children: [
        //         CachedNetworkImage(
        //           imageUrl: nearestStore![index!]['shop_logo_path'],
        //           imageBuilder: (context, imageProvider) => Container(
        //             height: ScreenConstant.defaultHeightTwoHundredTen,
        //             decoration: BoxDecoration(
        //               //border: Border.all(color: AppColors.accentColor),
        //               image: DecorationImage(
        //                 image: imageProvider,
        //                 fit: BoxFit.cover,
        //                 colorFilter: nearestStore![index!]['status'] == "0"
        //                     ? ColorFilter.mode(Colors.black.withOpacity(0.2),
        //                         BlendMode.dstATop)
        //                     : null,
        //               ),
        //               borderRadius: BorderRadius.circular(15.0),
        //             ),
        //             child: Stack(
        //               children: <Widget>[
        //                 Positioned(
        //                     bottom: 0,
        //                     left: 0,
        //                     right: 0,
        //                     child: Container(
        //                       decoration: BoxDecoration(
        //                         color: Colors.white,
        //                       ),
        //                       child: Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: <Widget>[
        //                           Container(
        //                             height: ScreenConstant.sizeMedium,
        //                           ),
        //                           Padding(
        //                             padding: EdgeInsets.only(
        //                                 left: ScreenConstant.sizeSmall,
        //                                 right: ScreenConstant.sizeSmall,
        //                                 bottom:
        //                                     ScreenConstant.sizeExtraSmall),
        //                             child: Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.spaceBetween,
        //                               children: <Widget>[
        //                                 Text(
        //                                   nearestStore![index!]['shop_name'],
        //                                   style: TextStyles.productTitle,
        //                                 ),
        //                                 nearestStore![index!]['avg_rating'] ==
        //                                         0
        //                                     ? Offstage()
        //                                     : Container(
        //                                         decoration: BoxDecoration(
        //                                           borderRadius:
        //                                               BorderRadius.circular(
        //                                                   40),
        //                                           color: AppColors
        //                                               .dashBoardChangeCategoryText,
        //                                         ),
        //                                         child: Padding(
        //                                           padding:
        //                                               EdgeInsets.symmetric(
        //                                             horizontal: 10,
        //                                             vertical: 2,
        //                                           ),
        //                                           child: Center(
        //                                             child: Row(
        //                                               children: [
        //                                                 Text(
        //                                                   "${nearestStore![index!]['avg_rating']}",
        //                                                   style:
        //                                                       TextStyles.rate,
        //                                                 ),
        //                                                 Container(
        //                                                   width: ScreenConstant
        //                                                       .sizeExtraSmall,
        //                                                 ),
        //                                                 Icon(
        //                                                   Icons.star,
        //                                                   color: AppColors
        //                                                       .secondary,
        //                                                 )
        //                                               ],
        //                                             ),
        //                                           ),
        //                                         ),
        //                                       ),
        //                               ],
        //                             ),
        //                           ),
        //                           Container(
        //                             decoration: BoxDecoration(
        //                               // border: Border.all(color: AppColors.accentColor),
        //                               borderRadius: BorderRadius.only(
        //                                   bottomLeft: Radius.circular(15),
        //                                   bottomRight: Radius.circular(15)),
        //                             ),
        //                             padding: EdgeInsets.only(
        //                                 left: ScreenConstant.sizeSmall,
        //                                 right: ScreenConstant.sizeSmall),
        //                             child: ListView(
        //                               shrinkWrap: true,
        //                               physics: ClampingScrollPhysics(),
        //                               children: [
        //                                 Container(
        //                                   child: Text(
        //                                     nearestStore![index!]
        //                                                 ['shop_tagline'] ==
        //                                             null
        //                                         ? ""
        //                                         : "${nearestStore![index!]['shop_tagline']}",
        //                                     style: TextStyles.productSubTitle,
        //                                     overflow: TextOverflow.visible,
        //                                   ),
        //                                 ),
        //                                 Container(
        //                                   height:
        //                                       ScreenConstant.sizeExtraSmall,
        //                                 ),
        //                                 Divider(
        //                                   thickness: 1,
        //                                 ),
        //                                 Container(
        //                                   height:
        //                                       ScreenConstant.sizeExtraSmall,
        //                                 ),
        //                                 Row(
        //                                   children: [
        //                                     Icon(
        //                                       Icons.av_timer,
        //                                       color: AppColors
        //                                           .dashBoardChangeCategoryText,
        //                                     ),
        //                                     Container(
        //                                       width: ScreenConstant.sizeSmall,
        //                                     ),
        //                                     nearestStore![index!][
        //                                                     'distanceaway'] ==
        //                                                 null ||
        //                                             double.parse(nearestStore![
        //                                                         index!][
        //                                                     'distanceaway']) <
        //                                                 1.0
        //                                         ? Text(
        //                                             "< 1 Km away from you",
        //                                             style: TextStyles
        //                                                 .storeDistance,
        //                                           )
        //                                         : Text(
        //                                             "${nearestStore![index!]!['distanceaway']} Km away from you",
        //                                             style: TextStyles
        //                                                 .storeDistance,
        //                                           )
        //                                   ],
        //                                 ),
        //                                 Container(
        //                                   height: ScreenConstant.sizeSmall,
        //                                 ),
        //                               ],
        //                             ),
        //                           )
        //                         ],
        //                       ),
        //                     ))
        //               ],
        //             ),
        //           ),
        //           placeholder: (context, url) =>
        //               Image.asset(Assets.loadingImageGif),
        //           errorWidget: (context, url, error) => Image.network(
        //               "https://corp.sellerscommerce.com//SCAssets/images/noimage.png"),
        //         ),
        //         HiveStore().get(Keys.guestToken) == null
        //             ? Padding(
        //                 padding: const EdgeInsets.all(20.0),
        //                 child: Material(
        //                   elevation: 2,
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(40.0),
        //                     side: BorderSide(
        //                         color: AppColors.productListingScreenColor),
        //                   ),
        //                   child: Container(
        //                     height: ScreenConstant.sizeXL,
        //                     width: ScreenConstant.sizeXL,
        //                     decoration: BoxDecoration(
        //                         color: Colors.white,
        //                         border: Border.all(
        //                             color:
        //                                 AppColors.productListingScreenColor),
        //                         shape: BoxShape.circle),
        //                     child: Center(
        //                       child: GestureDetector(
        //                         onTap: () {
        //                           _dashboardController.shopId.value =
        //                               nearestStore![index!]['id'].toString();
        //                           _dashboardController
        //                               .setAsFavouritePress(true);
        //                         },
        //                         child: Obx(() => Icon(
        //                               Icons.favorite,
        //                               color: nearestStore![index!]
        //                                       ['is_wishlist']
        //                                   ? AppColors.primary
        //                                   : Colors.black26,
        //                               size: ScreenConstant.sizeLarge,
        //                             )),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               )
        //             : Offstage(),
        //       ],
        //     ),
        //
        //     /*Container(
        //       decoration: BoxDecoration(
        //         // border: Border.all(color: AppColors.accentColor),
        //         borderRadius: BorderRadius.only(
        //             bottomLeft: Radius.circular(15),
        //             bottomRight: Radius.circular(15)),
        //       ),
        //       padding: EdgeInsets.only(
        //           left: ScreenConstant.sizeSmall,
        //           right: ScreenConstant.sizeSmall),
        //       child: ListView(
        //         shrinkWrap: true,
        //         physics: ClampingScrollPhysics(),
        //         children: [
        //           Container(
        //             child: Text(
        //               "Burger, Fast food & BevarageBurger,",
        //               style: TextStyles.productSubTitle,
        //               overflow: TextOverflow.visible,
        //             ),
        //           ),
        //           Container(
        //             height: ScreenConstant.sizeExtraSmall,
        //           ),
        //           Divider(
        //             thickness: 1,
        //           ),
        //           Container(
        //             height: ScreenConstant.sizeExtraSmall,
        //           ),
        //           Row(
        //             children: [
        //               Icon(
        //                 Icons.av_timer,
        //                 color: AppColors.dashBoardChangeCategoryText,
        //               ),
        //               Container(
        //                 width: ScreenConstant.sizeSmall,
        //               ),
        //               Text(
        //                 "15 min away from you",
        //                 style: TextStyles.storeDistance,
        //               )
        //             ],
        //           ),
        //           Container(
        //             height: ScreenConstant.sizeSmall,
        //           ),
        //         ],
        //       ),
        //     )*/
        //   ],
        // ),
        // ----New
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: Colors.grey)),
            width: ScreenConstant.defaultWidthOneNinety,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors
                                .grey, // You can set the color of the border
                            width: 2.0, // You can set the width of the border
                          ),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: nearestStore![index!]['shop_logo_path'] ??
                            "https://corp.sellerscommerce.com//SCAssets/images/noimage.png",
                        placeholder: (context, url) =>
                            Image.asset(Assets.loadingImageGif),
                        errorWidget: (context, url, error) => Image.network(
                            "https://corp.sellerscommerce.com//SCAssets/images/noimage.png"),
                        height: ScreenConstant.defaultHeightOneHundredFifty,
                        width: ScreenConstant.defaultHeightTwoHundred,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: ScreenConstant.sizeSmall,
                    right: ScreenConstant.sizeSmall,
                    top: ScreenConstant.sizeSmall,
                    //vertical: ScreenConstant.sizeSmall
                  ),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            nearestStore![index!]['shop_name'],
                            style: TextStyles.topStoreTitle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: ScreenConstant.sizeSmall,
                    right: ScreenConstant.sizeSmall,
                  ),
                  child: Container(
                    height: ScreenConstant.sizeLarge,
                    child: nearestStore![index!]['avg_rating'] == 0
                        ? Offstage()
                        : Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                nearestStore != null && index != null && nearestStore!.length > index!
                                    ? nearestStore![index!]['avg_rating']?.toInt() ?? 0
                                    : 0,
                                    (index) {
                                  return Icon(
                                    Icons.star,
                                    color: AppColors.topStoreWidgetsBorder,
                                    size: FontSizeStatic.lg,
                                  );
                                },
                              ),
                            )

                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "Start your Grocery",
                    style: TextStyle(fontSize: FontSizeStatic.sm),
                  ),
                ),
                SizedBox(
                  height: ScreenConstant.sizeExtraSmall,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(storeDetails,
                        arguments: JsonEncoder().convert({
                          "id": _dashboardController.nearestStore[index!]['id']
                              .toString(),
                          "isFavourite": false
                        }));
                  },
                  child: Text(
                    "Order Now",
                    style: TextStyle(fontSize: FontSizeStatic.sm, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColorSecondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Set the border radius here
                    ),
                  ),
                ),

              ],
            )),
      ),
    );
  }
}
