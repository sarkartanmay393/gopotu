import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';

import '../../DeviceManager/Colors.dart';
import '../../DeviceManager/TextStyles.dart';

class StoreOfferWidgets extends StatefulWidget {
  final List<dynamic> bannerList;

  StoreOfferWidgets({required this.bannerList});

  @override
  State<StoreOfferWidgets> createState() => _StoreOfferWidgetsState();
}

class _StoreOfferWidgetsState extends State<StoreOfferWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Colors.pinkAccent,
        height: ScreenConstant.defaultHeightSixty,
        child: imageSlider(context));
  }

  Swiper imageSlider(context) {
    return Swiper(
      // itemHeight: ScreenConstant.defaultHeightSeventy,
      itemCount: widget.bannerList.length,
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(top: 10, right: 10)),
      physics: ClampingScrollPhysics(),
      key: UniqueKey(),
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.secondary,
            border: Border.all(
              color: Colors.grey.shade300, // Border color
              width: 1.0, // Border width
            ),
            // Border radius
          ),
          height: ScreenConstant.screenHeightFifteen,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(ScreenConstant.sizeSmall),
                child: Container(
                  child: Image.asset(
                    Assets.promoIcon,
                  ),
                ),
              ),
              // Expanded(
              //   child: RichText(
              //     text: TextSpan(
              //       text: 'To receive ',
              //       style: TextStyles.bottomOfferTitle,
              //       children: <TextSpan>[
              //         TextSpan(
              //           text: 'Free delivery, ',
              //           style:  TextStyles.bottomOfferTitle.copyWith(fontWeight: FontWeight.bold),
              //         ),
              //         TextSpan(
              //           text: 'add products totaling at least 149',
              //           style:  TextStyles.bottomOfferTitle,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Expanded(
                child: Text(widget.bannerList[index]['description'],
                    style: TextStyles.bottomOfferTitle),
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(
                    left: ScreenConstant.sizeSmall,
                    right: ScreenConstant.sizeSmall,
                    bottom: ScreenConstant.sizeSmall,
                  ),
                  child: Container(
                      padding: EdgeInsets.all(ScreenConstant.sizeExtraSmall),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.dashBoardChangeCategoryText,
                      ),
                      child: Text(
                        '${index + 1}/${widget.bannerList.length}',
                        style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: FontSizeStatic.sm,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ],
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
