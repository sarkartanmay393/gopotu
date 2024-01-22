import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Widgets/LandingWidgets/OnBoardingWidget.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body: OnBoardingWidget(
          bgColor: AppColors.secondary,
          themeColor: AppColors.primary,
          skipClicked: (value) async {
            print("Skip");
            await HiveStore().initBox();
            await HiveStore().put(Keys.landingShow, "true");
            Get.offAllNamed(signIn);
          },
          pages: pages,
          getStartedClicked: (value) async {
            await HiveStore().initBox();
            await HiveStore().put(Keys.landingShow, "true");
            Get.offAndToNamed(signIn);
            print("Get Started");
          },
        ));
  }

  final pages = [
    OnBoardingModel(
        title: AppLabels.landingTitle1,
        description: AppLabels.landingSubTitle1,
        titleColor: AppColors.landingTitle,
        descripColor: AppColors.landingTitle,
        imagePath: Assets.landing1),
    // OnBoardingModel(
    //     title: AppLabels.landingTitle2,
    //     description: AppLabels.landingSubTitle2,
    //     titleColor: AppColors.landingTitle,
    //     descripColor: AppColors.landingTitle,
    //     imagePath: Assets.landing2),
    OnBoardingModel(
        title: AppLabels.landingTitle2,
        description: AppLabels.landingSubTitle2,
        titleColor: AppColors.landingTitle,
        descripColor: AppColors.landingTitle,
        imagePath: Assets.landing3),
    OnBoardingModel(
        title: AppLabels.landingTitle3,
        description: AppLabels.landingSubTitle3,
        titleColor: AppColors.landingTitle,
        descripColor: AppColors.landingTitle,
        imagePath: Assets.landing4),
  ];
}
