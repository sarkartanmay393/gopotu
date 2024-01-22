import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/MyBucketController/MyBucketController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Models/ResponseModels/GetMyBucketResponseModel/GetMyBucketResponseModel.dart';
import 'package:go_potu_user/Widgets/CartWidgets/PromoCardWidget.dart';

class PromoApplyScreen extends StatelessWidget {
  final List<AvailableCoupon>? couponsList;
  final String? couponCode;
  PromoApplyScreen({this.couponsList, this.couponCode});
  final MyBucketController _myBucketController = Get.find();

  Future<bool> _onBackPressed() {
    _myBucketController.thisController.text = "";
    couponCode == "empty"
        ? _myBucketController.getBucketPress(true, "")
        : _myBucketController.getBucketPress(true, couponCode!);
    Get.back();
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    print("couponCode.toUpperCase() :${couponCode!.toUpperCase()}");
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          AppStrings.PromoOffers,
          style: TextStyles.appBarTitle,
        ),
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            Container(
              height: ScreenConstant.sizeMedium,
            ),
            Padding(
              padding: EdgeInsets.all(ScreenConstant.sizeLarge),
              child: TextFormField(
                controller: _myBucketController.thisController,
                textCapitalization: TextCapitalization.characters,
                keyboardType: TextInputType.text,
                autofocus: false,
                maxLines: 1,
                style: TextStyles.textFieldText,
                decoration: InputDecoration(
                  hintText: "Enter coupon code",
                  //suffixText:"Apply",
                  suffix: GestureDetector(
                      onTap: () {
                        if (couponCode ==
                            _myBucketController.thisController.text) {
                          print(
                              "_myBucketController.thisController.text:${_myBucketController.thisController.text}");
                          Get.snackbar(
                            "Sorry!",
                            "You already applied this coupon",
                            backgroundColor: AppColors.secondary,
                            icon: Icon(
                              Icons.error_outline_sharp,
                              color: Colors.red,
                            ),
                            titleText: Text(
                              "Sorry!",
                              style: TextStyle(
                                fontFamily:
                                    'Poppins', // Replace with the desired font family for the title
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            messageText: Text(
                              "You already applied this coupon",
                              style: TextStyle(
                                fontFamily:
                                    'Poppins', // Replace with the desired font family for the message
                              ),
                            ),
                          );
                        } else {
                          print("else block");
                          // _myBucketController.applyCouponPress(
                          //     _myBucketController.thisController.text);
                        }
                      },
                      child: Text('Apply')),
                  suffixStyle: TextStyle(
                      color: AppColors.ordersStatusBox4,
                      fontSize: FontSizeStatic.maxMd),
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
              height: ScreenConstant.sizeMedium,
            ),
            Padding(
              padding: EdgeInsets.only(left: ScreenConstant.sizeLarge),
              child: Text(
                "Available Offers",
                style: TextStyles.availableOffer,
              ),
            ),
            Container(
              height: ScreenConstant.sizeSmall,
            ),
            AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: couponsList?.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1000),
                    child: FadeInAnimation(
                      child: SlideAnimation(
                        verticalOffset: 150.0,
                        child: PromoCardWidget(
                          couponCodeText: couponCode,
                          couponsList: couponsList!,
                          index: index,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
