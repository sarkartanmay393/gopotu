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

class ViewAllStoreScreen extends StatelessWidget {
  final DashboardController _dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: Text(
            AppStrings.AvailableStores,
            style: TextStyles.appBarTitle,
          ),
        ),
        body: _dashboardController.nearestStore.length < 1
            ? Container(
                child: Center(
                    child: NoResult(
                  titleText: "Sorry no store found!",
                  subTitle: "",
                )),
              )
            : Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: ScreenConstant.sizeLarge,
                    child: Padding(
                      padding:EdgeInsets.only(left: ScreenConstant.sizeSmall,right: ScreenConstant.sizeSmall),
                      child: StaggeredGridView.countBuilder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: _dashboardController.nearestStore.length,
                        itemBuilder: (context, index) {
                          return StoreListWidget(
                            index: index,
                            nearestStore: _dashboardController.nearestStore,
                            onTap: () {
                              Get.toNamed(storeDetails,
                                  arguments: JsonEncoder().convert({
                                    "id": _dashboardController.nearestStore[index]
                                            ['id']
                                        .toString(),
                                    "isFavourite": true
                                  }));
                            },
                          );
                        },
                          staggeredTileBuilder:
                              (int index) =>
                          new StaggeredTile.count(
                              1,1.55),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0),
                    ),
                    ),

                  /*Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Padding(
              padding: EdgeInsets.only(
                top: ScreenConstant.sizeExtraSmall,
              ),
              child: Container(
                color: AppColors.dashBoardChangeCategory,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: ScreenConstant.sizeLarge,
                    bottom: ScreenConstant.sizeSmall,
                    right: ScreenConstant.sizeLarge,
                    top: ScreenConstant.sizeSmall,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.selectedShoppingCategory,
                            style: TextStyles.categoryChangeText1,
                          ),
                          Container(
                            height: ScreenConstant.sizeExtraSmall,
                          ),
                          Text(
                            "RESTURANT FOOD".toUpperCase(),
                            style: TextStyles.categoryChangeText2,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap:(){
                              showBottomSheet(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color:
                                AppColors.dashBoardChangeCategoryText,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: ScreenConstant.sizeLarge,
                                  bottom: ScreenConstant.sizeExtraSmall,
                                  right: ScreenConstant.sizeLarge,
                                  top: ScreenConstant.sizeExtraSmall,
                                ),
                                child: Center(
                                    child: Text(
                                      AppStrings.change,
                                      style:
                                      TextStyles.categoryChangeBottomText,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),*/
                ],
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
