import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/ProductController/ProductController.dart';
import 'package:go_potu_user/Controller/StoreController/StoreController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/NoResult.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ScopeStorage.dart';
import 'package:go_potu_user/Store/ShareStore.dart';
import 'package:go_potu_user/Widgets/HomeScreenWidgets/SearchProductListWidget.dart';

class StoreProductSearchScreen extends StatelessWidget {
  StoreProductSearchScreen({this.lastInputValue});

  final StoreController _storeController = Get.put(StoreController());
  String? lastInputValue;

  @override
  Widget build(BuildContext context) {
    String type = ShareStore().getData(store: KeyStore.type) == null
        ? HiveStore().get(Keys.shopType)
        : ShareStore().getData(store: KeyStore.type);
    _storeController.itemList.clear();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.secondary,
        body: Stack(
          children: [
            Positioned(
              top: ScreenConstant.defaultHeightOneThirty,
              left: 0,
              right: 0,
              bottom: 0,
              child: Obx(
                () => _storeController.itemList.length < 1
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
                        itemCount: _storeController.itemList.length,
                        itemBuilder: (context, index) {
                          return SearchProductListWidget(
                            index: index,
                            items: _storeController.itemList,
                            onTap: () {
                              FocusManager.instance.primaryFocus!.unfocus();
                              final ProductController _productController =
                                  Get.put(ProductController());
                              _productController.isSearch.value = true;
                              _productController.productId.value =
                                  _storeController.itemList[index]['id']
                                      .toString();
                              Future.delayed(Duration(milliseconds: 500), () {
                                _productController.productDetailsPress(false);
                              });

                              Get.toNamed(
                                productDetails,
                              );
                            },
                          );
                        },
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
                        top: 1.0,
                        left: 15,
                        right: 15,
                      ),
                      child: TextFormField(
                        controller: _storeController.searchKeyController,
                        keyboardType: TextInputType.name,
                        autofocus: true,
                        enabled: true,
                        maxLines: 1,
                        style: TextStyles.textFieldText,
                        onChanged: (inputValue) {
                          if (lastInputValue != inputValue) {
                            lastInputValue = inputValue;
                            _storeController.searchListPress(false);
                            print(
                                "New value inserted in textField $inputValue");
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: GestureDetector(
                            onTap: () {
                              Get.back();
                              _storeController.searchKeyController!.text = "";
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
                          hintText: "Search for items name or more...",
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
                    _storeController.loader.value
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
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: AppColors.accentColor),
                              color: AppColors.accentColor,
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
                                      type == "restaurant" ? "Dishes" : "Items",
                                      style: TextStyle(
                                          color: AppColors.secondary,
                                          fontSize: FontSizeStatic.semiSm,
                                          fontWeight: FontWeight.bold,
                                          /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                              'Poppins'))),
                            ),
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
