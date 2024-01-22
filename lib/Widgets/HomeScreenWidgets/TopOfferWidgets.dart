import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';

import '../../Controller/ProductController/ProductController.dart';
import '../../DeviceManager/Colors.dart';
import '../../DeviceManager/TextStyles.dart';
import '../../Router/RouteConstants.dart';
import '../../Store/HiveStore.dart';

class TopOfferWidgets extends StatefulWidget {
  final List<dynamic> bannerList;

  TopOfferWidgets({required this.bannerList});

  @override
  State<TopOfferWidgets> createState() => _TopOfferWidgetsState();
}

class _TopOfferWidgetsState extends State<TopOfferWidgets> {
  get index => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenConstant.defaultWidthTwenty,
          right: ScreenConstant.defaultWidthTwenty),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        elevation: 8,
        color: AppColors.secondary,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),

            //color: Colors.pinkAccent,
            height: ScreenConstant.defaultHeightSeventy,
            child: imageSlider(context)),
      ),
    );
  }

  Swiper imageSlider(context) {
    return Swiper(
      // itemHeight: ScreenConstant.defaultHeightSeventy,
      itemCount: widget.bannerList.length,
      physics: ClampingScrollPhysics(),
      key: UniqueKey(),
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            final ProductController _productController =
            Get.put(ProductController());
            HiveStore().put(Keys.isHomeScreen, "true");
            _productController.productId.value =
                widget.bannerList![index!]['product_id'].toString();
            Future.delayed(Duration(milliseconds: 500), () {
              _productController.productDetailsPress(false);
            });
            Get.toNamed(
              productDetails,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    // height: ScreenConstant.sizeXXXL,
                    // width: ScreenConstant.sizeUltraXXXL,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Color(0x4C2AC5B8),
                    ),
                    height: ScreenConstant.defaultHeightOneForty,
                    width: ScreenConstant.defaultHeightSeventy,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.bannerList[index]['image_path'] ??
                            "https://corp.sellerscommerce.com//SCAssets/images/noimage.png",
                        placeholder: (context, url) =>
                            Image.asset(Assets.loadingImageGif),
                        errorWidget: (context, url, error) => Image.network(
                            "https://corp.sellerscommerce.com//SCAssets/images/noimage.png"),
                        fit: BoxFit.fill,
                      ),
                    )
                    // Image.asset(
                    //   "assets/temporary/rice.png",
                    //   fit: BoxFit.cover
                    // ),
                    ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenConstant.sizeMedium),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.bannerList[index]['description'],
                          style: TextStyles.homeScreenOfferTitle,
                        ),
                        Container(
                          height: ScreenConstant.sizeExtraSmall,
                        ),
                        Text(
                          widget.bannerList[index]['title'],
                          style: TextStyles.homeScreenOfferSubTitle,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenConstant.sizeSmall),
                        child: Center(
                            child: Icon(
                          Icons.arrow_circle_right_sharp,
                          color: AppColors.dashBoardChangeCategoryText,
                          size: ScreenConstant.sizeXXL,
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        /*Image.network(
          widget.bannerList[index]['image_path'],
          fit: BoxFit.cover,
        );*/
      },
    );
  }
}
