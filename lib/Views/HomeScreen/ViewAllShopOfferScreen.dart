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
import '../../Widgets/HomeScreenWidgets/TopStoreWidgets.dart';

class ViewAllShopOfferScreen extends StatelessWidget {
  final DashboardController _dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: Text(
            AppStrings.AllOffers,
            style: TextStyles.appBarTitle,
          ),
        ),
        body: _dashboardController.offers_shop.length < 1
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
                    top: ScreenConstant.sizeMedium,
                    child: StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: _dashboardController.offers_shop.length,
                      itemBuilder: (context, index) {
                        return  TopStoreWidgets(
                          index: index,
                          topStore:
                          _dashboardController
                              .offers_shop,
                        );

                      },
                        staggeredTileBuilder:
                            (int index) =>
                        new StaggeredTile.count(
                            1,0.8),
                        crossAxisCount: 2,
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
                                  left: ScreenConstant.sizeLarge,cccc
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

}
