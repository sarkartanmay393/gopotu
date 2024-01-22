import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/FavouriteController/FavouriteController.dart';
import 'package:go_potu_user/Controller/StoreController/StoreController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/NoResult.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Widgets/StoreWidgets/FavouriteListWidget.dart';

import 'FavouriteFilterScreen.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({Key? key}) : super(key: key);
  final FavouriteController _favouriteController =
      Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "My Favourite",
          style: TextStyles.appBarTitle,
        ),
        elevation: 0,
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.all(15.0),
        //     child: GestureDetector(
        //         onTap: () {
        //           showBottomSheet(context);
        //         },
        //         child: Icon(Icons.filter_list)),
        //   )
        // ],
      ),
      body: GetX<FavouriteController>(initState: (state) {
        Get.find<FavouriteController>().favouriteListPress(
          true,
        );
      }, builder: (_) {
        return _favouriteController.favouriteList.length < 1
            ? Container(
                child: Center(
                    child: NoResult(
                  titleText: "Sorry no favourite list found!",
                  subTitle: "",
                )),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: _favouriteController.favouriteList.length,
                itemBuilder: (context, index) {
                  return FavouriteListWidget(
                    index: index,
                    favouriteStore: _favouriteController.favouriteList,
                    onTap: _favouriteController.favouriteList[index]['shop']
                                ['online'] ==
                            "1"
                        ? () {
                            Get.toNamed(storeDetails,
                                arguments: JsonEncoder().convert({
                                  "id": _favouriteController
                                      .favouriteList[index]['shop']['id']
                                      .toString(),
                                  "isFavourite": true
                                }));
                          }
                        : () {
                            Get.snackbar("Sorry!", "The Shop is closed now",
                                backgroundColor: AppColors.secondary,
                                icon: Icon(
                                  Icons.error,
                                  color: Colors.redAccent,
                                ),titleText: Text(
                                "Sorry!",
                                style: TextStyle(
                                  fontFamily: 'Poppins',  // Replace with the desired font family for the title
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              messageText: Text(
                                "The shop is closed now",
                                style: TextStyle(
                                  fontFamily: 'Poppins',  // Replace with the desired font family for the message

                                ),
                              ),);
                          },
                  );
                },
              );
      }),
    );
  }

  showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: AppColors.secondary,
        isDismissible: true,
        context: context,
        builder: (context) {
          return FavouriteFilterScreen();
        });
  }
}
