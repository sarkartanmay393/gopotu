import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddressController/AddressController.dart';
import 'package:go_potu_user/Controller/MyBucketController/MyBucketController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/NoResult.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Views/AddressScreens/MapView.dart';
import 'package:go_potu_user/Widgets/AddressWidgets/AddressListWidget.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class AddressListScreen extends StatefulWidget {
  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  final AddressController _addressController = Get.put(AddressController());

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    print("LINE No - 34");
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press Back button again to Exit");
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<bool> _onBackPressed() {
    if (_addressController.isHomeScreen.value) {
      print("LINE No - 47");
      Get.offAllNamed(dashBoard);
    } else {
      final MyBucketController _myBucketController =
          Get.put(MyBucketController());
      _myBucketController.getBucketPress(
          true, _myBucketController.applyCouponCode.value);
      _addressController.isCheckOutPage.value = false;
      Get.back();
    }
    return Future.value(false);
  }

  Future _refreshData() async {
    //await Future.delayed(Duration(seconds: 1));
    _addressController.fetchAddressListPress(false);
  }

  bool? _serviceEnabled;

  bool stop = false;
  Timer? _timer;

  setLatLng(LatLng _position) async {
    _addressController.lat.value = _position.latitude;
    _addressController.lng.value = _position.longitude;
    _addressController.lat2.value = _position.latitude;
    _addressController.lng2.value = _position.longitude;

    print("Lat : ${_addressController.lat.value}");
    print("Lng : ${_addressController.lng.value}");
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    // _timer = Timer.periodic(Duration(seconds: 15), (timer) async {
    //   // print("hi");
    //   if (isChecking) {
    //     Location location = new Location();
    //     _serviceEnabled = await location.serviceEnabled();
    //     if (!_serviceEnabled) {
    //       setState(() {
    //         isChecking = false;
    //       });
    //       _serviceEnabled = await location.requestService().then((value) {
    //         if (value) {
    //           isChecking = true;
    //         } else {
    //           isChecking = true;
    //         }
    //       });
    //     }
    //   }
    // });
    String? gToken = HiveStore().get(Keys.guestToken);
    return Obx(() => WillPopScope(
          onWillPop: _addressController.addressListData.length < 1
              ? onWillPop
              : _onBackPressed,
          child: Scaffold(
            backgroundColor: AppColors.secondary,
            /*drawer: Drawer(
        ),*/
            floatingActionButton: Obx(() => _addressController.isLoading.isFalse
                ? Container()
                : _addressController.addressListData.length < 1
                    ? FloatingActionButton.extended(
                        onPressed: () async {
                          bool serviceEnabled;
                          LocationPermission permission;
                          Location location = new Location();

                          // Test if location services are enabled.
                          serviceEnabled =
                              await Geolocator.isLocationServiceEnabled();

                          permission = await Geolocator.checkPermission();

                          if (serviceEnabled &&
                              permission != LocationPermission.denied &&
                              permission != LocationPermission.deniedForever) {
                            print("LINE NO 297");
                            await _determinePosition()
                                .then((Position value) async {
                              setLatLng(
                                  LatLng(value.latitude, value.longitude));
                            });
                            _addressController.isEdit.value = false;
                            Get.to(MapView(
                              value: LatLng(_addressController.lat2.value,
                                  _addressController.lng2.value),
                            ));
                          } else if (!serviceEnabled) {
                            print("LINE NO 310");

                            _serviceEnabled = await location.requestService();
                          } else if (permission ==
                              LocationPermission.whileInUse) {
                            _serviceEnabled = await location.requestService();
                          } else if (permission ==
                              LocationPermission.unableToDetermine) {
                            _serviceEnabled = await location.requestService();
                          } else if (permission == LocationPermission.denied) {
                            print("LINE NO 318");
                            Widget cancelButton = TextButton(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: AppColors.accentColor,
                                    fontSize: FontSizeStatic.md,
                                    fontWeight: FontWeight.bold,
                                    /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                        'Poppins'),
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
                                    /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                        'Poppins'),
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
                          } else if (permission ==
                              LocationPermission.deniedForever) {
                            print("LINE NO 372");
                            Widget cancelButton = TextButton(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: AppColors.accentColor,
                                    fontSize: FontSizeStatic.md,
                                    fontWeight: FontWeight.bold,
                                    /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                        'Poppins'),
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
                                    /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                        'Poppins'),
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
                        icon: Icon(Icons.add),
                        label: Text('Add Address'),
                        backgroundColor: AppColors.primary,
                      )
                    : Offstage()),
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: AppColors.primary,
              title: Text(
                "Address List",
                style: TextStyles.appBarTitle,
              ),
              actions: [
                Obx(() => _addressController.isLoading.isFalse
                    ? Container()
                    : _addressController.addressListData.length < 1
                        ? GestureDetector(
                            onTap: gToken == null
                                ? () async {
                                    print("Login");
                                    await HiveStore().delete(Keys.guestToken);
                                    Get.offAllNamed(signIn);
                                  }
                                : () {
                                    showAlertDialog(context);
                                  },
                            child: gToken == null
                                ? Icon(Icons.login)
                                : Icon(Icons.logout))
                        : Offstage()),
                Container(
                  width: ScreenConstant.sizeMedium,
                ),
              ],
            ),
            body: GetX<AddressController>(initState: (state) {
              Get.find<AddressController>().fetchAddressListPress(true);
            }, builder: (_) {
              return _addressController.isLoading.isFalse
                  ? Container()
                  : _addressController.addressListData.length < 1
                      ? Container(
                          child: Center(
                              child: NoResult(
                            titleText: "Sorry no address found!",
                            subTitle: "",
                          )),
                        )
                      : RefreshIndicator(
                          onRefresh: _refreshData,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                bottom:
                                    _addressController.addressListData.length >
                                                2 &&
                                            _addressController
                                                .isAddressCardSelect.value
                                        ? 60
                                        : 0,
                                left: 0,
                                right: 0,
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                          ScreenConstant.sizeLarge),
                                      child: Text(
                                        AppStrings.chooseShoppingAddress,
                                        style: TextStyles.addressListTitleText,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20, bottom: 15),
                                      child: SizedBox(
                                        height: ScreenConstant.sizeXXXL,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: AppColors.primary),
                                                borderRadius: new BorderRadius
                                                    .all(
                                                    new Radius.circular(5))),
                                            elevation: 0,
                                            backgroundColor:
                                                AppColors.secondary,
                                          ),
                                          child: Text(
                                            "+ Add Address",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize: FontSizeStatic.semiSm,
                                                fontWeight: FontWeight.bold,
                                                /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                                    'Poppins'),
                                          ),
                                          onPressed: () async {
                                            bool serviceEnabled;
                                            LocationPermission permission;
                                            Location location = new Location();

                                            // Test if location services are enabled.
                                            serviceEnabled = await Geolocator
                                                .isLocationServiceEnabled();

                                            permission = await Geolocator
                                                .checkPermission();

                                            if (serviceEnabled &&
                                                permission !=
                                                    LocationPermission.denied &&
                                                permission !=
                                                    LocationPermission
                                                        .deniedForever) {
                                              print("LINE NO 297");
                                              await _determinePosition()
                                                  .then((Position value) async {
                                                setLatLng(LatLng(value.latitude,
                                                    value.longitude));
                                              });
                                              _addressController
                                                      .isCheckOutPage.value
                                                  ? _addressController
                                                      .isCheckOutPage
                                                      .value = true
                                                  : _addressController
                                                      .isCheckOutPage
                                                      .value = false;
                                              _addressController
                                                      .isCheckOutPage.value
                                                  ? _addressController
                                                      .isChaeckOutAddAddress
                                                      .value = true
                                                  : _addressController
                                                      .isChaeckOutAddAddress
                                                      .value = false;
                                              _addressController.isEdit.value =
                                                  false;
                                              Get.to(MapView(
                                                value: LatLng(
                                                    _addressController
                                                        .lat2.value,
                                                    _addressController
                                                        .lng2.value),
                                              ));
                                            } else if (!serviceEnabled) {
                                              print("LINE NO 310");

                                              _serviceEnabled = await location
                                                  .requestService();
                                            } else if (permission ==
                                                LocationPermission.whileInUse) {
                                              _serviceEnabled = await location
                                                  .requestService();
                                            } else if (permission ==
                                                LocationPermission
                                                    .unableToDetermine) {
                                              _serviceEnabled = await location
                                                  .requestService();
                                            } else if (permission ==
                                                LocationPermission.denied) {
                                              print("LINE NO 318");
                                              Widget cancelButton = TextButton(
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.accentColor,
                                                      fontSize:
                                                          FontSizeStatic.md,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Proxima-Bold'),
                                                ),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                              );
                                              Widget continueButton =
                                                  TextButton(
                                                child: Text(
                                                  "Settings",
                                                  style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontSize:
                                                          FontSizeStatic.md,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Proxima-Bold'),
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
                                                  style:
                                                      TextStyles.productPrice,
                                                ),
                                                content: Text(
                                                  "Please update your location permission from the app settings.",
                                                  style: TextStyles
                                                      .chooseCategorySubTitle,
                                                ),
                                                actions: [
                                                  cancelButton,
                                                  continueButton,
                                                ],
                                              );

                                              // show the dialog
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return alert;
                                                },
                                              );
                                            } else if (permission ==
                                                LocationPermission
                                                    .deniedForever) {
                                              print("LINE NO 372");
                                              Widget cancelButton = TextButton(
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.accentColor,
                                                      fontSize:
                                                          FontSizeStatic.md,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Proxima-Bold'),
                                                ),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                              );
                                              Widget continueButton =
                                                  TextButton(
                                                child: Text(
                                                  "Settings",
                                                  style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontSize:
                                                          FontSizeStatic.md,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Proxima-Bold'),
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
                                                  style:
                                                      TextStyles.productPrice,
                                                ),
                                                content: Text(
                                                  "Please update your location permission from the app settings.",
                                                  style: TextStyles
                                                      .chooseCategorySubTitle,
                                                ),
                                                actions: [
                                                  cancelButton,
                                                  continueButton,
                                                ],
                                              );

                                              // show the dialog
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return alert;
                                                },
                                              );
                                            } else {
                                              print("LINE NO 427");
                                              permission = await Geolocator
                                                  .requestPermission();
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    Obx(() => AnimationLimiter(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: ClampingScrollPhysics(),
                                            itemCount: _addressController
                                                .addressListData.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return AnimationConfiguration
                                                  .staggeredList(
                                                position: index,
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                                child: SlideAnimation(
                                                  verticalOffset: 50.0,
                                                  child: FadeInAnimation(
                                                    child: GestureDetector(
                                                      onTap: _addressController
                                                                  .addressListData[
                                                              index]['deliverable']
                                                          ? () {
                                                              _addressController
                                                                  .isAddressCardSelect
                                                                  .value = true;
                                                              _addressController
                                                                  .onAddressSelect
                                                                  .value = index;
                                                              _addressController
                                                                      .addressId
                                                                      .value =
                                                                  _addressController
                                                                      .addressListData[
                                                                          index]
                                                                          ['id']
                                                                      .toString();
                                                            }
                                                          : () {},
                                                      child: AddressListWidget(
                                                        index: index,
                                                        addressListData:
                                                            _addressController
                                                                .addressListData,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              Obx(() =>
                                  _addressController.isAddressCardSelect.value
                                      ? Positioned(
                                          bottom: 10,
                                          left: 40,
                                          right: 40,
                                          child: AppButton(
                                            buttonText: "Continue",
                                            onPressed: () {
                                              _addressController
                                                  .setDefaultAddressPress();
                                            },
                                          ),
                                        )
                                      : Positioned(
                                          top: 2,
                                          right: 2,
                                          child: Icon(
                                            Icons.add,
                                            size: 5,
                                            color: AppColors.secondary,
                                          )))
                            ],
                          ),
                        );
            }),
          ),
        ));
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
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
        "Yes",
        style: TextStyle(
            color: AppColors.primary,
            fontSize: FontSizeStatic.md,
            fontWeight: FontWeight.bold,
            /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins'),
      ),
      onPressed: () async {
        await HiveStore().delete(Keys.accessToken);
        await HiveStore().delete(Keys.guestToken);
        await HiveStore().delete(Keys.profileData);
        await HiveStore().delete(Keys.userNumber);
        await HiveStore().delete(Keys.shopType);
        await HiveStore().delete(Keys.typeSelectIndex);
        await HiveStore().delete(Keys.isDefaultAddressSet);
        await HiveStore().put(Keys.landingShow, "true");
        Get.offAllNamed(signIn);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Log Out!",
        style: TextStyles.productPrice,
      ),
      content: Text(
        "Are you sure want to log out?",
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
  }
}
