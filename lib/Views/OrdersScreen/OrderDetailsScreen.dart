import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:go_potu_user/Views/OrdersScreen/CancelOrderScreen.dart';
import 'package:go_potu_user/Views/OrdersScreen/ReturnReplaceRequestScreen.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';
import 'package:go_potu_user/Widgets/OrdersWidgets/OrderListWidgetProductListWidget.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../Controller/SplashController/SplashController.dart';
import 'RefundAndReturnDetailsScreen.dart';

class OrderDetailsScreen extends StatefulWidget {
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen>
    with TickerProviderStateMixin {
  Timer? _timer;
  final OrderListController _orderListController =
      Get.find<OrderListController>();
  final SplashController _splashController = Get.put(SplashController());

  bool isOpen = false;

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
  }

  @override
  void dispose() {
    print("Line: 216");
    if (_orderListController.orderDetailsData.value.status ==
        "outfordelivery") {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          backgroundColor: AppColors.secondary,
          appBar: AppBar(
            // centerTitle: true,
            // backgroundColor: AppColors.primary,
            // elevation: 0,
            // title: Text(
            //   AppStrings.orderDetails,
            //   style: TextStyles.appBarTitle,
            // ),
            backgroundColor: const Color.fromARGB(255, 186, 25, 14),
            leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                _onBackPressed();
              },
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  final SupportTicketController supportController =
                      Get.put(SupportTicketController());
                  supportController.issueTypeController!.text =
                      "Contact Request";
                  supportController.isCancel.value = false;
                  Get.to(CustomerCareService());
                },
                child: Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 232, 233, 235),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    'support',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
            title: Text("My Orders",style: TextStyle(color: Colors.white)),
            centerTitle: true,
          ),
          body: Obx(() => _orderListController
                      .orderDetailsData.value.payableAmount ==
                  null
              ? Container()
              : RefreshIndicator(
                  onRefresh: _refreshData,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.all(ScreenConstant.sizeMedium),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Order Status",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: FontSizeStatic.maxMd,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.buttonColorSecondary,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ScreenConstant.sizeSmall,
                                            vertical:
                                                ScreenConstant.sizeExtraSmall,
                                          ),
                                          child: Center(
                                            child: Text(
                                              _orderListController
                                                      .orderDetailsData
                                                      .value
                                                      .status
                                                      ?.toUpperCase() ??
                                                  "Fetching",
                                              style: TextStyles
                                                  .categoryChangeBottomText,
                                            ),

                                          ),


                                        ),

                                      ),
                                      // Column(
                                      //   children: [
                                      //     GestureDetector(
                                      //       onTap: () {
                                      //         setState(() {
                                      //           isOpen = !isOpen;
                                      //         });
                                      //       },
                                      //       child: Container(
                                      //         decoration: BoxDecoration(
                                      //           borderRadius: BorderRadius.circular(5),
                                      //           color: AppColors.buttonColorSecondary,
                                      //         ),
                                      //         child: Padding(
                                      //           padding: EdgeInsets.only(
                                      //             left: ScreenConstant.sizeSmall,
                                      //             bottom: ScreenConstant.sizeExtraSmall,
                                      //             right: ScreenConstant.sizeSmall,
                                      //             top: ScreenConstant.sizeExtraSmall,
                                      //           ),
                                      //           child: Center(
                                      //             child: Text(
                                      //               "In Progress",
                                      //               style: TextStyles.categoryChangeBottomText,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: ScreenConstant.sizeMedium,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Order ID: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: FontSizeStatic.maxMd),
                                      ),
                                      Text(
                                        "${_orderListController.orderDetailsData.value.code.toString()}",
                                        style: TextStyle(
                                            fontSize: FontSizeStatic.maxMd),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: ScreenConstant.sizeMedium,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${DateTimeUtility().parse(dateTime: _orderListController.orderDetailsData.value.statusLog?[index].timestamp.toString(), returnFormat: "EEE, d MMM yyyy")}",
                                        style: TextStyle(
                                            fontSize: FontSizeStatic.mdSm),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // child: Row(
                              //   children: [
                              //     Column(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceEvenly,
                              //           children: [
                              //             Text(
                              //               "Order Status",
                              //               style: TextStyle(
                              //                 fontWeight: FontWeight.bold,
                              //                 fontSize: FontSizeStatic.maxMd,
                              //               ),
                              //             ),
                              //             Container(
                              //               decoration: BoxDecoration(
                              //                 borderRadius:
                              //                     BorderRadius.circular(5),
                              //                 color: AppColors
                              //                     .buttonColorSecondary,
                              //               ),
                              //               child: Padding(
                              //                 padding: EdgeInsets.symmetric(
                              //                   horizontal:
                              //                       ScreenConstant.sizeSmall,
                              //                   vertical: ScreenConstant
                              //                       .sizeExtraSmall,
                              //                 ),
                              //                 child: Center(
                              //                   child: Text(
                              //                     "In Progress",
                              //                     style: TextStyles
                              //                         .categoryChangeBottomText,
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //         Spacer(),
                              //
                              //         Container(
                              //           height: ScreenConstant.sizeExtraSmall,
                              //         ),
                              //         // Text(_orderListController
                              //         //             .orderDetailsData.value.status ==
                              //         //         "outfordelivery"
                              //         //     ? "OUT FOR DELIVERY"
                              //         //     : _orderListController
                              //         //             .orderDetailsData.value.status!
                              //         //             .toUpperCase() ??
                              //         //         ""),
                              //         Padding(
                              //           padding: const EdgeInsets.only(
                              //               left: 1.0, top: 6),
                              //           child: Row(
                              //             children: [
                              //               Text(
                              //                 "Order ID: ",
                              //                 style: TextStyle(
                              //                     fontWeight: FontWeight.bold,
                              //                     fontSize:
                              //                         FontSizeStatic.maxMd),
                              //               ),
                              //               Text(
                              //                 "${_orderListController.orderDetailsData.value.code.toString()}",
                              //                 style: TextStyle(
                              //                     fontSize:
                              //                         FontSizeStatic.maxMd),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //         SizedBox(
                              //           height: 9,
                              //         ),
                              //         Padding(
                              //           padding: EdgeInsets.only(left: 2),
                              //           child: Row(
                              //             children: [
                              //               Text(
                              //                 "${DateTimeUtility().parse(dateTime: _orderListController.orderDetailsData.value.statusLog?[index].timestamp.toString(), returnFormat: "EEE, d MMM yyyy")}",
                              //                 style: TextStyle(
                              //                     fontSize:
                              //                         FontSizeStatic.mdSm),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //     GestureDetector(
                              //       onTap: () {
                              //         setState(() {
                              //           isOpen = !isOpen;
                              //         });
                              //       },
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(0.0),
                              //         child: Container(
                              //           decoration: BoxDecoration(
                              //             borderRadius:
                              //                 BorderRadius.circular(5),
                              //             color: AppColors.buttonColorSecondary,
                              //           ),
                              //           // child: Padding(
                              //           //   padding: EdgeInsets.only(
                              //           //     left: ScreenConstant.sizeSmall,
                              //           //     bottom:
                              //           //         ScreenConstant.sizeExtraSmall,
                              //           //     right: ScreenConstant.sizeSmall,
                              //           //     top:
                              //           //         ScreenConstant.sizeExtraSmall,
                              //           //   ),
                              //           //   child: Center(
                              //           //       child: Text(
                              //           //     "In Progress",
                              //           //     style: TextStyles
                              //           //         .categoryChangeBottomText,
                              //           //   )),
                              //           // ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ),
                            Divider(
                              color: Colors.black,
                              height: 0,
                            ),
                            isOpen
                                ? ListView.builder(
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
                                              ? Text(
                                                  "${DateTimeUtility().parse(dateTime: _orderListController.orderDetailsData.value.statusLog?[index].timestamp.toString(), returnFormat: "EEE, d MMM yyyy")}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          Colors.grey.shade500),
                                                )
                                              : Offstage(),
                                        ),
                                      );
                                    },
                                  )
                                : Offstage(),
                            isOpen
                                ? Container(
                                    height: ScreenConstant.sizeMedium,
                                  )
                                : Offstage(),
                            // _orderListController.orderDetailsData.value
                            //             .deliveryboyStatus ==
                            //         "accepted"
                            //     ? _orderListController.orderDetailsData.value
                            //                     .deliveryboy !=
                            //                 null &&
                            //             (_orderListController.orderDetailsData
                            //                         .value.status
                            //                         .toString() !=
                            //                     "cancelled" &&
                            //                 _orderListController
                            //                         .orderDetailsData
                            //                         .value
                            //                         .status
                            //                         .toString() !=
                            //                     "delivered")
                            //         ? Container(
                            //             color: AppColors.secondary,
                            //             child: Padding(
                            //               padding: EdgeInsets.all(
                            //                   ScreenConstant.sizeMedium),
                            //               child: Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.spaceBetween,
                            //                 children: [
                            //                   Column(
                            //                     crossAxisAlignment:
                            //                         CrossAxisAlignment.start,
                            //                     children: [
                            //                       Text(
                            //                         "Assigned delivery boy"
                            //                             .toUpperCase(),
                            //                         style:
                            //                             TextStyles.orderDetails,
                            //                       ),
                            //                       Container(
                            //                         height: ScreenConstant
                            //                             .sizeSmall,
                            //                       ),
                            //                       Row(
                            //                         children: [
                            //                           CircleAvatar(
                            //                             radius: ScreenConstant
                            //                                 .sizeLarge,
                            //                             backgroundImage:
                            //                                 NetworkImage(
                            //                                     "${_orderListController.orderDetailsData.value.deliveryboy!.avatar}"),
                            //                             backgroundColor:
                            //                                 Colors.transparent,
                            //                             /*child: Text(
                            //                             _orderListController
                            //                                 .orderDetailsData
                            //                                 .value
                            //                                 .deliveryboy
                            //                                 .name
                            //                                 .toString()
                            //                                 .substring(0, 1)
                            //                                 .toUpperCase(),
                            //                             style: TextStyles
                            //                                 .deliveryBoyNameFirst,
                            //                           ),*/
                            //                           ),
                            //                           Container(
                            //                             width: ScreenConstant
                            //                                 .sizeSmall,
                            //                           ),
                            //                           Column(
                            //                             crossAxisAlignment:
                            //                                 CrossAxisAlignment
                            //                                     .start,
                            //                             children: [
                            //                               Text(
                            //                                 _orderListController
                            //                                     .orderDetailsData
                            //                                     .value
                            //                                     .deliveryboy!
                            //                                     .name!,
                            //                                 style: TextStyles
                            //                                     .deliveryBoyName,
                            //                               ),
                            //                               Container(
                            //                                 height: ScreenConstant
                            //                                     .sizeExtraSmall,
                            //                               ),
                            //                               _orderListController
                            //                                           .orderDetailsData
                            //                                           .value
                            //                                           .deliveryboy!
                            //                                           .vaccination ==
                            //                                       null
                            //                                   ? Offstage()
                            //                                   : Text(
                            //                                       "${_orderListController.orderDetailsData.value.deliveryboy!.vaccination.toUpperCase() + " Vaccinated".toUpperCase()}",
                            //                                       style: TextStyles
                            //                                           .deliveryBoyWorkExp,
                            //                                     ),
                            //                             ],
                            //                           )
                            //                         ],
                            //                       )
                            //                     ],
                            //                   ),
                            //                   Column(
                            //                     children: [
                            //                       GestureDetector(
                            //                         onTap: () {
                            //                           UrlLauncher.launch(
                            //                               "tel://${_orderListController.orderDetailsData.value.deliveryboy!.mobile.toString()}");
                            //                         },
                            //                         child: Container(
                            //                           decoration: BoxDecoration(
                            //                             borderRadius:
                            //                                 BorderRadius
                            //                                     .circular(5),
                            //                             color: AppColors
                            //                                 .ordersStatusBox4,
                            //                           ),
                            //                           child: Padding(
                            //                             padding:
                            //                                 EdgeInsets.only(
                            //                               left: ScreenConstant
                            //                                   .sizeSmall,
                            //                               bottom: ScreenConstant
                            //                                   .sizeExtraSmall,
                            //                               right: ScreenConstant
                            //                                   .sizeSmall,
                            //                               top: ScreenConstant
                            //                                   .sizeExtraSmall,
                            //                             ),
                            //                             child: Center(
                            //                                 child: Text(
                            //                               "Call Now",
                            //                               style: TextStyles
                            //                                   .categoryChangeBottomText,
                            //                             )),
                            //                           ),
                            //                         ),
                            //                       )
                            //                     ],
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           )
                            //         : Offstage()
                            //     : Offstage(),
                            // _orderListController.orderDetailsData.value
                            //             .deliveryboyStatus ==
                            //         "accepted"
                            //     ? _orderListController.orderDetailsData.value
                            //                     .deliveryboy !=
                            //                 null &&
                            //             (_orderListController.orderDetailsData
                            //                         .value.status
                            //                         .toString() !=
                            //                     "cancelled" &&
                            //                 _orderListController
                            //                         .orderDetailsData
                            //                         .value
                            //                         .status
                            //                         .toString() !=
                            //                     "delivered")
                            //         ? Container(
                            //             height: ScreenConstant.sizeMedium,
                            //           )
                            //         : Offstage()
                            //     : Offstage(),
                            // _orderListController
                            //             .orderDetailsData.value.status ==
                            //         "outfordelivery"
                            //     ? _orderListController.isTimeApiDone.value ==
                            //                 false &&
                            //             controller != null
                            //         ? AnimatedContainer(
                            //             duration: Duration(seconds: 2),
                            //             onEnd: () {
                            //               setState(() {
                            //                 index = index + 1;
                            //                 // animate the color
                            //                 bottomColor = colorList[
                            //                     index % colorList.length];
                            //                 topColor = colorList[
                            //                     (index + 1) % colorList.length];
                            //
                            //                 //// animate the alignment
                            //                 begin = alignmentList[
                            //                     index % alignmentList.length];
                            //                 end = alignmentList[(index + 2) %
                            //                     alignmentList.length];
                            //               });
                            //             },
                            //             decoration: BoxDecoration(
                            //                 gradient: LinearGradient(
                            //                     begin: begin,
                            //                     end: end,
                            //                     colors: [
                            //                   bottomColor,
                            //                   topColor
                            //                 ])),
                            //             child: Padding(
                            //               padding: const EdgeInsets.all(15.0),
                            //               child: Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.spaceBetween,
                            //                 children: [
                            //                   Column(
                            //                     crossAxisAlignment:
                            //                         CrossAxisAlignment.start,
                            //                     children: [
                            //                       _orderListController
                            //                                   .secondsEstimated
                            //                                   .value <
                            //                               60
                            //                           ? Text(
                            //                               "REACHING!!!"
                            //                                   .toUpperCase(),
                            //                               style: TextStyle(
                            //                                   color: AppColors
                            //                                       .secondary,
                            //                                   fontSize:
                            //                                       FontSizeStatic
                            //                                           .xl,
                            //                                   fontWeight:
                            //                                       FontWeight
                            //                                           .bold,
                            //                                   fontFamily:
                            //                                       'Poppins'),
                            //                             )
                            //                           : Text(
                            //                               "HURRY!!!"
                            //                                   .toUpperCase(),
                            //                               style: TextStyle(
                            //                                   color: AppColors
                            //                                       .secondary,
                            //                                   fontSize:
                            //                                       FontSizeStatic
                            //                                           .xl,
                            //                                   fontWeight:
                            //                                       FontWeight
                            //                                           .bold,
                            //                                   fontFamily:
                            //                                       'Poppins'),
                            //                             ),
                            //                       Container(
                            //                         height: ScreenConstant
                            //                             .sizeLarge,
                            //                       ),
                            //                       _orderListController
                            //                                   .secondsEstimated
                            //                                   .value <
                            //                               60
                            //                           ? Text(
                            //                               "The delivery boy is reaching."
                            //                                   .toUpperCase(),
                            //                               style: TextStyle(
                            //                                 color: AppColors
                            //                                     .secondary,
                            //                                 fontSize:
                            //                                     FontSizeStatic
                            //                                         .md,
                            //                                 fontFamily:
                            //                                     'Proxima-Regular',
                            //                               ),
                            //                             )
                            //                           : Text(
                            //                               "Your order is on the way",
                            //                               style: TextStyle(
                            //                                 color: AppColors
                            //                                     .secondary,
                            //                                 fontSize:
                            //                                     FontSizeStatic
                            //                                         .md,
                            //                                 fontFamily:
                            //                                     'Proxima-Regular',
                            //                               ),
                            //                             ),
                            //                       Container(
                            //                         height: ScreenConstant
                            //                             .sizeMedium,
                            //                       ),
                            //                       _orderListController
                            //                                   .secondsEstimated
                            //                                   .value <
                            //                               60
                            //                           ? Offstage()
                            //                           : _orderListController
                            //                                       .onDelay
                            //                                       .value ==
                            //                                   "Delayed"
                            //                               ? Text(
                            //                                   "Delayed",
                            //                                   style: TextStyle(
                            //                                     color: AppColors
                            //                                         .secondary,
                            //                                     fontSize:
                            //                                         FontSizeStatic
                            //                                             .md,
                            //                                     fontFamily:
                            //                                         'Proxima-Regular',
                            //                                   ),
                            //                                 )
                            //                               : Text(
                            //                                   "On-Time",
                            //                                   style: TextStyle(
                            //                                     color: AppColors
                            //                                         .secondary,
                            //                                     fontSize:
                            //                                         FontSizeStatic
                            //                                             .md,
                            //                                     fontFamily:
                            //                                         'Proxima-Regular',
                            //                                   ),
                            //                                 )
                            //                     ],
                            //                   ),
                            //                   Column(
                            //                     children: [
                            //                       Stack(
                            //                         alignment: Alignment.center,
                            //                         children: [
                            //                           SizedBox(
                            //                             width: 100,
                            //                             height: 100,
                            //                             child: controller ==
                            //                                         null ||
                            //                                     _orderListController
                            //                                             .secondsEstimated
                            //                                             .value <
                            //                                         60
                            //                                 ? Offstage()
                            //                                 : CircularProgressIndicator(
                            //                                     backgroundColor:
                            //                                         Colors
                            //                                             .white,
                            //                                     valueColor: AlwaysStoppedAnimation<
                            //                                             Color>(
                            //                                         AppColors
                            //                                             .buttonColorSecondary),
                            //                                     value: (controller!.duration! *
                            //                                                 controller!
                            //                                                     .value)
                            //                                             .inSeconds /
                            //                                         _orderListController
                            //                                             .secondRemaining
                            //                                             .value,
                            //                                     strokeWidth: 6,
                            //                                   ),
                            //                           ),
                            //                           GestureDetector(
                            //                             // onTap: () {
                            //                             //   if (controller.isDismissed) {
                            //                             //     showModalBottomSheet(
                            //                             //       context: context,
                            //                             //       builder: (context) =>
                            //                             //           Container(
                            //                             //         //height: 200,
                            //                             //         child:
                            //                             //             CupertinoTimerPicker(
                            //                             //           initialTimerDuration:
                            //                             //               controller.duration,
                            //                             //           onTimerDurationChanged:
                            //                             //               (time) {
                            //                             //             setState(() {
                            //                             //               controller
                            //                             //                       .duration =
                            //                             //                   time;
                            //                             //             });
                            //                             //           },
                            //                             //         ),
                            //                             //       ),
                            //                             //     );
                            //                             //   }
                            //                             // },
                            //                             child: controller ==
                            //                                         null ||
                            //                                     _orderListController
                            //                                             .secondsEstimated
                            //                                             .value <
                            //                                         60
                            //                                 ? Container(
                            //                                     height: 75,
                            //                                     width: 75,
                            //                                     child: Image(
                            //                                       image: AssetImage(
                            //                                           Assets
                            //                                               .deliveryBoyReached),
                            //                                     ),
                            //                                   )
                            //                                 : AnimatedBuilder(
                            //                                     animation:
                            //                                         controller!,
                            //                                     builder: (context,
                            //                                             child) =>
                            //                                         Text(
                            //                                       countText,
                            //                                       style:
                            //                                           TextStyle(
                            //                                         fontSize:
                            //                                             20,
                            //                                         color: AppColors
                            //                                             .secondary,
                            //                                         fontWeight:
                            //                                             FontWeight
                            //                                                 .bold,
                            //                                       ),
                            //                                     ),
                            //                                   ),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           )
                            //         : Offstage()
                            //     : Offstage(),
                            // _orderListController
                            //             .orderDetailsData.value.status ==
                            //         "outfordelivery"
                            //     ? Container(
                            //         height: ScreenConstant.sizeMedium,
                            //       )
                            //     : Offstage(),

                            Container(
                              color: AppColors.secondary,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(ScreenConstant.sizeLarge),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          child: Text(
                                            // AppStrings.orderDetails.toUpperCase(),
                                            // style: TextStyles.orderDetail,
                                            "Bill Details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: FontSizeStatic.maxMd),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: ScreenConstant.sizeLarge,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          // AppStrings.orderId,
                                          // style: TextStyles.orderIdTitle,
                                          "Item Total",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: FontSizeStatic.maxMd),
                                        ),
                                        Container(
                                          child: Text(
                                            // _orderListController
                                            //         .orderDetailsData.value.code
                                            //         .toString() ??
                                            //     "",
                                            // style: TextStyles.orderId,
                                            "\₹${double.parse(_orderListController.orderDetailsData.value.itemTotal!.toString()).toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontSize: FontSizeStatic.maxMd,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Divider(
                                    //   thickness: 1,
                                    // ),
                                    // ${double.parse(_orderListController.orderDetailsData.value.deliveryCharge!.toString()).toStringAsFixed(2)}
                                    // Container(
                                    //   height: ScreenConstant.sizeSmall,
                                    // ),
                                    double.parse(_orderListController
                                                    .orderDetailsData
                                                    .value
                                                    .deliveryCharge!)
                                                .toStringAsFixed(2) ==
                                            "0.00"
                                        ? Offstage()
                                        : SizedBox(
                                            height: ScreenConstant.sizeLarge,
                                          ),
                                    double.parse(_orderListController
                                                    .orderDetailsData
                                                    .value
                                                    .deliveryCharge!)
                                                .toStringAsFixed(2) ==
                                            "0.00"
                                        ? Offstage()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Delivery Fee For 40 kms",
                                                style: TextStyle(
                                                    fontSize:
                                                        FontSizeStatic.maxMd),
                                              ),
                                              Container(
                                                child: Text(
                                                  // _orderListController.orderDetailsData
                                                  //     .value.paymentMode
                                                  //     .toString()
                                                  //     .toUpperCase(),
                                                  // style: TextStyles.orderId,
                                                  "\₹${double.parse(_orderListController.orderDetailsData.value.deliveryCharge!.toString()).toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          FontSizeStatic.maxMd),
                                                ),
                                              ),
                                            ],
                                          ),
                                    SizedBox(
                                      height: ScreenConstant.sizeLarge,
                                    ),
                                    _orderListController.orderDetailsData.value
                                                .adminCharge ==
                                            0
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "GST charges",
                                                style: TextStyle(
                                                    fontSize:
                                                        FontSizeStatic.maxMd),
                                              ),
                                              Text(
                                                "\₹${double.parse(_orderListController.orderDetailsData.value.adminCharge!.toString()).toStringAsFixed(2)}",
                                                style: TextStyle(
                                                    fontSize:
                                                        FontSizeStatic.maxMd),
                                              ),
                                            ],
                                          )
                                        : Offstage(),
                                    _orderListController.orderDetailsData.value
                                                .adminCharge ==
                                            0
                                        ? SizedBox(
                                            height: ScreenConstant.sizeLarge,
                                          )
                                        : Offstage(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Grand Total",
                                          style: TextStyle(
                                              fontSize: FontSizeStatic.maxMd,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          child: Text(
                                            "\₹${double.parse(_orderListController.orderDetailsData.value.payableAmount!.toString()).toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
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

                                    Text(
                                      "Order Items",
                                      style: TextStyles.orderDetails,
                                      // style: TextStyle(
                                      //     fontSize: 14,
                                      //     fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: ScreenConstant.sizeMedium,
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: _orderListController
                                          .orderDetailsData
                                          .value
                                          .orderProducts!
                                          .length,
                                      itemBuilder: (context, index) {
                                        return OrderListWidgetProductListWidget(
                                          index: index,
                                          listLength: _orderListController
                                              .orderDetailsData
                                              .value
                                              .orderProducts!
                                              .length,
                                          productName: _orderListController
                                              .orderDetailsData
                                              .value
                                              .orderProducts![index]
                                              .product!
                                              .details!
                                              .name!,
                                          productImage: _orderListController
                                              .orderDetailsData
                                              .value
                                              .orderProducts![index]
                                              .product!
                                              .details!
                                              .imagePath!,
                                          productQuantity: _orderListController
                                              .orderDetailsData
                                              .value
                                              .orderProducts![index]
                                              .quantity
                                              .toString(),
                                          productPrice: _orderListController
                                              .orderDetailsData
                                              .value
                                              .orderProducts![index]
                                              .price,
                                          dividerPosition: false,
                                          productVarient: _orderListController
                                                  .orderDetailsData
                                                  .value
                                                  .orderProducts![index]
                                                  .variantSelected!
                                                  .variantName ??
                                              "",
                                          productColor: _orderListController
                                                  .orderDetailsData
                                                  .value
                                                  .orderProducts![index]
                                                  .variantSelected!
                                                  .colorName ??
                                              "",
                                        );
                                      },
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: ScreenConstant.sizeMedium,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: ScreenConstant.sizeLarge,
                                        right: ScreenConstant.sizeLarge,
                                      ),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            // Icon(
                                            //   Icons.location_on,
                                            //   color: Colors.red,
                                            //   size: ScreenConstant.sizeXXL,
                                            // ),
                                            Container(
                                              height: ScreenConstant.sizeXXL,
                                                width: ScreenConstant.sizeXXL,
                                                child: Image.asset("assets/g.png")),
                                            SizedBox(
                                              width: ScreenConstant.sizeMedium,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Delivery From",
                                                  style: TextStyle(
                                                    fontSize:
                                                        FontSizeStatic.maxMd,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Text(
                                                  "${_orderListController.orderDetailsData.value.shop!.shopName}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          FontSizeStatic.maxMd,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenConstant.sizeLarge),
                                      child: Container(
                                        height: ScreenConstant
                                            .defaultHeightSeventy, // Adjust the height of the line as needed
                                        width:
                                            1, // Adjust the width of the line as needed
                                        color: Colors.black,
                                        // margin: EdgeInsets.only(
                                        //     left: ScreenConstant
                                        //         .sizeSmall) // Color of the line
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: ScreenConstant.sizeLarge,
                                      ),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Container(
                                                height: ScreenConstant.sizeXXL,
                                                width: ScreenConstant.sizeXXL,
                                                child: Image.asset("assets/h.png")),
                                            SizedBox(
                                              width: ScreenConstant.sizeMedium,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Delivery To",
                                                  style: TextStyle(
                                                    fontSize:
                                                        FontSizeStatic.maxMd,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Text(
                                                    "${_orderListController.orderDetailsData.value.shop!.shopAddress!.city ?? ""} - ${_orderListController.orderDetailsData.value.shop!.shopAddress!.postalCode ?? ""}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          FontSizeStatic.maxMd,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),


                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    /*Divider(
                                thickness: 1,
                              ),*/
                                    /*Container(
                                height: ScreenConstant.sizeSmall,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppStrings.paymentStatus,
                                    style: TextStyles.orderIdTitle,
                                  ),
                                  Text(
                                    _orderListController.orderDetailsData.value.status.toUpperCase() ?? "",
                                    style: TextStyles.orderId,
                                  ),
                                ],
                              ),*/
                                    // Container(
                                    //   height: ScreenConstant.sizeSmall,
                                    // ),
                                    /*Divider(
                                      thickness: 1,
                                    ),
                                    Container(
                                      height: ScreenConstant.sizeSmall,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppStrings.expectedDelivery,
                                          style: TextStyles.orderIdTitle,
                                        ),
                                        Text(
                                          "30/08/2020",
                                          style: TextStyles.orderId,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: ScreenConstant.sizeLarge,
                                    ),*/
                                  ],
                                ),
                              ),
                            ),
                            // Container(
                            //   height: ScreenConstant.sizeMedium,
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.all(ScreenConstant.sizeSmall),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Container(
                            //         height: ScreenConstant.sizeMedium,
                            //       ),
                            //       // Text(
                            //       //   AppStrings.billingDetails.toUpperCase(),
                            //       //   style: TextStyles.orderDetails,
                            //       // ),
                            //       Container(
                            //         height: ScreenConstant.sizeLarge,
                            //       ),
                            // Row(
                            //   mainAxisAlignment:
                            //       MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       AppStrings.MRPTotal,
                            //       style: TextStyles.orderIdTitle,
                            //     ),
                            //     Text(
                            //       "Rs. ${double.parse(_orderListController.orderDetailsData.value.itemTotal!.toString()).toStringAsFixed(2)}",
                            //       style: TextStyles.orderId,
                            //     ),
                            //   ],
                            // ),
                            // double.parse(_orderListController
                            //                 .orderDetailsData
                            //                 .value
                            //                 .deliveryCharge!)
                            //             .toStringAsFixed(2) ==
                            //         "0.00"
                            //     ? Offstage()
                            //     : Container(
                            //         height: ScreenConstant.sizeMedium,
                            //       ),
                            // double.parse(_orderListController
                            //                 .orderDetailsData
                            //                 .value
                            //                 .deliveryCharge!)
                            //             .toStringAsFixed(2) ==
                            //         "0.00"
                            //     ? Offstage()
                            //     : Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Text(
                            //             AppStrings.DeliveryFee,
                            //             style: TextStyles.orderIdTitle,
                            //           ),
                            //           Text(
                            //             "Rs. ${double.parse(_orderListController.orderDetailsData.value.deliveryCharge!.toString()).toStringAsFixed(2)}",
                            //             style: TextStyles.orderId,
                            //           ),
                            //         ],
                            //       ),
                            double.parse(_orderListController.orderDetailsData
                                            .value.walletDeducted!)
                                        .toStringAsFixed(2) ==
                                    "0.00"
                                ? Offstage()
                                : Container(
                                    height: ScreenConstant.sizeMedium,
                                  ),
                            double.parse(_orderListController.orderDetailsData
                                            .value.walletDeducted!)
                                        .toStringAsFixed(2) ==
                                    "0.00"
                                ? Offstage()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Wallet deduct",
                                        style: TextStyles.orderIdTitle,
                                      ),
                                      Text(
                                        " - Rs. ${double.parse(_orderListController.orderDetailsData.value.walletDeducted!.toString()).toStringAsFixed(2)}",
                                        style: TextStyles.orderId,
                                      ),
                                    ],
                                  ),
                            double.parse(_orderListController.orderDetailsData
                                            .value.couponDiscount!)
                                        .toStringAsFixed(2) ==
                                    "0.00"
                                ? Offstage()
                                : Container(
                                    height: ScreenConstant.sizeMedium,
                                  ),
                            double.parse(_orderListController.orderDetailsData
                                            .value.couponDiscount!)
                                        .toStringAsFixed(2) ==
                                    "0.00"
                                ? Offstage()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppStrings.CouponDiscount,
                                        style: TextStyles.orderIdTitle,
                                      ),
                                      Text(
                                        "- Rs. ${double.parse(_orderListController.orderDetailsData.value.couponDiscount!.toString()).toStringAsFixed(2)}",
                                        style: TextStyles.orderId,
                                      ),
                                    ],
                                  ),

                            _orderListController
                                        .orderDetailsData.value.shopRating ==
                                    "null"
                                ? Offstage()
                                : Container(
                                    height: ScreenConstant.sizeSmall,
                                  ),
                            _orderListController
                                        .orderDetailsData.value.shopRating ==
                                    "null"
                                ? Offstage()
                                : Container(
                                    color: AppColors.secondary,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: ScreenConstant.sizeMedium,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: ScreenConstant.sizeSmall),
                                          child: Text(
                                            "Your Rating",
                                            style:
                                                TextStyles.deliveryAddressTitle,
                                          ),
                                        ),
                                        Container(
                                          height: ScreenConstant.sizeExtraSmall,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: ScreenConstant.sizeSmall),
                                            child: _orderListController
                                                        .orderDetailsData
                                                        .value
                                                        .shopRating ==
                                                    "1"
                                                ? Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                    ],
                                                  )
                                                : _orderListController
                                                            .orderDetailsData
                                                            .value
                                                            .shopRating ==
                                                        "2"
                                                    ? Row(
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color: AppColors
                                                                .primary,
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: AppColors
                                                                .primary,
                                                          ),
                                                        ],
                                                      )
                                                    : _orderListController
                                                                .orderDetailsData
                                                                .value
                                                                .shopRating ==
                                                            "3"
                                                        ? Row(
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                color: AppColors
                                                                    .primary,
                                                              ),
                                                              Icon(
                                                                Icons.star,
                                                                color: AppColors
                                                                    .primary,
                                                              ),
                                                              Icon(
                                                                Icons.star,
                                                                color: AppColors
                                                                    .primary,
                                                              ),
                                                            ],
                                                          )
                                                        : _orderListController
                                                                    .orderDetailsData
                                                                    .value
                                                                    .shopRating ==
                                                                "4"
                                                            ? Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.star,
                                                                    color: AppColors
                                                                        .primary,
                                                                  ),
                                                                  Icon(
                                                                    Icons.star,
                                                                    color: AppColors
                                                                        .primary,
                                                                  ),
                                                                  Icon(
                                                                    Icons.star,
                                                                    color: AppColors
                                                                        .primary,
                                                                  ),
                                                                  Icon(
                                                                    Icons.star,
                                                                    color: AppColors
                                                                        .primary,
                                                                  ),
                                                                ],
                                                              )
                                                            : Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.star,
                                                                    color: AppColors
                                                                        .primary,
                                                                  ),
                                                                  Icon(
                                                                    Icons.star,
                                                                    color: AppColors
                                                                        .primary,
                                                                  ),
                                                                  Icon(
                                                                    Icons.star,
                                                                    color: AppColors
                                                                        .primary,
                                                                  ),
                                                                  Icon(
                                                                    Icons.star,
                                                                    color: AppColors
                                                                        .primary,
                                                                  ),
                                                                  Icon(
                                                                    Icons.star,
                                                                    color: AppColors
                                                                        .primary,
                                                                  )
                                                                ],
                                                              )),
                                        _orderListController.orderDetailsData
                                                    .value.shopReview ==
                                                "null"
                                            ? Offstage()
                                            : Container(
                                                height:
                                                    ScreenConstant.sizeMedium,
                                              ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: ScreenConstant.sizeSmall),
                                          child: Text(
                                            _orderListController
                                                    .orderDetailsData
                                                    .value
                                                    .shopReview ??
                                                "",
                                            style: TextStyles
                                                .deliveryAddressSubTitle,
                                          ),
                                        ),
                                        _orderListController.orderDetailsData
                                                    .value.shopReview ==
                                                "null"
                                            ? Offstage()
                                            : Container(
                                                height:
                                                    ScreenConstant.sizeMedium,
                                              ),
                                      ],
                                    ),
                                  ),
                            // Container(
                            //   height: ScreenConstant.sizeMedium,
                            // ),
                            _orderListController.orderDetailsData.value
                                        .returnReplacements!.length <
                                    1
                                ? Offstage()
                                : Container(
                                    color: AppColors.secondary,
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                          ScreenConstant.sizeSmall),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: ScreenConstant.sizeMedium,
                                          ),
                                          Text(
                                            AppStrings.RefundRequest
                                                .toUpperCase(),
                                            style: TextStyles.orderDetails,
                                          ),
                                          Container(
                                            height: ScreenConstant.sizeMedium,
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: ClampingScrollPhysics(),
                                            itemCount: _orderListController
                                                .orderDetailsData
                                                .value
                                                .returnReplacements!
                                                .length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .accentColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Type :",
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .doNotAccount,
                                                                fontSize:
                                                                    FontSizeStatic
                                                                        .md,
                                                                fontFamily:
                                                                    'Proxima-Regular',
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  ScreenConstant
                                                                      .sizeMedium,
                                                            ),
                                                            Text(
                                                              "${_orderListController.orderDetailsData.value.returnReplacements![index].type}",
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .accentColor,
                                                                fontSize:
                                                                    FontSizeStatic
                                                                        .md,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: ScreenConstant
                                                              .sizeMedium,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "ID :",
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .doNotAccount,
                                                                fontSize:
                                                                    FontSizeStatic
                                                                        .md,
                                                                fontFamily:
                                                                    'Proxima-Regular',
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  ScreenConstant
                                                                      .sizeMedium,
                                                            ),
                                                            Text(
                                                              "${_orderListController.orderDetailsData.value.returnReplacements![index].code}",
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .accentColor,
                                                                fontSize:
                                                                    FontSizeStatic
                                                                        .md,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: ScreenConstant
                                                              .sizeSmall,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Current Status :",
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .doNotAccount,
                                                                fontSize:
                                                                    FontSizeStatic
                                                                        .md,
                                                                fontFamily:
                                                                    'Proxima-Regular',
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  ScreenConstant
                                                                      .sizeMedium,
                                                            ),
                                                            Text(
                                                              "${_orderListController.orderDetailsData.value.returnReplacements![index].status}",
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .accentColor,
                                                                fontSize:
                                                                    FontSizeStatic
                                                                        .md,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: ScreenConstant
                                                              .sizeSmall,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Initiation Date :",
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .doNotAccount,
                                                                fontSize:
                                                                    FontSizeStatic
                                                                        .md,
                                                                fontFamily:
                                                                    'Proxima-Regular',
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  ScreenConstant
                                                                      .sizeMedium,
                                                            ),
                                                            Text(
                                                              "${_orderListController.orderDetailsData.value.returnReplacements![index].createdAt}",
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .accentColor,
                                                                fontSize:
                                                                    FontSizeStatic
                                                                        .md,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: ScreenConstant
                                                              .sizeSmall,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Last Updated :",
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .doNotAccount,
                                                                fontSize:
                                                                    FontSizeStatic
                                                                        .md,
                                                                fontFamily:
                                                                    'Proxima-Regular',
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  ScreenConstant
                                                                      .sizeMedium,
                                                            ),
                                                            Text(
                                                              "${_orderListController.orderDetailsData.value.returnReplacements![index].updatedAt}",
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .accentColor,
                                                                fontSize:
                                                                    FontSizeStatic
                                                                        .md,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: ScreenConstant
                                                              .sizeMedium,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                _orderListController
                                                                        .returnRefundId
                                                                        .value =
                                                                    _orderListController
                                                                        .orderDetailsData
                                                                        .value
                                                                        .returnReplacements![
                                                                            index]
                                                                        .id
                                                                        .toString();
                                                                Get.to(
                                                                    RefundAndReturnDetailsScreen());
                                                              },
                                                              child: Text(
                                                                "Details",
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .createNewAccountText,
                                                                  fontSize:
                                                                      FontSizeStatic
                                                                          .md,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          Container(
                                            height: ScreenConstant.sizeMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            _orderListController.orderDetailsData.value
                                        .returnReplacements!.length <
                                    1
                                ? Offstage()
                                : Container(
                                    height: ScreenConstant.sizeMedium,
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          bottomNavigationBar: Obx(() => _orderListController
                      .orderDetailsData.value.payableAmount ==
                  null
              ? Container()
              : _orderListController.orderDetailsData.value.status.toString() ==
                          "cancelled" ||
                      _orderListController.orderDetailsData.value.status
                              .toString() ==
                          "delivered"
                  ? _orderListController.orderDetailsData.value.shopRating ==
                          "null"
                      ? _orderListController.orderDetailsData.value.status
                                      .toString() !=
                                  "cancelled" &&
                              _orderListController.orderDetailsData.value.status
                                      .toString() ==
                                  "delivered"
                          ? Container(
                              color: AppColors.secondary,
                              height: ScreenConstant.defaultHeightOneHundred,
                              child:
                                  // Padding(
                                  //   padding: const EdgeInsets.all(30.0),
                                  //   child: AppButton(
                                  //     width: ScreenConstant.defaultWidthOneEighty,
                                  //     color: AppColors.buttonColorSecondary,
                                  //     buttonText: "Review Order",
                                  //     onPressed: () {
                                  //       Get.to(RateUSScreen());
                                  //     },
                                  //   ),
                                  // )

                                  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _orderListController.orderDetailsData.value
                                      .returnReplacements!.length <
                                      1?   AppButton(
                                    width: ScreenConstant.defaultWidthOneEighty,
                                    color: AppColors.buttonColorSecondary,
                                    buttonText: "Return/Replace Request",
                                    onPressed: () {
                                      // final SupportTicketController
                                      //     supportController =
                                      //     Get.put(SupportTicketController());
                                      // supportController.issueTypeController
                                      //     .text = "Contact Request";
                                      // supportController.isCancel.value = false;
                                      // Get.to(CustomerCareService());

                                      final SupportTicketController
                                          supportController =
                                          Get.put(SupportTicketController());
                                      supportController
                                              .orderIdController!.text =
                                          _orderListController
                                              .orderDetailsData.value.code
                                              .toString();

                                      Get.to(ReturnReplaceRequestScreen());
                                    },
                                  ): AppButton(
                                    width: ScreenConstant.defaultWidthOneEighty,
                                    color:Colors.grey,
                                    buttonText: "Return/Replace Request",
                                    onPressed: () {
                                      // final SupportTicketController
                                      //     supportController =
                                      //     Get.put(SupportTicketController());
                                      // supportController.issueTypeController
                                      //     .text = "Contact Request";
                                      // supportController.isCancel.value = false;
                                      // Get.to(CustomerCareService());

                                      // final SupportTicketController
                                      // supportController =
                                      // Get.put(SupportTicketController());
                                      // supportController
                                      //     .orderIdController!.text =
                                      //     _orderListController
                                      //         .orderDetailsData.value.code
                                      //         .toString();
                                      //
                                      // Get.to(ReturnReplaceRequestScreen());
                                    },
                                  ),
                                  Container(
                                    width: ScreenConstant.sizeMedium,
                                  ),
                                  AppButton(
                                    width: ScreenConstant.defaultWidthOneEighty,
                                    color: AppColors.primary,
                                    buttonText: "Review Order",
                                    onPressed: () {
                                      Get.to(RateUSScreen());
                                    },
                                  )
                                ],
                              ),
                            )
                          : Offstage()
                      : Offstage()
                  : _orderListController.orderDetailsData.value.status
                              .toString() ==
                          "received"
                      ? Container(
                          color: AppColors.secondary,
                          height: ScreenConstant.defaultHeightOneHundred,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppButton(
                                width: ScreenConstant.defaultWidthOneEighty,
                                color: AppColors.primary,
                                buttonText: AppStrings.CancelOrder,
                                onPressed: () {
                                  // set up the buttons
                                  Widget cancelButton = TextButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: AppColors.accentColor,
                                          fontSize: FontSizeStatic.md,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins'),
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
                                          fontFamily: 'Poppins'),
                                    ),
                                    onPressed: _orderListController
                                                    .orderDetailsData
                                                    .value
                                                    .status
                                                    .toString() ==
                                                "received" &&
                                            _orderListController
                                                    .orderDetailsData
                                                    .value
                                                    .paymentMode
                                                    .toString() ==
                                                "cash"
                                        ? () {
                                            Get.back();
                                            // Get.bottomSheet(
                                            //     Container(
                                            //       height: ScreenConstant
                                            //           .defaultHeightTwoHundredTen,
                                            //       child: Padding(
                                            //         padding:
                                            //         const EdgeInsets
                                            //             .all(8.0),
                                            //         child: Column(
                                            //           crossAxisAlignment:
                                            //           CrossAxisAlignment
                                            //               .start,
                                            //           children: [
                                            //             Container(
                                            //               height: ScreenConstant
                                            //                   .sizeLarge,
                                            //             ),
                                            //             Padding(
                                            //               padding:
                                            //               EdgeInsets
                                            //                   .all(
                                            //                   8.0),
                                            //               child: Text(
                                            //                 'Cancellation Reason',
                                            //                 style: TextStyles
                                            //                     .orderDetails,
                                            //               ),
                                            //             ),
                                            //             Container(
                                            //               height: ScreenConstant
                                            //                   .sizeLarge,
                                            //             ),
                                            //             Obx(() => Card(
                                            //               shape:
                                            //               RoundedRectangleBorder(
                                            //                 side: new BorderSide(
                                            //                     color:
                                            //                     AppColors.accentColor,
                                            //                     width: 1.0),
                                            //               ),
                                            //               child:
                                            //               ListTile(
                                            //                 title:
                                            //                 Center(
                                            //                   child:
                                            //                   DropdownButtonHideUnderline(
                                            //                     child:
                                            //                     DropdownButton<String>(
                                            //                       isExpanded: true,
                                            //                       value: _orderListController.cancelReason.value,
                                            //                       onChanged: (newValue) {
                                            //                         setState(() {
                                            //                           _orderListController.cancelReason.value = newValue!;
                                            //                           print("_orderListController.cancelReason.value: ${_orderListController.cancelReason.value}");
                                            //                         });
                                            //                       },
                                            //                       items: _orderListController.cancelReasonList.map((type) {
                                            //                         return DropdownMenuItem<String>(
                                            //                           child: Text(
                                            //                             type.description!,
                                            //                             style: TextStyles.orderIdTitle,
                                            //                           ),
                                            //                           value: type.description!
                                            //                         );
                                            //                       }).toList(),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               ),
                                            //             )),
                                            //             Container(
                                            //               height: ScreenConstant
                                            //                   .sizeExtraLarge,
                                            //             ),
                                            //             Row(
                                            //               mainAxisAlignment:
                                            //               MainAxisAlignment
                                            //                   .end,
                                            //               children: [
                                            //                 GestureDetector(
                                            //                   onTap:
                                            //                       () {
                                            //                     Get.back();
                                            //                   },
                                            //                   child:
                                            //                   Text(
                                            //                     "Cancel",
                                            //                     style: TextStyle(
                                            //                         color:
                                            //                         AppColors.accentColor,
                                            //                         fontSize: FontSizeStatic.maxMd,
                                            //                         fontWeight: FontWeight.bold,
                                            //                         fontFamily: 'Poppins'),
                                            //                   ),
                                            //                 ),
                                            //                 Container(
                                            //                   width: ScreenConstant
                                            //                       .sizeExtraLarge,
                                            //                 ),
                                            //                 GestureDetector(
                                            //                   onTap:
                                            //                       () {
                                            //                     Get.back();
                                            //                     _orderListController.cancelOrderPress(_orderListController
                                            //                         .orderDetailsData
                                            //                         .value
                                            //                         .id
                                            //                         .toString());
                                            //                   },
                                            //                   child:
                                            //                   Text(
                                            //                     "Submit",
                                            //                     style: TextStyle(
                                            //                         color:
                                            //                         AppColors.primary,
                                            //                         fontSize: FontSizeStatic.maxMd,
                                            //                         fontWeight: FontWeight.bold,
                                            //                         fontFamily: 'Poppins'),
                                            //                   ),
                                            //                 ),
                                            //                 Container(
                                            //                   width: ScreenConstant
                                            //                       .sizeSmall,
                                            //                 ),
                                            //               ],
                                            //             )
                                            //           ],
                                            //         ),
                                            //       ),
                                            //     ),
                                            //     elevation: 20.0,
                                            //     enableDrag: false,
                                            //     backgroundColor:
                                            //     Colors.white,
                                            //     shape:
                                            //     RoundedRectangleBorder(
                                            //         borderRadius:
                                            //         BorderRadius
                                            //             .only(
                                            //           topLeft:
                                            //           Radius.circular(
                                            //               30.0),
                                            //           topRight:
                                            //           Radius.circular(
                                            //               30.0),
                                            //         )));
                                            _displayTextInputDialog(context);
                                          }
                                        : () {
                                            Get.back();
                                            print("Support ticket");
                                            final SupportTicketController
                                                supportController = Get.put(
                                                    SupportTicketController());
                                            supportController
                                                    .orderIdController!.text =
                                                _orderListController
                                                    .orderDetailsData.value.code
                                                    .toString();
                                            supportController.isCancel.value =
                                                true;
                                            Get.to(CustomerCareService());
                                          },
                                  );

                                  // set up the AlertDialog
                                  AlertDialog alert = AlertDialog(
                                    content: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          "Do you want to cancel your order?",
                                          style: TextStyles.productPrice,
                                        ),
                                        // Adding space between text and buttons
                                        Divider(), // Adding a line between the text and buttons
                                        // Adding space between line and buttons
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(child: cancelButton),
                                            VerticalDivider(color: Colors.grey),
                                            Expanded(child: continueButton),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );

                                  // AlertDialog alert = AlertDialog(
                                  //   // title: Text(
                                  //   //   "Cancel Order!",
                                  //   //   style: TextStyles.productPrice,
                                  //   // ),
                                  //   content: Text(
                                  //     "Do you want to cancel your order?",
                                  //     style:
                                  //     TextStyles.productPrice,
                                  //   ),
                                  //
                                  //   actions: [
                                  //     cancelButton,
                                  //     continueButton,
                                  //   ],
                                  // );

                                  // show the dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                },
                              ),
                              Container(
                                width: ScreenConstant.sizeMedium,
                              ),
                              AppButton(
                                width: ScreenConstant.defaultWidthOneEighty,
                                color: AppColors.buttonColorSecondary,
                                buttonText: AppStrings.CallToStore,
                                onPressed: () {
                                  UrlLauncher.launch(
                                      "tel://${_splashController.accountSettingsData.value.contactDetails!.mobile.toString()}");
                                },
                              )
                            ],
                          ),
                        )
                      : Container(
                          color: AppColors.secondary,
                          height: ScreenConstant.defaultHeightOneHundred,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: AppButton(
                              width: ScreenConstant.defaultWidthOneEighty,
                              color: AppColors.buttonColorSecondary,
                              buttonText: AppStrings.CallToStore,
                              onPressed: () {
                                UrlLauncher.launch(
                                    "tel://${_splashController.accountSettingsData.value.contactDetails!.mobile.toString()}");
                              },
                            ),
                          ))),
        ));
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Cancellation Reason'),
            content: TextField(
              controller: _orderListController.rejectionReasonController,
              decoration: InputDecoration(hintText: "Reason..."),
            ),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: AppColors.accentColor,
                      fontSize: FontSizeStatic.md,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
              ),
              Container(
                width: ScreenConstant.sizeMedium,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  _orderListController.cancelOrderPress(_orderListController
                      .orderDetailsData.value.id
                      .toString());
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: FontSizeStatic.md,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
              ),
              Container(
                width: ScreenConstant.sizeSmall,
              ),
            ],
          );
        });
  }
}

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
  }) : super();

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst!,
      isLast: isLast!,
      indicatorStyle: indicatorStyle!,
      afterLineStyle: afterLineStyle,
      beforeLineStyle: beforeLineStyle!,
      endChild: data,
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



// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_potu_user/Controller/OrderListController/OrderListController.dart';
// import 'package:go_potu_user/Controller/SupportTicketController/SupportTicketController.dart';
// import 'package:go_potu_user/DeviceManager/Assets.dart';
// import 'package:go_potu_user/DeviceManager/Colors.dart';
// import 'package:go_potu_user/DeviceManager/DateTimeConverter.dart';
// import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
// import 'package:go_potu_user/DeviceManager/TextStyles.dart';
// import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
// import 'package:go_potu_user/Views/CompanyScreens/CustomerCareService.dart';
// import 'package:go_potu_user/Views/CompanyScreens/RateUSScreen.dart';
// import 'package:go_potu_user/Views/OrdersScreen/ReturnReplaceRequestScreen.dart';
// import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';
// import 'package:go_potu_user/Widgets/OrdersWidgets/OrderListWidgetProductListWidget.dart';
// import 'package:timeline_tile/timeline_tile.dart';
// import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
//
// import '../../Controller/SplashController/SplashController.dart';
// import 'RefundAndReturnDetailsScreen.dart';
//
// class OrderDetailsScreen extends StatefulWidget {
//   @override
//   State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
// }
//
// class _OrderDetailsScreenState extends State<OrderDetailsScreen>
//     with TickerProviderStateMixin {
//   Timer? _timer;
//   final OrderListController _orderListController =
//       Get.find<OrderListController>();
//   final SplashController _splashController = Get.put(SplashController());
//
//   bool isOpen = false;
//
//   AnimationController? controller;
//
//   bool isPlaying = false;
//   List<Color> colorList = [
//     Color(0xFF00d9e2),
//     Color(0xFF6c78fb),
//     Color(0xFFff004e),
//   ];
//   List<Alignment> alignmentList = [
//     Alignment.bottomLeft,
//     Alignment.bottomRight,
//     Alignment.topRight,
//     Alignment.topLeft,
//   ];
//   int index = 0;
//   Color bottomColor = Color(0xFF00d9e2);
//   Color topColor = Color(0xFF6c78fb);
//   Alignment begin = Alignment.centerLeft;
//   Alignment end = Alignment.centerRight;
//
//   // String get countText {
//   //   Duration count = controller?.duration * controller!.value;
//
//   //   return controller.isDismissed
//   //       ? '${controller!.duration!.inHours}:${(controller!.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller!.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
//   //       : controller.isCompleted
//   //           ? '0'
//   //           : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
//   // }
//   String get countText {
//     if (controller == null) {
//       return '0:00:00'; // Return a default value when controller is null
//     }
//
//     Duration count = controller!.duration! * controller!.value;
//
//     return controller!.isDismissed
//         ? '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}'
//         : controller!.isCompleted
//             ? '0:00:00' // Return 0 when completed
//             : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
//   }
//
//   double progress = 1.0;
//
//   Future _refreshData() async {
//     //await Future.delayed(Duration(seconds: 1));
//     _orderListController.getOrderDetailsPress(true).then((value) {
//       if (_orderListController.orderDetailsData.value.status ==
//           "outfordelivery") {
//         _orderListController.getOrderTimeDetailsPress(true).then((value) {
//           Future.delayed(const Duration(seconds: 1), () async {
//             print("Time3: ${_orderListController.secondsEstimated.value}");
//             setState(() {
//               controller!.reset();
//               controller!.duration = Duration(
//                   seconds: _orderListController.secondsEstimated.value);
//               print("controller.duration : ${controller!.duration}");
//               controller!.reverse(
//                   from: controller!.value == 0 ? 1.0 : controller!.value);
//               progress = 1.0;
//               Future.delayed(const Duration(milliseconds: 1000), () {
//                 print("Animation container");
//                 setState(() {
//                   bottomColor = Colors.blue;
//                 });
//               });
//             });
//           });
//         });
//       }
//     });
//   }
//
//   Future<bool> _onBackPressed() {
//     Get.back();
//     if (_orderListController.orderDetailsData.value.status ==
//         "outfordelivery") {
//       _timer!.cancel();
//       controller!.dispose();
//       return Future.value(true);
//     }
//
//     _orderListController.isTimeApiDone.value = true;
//     _orderListController.getOrderListPress(true, "");
//
//     return Future.value(false);
//   }
//
//   void notify() {
//     if (countText == '0:00:00') {
//       // FlutterRingtonePlayer.playNotification();
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     _orderListController.getOrderDetailsPress(true).then((value) {
//       if (_orderListController.orderDetailsData.value.status ==
//           "outfordelivery") {
//         _orderListController.getOrderTimeDetailsPress(false).then((value) {
//           Future.delayed(const Duration(seconds: 1), () async {
//             print("Time2: ${_orderListController.secondsEstimated.value}");
//
//             _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//               _orderListController.initialPosition.value =
//                   _orderListController.initialPosition.value - 1;
//               //tme = tme - Duration(seconds: 1);
//               // remainingTime = totalDuration - intialPosition;
//               // _controller.restart(
//               //     duration: totalDuration, initialPosition: remainingTime);
//               debugPrint(
//                   "Seconds Lapsed : ${_orderListController.initialPosition.value}");
//               if (_orderListController.initialPosition.value == 30) {
//                 _orderListController
//                     .getOrderTimeDetailsPress(false)
//                     .then((value) {
//                   _orderListController
//                       .getOrderTimeDetailsPress(false)
//                       .then((value) {
//                     Future.delayed(const Duration(seconds: 1), () async {
//                       print(
//                           "Time3: ${_orderListController.secondsEstimated.value}");
//                       setState(() {
//                         controller!.reset();
//                         controller!.duration = Duration(
//                             seconds:
//                                 _orderListController.secondsEstimated.value);
//                         print("controller.duration : ${controller!.duration}");
//                         controller!.reverse(
//                             from: controller!.value == 0
//                                 ? 1.0
//                                 : controller!.value);
//                         progress = 1.0;
//                         Future.delayed(const Duration(milliseconds: 1000), () {
//                           print("Animation container");
//                           setState(() {
//                             bottomColor = Colors.blue;
//                           });
//                         });
//                       });
//                     });
//                   });
//                 });
//               }
//             });
//
//             setState(() {
//               controller = AnimationController(
//                 vsync: this,
//                 duration: Duration(
//                     seconds: _orderListController.secondsEstimated.value),
//               );
//
//               controller!.addListener(() {
//                 notify();
//                 if (controller!.isAnimating) {
//                   setState(() {
//                     progress = controller!.value;
//                   });
//                 } else {
//                   print("===");
//
//                   print(controller!.value);
//                   if (controller!.value == 0) {
//                     setState(() {
//                       controller = AnimationController(
//                         vsync: this,
//                         duration: Duration(seconds: 0),
//                       );
//                       //controller.reset();
//                     });
//                   }
//                   print("===");
//                   setState(() {
//                     isPlaying = false;
//                   });
//                 }
//               });
//
//               if (controller!.isAnimating) {
//                 controller!.stop();
//
//                 setState(() {
//                   isPlaying = false;
//                 });
//               } else {
//                 controller!.reverse(
//                     from: controller!.value == 0 ? 1.0 : controller!.value);
//
//                 setState(() {
//                   isPlaying = true;
//                 });
//               }
//
//               Future.delayed(const Duration(milliseconds: 1000), () {
//                 print("Animation container");
//                 setState(() {
//                   bottomColor = Colors.blue;
//                 });
//               });
//             });
//           });
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     print("Line: 216");
//     if (_orderListController.orderDetailsData.value.status ==
//         "outfordelivery") {
//       _timer!.cancel();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onBackPressed,
//       child: Scaffold(
//           backgroundColor: AppColors.ordersScreenBackground,
//
//           body: Obx(() => _orderListController
//                       .orderDetailsData.value.payableAmount ==
//                   null
//               ? Container()
//               : RefreshIndicator(
//                   onRefresh: _refreshData,
//                   child: ListView(
//                     shrinkWrap: true,
//                     physics: ClampingScrollPhysics(),
//                     children: [
//
//                       isOpen
//                           ? Container(
//                               //height: ScreenConstant.defaultHeightTwoHundredFifty,
//                               color: Colors.white,
//                               child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16, vertical: 10),
//                                   child: ListView.builder(
//                                     shrinkWrap: true,
//                                     physics: ClampingScrollPhysics(),
//                                     itemCount: _orderListController
//                                         .orderDetailsData
//                                         .value
//                                         .statusLog!
//                                         .length,
//                                     itemBuilder: (context, index) {
//                                       return DeliveryTrackerSteps(
//                                         isFirst: index == 0 ? true : false,
//                                         isLast: index ==
//                                                 _orderListController
//                                                         .orderDetailsData
//                                                         .value
//                                                         .statusLog!
//                                                         .length -
//                                                     1
//                                             ? true
//                                             : false,
//                                         indicatorStyle: _orderListController
//                                                     .orderDetailsData
//                                                     .value
//                                                     .statusLog![index]
//                                                     .timestamp !=
//                                                 null
//                                             ? IndicatorStyles.completedIndicator
//                                             : IndicatorStyles
//                                                 .incompleteIndicator,
//                                         afterLineStyle: _orderListController
//                                                     .orderDetailsData
//                                                     .value
//                                                     .statusLog![index]
//                                                     .timestamp !=
//                                                 null
//                                             ? IndicatorStyles
//                                                 .completedAfterLineStyle
//                                             : IndicatorStyles
//                                                 .incompleteAfterLineStyle,
//                                         beforeLineStyle: _orderListController
//                                                     .orderDetailsData
//                                                     .value
//                                                     .statusLog![index]
//                                                     .timestamp !=
//                                                 null
//                                             ? IndicatorStyles
//                                                 .completedAfterLineStyle
//                                             : IndicatorStyles
//                                                 .incompleteAfterLineStyle,
//                                         data: ListTile(
//                                           minVerticalPadding: 27,
//                                           title: Text(
//                                             _orderListController
//                                                 .orderDetailsData
//                                                 .value
//                                                 .statusLog![index]
//                                                 .label
//                                                 .toString()
//                                                 .toUpperCase(),
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           subtitle: _orderListController
//                                                       .orderDetailsData
//                                                       .value
//                                                       .statusLog![index]
//                                                       .timestamp !=
//                                                   null
//                                               ? Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           top: 8.0),
//                                                   child: Text(
//                                                     "${DateTimeUtility().parse(dateTime: _orderListController.orderDetailsData.value.statusLog?[index].timestamp.toString(), returnFormat: "EEE, d MMM yyyy")}",
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                         color: Colors
//                                                             .grey.shade500),
//                                                   ),
//                                                 )
//                                               : Offstage(),
//                                         ),
//                                       );
//                                     },
//                                   )),
//                             )
//                           : Offstage(),
//                       isOpen
//                           ? Container(
//                               height: ScreenConstant.sizeMedium,
//                             )
//                           : Offstage(),
//                       _orderListController
//                                   .orderDetailsData.value.deliveryboyStatus ==
//                               "accepted"
//                           ? _orderListController
//                                           .orderDetailsData.value.deliveryboy !=
//                                       null &&
//                                   (_orderListController
//                                               .orderDetailsData.value.status
//                                               .toString() !=
//                                           "cancelled" &&
//                                       _orderListController
//                                               .orderDetailsData.value.status
//                                               .toString() !=
//                                           "delivered")
//                               ? Container(
//                                   color: AppColors.secondary,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(15.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               "Assigned delivery boy"
//                                                   .toUpperCase(),
//                                               style: TextStyles.orderDetails,
//                                             ),
//                                             Container(
//                                               height: ScreenConstant.sizeSmall,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 CircleAvatar(
//                                                   radius:
//                                                       ScreenConstant.sizeLarge,
//                                                   backgroundImage: NetworkImage(
//                                                       "${_orderListController.orderDetailsData.value.deliveryboy!.avatar}"),
//                                                   backgroundColor:
//                                                       Colors.transparent,
//
//                                                 ),
//                                                 Container(
//                                                   width:
//                                                       ScreenConstant.sizeSmall,
//                                                 ),
//                                                 Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       _orderListController
//                                                           .orderDetailsData
//                                                           .value
//                                                           .deliveryboy!
//                                                           .name!,
//                                                       style: TextStyles
//                                                           .deliveryBoyName,
//                                                     ),
//                                                     Container(
//                                                       height: ScreenConstant
//                                                           .sizeExtraSmall,
//                                                     ),
//                                                     _orderListController
//                                                                 .orderDetailsData
//                                                                 .value
//                                                                 .deliveryboy!
//                                                                 .vaccination ==
//                                                             null
//                                                         ? Offstage()
//                                                         : Text(
//                                                             "${_orderListController.orderDetailsData.value.deliveryboy!.vaccination.toUpperCase() + " Vaccinated".toUpperCase()}",
//                                                             style: TextStyles
//                                                                 .deliveryBoyWorkExp,
//                                                           ),
//                                                   ],
//                                                 )
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                         Column(
//                                           children: [
//                                             GestureDetector(
//                                               onTap: () {
//                                                 UrlLauncher.launch(
//                                                     "tel://${_orderListController.orderDetailsData.value.deliveryboy!.mobile.toString()}");
//                                               },
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(5),
//                                                   color: AppColors
//                                                       .ordersStatusBox4,
//                                                 ),
//                                                 child: Padding(
//                                                   padding: EdgeInsets.only(
//                                                     left: ScreenConstant
//                                                         .sizeSmall,
//                                                     bottom: ScreenConstant
//                                                         .sizeExtraSmall,
//                                                     right: ScreenConstant
//                                                         .sizeSmall,
//                                                     top: ScreenConstant
//                                                         .sizeExtraSmall,
//                                                   ),
//                                                   child: Center(
//                                                       child: Text(
//                                                     "Call Now",
//                                                     style: TextStyles
//                                                         .categoryChangeBottomText,
//                                                   )),
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               : Offstage()
//                           : Offstage(),
//                       _orderListController
//                                   .orderDetailsData.value.deliveryboyStatus ==
//                               "accepted"
//                           ? _orderListController
//                                           .orderDetailsData.value.deliveryboy !=
//                                       null &&
//                                   (_orderListController
//                                               .orderDetailsData.value.status
//                                               .toString() !=
//                                           "cancelled" &&
//                                       _orderListController
//                                               .orderDetailsData.value.status
//                                               .toString() !=
//                                           "delivered")
//                               ? Container(
//                                   height: ScreenConstant.sizeMedium,
//                                 )
//                               : Offstage()
//                           : Offstage(),
//                       _orderListController.orderDetailsData.value.status ==
//                               "outfordelivery"
//                           ? _orderListController.isTimeApiDone.value == false &&
//                                   controller != null
//                               ? AnimatedContainer(
//                                   duration: Duration(seconds: 2),
//                                   onEnd: () {
//                                     setState(() {
//                                       index = index + 1;
//                                       // animate the color
//                                       bottomColor =
//                                           colorList[index % colorList.length];
//                                       topColor = colorList[
//                                           (index + 1) % colorList.length];
//
//                                       //// animate the alignment
//                                       begin = alignmentList[
//                                           index % alignmentList.length];
//                                       end = alignmentList[
//                                           (index + 2) % alignmentList.length];
//                                     });
//                                   },
//                                   decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                           begin: begin,
//                                           end: end,
//                                           colors: [bottomColor, topColor])),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(15.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             _orderListController
//                                                         .secondsEstimated
//                                                         .value <
//                                                     60
//                                                 ? Text(
//                                                     "REACHING!!!".toUpperCase(),
//                                                     style: TextStyle(
//                                                         color:
//                                                             AppColors.secondary,
//                                                         fontSize:
//                                                             FontSizeStatic.xl,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontFamily:
//                                                             'Poppins'),
//                                                   )
//                                                 : Text(
//                                                     "HURRY!!!".toUpperCase(),
//                                                     style: TextStyle(
//                                                         color:
//                                                             AppColors.secondary,
//                                                         fontSize:
//                                                             FontSizeStatic.xl,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontFamily:
//                                                             'Poppins'),
//                                                   ),
//                                             Container(
//                                               height: ScreenConstant.sizeLarge,
//                                             ),
//                                             _orderListController
//                                                         .secondsEstimated
//                                                         .value <
//                                                     60
//                                                 ? Text(
//                                                     "The delivery boy is reaching."
//                                                         .toUpperCase(),
//                                                     style: TextStyle(
//                                                       color:
//                                                           AppColors.secondary,
//                                                       fontSize:
//                                                           FontSizeStatic.md,
//                                                       fontFamily:
//                                                           'Proxima-Regular',
//                                                     ),
//                                                   )
//                                                 : Text(
//                                                     "Your order is on the way",
//                                                     style: TextStyle(
//                                                       color:
//                                                           AppColors.secondary,
//                                                       fontSize:
//                                                           FontSizeStatic.md,
//                                                       fontFamily:
//                                                           'Proxima-Regular',
//                                                     ),
//                                                   ),
//                                             Container(
//                                               height: ScreenConstant.sizeMedium,
//                                             ),
//                                             _orderListController
//                                                         .secondsEstimated
//                                                         .value <
//                                                     60
//                                                 ? Offstage()
//                                                 : _orderListController
//                                                             .onDelay.value ==
//                                                         "Delayed"
//                                                     ? Text(
//                                                         "Delayed",
//                                                         style: TextStyle(
//                                                           color: AppColors
//                                                               .secondary,
//                                                           fontSize:
//                                                               FontSizeStatic.md,
//                                                           fontFamily:
//                                                               'Proxima-Regular',
//                                                         ),
//                                                       )
//                                                     : Text(
//                                                         "On-Time",
//                                                         style: TextStyle(
//                                                           color: AppColors
//                                                               .secondary,
//                                                           fontSize:
//                                                               FontSizeStatic.md,
//                                                           fontFamily:
//                                                               'Proxima-Regular',
//                                                         ),
//                                                       )
//                                           ],
//                                         ),
//                                         Column(
//                                           children: [
//                                             Stack(
//                                               alignment: Alignment.center,
//                                               children: [
//                                                 SizedBox(
//                                                   width: 100,
//                                                   height: 100,
//                                                   child: controller == null ||
//                                                           _orderListController
//                                                                   .secondsEstimated
//                                                                   .value <
//                                                               60
//                                                       ? Offstage()
//                                                       : CircularProgressIndicator(
//                                                           backgroundColor:
//                                                               Colors.white,
//                                                           valueColor:
//                                                               AlwaysStoppedAnimation<
//                                                                       Color>(
//                                                                   AppColors
//                                                                       .buttonColorSecondary),
//                                                           value: (controller!
//                                                                           .duration! *
//                                                                       controller!
//                                                                           .value)
//                                                                   .inSeconds /
//                                                               _orderListController
//                                                                   .secondRemaining
//                                                                   .value,
//                                                           strokeWidth: 6,
//                                                         ),
//                                                 ),
//                                                 GestureDetector(
//
//                                                   child: controller == null ||
//                                                           _orderListController
//                                                                   .secondsEstimated
//                                                                   .value <
//                                                               60
//                                                       ? Container(
//                                                           height: 75,
//                                                           width: 75,
//                                                           child: Image(
//                                                             image: AssetImage(Assets
//                                                                 .deliveryBoyReached),
//                                                           ),
//                                                         )
//                                                       : AnimatedBuilder(
//                                                           animation:
//                                                               controller!,
//                                                           builder: (context,
//                                                                   child) =>
//                                                               Text(
//                                                             countText,
//                                                             style: TextStyle(
//                                                               fontSize: 20,
//                                                               color: AppColors
//                                                                   .secondary,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               : Offstage()
//                           : Offstage(),
//                       _orderListController.orderDetailsData.value.status ==
//                               "outfordelivery"
//                           ? Container(
//                               height: ScreenConstant.sizeMedium,
//                             )
//                           : Offstage(),
//
//                     ],
//                   ),
//                 ))));
//
//
//
// }}
// class DeliveryTrackerSteps extends StatelessWidget {
// final bool? isFirst;
// final bool? isLast;
// final IndicatorStyle? indicatorStyle;
// final LineStyle? afterLineStyle;
// final LineStyle? beforeLineStyle;
// final Widget? data;
//
// const DeliveryTrackerSteps({
// this.isFirst,
// this.isLast,
// this.indicatorStyle,
// this.afterLineStyle,
// this.beforeLineStyle,
// this.data,
// Key? key,
// }) : super(key: key);
//
// @override
// Widget build(BuildContext context) {
// return TimelineTile(
// isFirst: isFirst ?? false,
// isLast: isLast ?? false,
// indicatorStyle: indicatorStyle ?? IndicatorStyle(),
// afterLineStyle: afterLineStyle ?? LineStyle(),
// beforeLineStyle: beforeLineStyle ?? LineStyle(),
// endChild: data ?? Container(), // You can provide a default widget if data is not provided
// );
// }
// }
//
//
// class IndicatorStyles {
//   static IndicatorStyle get completedIndicator => IndicatorStyle(
//       color: AppColors.buttonColorSecondary, height: 15, width: 15);
//
//   static IndicatorStyle get incompleteIndicator => IndicatorStyle(
//     height: 15,
//     width: 15,
//     indicator: Container(
//       width: 35,
//       height: 35,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.white,
//         border: Border.all(
//           color: Colors.grey,
//         ),
//       ),
//     ),
//   );
//
//   static LineStyle get completedAfterLineStyle =>
//       LineStyle(color: AppColors.buttonColorSecondary, thickness: 1);
//
//   static LineStyle get incompleteAfterLineStyle =>
//       LineStyle(color: Colors.grey, thickness: 1);
//
//   static LineStyle get incompleteBeforeLineStyle =>
//       LineStyle(color: Colors.grey, thickness: 1);
// }
//
