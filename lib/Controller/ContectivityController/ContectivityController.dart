import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../Models/ResponseModels/AccountSettingResponseModel/AccountSettingResponseModel.dart';
import '../../Router/RouteConstants.dart';
import '../../Service/CoreService.dart';
import '../../Service/Url.dart';
import '../../Views/ConnectionNotScreens/ConnectionNotScreens.dart';
import '../../Views/LocationPermissionNotAvailable/LocationPermissionNotAvailable.dart';

class ContectivityController extends GetxController {
  var isNetwokAvailabe = true.obs;
  var isNotConnectionPage = false.obs;
  var isLocationAvailable = false.obs;
  var isNotLocationPage = false.obs;
  var subscription = Connectivity()
      .onConnectivityChanged
      .listen((ConnectivityResult result) {});

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete {
    subscription.cancel();

    return super.onDelete;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkLocationEnable().then((value) {
      if (isLocationAvailable.value == false &&
          Get.currentRoute != "/LocationPermissionNotAvailable") {
        Get.offAll(LocationPermissionNotAvailable());
        isNotLocationPage.value = false;
      } else {
        isNotLocationPage.value = true;
      }
    });
    var subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isNetwokAvailabe.value = false;
      } else {
        isNetwokAvailabe.value = true;
        update();
        Get.closeCurrentSnackbar();
        Get.closeAllSnackbars();
      }
    });
    Future.delayed(const Duration(seconds: 1), () {
      isNetwokAvailabe.listen((p0) {
        debugPrint("Value listened");


        if (isNetwokAvailabe.value == false) {
          debugPrint("network listened");
        } else {
          if (isNetwokAvailabe.value == true) {
            debugPrint("Close all snackbars");
            Get.closeCurrentSnackbar();
            Get.closeAllSnackbars();
            Get.closeAllSnackbars();
            Get.offAllNamed(splash);
          }
        }
      });
    });

    Future.delayed(const Duration(seconds: 1), () {
      isLocationAvailable.listen((p0) {
        debugPrint("Value listened");

        if (isLocationAvailable.value == false) {
        } else {
          if (isLocationAvailable.value == true) {
            debugPrint("Close all snackbars");
            Get.closeCurrentSnackbar();
            Get.closeAllSnackbars();
            Get.closeAllSnackbars();
            Get.offAllNamed(splash);
          }
        }
      });
    });

    Timer.periodic(Duration(milliseconds: 2000), (T) {
      if (isNetwokAvailabe.value == false &&
          Get.currentRoute != "/ConnectionNotScreens") {
        print("Get Current route: ${Get.currentRoute}");
        Get.offAll(ConnectionNotScreens());
        isNotConnectionPage.value = false;
      } else {
        isNotConnectionPage.value = true;
      }
    });

    Timer.periodic(Duration(milliseconds: 2000), (T) {
      checkLocationEnable().then((value) {
        if (isLocationAvailable.value == false &&
            Get.currentRoute != "/LocationPermissionNotAvailable") {
          Get.offAll(LocationPermissionNotAvailable());
          isNotLocationPage.value = false;
        } else {
          isNotLocationPage.value = true;
        }
      });
    });
  }

  checkLocationEnable() async {
    bool serviceEnabled;
    LocationPermission permission;
    PermissionStatus getPermission;
    Location location = new Location();
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.checkPermission();
    if (serviceEnabled &&
        permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever) {
      isLocationAvailable.value = true;
    } else {
      getPermission = await location.requestPermission();
      isLocationAvailable.value = false;
    }
  }
}
