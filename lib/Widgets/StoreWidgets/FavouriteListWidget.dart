import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/DashboardController/DashboardController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';

class FavouriteListWidget extends StatelessWidget {
  final Function? onTap;
  final int? index;
  final List<dynamic>? favouriteStore;
  final DashboardController _dashboardController = Get.find();

  FavouriteListWidget({this.onTap, this.index, this.favouriteStore});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Padding(
        padding: EdgeInsets.only(
            bottom: ScreenConstant.sizeSmall, top: ScreenConstant.sizeSmall),
        child: Card(
          shape: RoundedRectangleBorder(
              side: new BorderSide(color: AppColors.accentColor, width: 1.0),
              borderRadius: BorderRadius.circular(15.0)),
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topRight,
                children: [
                  CachedNetworkImage(
                    imageUrl: favouriteStore![index!]['shop']['shop_logo_path'],
                    imageBuilder: (context, imageProvider) => Container(
                      height: ScreenConstant.defaultHeightTwoHundredTen,
                      decoration: BoxDecoration(
                        //border: Border.all(color: AppColors.accentColor),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: ScreenConstant.sizeMedium,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenConstant.sizeSmall,
                                          right: ScreenConstant.sizeSmall,
                                          bottom:
                                              ScreenConstant.sizeExtraSmall),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            favouriteStore![index!]['shop']
                                                ['shop_name'],
                                            style: TextStyles.productTitle,
                                          ),
                                          favouriteStore![index!]['shop']
                                                      ['avg_rating'] ==
                                                  0
                                              ? Offstage()
                                              : Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    color: AppColors
                                                        .dashBoardChangeCategoryText,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 2,
                                                    ),
                                                    child: Center(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "${favouriteStore![index!]['shop']['avg_rating']}",
                                                            style:
                                                                TextStyles.rate,
                                                          ),
                                                          Container(
                                                            width: ScreenConstant
                                                                .sizeExtraSmall,
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: AppColors
                                                                .secondary,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        // border: Border.all(color: AppColors.accentColor),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15)),
                                      ),
                                      padding: EdgeInsets.only(
                                          left: ScreenConstant.sizeSmall,
                                          right: ScreenConstant.sizeSmall),
                                      child: ListView(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        children: [
                                          Container(
                                            child: Text(
                                              favouriteStore![index!]['shop']
                                                          ['shop_tagline'] ==
                                                      null
                                                  ? ""
                                                  : "${favouriteStore![index!]['shop']['shop_tagline']}",
                                              style: TextStyles.productSubTitle,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ),
                                          Container(
                                            height:
                                                ScreenConstant.sizeExtraSmall,
                                          ),
                                          Divider(
                                            thickness: 1,
                                          ),
                                          Container(
                                            height:
                                                ScreenConstant.sizeExtraSmall,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.av_timer,
                                                color: AppColors
                                                    .dashBoardChangeCategoryText,
                                              ),
                                              Container(
                                                width: ScreenConstant.sizeSmall,
                                              ),
                                              favouriteStore![index!]['shop'][
                                                              'distanceaway'] ==
                                                          null ||
                                                      double.parse(favouriteStore![
                                                                      index!]
                                                                  ['shop'][
                                                              'distanceaway']) <
                                                          1.0
                                                  ? Text(
                                                      "< 1 Km away from you",
                                                      style: TextStyles
                                                          .storeDistance,
                                                    )
                                                  : Text(
                                                      "${favouriteStore![index!]['shop']!['distanceaway!']} Km away from you",
                                                      style: TextStyles
                                                          .storeDistance,
                                                    )
                                            ],
                                          ),
                                          Container(
                                            height: ScreenConstant.sizeSmall,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    placeholder: (context, url) =>
                        Image.asset(Assets.loadingImageGif),
                    errorWidget: (context, url, error) => Image.network(
                        "https://corp.sellerscommerce.com//SCAssets/images/noimage.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Material(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        side: BorderSide(
                            color: AppColors.productListingScreenColor),
                      ),
                      child: Container(
                        height: ScreenConstant.sizeXL,
                        width: ScreenConstant.sizeXL,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: AppColors.productListingScreenColor),
                            shape: BoxShape.circle),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              _dashboardController.shopId.value =
                                  favouriteStore![index!]['shop']['id']
                                      .toString();
                              _dashboardController.setAsFavouritePress(true);
                            },
                            child: Obx(() => Icon(
                                  Icons.favorite,
                                  color: favouriteStore![index!]['shop']
                                          ['is_wishlist']
                                      ? AppColors.primary
                                      : Colors.black26,
                                  size: ScreenConstant.sizeLarge,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              /*Container(
                decoration: BoxDecoration(
                  // border: Border.all(color: AppColors.accentColor),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                ),
                padding: EdgeInsets.only(
                    left: ScreenConstant.sizeSmall,
                    right: ScreenConstant.sizeSmall),
                child: ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
                    Container(
                      child: Text(
                        "Burger, Fast food & BevarageBurger,",
                        style: TextStyles.productSubTitle,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.av_timer,
                          color: AppColors.dashBoardChangeCategoryText,
                        ),
                        Container(
                          width: ScreenConstant.sizeSmall,
                        ),
                        Text(
                          "15 min away from you",
                          style: TextStyles.storeDistance,
                        )
                      ],
                    ),
                    Container(
                      height: ScreenConstant.sizeSmall,
                    ),
                  ],
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
