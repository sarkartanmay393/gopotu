import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/ProductController/ProductController.dart';
import 'package:go_potu_user/Controller/SearchController/SearchController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/NoResult.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ScopeStorage.dart';
import 'package:go_potu_user/Store/ShareStore.dart';
import 'package:go_potu_user/Widgets/HomeScreenWidgets/SearchProductListWidget.dart';
import 'package:go_potu_user/Widgets/StoreWidgets/StoreListWidget.dart';

class CategorySearchScreen extends StatelessWidget {
  final MySearchController _searchController = Get.put(MySearchController());
  String? lastInputValue;

  @override
  Widget build(BuildContext context) {
    String type = ShareStore().getData(store: KeyStore.type) == null
        ? HiveStore().get(Keys.shopType)
        : ShareStore().getData(store: KeyStore.type);
    _searchController.storeList.clear();
    _searchController.itemList.clear();
    _searchController.storeSelect.value = true;
    _searchController.itemSelect.value = false;
    _searchController.searchLocalList('');

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.secondary,
        body: Stack(
          children: [
            Positioned(
              top: ScreenConstant.defaultHeightOneHundredSeventy,
              left: 0,
              right: 0,
              bottom: 0,
              child: Obx(
                () => _searchController.itemSelect.value
                    ? _searchController.itemList.length < 1
                        ? Container(
                            child: Center(
                                child: NoResult(
                              titleText: type == "restaurant"
                                  ? "Sorry no dishes found!"
                                  : "Sorry no items found!",
                              subTitle: "",
                            )),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: _searchController.itemList.length,
                            itemBuilder: (context, index) {
                              return SearchProductListWidget(
                                index: index,
                                items: _searchController.itemList,
                                onTap: () {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  final ProductController _productController =
                                      Get.put(ProductController());
                                  _productController.isSearch.value = true;
                                  _productController.productId.value =
                                      _searchController.itemList[index]['id']
                                          .toString();
                                  Future.delayed(Duration(milliseconds: 500),
                                      () {
                                    _productController
                                        .productDetailsPress(false);
                                  });
                                  Get.toNamed(
                                    productDetails,
                                  );
                                },
                              );
                            },
                          )
                    : _searchController.storeList.length < 1
                        ? Container(
                            child: Center(
                                child: NoResult(
                              titleText: type == "restaurant"
                                  ? "Sorry no restaurants found!"
                                  : "Sorry no stores found!",
                              subTitle: "",
                            )),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenConstant.sizeSmall),
                            child: StaggeredGridView.countBuilder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: _searchController.storeList.length,
                                itemBuilder: (context, index) {
                                  return StoreListWidget(
                                    index: index,
                                    nearestStore: _searchController.storeList,
                                    onTap: () {
                                      FocusManager.instance.primaryFocus!
                                          .unfocus();
                                      Get.toNamed(storeDetails,
                                          arguments: JsonEncoder().convert({
                                            "id": _searchController
                                                .storeList[index]['id']
                                                .toString(),
                                            "isFavourite": true
                                          }));
                                    },
                                  );
                                },
                                staggeredTileBuilder: (int index) =>
                                    new StaggeredTile.count(1, 1.5),
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 8.0),
                          ),
              ),
            ),
            Obx(
              () => Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Column(
                  children: [
                    Container(
                      height: ScreenConstant.sizeXXL,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 15,
                        right: 15,
                      ),
                      child: TextFormField(
                        controller: _searchController.searchKeyController,
                        keyboardType: TextInputType.name,
                        autofocus: true,
                        enabled: true,
                        maxLines: 1,
                        style: TextStyles.textFieldText,
                        onChanged: (inputValue) {
                          if (lastInputValue != inputValue) {
                            lastInputValue = inputValue;
                            _searchController.searchLocalList(
                                _searchController.searchKeyController!.text);
                            print(
                                "New value inserted in textField $inputValue");
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: GestureDetector(
                            onTap: () {
                              Get.back();
                              _searchController.searchKeyController!.text = "";
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.accentColor,
                            ),
                          ),
                          filled: true,
                          fillColor: AppColors.secondary,
                          contentPadding:
                              EdgeInsets.all(ScreenConstant.sizeMedium),
                          hintText: type == "restaurant"
                              ? "Search for restaurants, items or more..."
                              : "Search for stores, items or more...",
                          hintStyle: TextStyles.hintTextFieldHints,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.textFieldBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid),
                          ),
                          disabledBorder: OutlineInputBorder(
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
                        ),
                      ),
                    ),
                    _searchController.loader.value
                        ? LinearProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                AppColors.primary),
                            backgroundColor: AppColors.primary.withOpacity(.4),
                          )
                        : Offstage(),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20, top: 20),
                      child: Row(
                        children: [
                          Obx(() => GestureDetector(
                                onTap: () {
                                  _searchController.itemSelect.value = false;
                                  _searchController.storeSelect.value = true;
                                },
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: ScreenConstant.sizeLarge,
                                      bottom: ScreenConstant.sizeExtraSmall,
                                      right: ScreenConstant.sizeLarge,
                                      top: ScreenConstant.sizeExtraSmall,
                                    ),
                                    child: Center(
                                        child: Text(
                                            type == "restaurant"
                                                ? "Restaurants"
                                                : "Stores",
                                            style: TextStyle(
                                                color: _searchController
                                                        .storeSelect.value
                                                    ? AppColors.secondary
                                                    : AppColors.storeDistance,
                                                fontSize: FontSizeStatic.semiSm,
                                                fontWeight: FontWeight.bold,
                                                /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                                    'Poppins'))),
                                  ),
                                ),
                              )),
                          Container(
                            width: ScreenConstant.sizeMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
