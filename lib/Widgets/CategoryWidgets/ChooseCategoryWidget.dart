import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/ChooseCategoryController/ChooseCategoryController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ScopeStorage.dart';
import 'package:go_potu_user/Store/ShareStore.dart';

class ChooseCategoryWidget extends StatelessWidget {
  final int? index;
  final ChooseCategoryController? chooseCategoryController = Get.find();

  ChooseCategoryWidget({
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    int typeIndex;
    typeIndex = ShareStore().getData(store: KeyStore.typeIndex) == null
        ? int.parse(HiveStore().get(Keys.typeSelectIndex) ?? "3")
        : int.parse(
            ShareStore().getData(store: KeyStore.typeIndex).toString() ?? "3");
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenConstant.sizeSmall,
          right: ScreenConstant.sizeSmall,
          bottom: ScreenConstant.sizeSmall),
      child: GestureDetector(
        onTap: index == 0
            ? chooseCategoryController!.isBeforeDashboard.value
                ? () {
                    Get.offAllNamed(dashBoard);
                    ShareStore()
                        .saveData(store: KeyStore.typeIndex, object: "0");
                    HiveStore().put(Keys.typeSelectIndex, "0");
                    ShareStore().saveData(store: KeyStore.type, object: "mart");
                    HiveStore().put(Keys.shopType, "mart");
                  }
                : () {
                    Get.back();
                    Get.offAllNamed(dashBoard);
                    ShareStore()
                        .saveData(store: KeyStore.typeIndex, object: "0");
                    HiveStore().put(Keys.typeSelectIndex, "0");
                    ShareStore().saveData(store: KeyStore.type, object: "mart");
                    HiveStore().put(Keys.shopType, "mart");
                  }
            : index == 1
                ? chooseCategoryController!.isBeforeDashboard.value
                    ? () {
                        ShareStore()
                            .saveData(store: KeyStore.typeIndex, object: "1");
                        HiveStore().put(Keys.typeSelectIndex, "1");
                        Get.offAllNamed(dashBoard);
                        ShareStore().saveData(
                            store: KeyStore.type, object: "restaurant");
                        HiveStore().put(Keys.shopType, "restaurant");
                      }
                    : () {
                        ShareStore()
                            .saveData(store: KeyStore.typeIndex, object: "1");
                        HiveStore().put(Keys.typeSelectIndex, "1");
                        Get.back();
                        Get.offAllNamed(dashBoard);
                        ShareStore().saveData(
                            store: KeyStore.type, object: "restaurant");
                        HiveStore().put(Keys.shopType, "restaurant");
                      }
                : () {
                    Get.back();
                    Get.snackbar(
                      "Sorry!",
                      "This Service is not available at this moment.",
                      backgroundColor: AppColors.secondary,
                      icon: Icon(
                        Icons.error_outline_sharp,
                        color: Colors.red,
                      ),
                      titleText: Text(
                        "Sorry!",
                        style: TextStyle(
                          fontFamily:
                              'Poppins', // Replace with the desired font family for the title
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      messageText: Text(
                        "This Service is not available at this moment.",
                        style: TextStyle(
                          fontFamily:
                              'Poppins', // Replace with the desired font family for the message
                        ),
                      ),
                    );
                  },
        child: Card(
          color: index == 0
              ? AppColors.categoryType1
              : index == 1
                  ? AppColors.secondary
                  : AppColors.categoryType3,
          elevation: 10,
          shape: RoundedRectangleBorder(
              side: new BorderSide(
                  color: index == typeIndex
                      ? AppColors.accentColor
                      : Colors.transparent,
                  width: 1.0),
              borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: EdgeInsets.all(ScreenConstant.sizeLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      index == 0
                          ? "GoPotu Mart"
                          : index == 1
                              ? "Restaurants Foods"
                              : "Door step service",
                      style: TextStyles.categoryTitle,
                    ),
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    Text(
                      index == 0
                          ? "1500+ products are there"
                          : index == 1
                              ? "150+ recipes are there"
                              : "50+ door-step service are there",
                      style: TextStyles.categorySubTitle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      height: ScreenConstant.sizeXL,
                    ),
                    GestureDetector(
                      onTap: index == 0
                          ? chooseCategoryController!.isBeforeDashboard.value
                              ? () {
                                  Get.offAllNamed(dashBoard);
                                  ShareStore().saveData(
                                      store: KeyStore.typeIndex, object: "0");
                                  HiveStore().put(Keys.typeSelectIndex, "0");
                                  ShareStore().saveData(
                                      store: KeyStore.type, object: "mart");
                                  HiveStore().put(Keys.shopType, "mart");
                                }
                              : () {
                                  Get.back();
                                  Get.offAllNamed(dashBoard);
                                  ShareStore().saveData(
                                      store: KeyStore.typeIndex, object: "0");
                                  HiveStore().put(Keys.typeSelectIndex, "0");
                                  ShareStore().saveData(
                                      store: KeyStore.type, object: "mart");
                                  HiveStore().put(Keys.shopType, "mart");
                                }
                          : index == 1
                              ? chooseCategoryController!
                                      .isBeforeDashboard.value
                                  ? () {
                                      ShareStore().saveData(
                                          store: KeyStore.typeIndex,
                                          object: "1");
                                      HiveStore()
                                          .put(Keys.typeSelectIndex, "1");
                                      Get.offAllNamed(dashBoard);
                                      ShareStore().saveData(
                                          store: KeyStore.type,
                                          object: "restaurant");
                                      HiveStore()
                                          .put(Keys.shopType, "restaurant");
                                    }
                                  : () {
                                      ShareStore().saveData(
                                          store: KeyStore.typeIndex,
                                          object: "1");
                                      HiveStore()
                                          .put(Keys.typeSelectIndex, "1");
                                      Get.back();
                                      Get.offAllNamed(dashBoard);
                                      ShareStore().saveData(
                                          store: KeyStore.type,
                                          object: "restaurant");
                                      HiveStore()
                                          .put(Keys.shopType, "restaurant");
                                    }
                              : () {
                                  Get.back();
                                  Get.snackbar(
                                    "Sorry!",
                                    "This Service is not available at this moment.",
                                    backgroundColor: AppColors.secondary,
                                    icon: Icon(
                                      Icons.error_outline_sharp,
                                      color: Colors.red,
                                    ),
                                    titleText: Text(
                                      "Sorry!",
                                      style: TextStyle(
                                        fontFamily:
                                            'Poppins', // Replace with the desired font family for the title
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    messageText: Text(
                                      "This Service is not available at this moment.",
                                      style: TextStyle(
                                        fontFamily:
                                            'Poppins', // Replace with the desired font family for the message
                                      ),
                                    ),
                                  );
                                },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: AppColors.buttonColorSecondary,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: ScreenConstant.sizeExtraSmall,
                              top: ScreenConstant.sizeExtraSmall,
                              left: ScreenConstant.sizeSmall,
                              right: ScreenConstant.sizeSmall),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Shop Now",
                                style: TextStyles.categoryChangeBottomText,
                              ),
                              Container(
                                width: ScreenConstant.sizeSmall,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: AppColors.secondary,
                              )
                            ],
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: ScreenConstant.sizeSmall,
                ),
                Container(
                  height: ScreenConstant.defaultHeightOneThirty,
                  width: ScreenConstant.defaultHeightOneThirty,
                  decoration: BoxDecoration(
                    //border: Border.all(color: AppColors.accentColor),
                    image: DecorationImage(
                      image: AssetImage(index == 0
                          ? Assets.category1
                          : index == 1
                              ? Assets.category2
                              : Assets.category3),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
