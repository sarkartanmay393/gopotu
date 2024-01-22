import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../DeviceManager/Assets.dart';
import '../../DeviceManager/Colors.dart';
import '../../DeviceManager/ScreenConstants.dart';
import '../../DeviceManager/TextStyles.dart';

class LocationPermissionNotAvailable extends StatelessWidget {
  LocationPermissionNotAvailable({Key? key}) : super(key: key);
  Location location = new Location();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(Assets.locationOff),
            height: ScreenConstant.defaultHeightOneThirty,
          ),
          Container(
            height: ScreenConstant.sizeMedium,
          ),
          Text("Device location is disable",
              style: TextStyle(
                  color: AppColors.loginTitle,
                  fontSize: FontSizeStatic.xl,
                  fontWeight: FontWeight.bold,
                  /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins')),
          Container(
            height: ScreenConstant.sizeSmall,
          ),
          Text("Location help us deliver to your address",
              style: TextStyle(
                  color: AppColors.loginTitle,
                  fontSize: FontSizeStatic.maxMd,
                  /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins')),
          Container(
            height: ScreenConstant.sizeExtraLarge,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: SizedBox(
              height: ScreenConstant.sizeXXXL,
              width: screenWidth,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      new BorderRadius.all(new Radius.circular(40))),
                  backgroundColor: AppColors.buttonColorSecondary,
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.gps_fixed,
                      color: AppColors.secondary,
                      size: ScreenConstant.sizeMidLarge,
                    ),
                    Container(
                      width: ScreenConstant.sizeSmall,
                    ),
                    Text(
                      "Enable location",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: FontSizeStatic.maxMd,
                          fontWeight: FontWeight.bold,
                          /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins'),
                    ),
                  ],
                ),
                onPressed: () async {
                  bool serviceEnabled;
                  LocationPermission permission;
                  Location location = new Location();

                  // Test if location services are enabled.
                  serviceEnabled = await Geolocator.isLocationServiceEnabled();

                  permission = await Geolocator.checkPermission();

                  if (serviceEnabled &&
                      permission != LocationPermission.denied &&
                      permission != LocationPermission.deniedForever) {
                    // print("LINE NO 297");
                    // await _determinePosition().then((Position value) async {
                    //   setLatLng(LatLng(value.latitude, value.longitude));
                    // });
                    // _addressController.isEdit.value = false;
                    // Get.to(MapView(
                    //   value: LatLng(_addressController.lat2.value,
                    //       _addressController.lng2.value),
                    // ));
                  } else if (!serviceEnabled) {
                    print("LINE NO 310");

                    serviceEnabled = await location.requestService();
                  } else if (permission == LocationPermission.whileInUse) {
                    serviceEnabled = await location.requestService();
                  } else if (permission ==
                      LocationPermission.unableToDetermine) {
                    serviceEnabled = await location.requestService();
                  } else if (permission == LocationPermission.denied) {
                    print("LINE NO 318");
                    Widget cancelButton = TextButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: AppColors.accentColor,
                            fontSize: FontSizeStatic.md,
                            fontWeight: FontWeight.bold,
                            /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins'),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    );
                    Widget continueButton = TextButton(
                      child: Text(
                        "Settings",
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: FontSizeStatic.md,
                            fontWeight: FontWeight.bold,
                            /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins'),
                      ),
                      onPressed: () async {
                        Get.back();
                        openAppSettings();
                      },
                    );

                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      title: Text(
                        "Sorry!",
                        style: TextStyles.productPrice,
                      ),
                      content: Text(
                        "Please update your location permission from the app settings.",
                        style: TextStyles.chooseCategorySubTitle,
                      ),
                      actions: [
                        cancelButton,
                        continueButton,
                      ],
                    );

                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  } else if (permission == LocationPermission.deniedForever) {
                    print("LINE NO 372");
                    Widget cancelButton = TextButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: AppColors.accentColor,
                            fontSize: FontSizeStatic.md,
                            fontWeight: FontWeight.bold,
                            /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins'),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    );
                    Widget continueButton = TextButton(
                      child: Text(
                        "Settings",
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: FontSizeStatic.md,
                            fontWeight: FontWeight.bold,
                            /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins'),
                      ),
                      onPressed: () async {
                        Get.back();
                        openAppSettings();
                      },
                    );

                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      title: Text(
                        "Sorry!",
                        style: TextStyles.productPrice,
                      ),
                      content: Text(
                        "Please update your location permission from the app settings.",
                        style: TextStyles.chooseCategorySubTitle,
                      ),
                      actions: [
                        cancelButton,
                        continueButton,
                      ],
                    );

                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  } else {
                    print("LINE NO 427");
                    permission = await Geolocator.requestPermission();
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
