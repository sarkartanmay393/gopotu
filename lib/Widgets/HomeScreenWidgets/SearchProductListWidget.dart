import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';

class SearchProductListWidget extends StatelessWidget {
  final Function? onTap;
  final int? index;
  final List<dynamic>? items;

  SearchProductListWidget({this.onTap, this.index, this.items});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        margin: EdgeInsets.only(left: 1, right: 1, bottom: 10, top: 10),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(items![index!]['shop']['shop_name'] ?? "",
                      style: TextStyle(
                          color: AppColors.accentColor,
                          fontSize: FontSizeStatic.xl,
                          fontWeight: FontWeight.bold,
                          /* fontFamily: 'Proxima-Bold' */ fontFamily:
                              'Poppins')),
                  GestureDetector(
                      onTap: onTap as void Function()?,
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColors.landingTitle,
                      )),
                ],
              ),
              Container(
                height: ScreenConstant.sizeExtraSmall,
              ),
              Row(
                children: [
                  items![index!]['shop']['avg_rating'] == 0 ||
                          items![index!]['shop']['avg_rating'] == null
                      ? Offstage()
                      : Icon(
                          Icons.stars,
                          color: AppColors.dashBoardChangeCategoryText,
                        ),
                  items![index!]['shop']['avg_rating'] == 0 ||
                          items![index!]['shop']['avg_rating'] == null
                      ? Offstage()
                      : Container(
                          width: ScreenConstant.sizeExtraSmall,
                        ),
                  items![index!]['shop']['avg_rating'] == 0 ||
                          items![index!]['shop']['avg_rating'] == null
                      ? Offstage()
                      : Text(items![index!]['shop']['avg_rating'].toString(),
                          style: TextStyle(
                              color: AppColors.goPotuOffersSubTitle,
                              fontSize: FontSizeStatic.lg,
                              fontWeight: FontWeight.bold,
                              /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                  'Poppins')),
                  items![index!]['shop']['avg_rating'] == 0 ||
                          items![index!]['shop']['avg_rating'] == null
                      ? Offstage()
                      : Container(
                          width: ScreenConstant.sizeExtraSmall,
                        ),
                  items![index!]['shop']['avg_rating'] == 0 ||
                          items![index!]['shop']['avg_rating'] == null
                      ? Offstage()
                      : Container(
                          height: ScreenConstant.sizeExtraSmall,
                          width: ScreenConstant.sizeExtraSmall,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.goPotuOffersSubTitle),
                        ),
                  items![index!]['shop']['avg_rating'] == 0 ||
                          items![index!]['shop']['avg_rating'] == null
                      ? Offstage()
                      : Container(
                          width: ScreenConstant.sizeExtraSmall,
                        ),
                  items![index!]['shop']['distanceaway'] == null ||
                          double.parse(items![index!]['shop']['distanceaway']) <
                              1.0
                      ? Text(
                          "< 1 Km away from you",
                          style: TextStyle(
                              color: AppColors.goPotuOffersSubTitle,
                              fontSize: FontSizeStatic.lg,
                              fontWeight: FontWeight.bold,
                              /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                  'Poppins'),
                        )
                      : Text(
                          "${items![index!]['shop']['distanceaway']} Km away from you",
                          style: TextStyle(
                              color: AppColors.goPotuOffersSubTitle,
                              fontSize: FontSizeStatic.lg,
                              fontWeight: FontWeight.bold,
                              /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                  'Poppins'))
                ],
              ),
              Container(
                height: ScreenConstant.sizeMedium,
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.secondary,
                    border: Border.all(
                      color: AppColors.addressListWidgetBorderColor,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(items![index!]['details']['name'] ?? "",
                                style: TextStyle(
                                    color: AppColors.accentColor,
                                    fontSize: FontSizeStatic.lg,
                                    fontWeight: FontWeight.bold,
                                    /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                        'Poppins')),
                            Container(
                              height: ScreenConstant.sizeSmall,
                            ),
                            items![index!]['product_variants'].isEmpty
                                ? Offstage()
                                : Row(
                                    children: [
                                      Text(
                                          "Rs. ${items![index!]['product_variants'][0]['listingprice'] ?? items![index!]['product_variants'][0]['purchase_price']} ",
                                          style: TextStyle(
                                              color: AppColors
                                                  .goPotuOffersSubTitle,
                                              fontSize: FontSizeStatic.lg,
                                              /* fontFamily: 'Proxima-Regular' */ fontFamily:
                                                  'Poppins')),
                                      Container(
                                          width: ScreenConstant.sizeExtraSmall),
                                      items![index!]['product_variants'][0]
                                                  ['price'] ==
                                              items![index!]['product_variants']
                                                  [0]['purchase_price']
                                          ? Offstage()
                                          : Text(
                                              "Rs. ${items![index!]['product_variants'][0]['price']} ",
                                              style: TextStyles.fakePrice,
                                            ),
                                    ],
                                  ),
                            Container(
                              height: ScreenConstant.sizeXXL,
                            ),
                            items![index!]['availability']
                                        .toString()
                                        .toLowerCase() ==
                                    "comingsoon"
                                ? Text(
                                    "COMMING SOON",
                                    style: TextStyles.outOfStock,
                                  )
                                : GestureDetector(
                                    onTap: onTap as void Function()?,
                                    child: Container(
                                      width: ScreenConstant
                                          .defaultWidthOneHundredSeven,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            color: AppColors
                                                .addressListWidgetBorderColor),
                                        color: AppColors.secondary,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Icon(Icons.info_outline),
                                              Container(
                                                width: ScreenConstant.sizeSmall,
                                              ),
                                              Text("Item info",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .storeDistance,
                                                      fontSize:
                                                          FontSizeStatic.semiSm,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Proxima-Bold')),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            child: CachedNetworkImage(
                              imageUrl: items![index!]['details']
                                      ['image_path'] ??
                                  "https://corp.sellerscommerce.com//SCAssets/images/noimage.png",
                              placeholder: (context, url) =>
                                  Image.asset(Assets.loadingImageGif),
                              errorWidget: (context, url, error) => Image.network(
                                  "https://corp.sellerscommerce.com//SCAssets/images/noimage.png"),
                              height: ScreenConstant.defaultHeightOneHundred,
                              width: ScreenConstant.defaultHeightOneHundred,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
