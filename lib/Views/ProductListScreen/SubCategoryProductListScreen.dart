import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddToCartController/AddToCartController.dart';
import 'package:go_potu_user/Controller/DashboardController/DashboardController.dart';
import 'package:go_potu_user/Controller/MyBucketController/MyBucketController.dart';
import 'package:go_potu_user/Controller/StoreController/StoreController.dart';
import 'package:go_potu_user/Controller/SubCategoryController/SubCategoryController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/NoResult.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Widgets/OrdersWidgets/OrdersListingWidget.dart';
import 'package:go_potu_user/Widgets/ProductListWidget/SubCategoryProductListWidget.dart';
import 'package:go_potu_user/Widgets/ProductListWidget/TypeOfProductListWidget.dart';

import '../../Store/HiveStore.dart';

class SubCategoryProductListScreen extends StatefulWidget {
  @override
  State<SubCategoryProductListScreen> createState() =>
      _SubCategoryProductListScreenState();
}

class _SubCategoryProductListScreenState
    extends State<SubCategoryProductListScreen> {
  final SubCategoryController _subCategoryController = Get.find();
  final AddToCartController addToCartController = Get.find();
  Future<bool> _onBackPressed() async{
    Future<bool> isHomeScreenTrue() async {
      String? isHome = await HiveStore().get(Keys.isHomeScreen);
      return isHome == "true";
    }

    if (await isHomeScreenTrue()){
      _subCategoryController.isSubCatChildLoading.value = true;
      DashboardController dashboardController = Get.put(DashboardController());
      dashboardController.getHomeDataPress(false,false);
      Get.back();
    }
    else{
      _subCategoryController.isSubCatChildLoading.value = true;
      StoreController storeController = Get.put(StoreController());
      storeController.storeDetailsPress(false);
      Get.back();

    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          backgroundColor: AppColors.secondary,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.primary,
            elevation: 0,
            title: Text(
              AppStrings.ProductList,
              style: TextStyles.appBarTitle,
            ),
            actions: [
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Obx(() => Container(
                    height: 150.0,
                    width: 30.0,
                    child: new GestureDetector(
                      onTap: () {
                        final MyBucketController _myBucketController =
                            Get.put(MyBucketController());
                        _myBucketController.subCategoryProductList.value = true;
                        Get.toNamed(myBasket);
                      },
                      child: new Stack(
                        children: <Widget>[
                          new IconButton(
                            icon: new Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            onPressed: null,
                          ),
                          addToCartController.cartCount.value == "" ||
                                  addToCartController.cartCount.value == "0"
                              ? new Container()
                              : new Positioned(
                                  child: new Stack(
                                  children: <Widget>[
                                    new Icon(Icons.brightness_1,
                                        size: 22.0,
                                        color: AppColors.accentColor),
                                    new Positioned(
                                        top: 5.0,
                                        right: 4.0,
                                        left: 4,
                                        child: new Text(
                                          addToCartController.cartCount.value ==
                                                  "10"
                                              ? "9+"
                                              : addToCartController
                                                  .cartCount.value
                                                  .toString(),
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ],
                                )),
                        ],
                      ),
                    ))),
              )
            ],
          ),
          body: GetX<SubCategoryController>(initState: (state) {
            Future.delayed(Duration(milliseconds: 500), () {
              Get.find<SubCategoryController>().loadCategoryListPress();
            });
          }, builder: (_) {
            return _subCategoryController.isSubCatChildLoading.value
                ? Container()
                : Stack(
                    children: [
                      _subCategoryController.subCategoryProductList.length <= 0
                          ? Container(
                              child: Center(
                                  child: NoResult(
                                titleText: "Sorry no product found!",
                                subTitle: "",
                              )),
                            )
                          : Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              top: ScreenConstant.sizeXXXL,
                              child: AnimationLimiter(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: _subCategoryController
                                      .subCategoryProductList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      child: FlipAnimation(
                                        child: ScaleAnimation(
                                          child: SubCategoryProductListWidget(
                                            index: index,
                                            productList: _subCategoryController
                                                .subCategoryProductList,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              /*ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return OrdersListingWidget(index: index,);
                },
              ),*/
                            ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            height: ScreenConstant.sizeXXXL,
                            child: Row(
                              children: [
                                Container(
                                  width: ScreenConstant.sizeSmall,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _subCategoryController.allTap.value = true;
                                    _subCategoryController.isTapId.value = 100;
                                    _subCategoryController
                                        .subCategoryProductList
                                        .clear();
                                    _subCategoryController.subcategoryId.value =
                                        _subCategoryController.categoryParentId
                                            .toString();
                                    _subCategoryController.loadProductListPress(
                                        _subCategoryController.categoryParentId
                                            .toString(),
                                        true);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _subCategoryController.allTap.value
                                          ? AppColors.primary
                                          : AppColors.gapColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenConstant.sizeSmall,
                                          right: ScreenConstant.sizeSmall,
                                          top: ScreenConstant.sizeDefault,
                                          bottom: ScreenConstant.sizeDefault),
                                      child: Text(
                                        "All" ?? "",
                                        style: _subCategoryController
                                                .allTap.value
                                            ? TextStyle(
                                                fontSize: FontSizeStatic.md,
                                                color: AppColors.secondary,
                                                fontWeight: FontWeight.bold)
                                            : TextStyle(
                                                fontSize: FontSizeStatic.md,
                                                color: AppColors.accentColor,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                _subCategoryController
                                            .subCategoryChildList.length <
                                        1
                                    ? Offstage()
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _subCategoryController
                                            .subCategoryChildList.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _subCategoryController
                                                    .allTap.value = false;
                                                _subCategoryController
                                                    .isTapId.value = index;
                                                _subCategoryController
                                                    .subCategoryProductList
                                                    .clear();
                                                _subCategoryController
                                                        .subcategoryId.value =
                                                    _subCategoryController
                                                        .subCategoryChildList[
                                                            index]['id']
                                                        .toString();
                                                _subCategoryController
                                                    .loadProductListPress(
                                                        _subCategoryController
                                                            .subCategoryChildList[
                                                                index]['id']
                                                            .toString(),
                                                        true);
                                              });
                                            },
                                            child: TypeOfProductListWidget(
                                              id: _subCategoryController
                                                  .subCategoryChildList[index]
                                                      ['id']
                                                  .toString(),
                                              name: _subCategoryController
                                                      .subCategoryChildList[
                                                  index]['name'],
                                              isTap: index ==
                                                      _subCategoryController
                                                          .isTapId.value
                                                  ? true
                                                  : false,
                                            ),
                                          );
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          })),
    );
  }
}
