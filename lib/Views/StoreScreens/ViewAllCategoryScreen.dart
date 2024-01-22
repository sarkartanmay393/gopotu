import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/DashboardController/DashboardController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/NoResult.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Views/CategoryScreen/ChangeCategoryScreen.dart';
import 'package:go_potu_user/Widgets/StoreWidgets/StoreListWidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../Widgets/CategoryHomeScreenWidget/CategoryHomeScreenWidget.dart';
import '../../Widgets/HomeScreenWidgets/SecondBannerListWidget.dart';

class ViewAllCategoryScreen extends StatelessWidget {
  final DashboardController _dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child:  Icon(Icons.chevron_left_rounded,size: 35,color: Colors.white,),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: Text(
            AppStrings.AllCategories,
            style: TextStyles.appBarTitle,
          ),
        ),
        body: _dashboardController.featuredCategories.length < 1
            ? Container(
                child: Center(
                    child: NoResult(
                  titleText: "Sorry no store found!",
                  subTitle: "",
                )),
              )
            : SingleChildScrollView(
              child: Column(
                  children: [
                    _dashboardController.appBannerMiddle.length < 1
                        ? Offstage()
                        : SecondBannerListWidget(
                      bannerList:
                      _dashboardController.appBannerFooter,
                    ),
                    _dashboardController.appBannerMiddle.length < 1
                        ? Offstage()
                        : Divider(
                      color: Colors.black,
                    ),
                    StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: _dashboardController.featuredCategories.length,
                      itemBuilder: (context, index) {
                        return  Padding(
                          padding: EdgeInsets.all(ScreenConstant.sizeMedium),
                          child: CategoryHomeScreenWidget(
                            index: index,
                            categoryList:
                            _dashboardController
                                .featuredCategories,
                          ),
                        );
                        // return StoreListWidget(
                        //   index: index,
                        //   nearestStore: _dashboardController.featuredCategories,
                        //   onTap: () {
                        //     Get.toNamed(storeDetails,
                        //         arguments: JsonEncoder().convert({
                        //           "id": _dashboardController.featuredCategories[index]
                        //                   ['id']
                        //               .toString(),
                        //           "isFavourite": true
                        //         }));
                        //   },
                        // );
                      },
                        staggeredTileBuilder:
                            (int index) =>
                        new StaggeredTile.count(
                            1,1.5),
                        crossAxisCount: 3,
                        ),


                  ],
                ),
            ));
  }

  showBottomSheet(BuildContext context) {
    showBarModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        backgroundColor: AppColors.secondary,
        isDismissible: false,
        expand: true,
        topControl: Container(
          decoration: BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.circular(40)),
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.cancel,
                color: AppColors.secondary,
                size: ScreenConstant.sizeXXL,
              )),
        ),
        context: context,
        builder: (context) {
          return ChangeCategoryScreen();
        });
  }
}
