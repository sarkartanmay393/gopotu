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
import '../../Widgets/HomeScreenWidgets/TopStoreWidgets.dart';
import '../../Widgets/ProductsHomeScreenWidget/ProductHomeScreenWidget.dart';

class ViewAllProductOfferScreen extends StatelessWidget {
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
            "All Subcategory",
            style: TextStyles.appBarTitle,
          ),
        ),
        body:

        _dashboardController.featuredProducts.length < 1
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
                    Divider(
                      color: Colors.black,
                    ),
                    StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: _dashboardController.featuredProducts.length,
                      itemBuilder: (context, index) {
                        return  Padding(
                          padding:  EdgeInsets.all(ScreenConstant.sizeMedium),
                          child: ProductHomeScreenWidget(
                            index: index,
                            productList:
                            _dashboardController
                                .featuredProducts,
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
                            1,1.3),
                        crossAxisCount: 3,
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
                ),
            ));
  }

}
