import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/OrderListController/OrderListController.dart';
import 'package:go_potu_user/Controller/SupportTicketController/SupportTicketController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/DateTimeConverter.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Views/CompanyScreens/CustomerCareService.dart';
import 'package:go_potu_user/Views/CompanyScreens/RateUSScreen.dart';
import 'package:go_potu_user/Views/HelpScreen/Help.dart';
import 'package:go_potu_user/Views/OrdersScreen/OrderDetailsScreen.dart';
import 'package:go_potu_user/Views/OrdersScreen/ReturnReplaceRequestScreen.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';
import 'package:go_potu_user/Widgets/OrdersWidgets/OrderListWidgetProductListWidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../Controller/AddressController/AddressController.dart';
import '../../Controller/MyBucketController/MyBucketController.dart';
import '../../Controller/ProductController/ProductController.dart';
import '../../Controller/SplashController/SplashController.dart';
import '../../Models/ResponseModels/OrderListResponseModel/OrderListResponseModel.dart';
import '../../Router/RouteConstants.dart';
import '../../Store/HiveStore.dart';
import '../AddressScreens/SelectAddress.dart';

class TrcakingScreen1 extends StatefulWidget {
  @override
  State<TrcakingScreen1> createState() => _TrcakingScreen1State();
}

class _TrcakingScreen1State extends State<TrcakingScreen1>
    with TickerProviderStateMixin {
  Timer? _timer;
  List<Order>? orderListData;

  final OrderListController _orderListController =
  Get.find<OrderListController>();
  final SplashController _splashController = Get.put(SplashController());
  final AddressController _addressController = Get.put(AddressController());
  final MyBucketController _myBucketController = Get.put(MyBucketController());
  setInitialAddress({LatLng? latLng, String description = ''}) async {
    List<Placemark> placeMarks =
    await placemarkFromCoordinates(latLng!.latitude, latLng.longitude);
    var place = placeMarks.first;
    print(place);
    var _address = '';
    if (description.isNotEmpty) {
      _address = description + ' - ${place.postalCode}';
    } else {
      _address =
      '${place.street}, ${place.thoroughfare},${place.subLocality}, ${place.locality}, ${place.country} - ${place.postalCode}';
    }
    setState(() {
      _addressController.location.text = _address;
      _addressController.city.value = place.locality!;
      _addressController.state.value = place.administrativeArea!;
      _addressController.postalCode.value = place.postalCode!;
      _addressController.country.value = place.country!;
      _addressController.postalCodeController.text = place.postalCode!;
    });
  }

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

  bool isOpen = true;

  AnimationController? controller;

  bool isPlaying = false;
  List<Color> colorList = [
    Color(0xFF00d9e2),
    Color(0xFF6c78fb),
    Color(0xFFff004e),
  ];
  List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];
  int index = 0;
  Color bottomColor = Color(0xFF00d9e2);
  Color topColor = Color(0xFF6c78fb);
  Alignment begin = Alignment.centerLeft;
  Alignment end = Alignment.centerRight;

  // String get countText {
  //   Duration count = controller?.duration * controller!.value;

  //   return controller.isDismissed
  //       ? '${controller!.duration!.inHours}:${(controller!.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller!.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
  //       : controller.isCompleted
  //           ? '0'
  //           : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  // }
  String get countText {
    if (controller == null) {
      return '0:00:00'; // Return a default value when controller is null
    }

    Duration count = controller!.duration! * controller!.value;

    return controller!.isDismissed
        ? '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}'
        : controller!.isCompleted
        ? '0:00:00' // Return 0 when completed
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;

  Future _refreshData() async {
    //await Future.delayed(Duration(seconds: 1));
    _orderListController.getOrderDetailsPress(true).then((value) {
      if (_orderListController.orderDetailsData.value.status ==
          "outfordelivery") {
        _orderListController.getOrderTimeDetailsPress(true).then((value) {
          Future.delayed(const Duration(seconds: 1), () async {
            print("Time3: ${_orderListController.secondsEstimated.value}");
            setState(() {
              controller!.reset();
              controller!.duration = Duration(
                  seconds: _orderListController.secondsEstimated.value);
              print("controller.duration : ${controller!.duration}");
              controller!.reverse(
                  from: controller!.value == 0 ? 1.0 : controller!.value);
              progress = 1.0;
              Future.delayed(const Duration(milliseconds: 1000), () {
                print("Animation container");
                setState(() {
                  bottomColor = Colors.blue;
                });
              });
            });
          });
        });
      }
    });
  }

  Future<bool> _onBackPressed() {
    Get.back();
    if (_orderListController.orderDetailsData.value.status ==
        "outfordelivery") {
      _timer!.cancel();
      controller!.dispose();
      return Future.value(true);
    }

    _orderListController.isTimeApiDone.value = true;
    _orderListController.getOrderListPress(true, "");

    return Future.value(false);
  }

  void notify() {
    if (countText == '0:00:00') {
      // FlutterRingtonePlayer.playNotification();
    }
  }

  @override
  void initState() {
    super.initState();

    _orderListController.getOrderDetailsPress(true).then((value) {
      if (_orderListController.orderDetailsData.value.status ==
          "outfordelivery") {
        _orderListController.getOrderTimeDetailsPress(false).then((value) {
          Future.delayed(const Duration(seconds: 1), () async {
            print("Time2: ${_orderListController.secondsEstimated.value}");

            _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
              _orderListController.initialPosition.value =
                  _orderListController.initialPosition.value - 1;
              //tme = tme - Duration(seconds: 1);
              // remainingTime = totalDuration - intialPosition;
              // _controller.restart(
              //     duration: totalDuration, initialPosition: remainingTime);
              debugPrint(
                  "Seconds Lapsed : ${_orderListController.initialPosition.value}");
              if (_orderListController.initialPosition.value == 30) {
                _orderListController
                    .getOrderTimeDetailsPress(false)
                    .then((value) {
                  _orderListController
                      .getOrderTimeDetailsPress(false)
                      .then((value) {
                    Future.delayed(const Duration(seconds: 1), () async {
                      print(
                          "Time3: ${_orderListController.secondsEstimated.value}");
                      setState(() {
                        controller!.reset();
                        controller!.duration = Duration(
                            seconds:
                            _orderListController.secondsEstimated.value);
                        print("controller.duration : ${controller!.duration}");
                        controller!.reverse(
                            from: controller!.value == 0
                                ? 1.0
                                : controller!.value);
                        progress = 1.0;
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          print("Animation container");
                          setState(() {
                            bottomColor = Colors.blue;
                          });
                        });
                      });
                    });
                  });
                });
              }
            });

            setState(() {
              controller = AnimationController(
                vsync: this,
                duration: Duration(
                    seconds: _orderListController.secondsEstimated.value),
              );

              controller!.addListener(() {
                notify();
                if (controller!.isAnimating) {
                  setState(() {
                    progress = controller!.value;
                  });
                } else {
                  print("===");

                  print(controller!.value);
                  if (controller!.value == 0) {
                    setState(() {
                      controller = AnimationController(
                        vsync: this,
                        duration: Duration(seconds: 0),
                      );
                      //controller.reset();
                    });
                  }
                  print("===");
                  setState(() {
                    isPlaying = false;
                  });
                }
              });

              if (controller!.isAnimating) {
                controller!.stop();

                setState(() {
                  isPlaying = false;
                });
              } else {
                controller!.reverse(
                    from: controller!.value == 0 ? 1.0 : controller!.value);

                setState(() {
                  isPlaying = true;
                });
              }

              Future.delayed(const Duration(milliseconds: 1000), () {
                print("Animation container");
                setState(() {
                  bottomColor = Colors.blue;
                });
              });
            });
          });
        });
      }
    });
    // startTimer();
  }

  String? _timerValue ;// 20 minutes in seconds

  // void startTimer() {
  //   const oneSec = Duration(seconds: 1);
  //   _timer = Timer.periodic(
  //     oneSec,
  //         (Timer timer) {
  //       if (_timerValue == 0) {
  //         timer.cancel();
  //       } else {
  //         setState(() {
  //           _timerValue != null?
  //         });
  //       }
  //     },
  //   );
  // }



  @override
  void dispose() {
    print("Line: 216");
    if (_orderListController.orderDetailsData.value.status ==
        "outfordelivery") {
      _timer!.cancel();
    }
    super.dispose();
    _timer?.cancel();
    // startTimer();

  }
  // String get formattedTime {
  //   int minutes = _timerValue ~/ 60;
  //   int seconds = _timerValue % 60;
  //   return '$minutes:${seconds.toString().padLeft(2, '0')}';
  // }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            backgroundColor: Colors.white,
        appBar: AppBar(

        centerTitle: true,
        backgroundColor: Color(0xFFD32033),

          elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Product Details",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),

            body:
            RefreshIndicator(
              onRefresh:  _refreshData,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: ScreenConstant.defaultHeightOneHundred,
                            height: ScreenConstant.defaultHeightOneTwenty,
                            child: Center(child: Image.asset("assets/LOgo Time 1.png")),
                          ),
                          Positioned(
                            top: 30,
                            left: 40,
                            child: StreamBuilder<Duration>(
                              stream: _orderListController.orderDetailsData.value.status != "delivered"
                                  ? Stream.periodic(
                                Duration(seconds: 1),
                                    (i) {
                                  final expectedInTransitString = _orderListController.orderDetailsData.value.expected_intransit;
                                  final expectedTime = DateTime.parse(expectedInTransitString!);
                                  final currentTime = DateTime.now();
                                  final remainingTime = expectedTime.isAfter(currentTime) ? expectedTime.difference(currentTime) : Duration(seconds: 0);

                                  return remainingTime;
                                },
                              )
                                  : null, // return null stream when the order is delivered
                              builder: (context, snapshot) {
                                final remainingTime = snapshot.data ?? Duration(seconds: 0);
                                final formattedTime = '${remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:${remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}';

                                return Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${formattedTime}",
                                        style: TextStyle(fontSize: FontSizeStatic.sm, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Min",
                                        style: TextStyle(fontSize: FontSizeStatic.sm, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),


                        ],
                      ),
                    ),


                    Obx(() => _orderListController
                        .orderDetailsData.value.payableAmount ==
                        null
                        ? Container()
                        : RefreshIndicator(
                      onRefresh: _refreshData,
                      child: ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: [

                          isOpen
                              ? Container(
                            //height: ScreenConstant.defaultHeightTwoHundredFifty,
                            color: Colors.white,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: _orderListController
                                      .orderDetailsData
                                      .value
                                      .statusLog!
                                      .length,
                                  itemBuilder: (context, index) {
                                    return DeliveryTrackerSteps(
                                      isFirst: index == 0 ? true : false,
                                      isLast: index ==
                                          _orderListController
                                              .orderDetailsData
                                              .value
                                              .statusLog!
                                              .length -
                                              1
                                          ? true
                                          : false,
                                      indicatorStyle: _orderListController
                                          .orderDetailsData
                                          .value
                                          .statusLog![index]
                                          .timestamp !=
                                          null
                                          ? IndicatorStyles.completedIndicator
                                          : IndicatorStyles
                                          .incompleteIndicator,
                                      afterLineStyle: _orderListController
                                          .orderDetailsData
                                          .value
                                          .statusLog![index]
                                          .timestamp !=
                                          null
                                          ? IndicatorStyles
                                          .completedAfterLineStyle
                                          : IndicatorStyles
                                          .incompleteAfterLineStyle,
                                      beforeLineStyle: _orderListController
                                          .orderDetailsData
                                          .value
                                          .statusLog![index]
                                          .timestamp !=
                                          null
                                          ? IndicatorStyles
                                          .completedAfterLineStyle
                                          : IndicatorStyles
                                          .incompleteAfterLineStyle,
                                      data: ListTile(
                                        minVerticalPadding: 27,
                                        title: Text(
                                          _orderListController
                                              .orderDetailsData
                                              .value
                                              .statusLog![index]
                                              .label
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: _orderListController
                                            .orderDetailsData
                                            .value
                                            .statusLog![index]
                                            .timestamp !=
                                            null
                                            ? Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              top: 8.0),
                                          child: Text(
                                            "${DateTimeUtility().parse(dateTime: _orderListController.orderDetailsData.value.statusLog?[index].timestamp.toString(), returnFormat: "EEE, d MMM yyyy")}",
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.w500,
                                                color: Colors
                                                    .grey.shade500),
                                          ),
                                        )
                                            : Offstage(),
                                      ),
                                    );
                                  },
                                )),
                          )
                              : Offstage(),
                          isOpen
                              ? Container(
                            height: ScreenConstant.sizeMedium,
                          )
                              : Offstage(),

                          Divider(thickness: 2,),
                          Row(
                            children: [
                              SizedBox(height: ScreenConstant.defaultWidthTen),
                              Container(
                                height: 80,
                                width: 80,
                                child: Image.network(
                                  _orderListController.orderDetailsData.value.orderProducts?[index]?.product?.details?.imagePath ??
                                      "http://api.gopotu.com/uploads/product/1700294783_1679387673_77_UNCLE_CHIPS_PLAIN_SALTED_50G-removebg-preview.png",
                                  fit: BoxFit.cover, // Adjust the fit as needed
                                ),
                              )
                              ,
              SizedBox(width: 10,),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Row(
                                         children: [
                                           Container(
                                             width:90,
                                             child: Text("${ _orderListController
                      .orderDetailsData
                      .value
                      .orderProducts![index]
                      .product!
                  .details!
                  .name! }  ",style: TextStyle(fontSize: FontSizeStatic.sm),overflow: TextOverflow.ellipsis,
                                             ),
                                           ) ,
                                         SizedBox(width: ScreenConstant.defaultHeightTwentyeight,),
                                         // Text( "₹${(_orderListController.orderDetailsData.value.couponDiscount!.toString())} Saved",style: TextStyle(fontSize: FontSizeStatic.sm,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis)
                                         ]),
                                     ),
                              SizedBox(width: 10,),   TextButton(  onPressed: () {
                                // final OrderListController _orderListController =
                                // Get.find();
                                // _orderListController.orderId.value =
                                //     orderListData![index!].id.toString();
                                Get.to(OrderDetailsScreen());

                              }

                                  ,  child: Text("Order Details >",style: TextStyle(fontSize: 15,color: Colors.green,decoration: TextDecoration.underline,),))
                            ],
                          ),
                          Divider(thickness: 2,),
                          Padding(
                            padding:  EdgeInsets.only(left: ScreenConstant.defaultWidthTwenty),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Shop Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: FontSizeStatic.maxMd),),
                                SizedBox(height: ScreenConstant.defaultWidthTen),
                                Text(
                                  _orderListController.orderDetailsData.value
                                      .shop!.shopName ??
                                      "",
                                  style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: FontSizeStatic.md),
                                ),
                                SizedBox(height: ScreenConstant.defaultWidthTen),
                                Text("Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: FontSizeStatic.maxMd),),
                                SizedBox(height: ScreenConstant.defaultWidthTen),
                            Text(
                              "${_orderListController.orderDetailsData.value.shop!.shopAddress!.city ?? ""} ,${_orderListController.orderDetailsData.value.shop!.shopAddress!.state} ,${_orderListController.orderDetailsData.value.shop!.shopAddress!.country}" ??"",style: TextStyle(fontSize: FontSizeStatic.md),
                                // Text("XYZ street Kolkata -700005",style: TextStyle(fontSize: FontSizeStatic.maxMd),),

                                // SizedBox(height: ScreenConstant.defaultWidthTen,),
                            )],
                            ),
                          ),
                          Divider(thickness: 2,),
                          Padding(
                            padding:  EdgeInsets.only(left:ScreenConstant.defaultHeightFifteen ),
                            child: Row(
                              children: [
                                Text("Deliver to: ",style: TextStyle(fontSize: FontSizeStatic.md)),
                                Text(
                                  // " ${_orderListController.orderDetailsData.value.shop.shopAddress.city ?? ""} ,${_orderListController.orderDetailsData.value.shop.shopAddress.state} ,${_orderListController.orderDetailsData.value.shop.shopAddress.country}" ??
                                  //     "",

                                  "${_orderListController.orderDetailsData.value.shop!.shopAddress!.city ?? ""}",
                                  style: TextStyle(
                                  fontSize: FontSizeStatic.md,
                                  fontWeight: FontWeight.bold,
                                )
                                ),
                                Text(" - "),Text("${_orderListController.orderDetailsData.value.shop!.shopAddress!.postalCode ?? ""}",  style: TextStyle(
                                  fontSize: FontSizeStatic.md,
                                  fontWeight: FontWeight.bold,
                                ),),

                                SizedBox(width: ScreenConstant.defaultHeightOneHundred,),
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.green),
                                width: ScreenConstant
                                    .defaultHeightSeventySix, // Set the width as needed
                                height: ScreenConstant.sizeExtraLarge,


                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenConstant.defaultHeightFive,
                                      left:
                                      ScreenConstant.defaultHeightTen),
                                  child: GestureDetector(
                                    onTap: () {
                                      _addressController.isHomeScreen.value = true;
                                      Get.to(SelectAddress(
                                        value: LatLng(HiveStore().get(Keys.currLat),HiveStore().get(Keys.currLong)),
                                      ));
                                    },
                                    child: Text(
                                      "Change",
                                      style: TextStyle(
                                          fontSize: FontSizeStatic.maxMd,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ), // Set the background color to green
                              ),
                            ),

                              ],

                            ),


                          ),

                          Padding(
                            padding:  EdgeInsets.only(left: 15),
                            child: Container(

                            ),
                          ),

                          Column(
                            children: [
                              Divider(thickness: 2),
                              _orderListController.orderDetailsData.value.status == "processed"
                                  ?
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: ScreenConstant.defaultWidthTwenty,
                                        width: ScreenConstant.defaultWidthTwenty,
                                        child: Image.asset("assets/svg-spinners_clock.png"),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        "Processing Your Package",
                                        style: TextStyle(fontSize: FontSizeStatic.xl),
                                      ),
                                      SizedBox(width: ScreenConstant.sizeExtraLarge),
                                      Container(
                                        height: 70,
                                        width: 70,
                                        child: Image.network(
                                          _orderListController.orderDetailsData.value.orderProducts![index].product!.details!.imagePath!,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ) : Container(),



                              Divider(thickness: 2),
                        _orderListController.orderDetailsData.value.deliveryboyStatus == "accepted"
                            ? (_orderListController.orderDetailsData.value.deliveryboy != null &&
                            (_orderListController.orderDetailsData.value.status.toString() != "cancelled" &&
                                _orderListController.orderDetailsData.value.status.toString() != "delivered"))
                            ? Column(
                          children: [
                            Container(
                              width: ScreenConstant.defaultHeightThreeHundredEighty,
                              height: ScreenConstant.defaultHeightOneHundredFifty,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: ScreenConstant.defaultWidthTen,
                                          left: ScreenConstant.defaultHeightEight,
                                        ),
                                        child: CircleAvatar(
                                          radius: ScreenConstant.defaultHeightForty,
                                          backgroundImage: AssetImage(
                                            Assets.deliveryBoyReached,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: ScreenConstant.defaultWidthTen),
                                      Row(
                                        children: [
                                          Text("4.5⭐"),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 20.0),
                                  Container(
                                    height: ScreenConstant.defaultHeightOneHundred,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Hi",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: ScreenConstant.defaultHeightOneHundred),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: ScreenConstant.sizeMedium,
                                                    width: ScreenConstant.defaultHeightFifty,
                                                    decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Container(
                                                      height: 5,
                                                      width: ScreenConstant.defaultWidthTen,
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.verified, size: 10, color: Colors.white),
                                                          Text("Verified", style: TextStyle(fontSize: 10, color: Colors.white)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Container(
                                                    height: ScreenConstant.sizeMedium,
                                                    width: ScreenConstant.defaultHeightFifty,
                                                    decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Center(
                                                      child: Text("Vacinated", style: TextStyle(fontSize: 10, color: Colors.white)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          "I am G man",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          "${_orderListController.orderDetailsData.value.deliveryboy?.name ?? 'Default Name'}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: ScreenConstant.defaultWidthTen,
                                              ),
                                              child: Container(
                                                height: ScreenConstant.defaultHeightThirtyFive,
                                                width: ScreenConstant.defaultHeightThirtyFive,
                                                child: Image.asset("assets/Group 199.png"),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                UrlLauncher.launch("tel://${_orderListController.orderDetailsData.value.deliveryboy!.mobile.toString()}");
                                              },
                                              child: Text(
                                                "Call us",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(Help_Screen());
                                              },
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        left: ScreenConstant.defaultWidthTen,
                                                      ),
                                                      child: Container(
                                                        height: ScreenConstant.defaultHeightThirtyFive,
                                                        width: ScreenConstant.defaultHeightThirtyFive,
                                                        child: Image.asset("assets/Group 200.png"),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Chat With Us",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: ScreenConstant.defaultHeightFifteen,),
                            Container(
                              width:ScreenConstant.defaultHeightThreeHundredEighty,
                              child: Image.asset("assets/deliveryass.gif"),
                            )
                          ],
                        )
                            : Container()
                            : Container(),



                        SizedBox(width: 20),

                              Padding(
                                padding: EdgeInsets.only(left: 20, top: 30),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text("Explore Now", style: TextStyle(fontSize: FontSizeStatic.md, fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: ScreenConstant.defaultWidthTen),

                              Container(
                                height: ScreenConstant.defaultHeightOneThirty,
                                width: ScreenConstant.defaultHeightThreeHundredEighty,
                                child: Image.asset("assets/Rectangle 1262.png"),

                              ),

                              SizedBox(height: ScreenConstant.defaultWidthTen),

                              Container(
                                height: ScreenConstant.defaultHeightOneThirty,
                                width: ScreenConstant.defaultHeightThreeHundredEighty,
                                child: Image.asset("assets/Rectangle 1263.png"),
                              ),
                            ],
                          ),


                        ],
                      ),

                    ),
                    ),
                  ],
                ),
              ),
            ),


        ),
    );



  }}
class DeliveryTrackerSteps extends StatelessWidget {
  final bool? isFirst;
  final bool? isLast;
  final IndicatorStyle? indicatorStyle;
  final LineStyle? afterLineStyle;
  final LineStyle? beforeLineStyle;
  final Widget? data;

  const DeliveryTrackerSteps({
    this.isFirst,
    this.isLast,
    this.indicatorStyle,
    this.afterLineStyle,
    this.beforeLineStyle,
    this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst ?? false,
      isLast: isLast ?? false,
      indicatorStyle: indicatorStyle ?? IndicatorStyle(),
      afterLineStyle: afterLineStyle ?? LineStyle(),
      beforeLineStyle: beforeLineStyle ?? LineStyle(),
      endChild: data ?? Container(), // You can provide a default widget if data is not provided
    );
  }
}


class IndicatorStyles {
  static IndicatorStyle get completedIndicator => IndicatorStyle(
      color: AppColors.buttonColorSecondary, height: 15, width: 15);

  static IndicatorStyle get incompleteIndicator => IndicatorStyle(
    height: 15,
    width: 15,
    indicator: Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
      ),
    ),
  );

  static LineStyle get completedAfterLineStyle =>
      LineStyle(color: AppColors.buttonColorSecondary, thickness: 1);

  static LineStyle get incompleteAfterLineStyle =>
      LineStyle(color: Colors.grey, thickness: 1);

  static LineStyle get incompleteBeforeLineStyle =>
      LineStyle(color: Colors.grey, thickness: 1);
}





//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/get_instance.dart';
// import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
// import 'package:go_potu_user/Views/TrackingScreen/Controller.dart';
// import 'package:hive/hive.dart';
// import 'package:order_tracker/order_tracker.dart';
// import 'package:http/http.dart' as http;
//
// import '../../Service/Url.dart';
// import 'OrderTrackingResponseModel.dart';
//
// class Tracking_Screen extends StatefulWidget {
//   @override
//   State<Tracking_Screen> createState() => _Tracking_ScreenState();
// }
//
// class _Tracking_ScreenState extends State<Tracking_Screen> {
//   int _currentStep = 0;
//   int currentStatusIndex = 0;
//
//
//
//   @override
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.red,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.keyboard_arrow_left,
//             color: Colors.black,
//             size: 30,
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: Text(
//           "Product Details",
//           style: TextStyle(
//             fontSize: 20,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 0, top: 50),
//               child: Container(
//                 width: ScreenConstant.defaultHeightOneHundred,
//                 height: ScreenConstant.defaultHeightOneTwenty,
//                 child: Center(child: Image.asset("assets/LOgo Time 1.png")),
//               ),
//             ),
//
//
//
//
//
//             Divider(thickness: 2,),
//             Row(
//               children: [
//                 SizedBox(height: ScreenConstant.defaultWidthTen),
//                 Container(
//                     height: 100,
//                     width: 100,
//                     child: Image.asset("assets/ReferImage.png")
//                 ),
//                 Container(height: 18,width: 180,
//                     child: Text("1 item              ₹20 saved",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
//                 TextButton(onPressed:(){} , child: Text("Order Details >",style: TextStyle(fontSize: 15,color: Colors.green,decoration: TextDecoration.underline,),))
//               ],
//             ),
//             Divider(thickness: 2,),
//             Padding(
//               padding:  EdgeInsets.only(right: ScreenConstant.defaultWidthOneSeventy),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Shop Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: FontSizeStatic.maxMd),),
//                   SizedBox(height: ScreenConstant.defaultWidthTen),
//                   Text("KP store",style: TextStyle(fontWeight: FontWeight.bold,fontSize: FontSizeStatic.maxMd,color: Colors.green)),
//                   SizedBox(height: ScreenConstant.defaultWidthTen),
//                   Text("Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: FontSizeStatic.maxMd),),
//                   SizedBox(height: ScreenConstant.defaultWidthTen),
//                   Text("XYZ street Kolkata -700005",style: TextStyle(fontSize: FontSizeStatic.maxMd),),
//
//                   SizedBox(height: ScreenConstant.defaultWidthTen,),
//                 ],
//               ),
//             ),
//             Divider(thickness: 2,),  SizedBox(height: ScreenConstant.defaultWidthTen),
//             Padding(
//               padding:  EdgeInsets.only(left:ScreenConstant.defaultHeightFifteen ),
//               child: Row(
//                 children: [
//                   Text("Deliver to: ",style: TextStyle(fontSize: FontSizeStatic.md)),
//                   Text("Kolkata - 700005",style: TextStyle(fontSize: FontSizeStatic.md,fontWeight: FontWeight.bold)),
//               SizedBox(width: ScreenConstant.defaultHeightNinetyEight,),
//               Container(
//                 width: ScreenConstant.defaultHeightSeventySix,
//                 height: ScreenConstant.defaultHeightTwentyfive,
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Handle button press
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.green,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: Text(
//                     "Change",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: FontSizeStatic.sm,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 )),
//
//                 ],
//               ),
//
//             ),  SizedBox(height: ScreenConstant.defaultWidthTen),
//             Divider(thickness: 2,),
//
//             Padding(
//               padding:  EdgeInsets.only(left: 15),
//               child: Container(
//                 child: Row(
//                   children: [
//                     Container(
//                       height: ScreenConstant.defaultWidthTwenty,
//                       width: ScreenConstant.defaultWidthTwenty,
//                       child: Image.asset("assets/svg-spinners_clock.png"),
//
//                     ),
//                     SizedBox(width: 20,),
//                     Text("Processing Your Package ",style: TextStyle(fontSize: FontSizeStatic.xl)),
//                    SizedBox(width: ScreenConstant.sizeExtraLarge,),
//                    Container(height: 70,width: 70,
//                        child: Image.asset("assets/ReferImage.png"))
//                   ],
//                 ),
//               ),
//             ),
//
//             Divider(thickness: 2,),
//       Container(
//         width: ScreenConstant.defaultHeightThreeHundredEighty,
//         height: ScreenConstant.defaultHeightOneHundredFifty,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 5,
//               blurRadius: 7,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Column(
//               children: [
//                 Padding(
//                   padding:  EdgeInsets.only(top: ScreenConstant.defaultWidthTen,left: ScreenConstant.defaultHeightEight),
//                   child: CircleAvatar(
//                     radius: ScreenConstant.defaultHeightForty,
//                     backgroundImage: AssetImage('assets/customerCareService.png'), // Replace with your image asset
//                   ),
//                 ),
//                 SizedBox(height: ScreenConstant.defaultWidthTen,),
//                 Row(
//                   children: [
//                     Text("4.5⭐"),
//
//                   ],
//                 )
//               ],
//             ),
//             SizedBox(width: 20.0),
//             Container(
//
//               height: ScreenConstant.defaultHeightOneHundred,
//
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Hi",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey),),SizedBox(height: 8.0),
//                   SizedBox(height: ScreenConstant.defaultWidthTen),
//                   Text("I am G man",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey),),SizedBox(height: 8.0),
//                   Text("Raghav Jain",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey),),
//                   SizedBox(height: 4,),
//                   Row(
//                     children: [
//                       Padding(
//                         padding:  EdgeInsets.only(left: ScreenConstant.defaultWidthTen),
//                         child: Container(height:ScreenConstant.defaultHeightThirtyFive,width: ScreenConstant.defaultHeightThirtyFive,
//                             child: Image.asset("assets/Group 199.png")),
//
//                       ),
//
//                       Text("Call us",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),),
//
//                     ],
//                   ),
//
//                 ],
//               ),
//
//             ),//,
//             Container(
//               child: Padding(
//                 padding:  EdgeInsets.only(left: ScreenConstant.defaultWidthTen,top: ScreenConstant.defaultHeightSeventy),
//                 child: Container(height:ScreenConstant.defaultHeightThirtyFive,width: ScreenConstant.defaultHeightThirtyFive,
//                     child: Image.asset("assets/Group 200.png")),
//
//               ),
//             ),
//
//             Padding(
//               padding:  EdgeInsets.only(top: ScreenConstant.defaultHeightSeventy),
//               child: Text("Chat with Us",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),),
//             ),
//             Row(
//               children: [
//                 Container(
//                   height: ScreenConstant.defaultWidthTen,
//                   width: ScreenConstant.sizeExtraLarge,
//                   decoration: BoxDecoration(
//                     color: Colors.green,
//                     borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: Padding(
//                     padding:  EdgeInsets.only(right: ScreenConstant.screenHeightFifteen),
//                     child: Container(
//                         height: 5,
//                         width: ScreenConstant.defaultWidthTen ,
//                         child: Icon(Icons.verified,size: 10,color: Colors.white,),),
//                   ),
//
//                 ),
//                 SizedBox(width: 5,),
//                 Container(
//                   height: ScreenConstant.defaultWidthTen,
//                   width: 30,
//                   decoration: BoxDecoration(
//                       color: Colors.green,
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                 )
//               ],
//             )// Adjust spacing as needed
//
//           ],
//         ),
//       ),
//
//             SizedBox(width: 20,),
//           Padding(
//             padding:  EdgeInsets.only(left:20,top: 30),
//             child: Row(
//               children: [
//                 Container(
//                   child:   Text("Explore Now",style: TextStyle(fontSize: FontSizeStatic.md,fontWeight: FontWeight.bold)),
//                 ),
//               ],
//             ),
//           ),
//             SizedBox(height: ScreenConstant.defaultWidthTen,),
//             Container(
//               height: ScreenConstant.defaultHeightOneThirty,
//               width: ScreenConstant.defaultHeightThreeHundredEighty,
//               child: Image.asset("assets/Rectangle 1262.png"),
//             ),
//             SizedBox(height: ScreenConstant.defaultWidthTen,),
//             Container(
//               height: ScreenConstant.defaultHeightOneThirty,
//               width: ScreenConstant.defaultHeightThreeHundredEighty,
//               child: Image.asset("assets/Rectangle 1263.png"),
//             ),
//
//
//           ],
//         ),
//       ),
//
//
//     );
//   }
//
//
//
//
//
//
// // Example method to get color based on order status
//   Color getColorForStatus(String orderStatus, int currentIndex) {
//     // Add more cases based on your specific order status values
//     switch (orderStatus) {
//       case "accepted":
//         return currentIndex == 0 ? Colors.green : Colors.grey;
//       case "processed":
//         return currentIndex == 1 ? Colors.green : Colors.grey;
//       case "intransit":
//         return currentIndex == 2 ? Colors.green : Colors.grey;
//       case "outfordelivery":
//         return currentIndex == 3 ? Colors.green : Colors.grey;
//       case "delivered":
//         return currentIndex == 4 ? Colors.green : Colors.grey;
//       default:
//         return Colors.grey;
//     }
//   }
//
//
//
// }
//
//
// //
// // import 'package:flutter/material.dart';
// // import 'package:go_potu_user/Views/TrackingScreen/Tracking_page.dart';
// // import 'package:timeline_tile/timeline_tile.dart';
// //
// // class Tracking_Screen extends StatefulWidget {
// //   @override
// //   State<Tracking_Screen> createState() => _Tracking_ScreenState();
// // }
// //
// // class _Tracking_ScreenState extends State<Tracking_Screen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: ListView(
// //         children: [
// //           Order_Tracking(isFirst: true, isLast: false),
// //           Order_Tracking(isFirst: false, isLast: false),
// //           Order_Tracking(isFirst: false, isLast: true)
// //         ],
// //       )
// //     );
// //   }
// // }
//
// // Container(
// //   width: 340,
// //   height: 20,
// //   child: ListView.builder(
// //     scrollDirection: Axis.horizontal,
// //     itemCount: containerNames.length,
// //     itemBuilder: (context, index) {
// //       String containerStatus = containerNames[index];
// //       Color containerColor = Colors.black;
// //
// //       // Check if orderData is not null
// //       if (Order != null && Order is Map<String, dynamic>) {
// //         // Check if the "status_log" property exists and is a list
// //         dynamic statusLog = orderData['status_log'];
// //         if (statusLog is List) {
// //           // Iterate over the list
// //           for (var logEntry in statusLog) {
// //             // Check if the entry is a Map
// //             if (logEntry is Map<String, dynamic>) {
// //               // Check for a specific status match
// //               if (logEntry['key'] == containerStatus &&
// //                   logEntry['label'] == containerStatus) {
// //                 containerColor = Colors.green;
// //                 break; // Exit the loop since a match is found
// //               }
// //             }
// //           }
// //         } else {
// //           print('Invalid or missing "status_log" property in order');
// //         }
// //       } else {
// //         print('Invalid order data structure');
// //       }
// //
// //       return Row(
// //         children: [
// //           Column(
// //             children: [
// //               Container(
// //                 height: 20,
// //                 width: 20,
// //                 decoration: BoxDecoration(
// //                   color: containerColor,
// //                   borderRadius: BorderRadius.circular(20),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           // Add a separator (line or any other widget) between the circles
// //           Container(
// //             height: 4,
// //             width: 60,
// //             color: Colors.green,
// //           ),
// //         ],
// //       );
// //     },
// //   ),
// // ),
// //
// // Container(
// // child: Padding(
// // padding: const EdgeInsets.only(left: 30,top: 25),
// // child: Row(
// // children: [
// // Container(width: ScreenConstant.defaultHeightFifty,child: Text("Order Placed",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),)),
// // SizedBox(width: ScreenConstant.defaultHeightTwentyfive,),
// // Container(width: ScreenConstant.defaultHeightSixty,child: Text("Preparing",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),)),
// // SizedBox(width: ScreenConstant.defaultHeightTwentyfive,),
// // Container(width: ScreenConstant.defaultHeightSixty,child: Text("Assigned",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),)),
// // SizedBox(width: ScreenConstant.defaultHeightTwentyfive,),
// // Container(
// // width: ScreenConstant.defaultHeightSixty,child: Text("Out for Delivery",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),)),
// // SizedBox(width:  ScreenConstant.defaultWidthTen,),
// // Container(width: ScreenConstant.defaultHeightFifty,
// // child: Text("Delivered",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),)),
// //
// //
// // ],
// // ),
// // ),
// // ),