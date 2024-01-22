import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/OrderRatingController/OrderRatingController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';

class RateUSScreen extends StatefulWidget {
  @override
  State<RateUSScreen> createState() => _RateUSScreenState();
}

class _RateUSScreenState extends State<RateUSScreen> {
  final OrderRatingController _orderRatingController =
      Get.put(OrderRatingController());

  bool isTap1 = false;
  bool isTap2 = false;
  bool isTap3 = false;
  bool isTap4 = false;
  bool isTap5 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          AppStrings.RateUs,
          style: TextStyles.appBarTitle,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          Image(
            image: AssetImage(Assets.rateUs),
          ),
          Container(
            height: ScreenConstant.sizeXL,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenConstant.sizeLarge),
            child: Text(
              "Rate your experience",
              style: TextStyle(
                  fontSize: FontSizeStatic.lg, color: AppColors.couponCode),
            ),
          ),
          Container(
            height: ScreenConstant.sizeExtraSmall,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenConstant.sizeLarge),
            child: Text(
              "It will help us to improve our service",
              style: TextStyle(
                  fontSize: FontSizeStatic.semiSm,
                  color: AppColors.accentColor),
            ),
          ),
          Container(
            height: ScreenConstant.sizeExtraLarge,
          ),
          Container(
            height: ScreenConstant.sizeXXXL,
            decoration: BoxDecoration(
                color: AppColors.gapColor,
                border: Border.all(color: AppColors.accentColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isTap1 = true;
                      isTap2 = false;
                      isTap3 = false;
                      isTap4 = false;
                      isTap5 = false;
                      _orderRatingController.ratingNumber.value = "1";
                    });
                  },
                  child: Container(
                    height: 48,
                    width: ScreenConstant.sizeXXXL,
                    color: isTap1 ? AppColors.primary : AppColors.secondary,
                    child: Center(
                        child: Text(
                      "1",
                      style: TextStyle(
                          color: isTap1
                              ? AppColors.secondary
                              : AppColors.accentColor,
                          fontSize: FontSizeStatic.xl,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isTap1 = false;
                      isTap2 = true;
                      isTap3 = false;
                      isTap4 = false;
                      isTap5 = false;
                      _orderRatingController.ratingNumber.value = "2";
                    });
                  },
                  child: Container(
                    height: 48,
                    width: ScreenConstant.sizeXXXL,
                    color: isTap2 ? AppColors.primary : AppColors.secondary,
                    child: Center(
                        child: Text(
                      "2",
                      style: TextStyle(
                          color: isTap2
                              ? AppColors.secondary
                              : AppColors.accentColor,
                          fontSize: FontSizeStatic.xl,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isTap1 = false;
                      isTap2 = false;
                      isTap3 = true;
                      isTap4 = false;
                      isTap5 = false;
                      _orderRatingController.ratingNumber.value = "3";
                    });
                  },
                  child: Container(
                    height: 48,
                    width: ScreenConstant.sizeXXXL,
                    color: isTap3 ? AppColors.primary : AppColors.secondary,
                    child: Center(
                        child: Text(
                      "3",
                      style: TextStyle(
                          color: isTap3
                              ? AppColors.secondary
                              : AppColors.accentColor,
                          fontSize: FontSizeStatic.xl,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isTap1 = false;
                      isTap2 = false;
                      isTap3 = false;
                      isTap4 = true;
                      isTap5 = false;
                      _orderRatingController.ratingNumber.value = "4";
                    });
                  },
                  child: Container(
                    height: 48,
                    width: ScreenConstant.sizeXXXL,
                    color: isTap4 ? AppColors.primary : AppColors.secondary,
                    child: Center(
                        child: Text(
                      "4",
                      style: TextStyle(
                          color: isTap4
                              ? AppColors.secondary
                              : AppColors.accentColor,
                          fontSize: FontSizeStatic.xl,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isTap1 = false;
                      isTap2 = false;
                      isTap3 = false;
                      isTap4 = false;
                      isTap5 = true;
                      _orderRatingController.ratingNumber.value = "5";
                    });
                  },
                  child: Container(
                    height: 48,
                    width: ScreenConstant.sizeXXXL,
                    color: isTap5 ? AppColors.primary : AppColors.secondary,
                    child: Center(
                        child: Text(
                      "5",
                      style: TextStyle(
                          color: isTap5
                              ? AppColors.secondary
                              : AppColors.accentColor,
                          fontSize: FontSizeStatic.xl,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: ScreenConstant.sizeExtraLarge,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenConstant.sizeLarge),
            child: Text(
              "Share somethings",
              style: TextStyle(
                  fontSize: FontSizeStatic.md, color: AppColors.accentColor),
            ),
          ),
          Container(
            height: ScreenConstant.sizeSmall,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenConstant.sizeLarge),
            child: TextFormField(
              controller: _orderRatingController.reviewController,
              keyboardType: TextInputType.text,
              autofocus: false,
              maxLines: 5,
              maxLength: 500,
              style: TextStyles.textFieldText,
              decoration: InputDecoration(
                hintText: "Write something ....",
                hintStyle: TextStyle(
                    fontSize: FontSizeStatic.semiSm, color: Color(0xFFD5DBE1)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.textFieldBorderColor,
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.textFieldBorderColor,
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
              ),
            ),
          ),
          Container(
            height: ScreenConstant.sizeExtraLarge,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenConstant.sizeLarge),
            child: AppButton(
              elevation: 0,
              buttonText: AppStrings.Submit,
              onPressed: () {
                _orderRatingController.ratingPress();
              },
              textStyle: TextStyles.bottomTextStyle,
            ),
          ),
          Container(
            height: ScreenConstant.sizeExtraLarge,
          ),
        ],
      ),
    );
  }
}
