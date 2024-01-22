import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/MyBucketController/MyBucketController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Models/ResponseModels/GetMyBucketResponseModel/GetMyBucketResponseModel.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/ItemIncrementDecrementButton.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/ItemIncrementDecrementButtonWidget1.dart';

class CartProductListWidget extends StatelessWidget {
  final int? index;
  final List<Item>? items;
  final bool? isDeliverable;
  final String? isCouponCode;

  CartProductListWidget(
      {this.index, this.items, this.isDeliverable, this.isCouponCode});

  @override
  bool _isRadioButtonSelected = false;
  Widget build(BuildContext context) {
    double calculateTotalPrice(double purchasePrice, int quantity) {
      return purchasePrice * quantity;
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                /*decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(
                      items[index].variant.product.imagePath,
                    )),
              ),*/
                child: Container(
              width: ScreenConstant.defaultHeightTwentyfive,
              height: ScreenConstant.defaultHeightTwentyfive,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Colors.green, width: 4),
              ),
              child: Center(
                child: Container(
                  height: ScreenConstant.defaultWidthTen,
                  width: ScreenConstant.defaultWidthTen,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
              ),
            )

                // child: CachedNetworkImage(
                //   imageUrl: items![index!].variant!.product!.details?.imagePath ??
                //       "https://corp.sellerscommerce.com//SCAssets/images/noimage.png",
                //   placeholder: (context, url) =>
                //       Image.asset(Assets.loadingImageGif),
                //   errorWidget: (context, url, error) => Image.network(
                //       "https://corp.sellerscommerce.com//SCAssets/images/noimage.png"),
                //   height: ScreenConstant.defaultHeightSeventy,
                //   width: ScreenConstant.defaultHeightSeventy,
                //   fit: BoxFit.contain,
                // ),
                ),
            Container(
              width: ScreenConstant.sizeSmall,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: ScreenConstant.defaultHeightEightyTwo,
                        child: Text(
                          items![index!].variant!.product!.details!.name ?? "",
                          style: TextStyles.productListTitleOnOrderListing,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: ScreenConstant.defaultHeightFortyFive,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          !isDeliverable!
                              ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.addressListWidgetBorderColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    MyBucketController myBucketController = Get.find();
                                    myBucketController.addToCartPress(
                                      items![index!].shopId.toString(),
                                      items![index!].variantId.toString(),
                                      '-1', // Decrement by 1
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 1.0, bottom: 1),
                                  child: Container(
                                    margin:
                                    EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenConstant.sizeMedium, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.white),
                                    child: Text(
                                      items![index!].quantity.toString(),
                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    MyBucketController myBucketController = Get.find();
                                    myBucketController.addToCartPress(
                                      items![index!].shopId.toString(),
                                      items![index!].variantId.toString(),
                                      '1', // Increment by 1
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                              : ItemIncrementDecrementButton1(
                            quantity: items![index!].quantity.toString(),
                            decrementCart: isCouponCode!.isEmpty
                                ? () {
                              MyBucketController myBucketController = Get.find();
                              myBucketController.addToCartPress(
                                items![index!].shopId.toString(),
                                items![index!].variantId.toString(),
                                '-1',
                              );
                            }
                                : () {
                              showAlertDialog(context);
                            },
                            incrementCart: () {
                              MyBucketController myBucketController = Get.find();
                              myBucketController.addToCartPress(
                                items![index!].shopId.toString(),
                                items![index!].variantId.toString(),
                                '1',
                              );
                            },
                          ),

                        ],
                      ),
                      SizedBox(
                        width: ScreenConstant.defaultWidthTwenty,
                      ),
                      Container(
                        height: ScreenConstant.defaultWidthEighteen,
                        child: Text(
                          "₹${calculateTotalPrice(
                            double.tryParse(items![index!].variant!.purchasePrice?.toString() ?? '0.0') ?? 0.0,
                            int.tryParse(items![index!].quantity?.toString() ?? '0') ?? 0,
                          ).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: FontSizeStatic.md,
                            fontWeight: FontWeight.bold,
                          ),
                        ),


                      ),

                    ],
                  ),
                  Container(
                    height: ScreenConstant.sizeExtraSmall,
                  ),

                  //   items![index!].variant!.variant == ""
                  //       ? Offstage()
                  //       : Row(
                  //           children: [
                  //             Text(
                  //               items![index!].variant!.variant ?? "",
                  //               style: TextStyle(
                  //                   color: AppColors.accentColor,
                  //                   fontSize: FontSizeStatic.semiSm,
                  //                   fontWeight: FontWeight.bold,
                  //                   /* fontFamily: 'Proxima-Bold' */ fontFamily:
                  //                       'Poppins'),
                  //             ),
                  //           ],
                  //         ),
                  //   items![index!].variant!.variant == ""
                  //       ? Offstage()
                  //       : Container(
                  //           height: ScreenConstant.sizeExtraSmall,
                  //         ),
                  //   items![index!].variant?.colorDetails == null
                  //       ? Offstage()
                  //       : Row(
                  //           children: [
                  //             Text(
                  //               "COLOR: ",
                  //               style: TextStyle(
                  //                   color: AppColors.accentColor,
                  //                   fontSize: FontSizeStatic.semiSm,
                  //                   fontWeight: FontWeight.bold,
                  //                   /* fontFamily: 'Proxima-Bold' */ fontFamily:
                  //                       'Poppins'),
                  //             ),
                  //             Text(
                  //               items![index!].variant?.colorDetails['name'],
                  //               style: TextStyle(
                  //                   color: AppColors.accentColor,
                  //                   fontSize: FontSizeStatic.semiSm,
                  //                   fontWeight: FontWeight.bold,
                  //                   /* fontFamily: 'Proxima-Bold' */ fontFamily:
                  //                       'Poppins'),
                  //             ),
                  //           ],
                  //         ),
                  //   items![index!].variant?.colorDetails == null
                  //       ? Offstage()
                  //       : Container(
                  //           height: ScreenConstant.sizeExtraSmall,
                  //         ),
                  //   // productColor == ""
                  //   //     ? Offstage()
                  //   //     : Row(
                  //   //         children: [
                  //   //           Container(
                  //   //             height: ScreenConstant.sizeExtraSmall,
                  //   //           ),
                  //   //           Text(
                  //   //             "COLOR : ",
                  //   //             style: TextStyle(
                  //   //                 color: AppColors.accentColor,
                  //   //                 fontSize: FontSizeStatic.semiSm,
                  //   //                 fontWeight: FontWeight.bold,
                  //   //                 /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins'),
                  //   //           ),
                  //   //           Text(
                  //   //             productColor,
                  //   //             style: TextStyle(
                  //   //                 color: AppColors.accentColor,
                  //   //                 fontSize: FontSizeStatic.semiSm,
                  //   //                 fontWeight: FontWeight.bold,
                  //   //                 /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins'),
                  //   //           ),
                  //   //           Container(
                  //   //             height: ScreenConstant.sizeExtraSmall,
                  //   //           ),
                  //   //         ],
                  //   //       ),
                  //   // productColor == ""
                  //   //     ? Offstage()
                  //   //     : Container(
                  //   //         height: ScreenConstant.sizeExtraSmall,
                  //   //       ),
                  //   Row(
                  //     children: [
                  //       Text(
                  //         "Rs. ${double.parse(items![index!].variant!.purchasePrice!).toStringAsFixed(2)}",
                  //         // "Rs. ${double.parse(items[index].variant.listingPrice).toStringAsFixed(2)}" ??

                  //         style: TextStyles.productPriceInOrderDetails,
                  //       ),
                  //       Container(
                  //         width: ScreenConstant.sizeSmall,
                  //       ),
                  //       Text(
                  //         "Rs. ${double.parse(items![index!].variant!.price!).toStringAsFixed(2)}",
                  //         style: TextStyles.fakePriceInOrderDetails,
                  //       ),
                  //     ],
                  //   ),

                  //   (double.parse(items![index!].variant!.price!) -
                  //                   double.parse(
                  //                       items![index!].variant!.purchasePrice!))
                  //               // items[index].variant.listingPrice))
                  //               .toStringAsFixed(2) ==
                  //           "0.00"
                  //       ? Offstage()
                  //       : Text(
                  //           (double.parse(items![index!].variant!.price!) -
                  //                           double.parse(items![index!]
                  //                                   .variant!
                  //                                   .purchasePrice!
                  //                               // .listingPrice
                  //                               ))
                  //                       .toStringAsFixed(2) ==
                  //                   "1.00"
                  //               ? "You Save Re. 1"
                  //               : "You Save Rs. ${double.parse((int.parse(items![index!].quantity!) * (double.parse(items![index!].variant!.price!) - double.parse(items![index!].variant!.purchasePrice! //listingPrice
                  //                   ))).toString()).toStringAsFixed(2)}",
                  //           style: TextStyles.productListSubTitleOnOrderListing2,
                  //         ),
                ],
              ),
            ),
          ],
        ),
        index == items!.length - 1
            ? Offstage()
            : Divider(
                thickness: 2,
              ),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(
            color: AppColors.accentColor,
            fontSize: FontSizeStatic.md,
            fontWeight: FontWeight.bold,
            /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins'),
      ),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Yes",
        style: TextStyle(
            color: AppColors.primary,
            fontSize: FontSizeStatic.md,
            fontWeight: FontWeight.bold,
            /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins'),
      ),
      onPressed: () async {
        Get.back();
        MyBucketController myBucketController = Get.find();
        myBucketController.applyCouponCode.value = "";
        myBucketController.addToCartPress(items![index!].shopId.toString(),
            items![index!].variantId.toString(), '-1');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Alert!",
        style: TextStyles.productPrice,
      ),
      content: Text(
        "On removing the item coupon discount will be lost.",
        style: TextStyles.chooseCategorySubTitle,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
