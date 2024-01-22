import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:go_potu_user/Controller/MyWalletController/MyWalletController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/NoResult.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';

import 'WalletTransactionHistoryList.dart';

class UserWalletScreen extends StatelessWidget {
  final MyWalletController _myWalletController = Get.put(MyWalletController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          _myWalletController.isWalletLoading.value = true;
          Get.back();
          return Future.value(false);
        },
        child: Scaffold(
            backgroundColor: AppColors.secondary,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColors.primary,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.white,
                  size: ScreenConstant.sizeXL,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                "My Wallet",
                style: TextStyles.appBarTitle,
              ),
            ),
            body: GetX<MyWalletController>(initState: (state) {
              Get.find<MyWalletController>().myWalletPress(true);
            }, builder: (_) {
              return _myWalletController.isWalletLoading.value
                  ? Container()
                  : Stack(
                      children: [
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Column(children: <Widget>[
                            // Container(
                            //   height: ScreenConstant.defaultHeightSeventy,
                            //   color: AppColors.primary,
                            // ),
                            Expanded(
                                child: Container(
                              color: AppColors.secondary,
                            )),
                          ]),
                        ),
                        Positioned(
                          left: 0,
                          top: ScreenConstant.sizeLarge,
                          right: 0,
                          bottom: 0,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.0, right: 15),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: ScreenConstant
                                          .defaultHeightOneHundredTen,
                                      width: ScreenConstant
                                          .defaultHeightFourHundred,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.green,
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: ScreenConstant
                                                    .defaultHeightFour,
                                                bottom: ScreenConstant
                                                    .defaultHeightThirtyFive),
                                            child: Container(
                                              height: 82,
                                              width: 80,
                                              child: Image.asset(
                                                  "assets/Group 297.png"),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenConstant
                                                    .sizeExtraLarge),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "Enjoy your wallet balance",
                                                    style: TextStyle(
                                                        fontSize: FontSizeStatic
                                                            .maxMd,
                                                        color: Colors.white)),
                                                SizedBox(
                                                  height: ScreenConstant
                                                      .defaultHeightEight,
                                                ),
                                                Text(
                                                    "Recharge with just one click",
                                                    style: TextStyle(
                                                        fontSize: FontSizeStatic
                                                            .maxMd,
                                                        color: Colors.white)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                ScreenConstant.defaultWidthTen,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenConstant
                                                    .defaultHeightThirtyFive),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: ScreenConstant
                                                          .defaultWidthTen),
                                                  child: Container(
                                                    width: ScreenConstant
                                                        .sizeUltraXXXL,
                                                    child: Text(
                                                        "₹${double.parse(_myWalletController.myWalletDashBoardData.value.balance!).toStringAsFixed(2)}",
                                                        style: TextStyle(
                                                            fontSize:
                                                                FontSizeStatic
                                                                    .xl,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                ),
                                                Text("Your Balance",
                                                    style: TextStyle(
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: ScreenConstant
                                                          .defaultWidthTwenty,
                                                      left: ScreenConstant
                                                          .defaultHeightThirtyFive),
                                                  child: Text("*T&C Apply",
                                                      style: TextStyle(
                                                          fontSize: 8,
                                                          color: Colors.white)),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenConstant
                                                    .defaultWidthTen),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: ScreenConstant
                                                      .defaultHeightFive,
                                                  width: ScreenConstant
                                                      .defaultWidthEighteen,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFD32033),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(4),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      4))),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: ScreenConstant
                                                          .defaultHeightSeventy,
                                                      left: ScreenConstant
                                                          .defaultHeightFive),
                                                  child: Container(
                                                    height: ScreenConstant
                                                        .defaultHeightFive,
                                                    width: ScreenConstant
                                                        .defaultWidthFourteen,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFD32033),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        4),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        4))),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                  Container(
                                    height: ScreenConstant.sizeLarge,
                                  ),

                                  Container(
                                    height: ScreenConstant.sizeLarge,
                                  ),
                                  Container(
                                    height: ScreenConstant
                                        .defaultHeightFourHundredFifty,
                                    width: 400,
                                    // color: Color(0xFFF4F4F4),
                                    decoration: BoxDecoration(
                                      color:
                                          Color(0xFFF4F4F4), // Background color
                                      border: Border.all(
                                        color: Color(
                                            0xFFF4F4F4), // Border color (matches background color)
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          10), // Border radius (rounded corners)
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: ScreenConstant
                                                  .defaultHeightSeventySix,
                                              top: ScreenConstant
                                                  .sizeExtraLarge),
                                          child: Text(
                                            "Add money to Gopotu Cash",
                                            style: TextStyle(
                                                fontSize: FontSizeStatic.xl,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenConstant
                                                  .defaultHeightTwentyfive,
                                              right: ScreenConstant
                                                  .defaultSizeTwoFifty),
                                          child: Text(
                                            " ₹ 80",
                                            style: TextStyle(
                                                fontSize: FontSizeStatic.xxxl,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: ScreenConstant
                                                  .defaultHeightFifteen,
                                              right: ScreenConstant
                                                  .defaultHeightFifteen),
                                          child: Container(
                                            height: 2,
                                            width: double.infinity,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenConstant
                                                  .defaultHeightTwentyfive,
                                              right: 260),
                                          child: Text("Recommended",
                                              style: TextStyle(
                                                fontSize: FontSizeStatic.md,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                        SizedBox(
                                          height:
                                              ScreenConstant.defaultWidthTwenty,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: ScreenConstant
                                                  .defaultHeightFifteen),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: ScreenConstant
                                                    .defaultHeightThirtyFive,
                                                width: ScreenConstant
                                                    .defaultHeightSeventy,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFF4F4F4),
                                                  border: Border.all(
                                                      color: Colors.green),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "₹500",
                                                    style: TextStyle(
                                                        fontSize:
                                                            FontSizeStatic.md,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: ScreenConstant
                                                    .defaultWidthTen,
                                              ),
                                              Container(
                                                height: ScreenConstant
                                                    .defaultHeightThirtyFive,
                                                width: ScreenConstant
                                                    .defaultHeightSeventy,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFF4F4F4),
                                                  border: Border.all(
                                                      color: Colors.green),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "₹1000",
                                                    style: TextStyle(
                                                        fontSize:
                                                            FontSizeStatic.md,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: ScreenConstant
                                                    .defaultWidthTen,
                                              ),
                                              Container(
                                                height: ScreenConstant
                                                    .defaultHeightThirtyFive,
                                                width: ScreenConstant
                                                    .defaultHeightSeventy,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFF4F4F4),
                                                  border: Border.all(
                                                      color: Colors.green),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "₹2000",
                                                    style: TextStyle(
                                                        fontSize:
                                                            FontSizeStatic.md,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              ScreenConstant.defaultHeightFifty,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(),
                                          child: Container(
                                            height: ScreenConstant
                                                .defaultHeightThirtyFive,
                                            width: ScreenConstant
                                                .defaultHeightThreeHundredEighty,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFD9D9D9),
                                              // border: Border.all(
                                              //     color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "PROCEED TO TOPUP",
                                                style: TextStyle(
                                                    fontSize: FontSizeStatic.md,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: ScreenConstant
                                                .defaultWidthTwenty),
                                        Divider(
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                            height: ScreenConstant
                                                .defaultWidthTwenty),
                                        Container(
                                          width: ScreenConstant
                                              .defaultHeightFourHundred,
                                          height:
                                              ScreenConstant.defaultHeightFifty,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: ScreenConstant
                                                        .defaultHeightTwentyThree,
                                                    bottom: ScreenConstant
                                                        .defaultHeightEight),
                                                child: Container(
                                                  height: ScreenConstant
                                                      .defaultHeightTwentyeight,
                                                  width: ScreenConstant
                                                      .defaultHeightThirtyFive,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.green),
                                                  child: Container(
                                                    child: Image.asset(
                                                        "assets/aa.png"),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: ScreenConstant
                                                    .defaultHeightTen,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: ScreenConstant
                                                        .defaultHeightFour),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Set Auto Top-up",
                                                      style: TextStyle(
                                                          fontSize:
                                                              FontSizeStatic.md,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: ScreenConstant
                                                          .defaultHeightFour,
                                                    ),
                                                    Text(
                                                        "Never run out of balance",
                                                        style: TextStyle(
                                                          fontSize:
                                                              FontSizeStatic.md,
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: ScreenConstant
                                                    .defaultHeightSeventySix,
                                              ),
                                              Icon(
                                                Icons.keyboard_arrow_right,
                                                color: Colors.black,
                                                size: ScreenConstant.sizeXL,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenConstant.defaultWidthTwenty,
                                  ),
                                  Container(
                                      height: ScreenConstant.defaultHeightSixty,
                                      width: defaultScreenWidth,
                                      decoration: BoxDecoration(
                                        color: Color(
                                            0xFFF4F4F4), // Background color
                                        border: Border.all(
                                          color: Color(
                                              0xFFF4F4F4), // Border color (matches background color)
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            10), // Border radius (rounded corners)
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: ScreenConstant
                                                    .defaultWidthTwenty),
                                            child: Container(
                                                height: ScreenConstant
                                                    .defaultHeightForty,
                                                width: ScreenConstant
                                                    .defaultHeightForty,
                                                child: Image.asset(
                                                    "assets/history.png")),
                                          ),
                                          SizedBox(
                                              width: ScreenConstant
                                                  .defaultWidthTen),
                                          Text(
                                            "Wallet Transaction History",
                                            style: TextStyle(
                                                fontSize: FontSizeStatic.maxMd,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: ScreenConstant
                                                .defaultHeightSixty,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                  WalletTransactionHistoryList());
                                            },
                                            child: Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colors.black,
                                              size: ScreenConstant.sizeXL,
                                            ),
                                          )
                                        ],
                                      )),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     Get.to(WalletTransactionHistoryList());
                                  //   },
                                  //   child: Card(
                                  //     color: AppColors.buttonColorSecondary,
                                  //     child: ListTile(
                                  //       title: Text(
                                  //         "Transaction History",
                                  //         style: TextStyle(
                                  //           fontSize: FontSizeStatic.maxMd,
                                  //           /* fontFamily: 'Proxima-Regular' */ fontFamily:
                                  //               'Poppins',
                                  //           color: AppColors.secondary,
                                  //         ),
                                  //       ),
                                  //       trailing: Container(
                                  //         height: ScreenConstant.sizeXXL,
                                  //         width: ScreenConstant.sizeXXL,
                                  //         child: Image.asset(
                                  //           Assets.rupee,
                                  //           color:
                                  //               AppColors.secondary.withOpacity(.3),
                                  //           fit: BoxFit.contain,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: ScreenConstant.defaultSizeOneTwenty,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
            }),
            bottomNavigationBar: Container(
              height: 165,
              child: Column(
                children: [
                  Container(
                    height: ScreenConstant.sizeSmall,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: ScreenConstant.defaultHeightEight,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenConstant.defaultWidthTwenty,
                        top: ScreenConstant.defaultWidthTen),
                    child: Row(children: [
                      Container(
                        width: ScreenConstant.defaultWidthTwenty,
                        height: ScreenConstant.defaultWidthTwenty,
                        child: Image.asset("assets/offer.png"),
                      ),
                      SizedBox(
                        width: ScreenConstant.defaultHeightFour,
                      ),
                      Text("To receive",
                          style: TextStyle(
                            fontSize: FontSizeStatic.sm,
                          )),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        "Free Delivery,",
                        style: TextStyle(
                            fontSize: FontSizeStatic.sm,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text("add products totaling at least",
                          style: TextStyle(
                            fontSize: FontSizeStatic.sm,
                          )),
                      SizedBox(
                        width: 2,
                      ),
                      Text("₹149",
                          style: TextStyle(
                              fontSize: FontSizeStatic.sm,
                              fontWeight: FontWeight.bold))
                    ]),
                  ),
                  SizedBox(
                    height: ScreenConstant.defaultHeightEight,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  BottomNavigationBar(
                    showUnselectedLabels: true,
                    unselectedItemColor: Colors.black,
                    selectedItemColor: Colors.red,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Container(
                            height: ScreenConstant.defaultHeightForty,
                            width: ScreenConstant.defaultHeightTwentyfive,
                            child: Image.asset(
                              "assets/Vectorhome.png",
                            )),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Container(
                            height: ScreenConstant.defaultHeightForty,
                            width: ScreenConstant.defaultHeightTwentyfive,
                            child: Image.asset(
                              "assets/orders.png",
                            )),
                        label: 'My Orders',
                      ),
                      BottomNavigationBarItem(
                        icon: Container(
                            height: ScreenConstant.defaultHeightForty,
                            width: ScreenConstant.defaultHeightTwentyfive,
                            child: Image.asset("assets/categories.png")),
                        label: 'Categories',
                      ),
                      BottomNavigationBarItem(
                        icon: Container(
                            height: ScreenConstant.defaultHeightForty,
                            width: ScreenConstant.defaultHeightTwentyfive,
                            child: Image.asset("assets/Group.png")),
                        label: 'Cart',
                      ),
                      BottomNavigationBarItem(
                        icon: Container(
                            height: ScreenConstant.defaultHeightForty,
                            width: ScreenConstant.defaultHeightTwentyfive,
                            child: Image.asset("assets/profile.png")),
                        label: 'Profile',
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
