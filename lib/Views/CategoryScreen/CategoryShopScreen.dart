import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_potu_user/Controller/CategoryController/CategoryController.dart';
import 'package:go_potu_user/Controller/OrderListController/OrderListController.dart';
import 'package:go_potu_user/Controller/SearchController/SearchController.dart';
import 'package:go_potu_user/Controller/StoreController/StoreController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/Views/FilterScreen/FilterScreen.dart';
import 'package:go_potu_user/Views/HomeScreen/CateGorySearchScreen.dart';
import 'package:go_potu_user/Views/HomeScreen/SearchScreen.dart';
import 'package:go_potu_user/Widgets/CategoryWidgets/SearchCategoryWidget.dart';

import '../../Controller/DashboardController/DashboardController.dart';
import '../../DeviceManager/NoResult.dart';
import '../../DeviceManager/TextStyles.dart';
import '../../Router/RouteConstants.dart';
import '../../Store/HiveStore.dart';
import '../../Store/ScopeStorage.dart';
import '../../Store/ShareStore.dart';
import '../../Widgets/CategoryHomeScreenWidget/CategoryShopWidgets.dart';
import '../../Widgets/HomeScreenWidgets/SearchWidget.dart';
import '../../Widgets/HomeScreenWidgets/SecondBannerListWidget.dart';
import '../../Widgets/HomeScreenWidgets/TopOfferWidgets.dart';
import '../../Widgets/StoreWidgets/StoreListWidget.dart';

class CategoryShopScreen extends StatefulWidget {
  @override
  State<CategoryShopScreen> createState() => _CategoryShopScreenState();
}

class _CategoryShopScreenState extends State<CategoryShopScreen> {
  final DashboardController _dashboardController =
      Get.put(DashboardController());
  final CategoryController _categoryController = Get.put(CategoryController());
  final MySearchController _mySearchController = Get.put(MySearchController());
  final OrderListController _orderListController =
      Get.put(OrderListController());
  Future _refreshData() async {
    // await Future.delayed(Duration(seconds: 1));
    _categoryController.storeByCategoryPress(true);

    _mySearchController.search = _categoryController.shops;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshData();
  }

  Future<bool> _onBackPressed() async {
    _categoryController.shops.clear();
    _categoryController.categoryId.value = "0.00";
    _categoryController.isLoading.value = true;

    Get.back();

    return Future.value(false);
  }

  Widget build(BuildContext context) {
    String type = ShareStore().getData(store: KeyStore.type) == null
        ? HiveStore().get(Keys.shopType)
        : ShareStore().getData(store: KeyStore.type);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          backgroundColor: AppColors.secondary,
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
              "Category",
              style: TextStyles.appBarTitle,
            ),
          ),
          body: GetX<CategoryController>(initState: (state) {
            Future.delayed(Duration(milliseconds: 500), () {
              Get.find<CategoryController>().storeByCategoryPress(false);
            });
          }, builder: (_) {
            return _categoryController.isLoading.value
                ? Container()
                : ListView(
                    physics: const ClampingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      Column(
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
                          Padding(
                            padding: EdgeInsets.only(
                              top: ScreenConstant.sizeSmall,
                              left: ScreenConstant.sizeSmall,
                              right: ScreenConstant.sizeSmall,
                            ),
                            child: Container(
                              color: AppColors.secondary,
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(CategorySearchScreen());
                                },
                                child: SearchCategoryWidget(
                                  onTap: () {},
                                  searchLevelText: type == "restaurant"
                                      ? "Search Store"
                                      : "Search Store",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenConstant.sizeMedium,
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: ScreenConstant.sizeMedium,
                          ),
                          _categoryController.shops.length <= 0
                              ? Container(
                                  child: Center(
                                      child: NoResult(
                                    titleText: "Sorry no product found!",
                                    subTitle: "",
                                  )),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                    left: ScreenConstant.sizeSmall,
                                    right: ScreenConstant.sizeSmall,
                                  ),
                                  child: AnimationLimiter(
                                    child: StaggeredGridView.countBuilder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount:
                                            _categoryController.shops.length,
                                        // <=
                                        //     4
                                        // ? _storeController.storeData.value
                                        //     .topofferedProducts.length
                                        // : 4,
                                        itemBuilder: (BuildContext context,
                                                int index) =>
                                            AnimationConfiguration
                                                .staggeredGrid(
                                              position: index,
                                              duration: const Duration(
                                                  milliseconds: 1500),
                                              columnCount: 2,
                                              child: SlideAnimation(
                                                child: FlipAnimation(
                                                  child: CategoryShopWidgets(
                                                    index: index,
                                                    nearestStore:
                                                        _categoryController
                                                            .shops,
                                                    onTap: () {
                                                      Get.toNamed(storeDetails,
                                                          arguments:
                                                              JsonEncoder()
                                                                  .convert({
                                                            "id":
                                                                _categoryController
                                                                    .shops[
                                                                        index]
                                                                        ['id']
                                                                    .toString(),
                                                            "isFavourite": false
                                                          }));
                                                      String categoryId = _categoryController.categoryId.toString();
                                                     print("category iddddd: ${categoryId}");
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                        staggeredTileBuilder: (int index) =>
                                            new StaggeredTile.count(1, 1.4),
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5.0,
                                        mainAxisSpacing: 5.0),
                                  ),
                                ),
                        ],
                      )
                    ],
                  );
          })),
    );
  }
}

showBottomSheet(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: AppColors.secondary,
      isDismissible: true,
      context: context,
      builder: (context) {
        return FilterScreen();
      });
}
