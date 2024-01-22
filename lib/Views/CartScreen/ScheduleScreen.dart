import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.secondary,
        height: screenHeight - 320,
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenConstant.sizeLarge,
                  top: ScreenConstant.sizeLarge),
              child: Text(
                "Schedule Service",
                style: TextStyle(
                  fontSize: FontSizeStatic.lg,
                  color: Color(0xFF171616),
                  fontFamily: 'Proxima-Regular',
                ),
              ),
            ),
            Container(
              height: ScreenConstant.sizeExtraSmall,
            ),
            Padding(
              padding: EdgeInsets.only(left: ScreenConstant.sizeLarge),
              child: Text(
                "Choose date time for service",
                style: TextStyle(
                    fontSize: FontSizeStatic.semiSm,
                    fontFamily: 'Proxima-Regular',
                    color: Color(0xFFA5A5A5)),
              ),
            ),
            Container(
              height: ScreenConstant.sizeLarge,
            ),
            Padding(
              padding: EdgeInsets.only(left: ScreenConstant.sizeLarge),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.productType,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.sizeLarge,
                          vertical: ScreenConstant.sizeSmall),
                      child: Text(
                        "09:30 AM - 10:30 AM",
                        style: TextStyle(
                          fontSize: FontSizeStatic.md,
                          color: AppColors.secondary,
                          fontFamily: 'Proxima-Regular',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: ScreenConstant.sizeSmall,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.productType)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.sizeLarge,
                          vertical: ScreenConstant.sizeSmall),
                      child: Text(
                        "10:30 AM - 11:30 AM",
                        style: TextStyle(
                          fontSize: FontSizeStatic.md,
                          color: AppColors.accentColor,
                          fontFamily: 'Proxima-Regular',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: ScreenConstant.sizeSmall,
            ),
            Padding(
              padding: EdgeInsets.only(left: ScreenConstant.sizeLarge),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.productType)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.sizeLarge,
                          vertical: ScreenConstant.sizeSmall),
                      child: Text(
                        "09:30 AM - 10:30 AM",
                        style: TextStyle(
                          fontSize: FontSizeStatic.md,
                          color: AppColors.accentColor,
                          fontFamily: 'Proxima-Regular',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: ScreenConstant.sizeSmall,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.productType)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.sizeLarge,
                          vertical: ScreenConstant.sizeSmall),
                      child: Text(
                        "10:30 AM - 11:30 AM",
                        style: TextStyle(
                          fontSize: FontSizeStatic.md,
                          color: AppColors.accentColor,
                          fontFamily: 'Proxima-Regular',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: ScreenConstant.sizeSmall,
            ),
            Padding(
              padding: EdgeInsets.only(left: ScreenConstant.sizeLarge),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.productType)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.sizeLarge,
                          vertical: ScreenConstant.sizeSmall),
                      child: Text(
                        "09:30 AM - 10:30 AM",
                        style: TextStyle(
                          fontSize: FontSizeStatic.md,
                          color: AppColors.accentColor,
                          fontFamily: 'Proxima-Regular',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: ScreenConstant.sizeSmall,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.productType)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.sizeLarge,
                          vertical: ScreenConstant.sizeSmall),
                      child: Text(
                        "10:30 AM - 11:30 AM",
                        style: TextStyle(
                          fontSize: FontSizeStatic.md,
                          color: AppColors.accentColor,
                          fontFamily: 'Proxima-Regular',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: ScreenConstant.sizeSmall,
            ),
            Padding(
              padding: EdgeInsets.only(left: ScreenConstant.sizeLarge),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.productType)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.sizeLarge,
                          vertical: ScreenConstant.sizeSmall),
                      child: Text(
                        "09:30 AM - 10:30 AM",
                        style: TextStyle(
                          fontSize: FontSizeStatic.md,
                          color: AppColors.accentColor,
                          fontFamily: 'Proxima-Regular',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: ScreenConstant.sizeSmall,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.productType)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.sizeLarge,
                          vertical: ScreenConstant.sizeSmall),
                      child: Text(
                        "10:30 AM - 11:30 AM",
                        style: TextStyle(
                          fontSize: FontSizeStatic.md,
                          color: AppColors.accentColor,
                          fontFamily: 'Proxima-Regular',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: ScreenConstant.sizeSmall,
            ),
            Padding(
              padding: EdgeInsets.only(left: ScreenConstant.sizeLarge),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.productType)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.sizeLarge,
                          vertical: ScreenConstant.sizeSmall),
                      child: Text(
                        "09:30 AM - 10:30 AM",
                        style: TextStyle(
                          fontSize: FontSizeStatic.md,
                          color: AppColors.accentColor,
                          fontFamily: 'Proxima-Regular',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: ScreenConstant.sizeSmall,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.productType)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.sizeLarge,
                          vertical: ScreenConstant.sizeSmall),
                      child: Text(
                        "10:30 AM - 11:30 AM",
                        style: TextStyle(
                          fontSize: FontSizeStatic.md,
                          color: AppColors.accentColor,
                          fontFamily: 'Proxima-Regular',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: ScreenConstant.sizeLarge,
            ),
            Padding(
              padding: EdgeInsets.only(left: ScreenConstant.sizeLarge),
              child: Text(
                "Service Date",
                style: TextStyle(
                  fontSize: FontSizeStatic.semiSm,
                  color: AppColors.accentColor,
                  fontFamily: 'Poppins' /*'Proxima-Regular'*/,
                ),
              ),
            ),
            Container(
              height: ScreenConstant.sizeSmall,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenConstant.sizeLarge,
                  right: ScreenConstant.sizeLarge),
              child: TextFormField(
                //controller: searchEditingController,
                keyboardType: TextInputType.name,
                autofocus: false,
                enabled: false,
                maxLines: 1,
                style: TextStyles.textFieldText,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.calendar_today_rounded,
                    color: AppColors.productType,
                  ),
                  filled: true,
                  fillColor: AppColors.secondary,
                  contentPadding: EdgeInsets.all(ScreenConstant.sizeMedium),
                  hintText: "DD-MM-YYYY",
                  hintStyle: TextStyles.hintTextFieldHints,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.productType,
                        width: 1.0,
                        style: BorderStyle.solid),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.productType,
                        width: 1.0,
                        style: BorderStyle.solid),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.productType,
                        width: 1.0,
                        style: BorderStyle.solid),
                  ),
                ),
              ),
            ),
            Container(
              height: ScreenConstant.sizeMedium,
            ),
            Divider(
              thickness: 10,
            ),
            Container(
              height: ScreenConstant.sizeMedium,
            ),
            Divider(
              thickness: 10,
            ),
            Container(
              height: ScreenConstant.sizeExtraSmall,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    Text(
                      "Your payable amount",
                      style: TextStyles.yourPayableBill,
                    ),
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    Text(
                      "Rs.515",
                      style: TextStyles.totalPayablePrice,
                    ),
                    Text(
                      "(Inclusive of all taxes)",
                      style: TextStyles.includingAllTax,
                    ),
                  ],
                ),
                Container(
                  width: ScreenConstant.sizeMedium,
                ),
                AppButton(
                  width: ScreenConstant.defaultWidthOneEighty,
                  color: AppColors.primary,
                  buttonText: AppStrings.PlaceOrder,
                  onPressed: () {
                    Get.offAllNamed(orderPlaced);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
