import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/ChooseCategoryController/ChooseCategoryController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Widgets/CategoryWidgets/ChooseCategoryWidget.dart';

class ChangeCategoryScreen extends StatelessWidget {
  final ChooseCategoryController chooseCategoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight - 250,
      color: AppColors.secondary,
      child: Column(
        children: [
          Container(
            height: ScreenConstant.sizeMedium,
          ),
          chooseCategoryController.isBeforeDashboard.value
              ? Offstage()
              : Container(
                  height: 2,
                  width: ScreenConstant.sizeXL,
                  decoration: BoxDecoration(
                    color: AppColors.landingTitle,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6)),
                  ),
                ),
          Container(
            height: ScreenConstant.sizeMedium,
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenConstant.sizeXL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppStrings.shopCategory,
                  style: TextStyles.chooseCategoryTitle,
                ),
              ],
            ),
          ),
          Container(
            height: ScreenConstant.sizeExtraSmall,
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenConstant.sizeXL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppStrings.chooseACategory,
                  style: TextStyles.chooseCategorySubTitle,
                ),
              ],
            ),
          ),
          Container(
            height: ScreenConstant.sizeMedium,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return ChooseCategoryWidget(
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
