import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/MyBucketController/MyBucketController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Models/ResponseModels/GetMyBucketResponseModel/GetMyBucketResponseModel.dart';

class PromoCardWidget extends StatelessWidget {
  final MyBucketController _myBucketController = Get.find();
  final List<AvailableCoupon>? couponsList;
  final int? index;
  final couponCodeText;
  PromoCardWidget({this.couponsList, this.index, this.couponCodeText});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: couponCodeText ==
              couponsList![index!].code.toString().toUpperCase()
          ? () {}
          : () {
              print("false");
              print("${couponCodeText!}");
              print("${couponsList![index!].code.toString().toUpperCase()}");
              _myBucketController
                  .applyCouponPress(couponsList![index!].code.toString());
            },
      child: Padding(
        padding: EdgeInsets.all(ScreenConstant.sizeDefault),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(ScreenConstant.sizeLarge),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: ScreenConstant.sizeXXXL,
                            width: ScreenConstant.sizeXXXL,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                    Assets.promoIcon2,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: ScreenConstant.sizeLarge,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "GOPOTU OFFERS",
                            style: TextStyles.goPotuOffer,
                          ),
                          Text(
                            couponsList![index!].description ?? "",
                            style: TextStyles.goPotuOfferTitle,
                          ),
                          Container(
                            height: ScreenConstant.sizeExtraSmall,
                          ),
                          Text(
                            "View T&C",
                            style: TextStyles.viewTC,
                          ),
                          Text(
                            "- Valid for all user",
                            style: TextStyles.goPotuOfferSubTitle,
                          ),
                          Text(
                            "- Coupon Type - ${couponsList![index!].type?.toUpperCase()}",
                            style: TextStyles.goPotuOfferSubTitle,
                          ),
                          Text(
                            couponsList![index!].minOrder == null
                                ? ""
                                : "- Minimum Transaction value ${couponsList![index!].minOrder}",
                            style: TextStyles.goPotuOfferSubTitle,
                          ),
                          Text(
                            couponsList![index!].maxUsages != null
                                ? "- Valid for first ${couponsList![index!].maxUsages} user"
                                : "",
                            style: TextStyles.goPotuOfferSubTitle,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: ScreenConstant.sizeExtraSmall,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Container(
                    height: ScreenConstant.sizeMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DottedBorder(
                        color: Color(0xFF707070),
                        dashPattern: [15, 5],
                        strokeWidth: 1,
                        child: Container(
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.only(
                                left: ScreenConstant.sizeXXL,
                                right: ScreenConstant.sizeXXL,
                                top: ScreenConstant.sizeSmall,
                                bottom: ScreenConstant.sizeSmall),
                            child: Text(
                              couponsList![index!].code!,
                              style: TextStyles.promoCodeText,
                            ),
                          )),
                        ),
                      ),
                      GestureDetector(
                        onTap: couponCodeText ==
                                couponsList![index!]
                                    .code
                                    .toString()
                                    .toUpperCase()
                            ? () {}
                            : () {
                                print("false");
                                print("$couponCodeText");
                                print(
                                    "${couponsList![index!].code.toString().toUpperCase()}");
                                _myBucketController.applyCouponPress(
                                    couponsList![index!].code.toString());
                              },
                        child: Text(
                          couponCodeText ==
                                  couponsList![index!]
                                      .code
                                      .toString()
                                      .toUpperCase()
                              ? "Applied"
                              : "Apply",
                          style: TextStyle(
                              color: AppColors.ordersStatusBox4,
                              fontSize: FontSizeStatic.maxMd),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: ScreenConstant.sizeSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
