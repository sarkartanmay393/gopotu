// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:go_potu_user/Controller/AddressController/AddressController.dart';
// import 'package:go_potu_user/Controller/MyBucketController/MyBucketController.dart';
// import 'package:go_potu_user/Controller/MyWalletController/MyWalletController.dart';
// import 'package:go_potu_user/Controller/ProductController/ProductController.dart';
// import 'package:go_potu_user/Controller/StoreController/StoreController.dart';
// import 'package:go_potu_user/Controller/SubCategoryController/SubCategoryController.dart';
// import 'package:go_potu_user/DeviceManager/Assets.dart';
// import 'package:go_potu_user/DeviceManager/Colors.dart';
// import 'package:go_potu_user/DeviceManager/NoResult.dart';
// import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
// import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
// import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
// import 'package:go_potu_user/DeviceManager/TextStyles.dart';
// import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
// import 'package:go_potu_user/Models/ResponseModels/GetMyBucketResponseModel/GetMyBucketResponseModel.dart';
// import 'package:go_potu_user/Router/RouteConstants.dart';
// import 'package:go_potu_user/Store/HiveStore.dart';
// import 'package:go_potu_user/Store/ScopeStorage.dart';
// import 'package:go_potu_user/Store/ShareStore.dart';
// import 'package:go_potu_user/Views/CartScreen/ScheduleScreen.dart';
import 'package:go_potu_user/Controller/OrderListController/OrderListController.dart';
import 'package:go_potu_user/Views/HomeScreen/HomeScreen.dart';
// import 'package:go_potu_user/Views/SignInScreen/SignIn.dart';
// import 'package:go_potu_user/Views/StoreScreens/Strore.dart';
// import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';
// import 'package:go_potu_user/Widgets/CartWidgets/CartProductListWidget.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import '../../DeviceManager/ScreenConstants.dart';
// import '../../Widgets/TextFieldWidgets/RequireTextField.dart';
// import '../CompanyScreens/CancelPolicyScreen.dart';
// import 'PromoApplyScreen.dart';
//
// class CheckOutPage extends StatefulWidget {
//   @override
//   State<CheckOutPage> createState() => _CheckOutPageState();
// }
//
// class _CheckOutPageState extends State<CheckOutPage> {
//   final MyBucketController _myBucketController = Get.put(MyBucketController());
//   final MyWalletController _myWalletController = Get.put(MyWalletController());
//   StoreController storeController = Get.put(StoreController());
//
//
//   Future _refreshData() async {
//     //await Future.delayed(Duration(seconds: 1));
//     _myBucketController.getBucketPress(false, "");
//   }
//
//   Future<bool> _onBackPressed() {
//     _myBucketController.isLoading.value = true;
//     if (_myBucketController.isStoreDetails.value) {
//       StoreController storeController = Get.find();
//       storeController.storeDetailsPress(true);
//       _myBucketController.isStoreDetails.value = false;
//       Get.back();
//     } else if (_myBucketController.subCategoryProductList.value) {
//       SubCategoryController subCategoryController = Get.find();
//       if (subCategoryController.allTap.value) {
//         subCategoryController.loadProductListPress(
//             subCategoryController.categoryParentId.toString(), true);
//       } else {
//         subCategoryController.loadProductListPress(
//             subCategoryController.subcategoryId.toString(), true);
//       }
//
//       _myBucketController.subCategoryProductList.value = false;
//       Get.back();
//     } else if (_myBucketController.productDetails.value) {
//       ProductController _productController = Get.find();
//       Future.delayed(Duration(milliseconds: 100), () {
//         _productController.productDetailsPress(false);
//       });
//       _productController.isLoading.value = true;
//       _myBucketController.productDetails.value = false;
//       Get.back();
//     } else {
//       Get.offAllNamed(dashBoard);
//     }
//     return Future.value(false);
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _myBucketController.isLoading.value = true;
//   }
//
//   int selectedIndex = -1;
//   String selectedValue = '';
//   @override
//   Widget build(BuildContext context) {
//     _myBucketController.paymentMode.value = "cash";
//     return GetX<MyBucketController>(initState: (state) {
//       Get.find<MyBucketController>().getBucketPress(true, "");
//     }, builder: (_) {
//       return _myBucketController.myBucketData.value.itemTotal == null ||
//               _myBucketController.myBucketData.value.itemTotal == "0.00"
//           ? WillPopScope(
//               onWillPop: _onBackPressed,
//               child: Scaffold(
//                 backgroundColor: Color(0xFFF0F0F0),
//                 appBar: AppBar(
//                   /*leading: BackButton(
//                     onPressed: _onBackPressed,
//                   ),*/
//                   centerTitle: true,
//                   backgroundColor: Colors.black,
//                   elevation: 0,
//                   title: Text(
//                     AppStrings.MyBasket,
//                     style: TextStyles.appBarTitle,
//                   ),
//                 ),
//                 body: _myBucketController.isLoading.value
//                     ? Container()
//                     : Container(
//                         child: Center(
//                             child: NoResult(
//                           titleText: "Sorry no item found!",
//                           subTitle: "",
//                         )),
//                       ),
//               ),
//             )
//           : WillPopScope(
//               onWillPop: _onBackPressed,
//               child: Scaffold(
//                 backgroundColor: Color(0xFFF0F0F0),
//                 appBar: AppBar(
//                   leading: IconButton(
//                     icon: Icon(
//                       Icons.chevron_left,
//                       size: FontSizeStatic.xxxl,
//                       color: Colors.black,
//                     ),
//                     onPressed: (() {
//                       Navigator.pop(context);
//                     }),
//                   ),
//                   centerTitle: true,
//                   backgroundColor: Colors.white,
//                   elevation: 0,
//                   title: Text(
//                     "Cart",
//                     style: TextStyle(
//                         fontSize: FontSizeStatic.xxl,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                 ),
//                 //drawer: DrawerFile(),
//                 body: _myBucketController.isLoading.value
//                     ? Container()
//                     : RefreshIndicator(
//                         onRefresh: _refreshData,
//                         child: ListView(
//                           shrinkWrap: true,
//                           physics: ClampingScrollPhysics(),
//                           children: [
//                             Container(
//                               child: Padding(
//                                 padding:
//                                     EdgeInsets.all(ScreenConstant.sizeLarge),
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(
//                                             ScreenConstant.defaultWidthTen),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.5),
//                                             blurRadius: 7,
//                                             offset: Offset(0, 3),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             top: ScreenConstant.sizeSmall,
//                                             bottom: ScreenConstant.sizeSmall),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Icon(
//                                               Icons.timer,
//                                               size: ScreenConstant.sizeXXL,
//                                               color: Colors.green,
//                                             ),
//                                             Text(
//                                               'Deliver in 30mins to Home',
//                                               style: TextStyle(
//                                                   fontSize:
//                                                       FontSizeStatic.semiSm,
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             Container(
//                                               height: ScreenConstant
//                                                   .defaultHeightForty, // Adjust the height of the line as needed
//                                               width:
//                                                   1, // Adjust the width of the line as needed
//                                               color: Colors.black,
//                                             ),
//                                             Container(
//                                               width:ScreenConstant.defaultHeightOneHundredFifty,
//                                               child: Row(
//                                                 children: [
//                                                   Container(
//                                                     width:ScreenConstant.defaultHeightEightyTwo,
//                                                     child: Text(
//                                                       _myBucketController
//                                                               .myBucketData
//                                                               .value
//                                                               .defaultAddress!
//                                                               .location ??
//                                                           "",
//                                                       style: TextStyle(
//                                                           fontSize: FontSizeStatic.md,
//                                                           fontWeight: FontWeight.bold),
//                                                       overflow: TextOverflow.ellipsis,
//                                                     ),
//                                                   ),
//                                                   Container(width:ScreenConstant.defaultWidthTen),
//                                                   Icon(
//                                                     Icons.location_on,
//                                                     color: Colors.green,
//                                                     size: ScreenConstant.sizeXXL,
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Container(
//                                       height: ScreenConstant.sizeExtraLarge,
//                                     ),
//                                     Column(
//                                       children: [
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.grey
//                                                     .withOpacity(0.5),
//                                                 blurRadius: 7,
//                                                 offset: Offset(0, 3),
//                                               ),
//                                             ],
//                                           ),
//                                           child: Center(
//                                             child: Column(
//                                               children: [
//                                                 Container(
//                                                   color: AppColors.secondary,
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(
//                                                       top: ScreenConstant
//                                                           .sizeMedium,
//                                                       left: ScreenConstant
//                                                           .sizeMedium,
//                                                       right: ScreenConstant
//                                                           .sizeMedium,
//                                                     ),
//                                                     child: Center(
//                                                       child: ListView.builder(
//                                                         shrinkWrap: true,
//                                                         physics:
//                                                             ClampingScrollPhysics(),
//                                                         itemCount:
//                                                             _myBucketController
//                                                                 .myBucketData
//                                                                 .value
//                                                                 .items!
//                                                                 .length,
//                                                         itemBuilder:
//                                                             (context, index) {
//                                                           return CartProductListWidget(
//                                                             isDeliverable:
//                                                                 _myBucketController
//                                                                     .myBucketData
//                                                                     .value
//                                                                     .defaultAddress!
//                                                                     .deliverable,
//                                                             items:
//                                                                 _myBucketController
//                                                                     .myBucketData
//                                                                     .value
//                                                                     .items,
//                                                             index: index,
//                                                             isCouponCode:
//                                                                 _myBucketController
//                                                                         .myBucketData
//                                                                         .value
//                                                                         ?.couponDetails
//                                                                         ?.code ??
//                                                                     "",
//                                                           );
//                                                         },
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   height: ScreenConstant
//                                                       .sizeExtraSmall,
//                                                 ),
//                                                 Divider(
//                                                   color: Colors.black,
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                     left: ScreenConstant
//                                                         .defaultWidthTwenty,
//                                                     top: ScreenConstant
//                                                         .defaultWidthTen,
//                                                     bottom: ScreenConstant
//                                                         .defaultWidthTen,
//                                                   ),
//                                                   child: Row(
//                                                     children: [
//                                                       Icon(Icons.add),
//                                                       SizedBox(
//                                                         width: ScreenConstant
//                                                             .sizeSmall,
//                                                       ),
//                                                       Text("Add more items",
//                                                           style: TextStyle(
//                                                             fontSize:
//                                                                 FontSizeStatic
//                                                                     .semiSm,
//                                                           )),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 // Divider(
//                                                 //   color: Colors.black,
//                                                 // ),
//                                                 // Padding(
//                                                 //   padding: EdgeInsets.only(
//                                                 //       left: ScreenConstant
//                                                 //           .defaultHeightTwentyeight),
//                                                 //   child: Row(
//                                                 //     children: [
//                                                 //       Text("Add description",
//                                                 //           style: TextStyle(
//                                                 //             fontSize:
//                                                 //                 FontSizeStatic
//                                                 //                     .semiSm,
//                                                 //           )),
//                                                 //       SizedBox(
//                                                 //           width: ScreenConstant
//                                                 //               .defaultWidthOneEighty),
//                                                 //       Container(
//                                                 //         width: ScreenConstant
//                                                 //             .sizeLarge,
//                                                 //         height: ScreenConstant
//                                                 //             .defaultHeightFiftyFive,
//                                                 //         decoration:
//                                                 //             BoxDecoration(
//                                                 //           color: Colors.white,
//                                                 //           shape:
//                                                 //               BoxShape.circle,
//                                                 //           border: Border.all(
//                                                 //             color: Colors.black,
//                                                 //             width: 2.0,
//                                                 //           ),
//                                                 //         ),
//                                                 //         child: Center(
//                                                 //           child: Icon(
//                                                 //             Icons.add,
//                                                 //             color: Colors.black,
//                                                 //             size: FontSizeStatic
//                                                 //                 .lg,
//                                                 //           ),
//                                                 //         ),
//                                                 //       )
//                                                 //     ],
//                                                 //   ),
//                                                 // )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: ScreenConstant.defaultHeightForty,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           "Apply Offer",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: FontSizeStatic.md),
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: ScreenConstant.defaultWidthTwenty,
//                                     ),
//                                     Container(
//                                       width: ScreenConstant
//                                           .defaultHeightFiveHundred,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(
//                                             ScreenConstant.defaultWidthTen),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.5),
//                                             blurRadius: 7,
//                                             offset: Offset(0, 3),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Column(
//                                         children: [
//                                           Padding(
//                                             padding: EdgeInsets.only(
//                                               left: ScreenConstant
//                                                   .defaultWidthTen,
//                                             ),
//                                             child: Row(
//                                               children: [
//                                                 Container(
//                                                   height: ScreenConstant
//                                                       .defaultHeightFifty,
//                                                   width: ScreenConstant
//                                                       .defaultHeightFifty,
//                                                   child: Image.asset(
//                                                       "assets/offer.png"),
//                                                 ),
//                                                 SizedBox(
//                                                   width:
//                                                       ScreenConstant.sizeSmall,
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                       bottom: ScreenConstant
//                                                           .defaultWidthTen),
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Padding(
//                                                         padding:
//                                                             EdgeInsets.only(
//                                                           top: ScreenConstant
//                                                               .defaultHeightTwentyeight,
//                                                         ),
//                                                         child: Text(
//                                                           "AVAILABLE OFFERS",
//                                                           style: TextStyle(
//                                                             fontSize:
//                                                                 FontSizeStatic
//                                                                     .md,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                           height: ScreenConstant
//                                                               .defaultHeightEight),
//                                                       Text(
//                                                         "Save ${double.parse(_myBucketController.myBucketData.value.couponDiscount!).toStringAsFixed(2)} on this order",
//                                                         style: TextStyle(
//                                                           fontSize:
//                                                               FontSizeStatic.sm,
//                                                           color: Colors.grey,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   width: ScreenConstant
//                                                       .defaultHeightEightyTwo,
//                                                 ),
//                                                 // TextButton(
//                                                 //     onPressed: () {
//                                                 //       _myBucketController
//                                                 //           .applyCouponPress(
//                                                 //               _myBucketController
//                                                 //                   .thisController
//                                                 //                   .text);
//                                                 //     },
//                                                 //     child: Text(
//                                                 //       "Apply",
//                                                 //       style: TextStyle(
//                                                 //           fontSize:
//                                                 //               FontSizeStatic.lg,
//                                                 //           color: Colors.green,
//                                                 //           fontWeight:
//                                                 //               FontWeight.bold),
//                                                 //     )),
//                                               ],
//                                             ),
//                                           ),
//                                           Divider(
//                                             color: Colors.black,
//                                           ),
//                                           Container(
//                                             height: ScreenConstant
//                                                 .defaultHeightFortyFive,
//                                             child: GestureDetector(
//                                               onTap: HiveStore().get(
//                                                           Keys.guestToken) ==
//                                                       null
//                                                   ? _myBucketController
//                                                           .myBucketData
//                                                           .value
//                                                           .defaultAddress!
//                                                           .deliverable!
//                                                       ? () {
//                                                           if (_myBucketController
//                                                               .walletUsed
//                                                               .value) {
//                                                             // set up the buttons
//                                                             Widget
//                                                                 cancelButton =
//                                                                 TextButton(
//                                                               child: Text(
//                                                                 "Cancel",
//                                                                 style: TextStyle(
//                                                                     color: AppColors
//                                                                         .accentColor,
//                                                                     fontSize:
//                                                                         FontSizeStatic
//                                                                             .md,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                     fontFamily:
//                                                                         /*'Proxima-Bold'*/ 'Poppins'),
//                                                               ),
//                                                               onPressed: () {
//                                                                 Get.back();
//                                                               },
//                                                             );
//                                                             Widget
//                                                                 continueButton =
//                                                                 TextButton(
//                                                               child: Text(
//                                                                 "Yes",
//                                                                 style: TextStyle(
//                                                                     color: AppColors
//                                                                         .primary,
//                                                                     fontSize:
//                                                                         FontSizeStatic
//                                                                             .md,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                     fontFamily:
//                                                                         /*'Proxima-Bold'*/ 'Poppins'),
//                                                               ),
//                                                               onPressed: () {
//                                                                 print("press");
//                                                                 Get.back();
//                                                                 _myBucketController
//                                                                         .context =
//                                                                     context;
//                                                                 print(
//                                                                     "${_myBucketController.myBucketData.value?.couponDetails?.code}");
//                                                                 Get.to(
//                                                                     PromoApplyScreen(
//                                                                   couponCode: _myBucketController
//                                                                           .myBucketData
//                                                                           .value
//                                                                           ?.couponDetails
//                                                                           ?.code ??
//                                                                       "empty",
//                                                                   couponsList:
//                                                                       _myBucketController
//                                                                           .myBucketData
//                                                                           .value
//                                                                           .availableCoupons,
//                                                                 ));
//                                                                 _myBucketController
//                                                                     .walletUsed
//                                                                     .value = false;
//                                                               },
//                                                             );
//
//                                                             // set up the AlertDialog
//                                                             AlertDialog alert =
//                                                                 AlertDialog(
//                                                               title: Text(
//                                                                 "Alert!",
//                                                                 style: TextStyles
//                                                                     .productPrice,
//                                                               ),
//                                                               content: Text(
//                                                                 "Coupon discounts cannot be combined with wallet balance. You are using wallet balance. After applying any coupon discount,you will not be able to use wallet balance for this order. Are you sure you want to replace it?",
//                                                                 style: TextStyles
//                                                                     .chooseCategorySubTitle,
//                                                               ),
//                                                               actions: [
//                                                                 cancelButton,
//                                                                 continueButton,
//                                                               ],
//                                                             );
//
//                                                             // show the dialog
//                                                             showDialog(
//                                                               context: context,
//                                                               builder:
//                                                                   (BuildContext
//                                                                       context) {
//                                                                 return alert;
//                                                               },
//                                                             );
//                                                           } else {
//                                                             _myBucketController
//                                                                     .context =
//                                                                 context;
//                                                             print(
//                                                                 "${_myBucketController.myBucketData.value?.couponDetails?.code}");
//                                                             Get.to(
//                                                                 PromoApplyScreen(
//                                                               couponCode: _myBucketController
//                                                                       .myBucketData
//                                                                       .value
//                                                                       ?.couponDetails
//                                                                       ?.code ??
//                                                                   "empty",
//                                                               couponsList:
//                                                                   _myBucketController
//                                                                       .myBucketData
//                                                                       .value
//                                                                       .availableCoupons,
//                                                             ));
//                                                           }
//                                                         }
//                                                       : () {}
//                                                   : () {
//                                                       Get.snackbar("Sorry!",
//                                                           "Please login to continue",
//                                                           backgroundColor:
//                                                               AppColors
//                                                                   .secondary,
//                                                           icon: Icon(
//                                                             Icons
//                                                                 .error_outline_sharp,
//                                                             color: Colors.red,
//                                                           ));
//                                                     },
//                                               child: Padding(
//                                                 padding: EdgeInsets.only(
//                                                     top: ScreenConstant
//                                                         .defaultWidthEighteen),
//                                                 child: Text(
//                                                   "View More Coupons >",
//                                                   style: TextStyle(
//                                                       fontSize:
//                                                           FontSizeStatic.maxMd,
//                                                       color: Colors.black),
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: ScreenConstant.sizeXXL,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           "Wallet",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: FontSizeStatic.md),
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: ScreenConstant.defaultWidthTwenty,
//                                     ),
//                                     Container(
//                                       width: defaultScreenWidth,
//                                       height: ScreenConstant
//                                           .defaultWidthNinetyEight,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(
//                                             ScreenConstant.defaultWidthTen),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.5),
//                                             blurRadius: 7,
//                                             offset: Offset(0, 3),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding: EdgeInsets.only(
//                                               left: ScreenConstant
//                                                   .defaultWidthTwenty,
//                                             ),
//                                             child: Icon(
//                                               Icons.wallet,
//                                               size: FontSizeStatic.xxxl,
//                                               color: Colors.green,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: ScreenConstant.sizeSmall,
//                                           ),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                     top: ScreenConstant
//                                                         .defaultHeightThirtyFive),
//                                                 child: Container(
//                                                   width:ScreenConstant.defaultHeightTwoHundred,
//                                                   child: Text(
//                                                     "Use Wallet (Balance: ₹${double.parse(_myBucketController.myBucketData.value.wallet!.balance.toString()).toStringAsFixed(2)})",
//                                                     style: TextStyle(
//                                                       fontSize:
//                                                           FontSizeStatic.mdSm,
//                                                       fontWeight: FontWeight.bold,
//                                                     ),
//                                                     overflow: TextOverflow.ellipsis,
//                                                   ),
//                                                 ),
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                     "Get ₹${double.parse(_myBucketController.myBucketData.value.wallet!.usable.toString()).toStringAsFixed(2)} off byusing your wallet balance",
//                                                     style: TextStyle(
//                                                         fontSize:
//                                                             FontSizeStatic.sm),
//                                                   ),
//                                                   GestureDetector(
//                                                       onTap: () {
//                                                         String type = ShareStore()
//                                                                     .getData(
//                                                                         store: KeyStore
//                                                                             .type) ==
//                                                                 null
//                                                             ? HiveStore().get(
//                                                                 Keys.shopType)
//                                                             : ShareStore().getData(
//                                                                 store: KeyStore
//                                                                     .type);
//
//                                                         // set up the AlertDialog
//                                                         AlertDialog alert =
//                                                             AlertDialog(
//                                                           title: Column(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceBetween,
//                                                             children: [
//                                                               Text(
//                                                                 "- You can use max ${double.parse(_myBucketController.myBucketData.value.wallet!.maxusagePer!).toStringAsFixed(2)}% of your wallet balance for $type category.",
//                                                                 style: TextStyles
//                                                                     .goPotuOfferSubTitle,
//                                                               ),
//                                                               Container(
//                                                                 height:
//                                                                     ScreenConstant
//                                                                         .sizeSmall,
//                                                               ),
//                                                               Text(
//                                                                 "- Max amount Rs.${double.parse(_myBucketController.myBucketData.value.wallet!.maxusageAllowed!).toStringAsFixed(2)} allowed to your order.",
//                                                                 style: TextStyles
//                                                                     .goPotuOfferSubTitle,
//                                                               ),
//                                                               Container(
//                                                                 height:
//                                                                     ScreenConstant
//                                                                         .sizeSmall,
//                                                               ),
//                                                               Text(
//                                                                 "- Usable amount Rs.${double.parse(_myBucketController.myBucketData.value.wallet!.usable!).toStringAsFixed(2)} for your order.",
//                                                                 style: TextStyles
//                                                                     .goPotuOfferSubTitle,
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         );
//
//                                                         // show the dialog
//                                                         showDialog(
//                                                           context: context,
//                                                           builder: (BuildContext
//                                                               context) {
//                                                             return alert;
//                                                           },
//                                                         );
//                                                       },
//                                                       child: Icon(
//                                                         Icons.info_outline,
//                                                         size: ScreenConstant
//                                                             .sizeLarge,
//                                                       ))
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                           // SizedBox(
//                                           //     width: ScreenConstant
//                                           //         .defaultHeightFour),
//                                           Padding(
//                                             padding: EdgeInsets.only(
//                                                 bottom: ScreenConstant
//                                                     .defaultHeightTen,),
//                                             child: Container(
//                                               width: ScreenConstant.defaultHeightSixty,
//                                               child: TextButton(
//                                                 onPressed: () {
//                                                   if (_myBucketController
//                                                       .myBucketData
//                                                       .value
//                                                       .defaultAddress!
//                                                       .deliverable!) {
//                                                     if (_myBucketController
//                                                         .isCouponApply.value) {
//                                                       // set up the buttons
//                                                       Widget cancelButton =
//                                                           TextButton(
//                                                         child: Text(
//                                                           "Cancel",
//                                                           style: TextStyle(
//                                                             color: AppColors
//                                                                 .accentColor,
//                                                             fontSize:
//                                                                 FontSizeStatic.md,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             fontFamily: 'Poppins',
//                                                           ),
//                                                         ),
//                                                         onPressed: () {
//                                                           Get.back();
//                                                         },
//                                                       );
//                                                       Widget continueButton =
//                                                           TextButton(
//                                                         child: Text(
//                                                           "Yes",
//                                                           style: TextStyle(
//                                                             color:
//                                                                 AppColors.primary,
//                                                             fontSize:
//                                                                 FontSizeStatic.md,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             fontFamily: 'Poppins',
//                                                           ),
//                                                         ),
//                                                         onPressed: () async {
//                                                           _myBucketController
//                                                                   .walletUsed
//                                                                   .value =
//                                                               !_myBucketController
//                                                                   .walletUsed
//                                                                   .value;
//                                                           _myBucketController
//                                                               .isCouponApply
//                                                               .value = false;
//                                                           _myBucketController
//                                                               .getBucketPress(
//                                                                   true, "");
//                                                           Get.back();
//                                                         },
//                                                       );
//
//                                                       // set up the AlertDialog
//                                                       AlertDialog alert =
//                                                           AlertDialog(
//                                                         title: Text(
//                                                           "Alert!",
//                                                           style: TextStyles
//                                                               .productPrice,
//                                                         ),
//                                                         content: Text(
//                                                           "Wallet balance cannot be combined with coupon discounts. You are using coupon discounts. After using your wallet balance, you will not be able to use a coupon discount for this order. Are you sure you want to replace it?",
//                                                           style: TextStyles
//                                                               .chooseCategorySubTitle,
//                                                         ),
//                                                         actions: [
//                                                           cancelButton,
//                                                           continueButton,
//                                                         ],
//                                                       );
//
//                                                       // show the dialog
//                                                       showDialog(
//                                                         context: context,
//                                                         builder: (BuildContext
//                                                             context) {
//                                                           return alert;
//                                                         },
//                                                       );
//                                                     } else {
//                                                       _myBucketController
//                                                               .walletUsed.value =
//                                                           !_myBucketController
//                                                               .walletUsed.value;
//                                                       _myBucketController
//                                                           .isCouponApply
//                                                           .value = false;
//                                                       _myBucketController
//                                                           .getBucketPress(
//                                                               true, "");
//                                                     }
//                                                   }
//                                                 },
//                                                 child: Text(
//                                                   "Apply",
//                                                   style: TextStyle(
//                                                       fontSize: FontSizeStatic.sm,
//                                                       color: Colors.green,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                   overflow: TextOverflow.ellipsis,
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: ScreenConstant.sizeExtraLarge,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           "Bill Details",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: FontSizeStatic.md),
//                                           overflow: TextOverflow.ellipsis,
//                                         )
//                                       ],
//                                     ),
//                                     // Padding(
//                                     //   padding: EdgeInsets.only(
//                                     //       right: ScreenConstant
//                                     //           .defaultHeightThreeHundread),
//                                     //   child: Container(
//                                     //     width:double.infinity,
//                                     //     child: Text(
//                                     //       "Bill Details",
//                                     //       style: TextStyle(
//                                     //           fontWeight: FontWeight.bold,
//                                     //           fontSize: FontSizeStatic.md),
//                                     //       overflow: TextOverflow.ellipsis,
//                                     //     ),
//                                     //   ),
//                                     // ),
//                                     SizedBox(
//                                       height: ScreenConstant.defaultWidthTwenty,
//                                     ),
//                                     Container(
//                                       width: defaultScreenWidth,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                             BorderRadius.circular(10.0),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.5),
//                                             blurRadius: 7,
//                                             offset: Offset(0, 3),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Column(
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                     top: ScreenConstant
//                                                         .defaultHeightTwentyfive,
//                                                     left: ScreenConstant
//                                                         .defaultHeightTwentyfive),
//                                                 child: Text(
//                                                   "Item Total",
//                                                   style: TextStyle(
//                                                       fontSize:
//                                                           FontSizeStatic.maxMd,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                   top: ScreenConstant
//                                                       .defaultHeightTwentyfive,
//                                                   right: ScreenConstant
//                                                       .defaultHeightTwentyfive,
//                                                 ),
//                                                 child: Text(
//                                                   "₹${_myBucketController.myBucketData.value!.itemTotal!}",
//                                                   style: TextStyle(
//                                                       fontSize:
//                                                           FontSizeStatic.maxMd,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: ScreenConstant
//                                                 .defaultHeightFour,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                   top: ScreenConstant
//                                                       .defaultHeightTwentyfive,
//                                                   left: ScreenConstant
//                                                       .defaultHeightTwentyfive,
//                                                 ),
//                                                 child: Text(
//                                                   "Delivery Fee For ${double.parse(_myBucketController.myBucketData.value.deliverychargeSettings!.deliveryDistance.toString()).toStringAsFixed(2)} kms",
//                                                   style: TextStyle(
//                                                     fontSize:
//                                                         FontSizeStatic.maxMd,
//                                                   ),
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                   top: ScreenConstant
//                                                       .defaultHeightTwentyfive,
//                                                   right: ScreenConstant
//                                                       .defaultHeightTwentyfive,
//                                                 ),
//                                                 child: Text(
//                                                   "₹${_myBucketController.myBucketData.value.deliveryCharge}",
//                                                   style: TextStyle(
//                                                     fontSize:
//                                                         FontSizeStatic.maxMd,
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           Visibility(
//                                             visible: selectedIndex != -1,
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                     top: ScreenConstant
//                                                         .defaultHeightTwentyfive,
//                                                     left: ScreenConstant
//                                                         .defaultHeightTwentyfive,
//                                                   ),
//                                                   child: Text(
//                                                     "Tips your Delivery partner",
//                                                     style: TextStyle(
//                                                       fontSize:
//                                                           FontSizeStatic.maxMd,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                       top: ScreenConstant
//                                                           .defaultHeightTwentyfive,
//                                                       right: ScreenConstant
//                                                           .defaultHeightTwentyfive),
//                                                   child: Text(
//                                                     "₹${10 + selectedIndex * 10}",
//                                                     style: TextStyle(
//                                                       fontSize:
//                                                           FontSizeStatic.maxMd,
//                                                     ),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                           // Row(
//                                           //   mainAxisAlignment:
//                                           //       MainAxisAlignment.spaceBetween,
//                                           //   children: [
//                                           //     Padding(
//                                           //       padding: EdgeInsets.only(
//                                           //         top: ScreenConstant
//                                           //             .defaultHeightTwentyfive,
//                                           //         left: ScreenConstant
//                                           //             .defaultHeightTwentyfive,
//                                           //       ),
//                                           //       child: Text(
//                                           //         "GST charges",
//                                           //         style: TextStyle(
//                                           //           fontSize:
//                                           //               FontSizeStatic.maxMd,
//                                           //         ),
//                                           //       ),
//                                           //     ),
//                                           //     Padding(
//                                           //       padding: EdgeInsets.only(
//                                           //           top: ScreenConstant
//                                           //               .defaultHeightTwentyfive,
//                                           //           right: ScreenConstant
//                                           //               .defaultHeightTwentyfive),
//                                           //       child: Text(
//                                           //         "₹100",
//                                           //         style: TextStyle(
//                                           //           fontSize:
//                                           //               FontSizeStatic.maxMd,
//                                           //         ),
//                                           //       ),
//                                           //     )
//                                           //   ],
//                                           // ),
//                                           SizedBox(
//                                             height: ScreenConstant
//                                                 .defaultHeightEight,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                     top: ScreenConstant
//                                                         .defaultHeightTwentyfive,
//                                                     left: ScreenConstant
//                                                         .defaultHeightTwentyfive),
//                                                 child: Text(
//                                                   "Grand Total",
//                                                   style: TextStyle(
//                                                       fontSize:
//                                                           FontSizeStatic.maxMd,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                     top: ScreenConstant
//                                                         .defaultHeightTwentyfive,
//                                                     right: ScreenConstant
//                                                         .defaultHeightTwentyfive),
//                                                 child: Text(
//                                                   "₹${(double.parse(_myBucketController.myBucketData.value.payableAmount!) + (selectedIndex != null ? 10 + selectedIndex * 10 : 0)).toStringAsFixed(2)}",
//                                                   style: TextStyle(
//                                                       fontSize:
//                                                           FontSizeStatic.maxMd,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: ScreenConstant
//                                                 .defaultWidthTwenty,
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: ScreenConstant.sizeExtraLarge,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           "Tips your delivery partner",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: FontSizeStatic.maxMd),
//                                         ),
//                                         Container(
//                                           height:
//                                               ScreenConstant.screenWidthFifteen,
//                                           width:
//                                               ScreenConstant.screenWidthFifteen,
//                                           child: Image.asset(
//                                               "assets/Group 111.png"),
//                                         )
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: ScreenConstant.defaultWidthTwenty,
//                                     ),
//                                     Container(
//                                       width: defaultScreenWidth,
//                                       height: ScreenConstant.defaultHeightOneThirty,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                             BorderRadius.circular(10.0),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.5),
//                                             blurRadius: 7,
//                                             offset: Offset(0, 3),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                     top: ScreenConstant
//                                                         .defaultHeightTwentyfive,
//                                                     left: ScreenConstant
//                                                         .defaultHeightTwentyfive),
//                                                 child: Container(
//                                                   width: ScreenConstant
//                                                       .defaultHeightTwoHundredTen,
//                                                   child: Container(
//                                                     width: ScreenConstant
//                                                         .defaultSizeThreeTwenty,
//                                                     child: Text(
//                                                       "Helping your delivery partners by conveniently tipping them. Your kindness means a lot ",
//                                                       style: TextStyle(
//                                                         fontSize: FontSizeStatic
//                                                             .semiSm,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height:
//                                                 ScreenConstant.defaultWidthTen,
//                                           ),
//                                           Row(
//                                             children: [
//                                               Row(
//                                                 children: List.generate(
//                                                   4,
//                                                   (index) => GestureDetector(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         selectedIndex =
//                                                             selectedIndex ==
//                                                                     index
//                                                                 ? -1
//                                                                 : index;
//                                                         int selectedTip =
//                                                             (selectedIndex ==
//                                                                     -1)
//                                                                 ? 0
//                                                                 : (selectedIndex +
//                                                                         1) *
//                                                                     10;
//                                                         _myBucketController
//                                                             .storeSelectedTip(
//                                                                 selectedTip);
//                                                       });
//                                                     },
//                                                     child: Padding(
//                                                       padding: EdgeInsets.only(
//                                                           left: ScreenConstant
//                                                               .defaultHeightTwentyThree), // Adjust as needed
//                                                       child: Container(
//                                                         width: ScreenConstant
//                                                             .defaultWidthSixty, // Adjust as needed
//                                                         height: ScreenConstant
//                                                             .defaultHeightThirtyFive, // Adjust as needed
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color: selectedIndex ==
//                                                                   index
//                                                               ? Color(
//                                                                   0xFF37B24B)
//                                                               : Colors.white,
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(6),
//                                                           border: Border.all(
//                                                               color:
//                                                                   Colors.grey),
//                                                           boxShadow: [
//                                                             BoxShadow(
//                                                               color: Colors.grey
//                                                                   .withOpacity(
//                                                                       0.5),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         child: Center(
//                                                           child: Text(
//                                                             selectedValue =
//                                                                 "₹${10 + index * 10}",
//                                                             style: TextStyle(
//                                                               fontSize: 14.0,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   selectedIndex ==
//                                                                           index
//                                                                       ? Colors
//                                                                           .white
//                                                                       : Colors
//                                                                           .black,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         height: ScreenConstant.sizeExtraLarge),
//                                     Row(
//                                       children: [
//                                         Container(
//                                           width: 327,
//                                           child: Text(
//                                             "Please review your order and address details to avoid cancellation ",
//                                             style: TextStyle(
//                                                 fontSize: FontSizeStatic.semiSm,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: ScreenConstant.defaultWidthTwenty,
//                                     ),
//                                     Container(
//                                       width: defaultScreenWidth,
//                                       height:
//                                           ScreenConstant.defaultHeightOneForty,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                             BorderRadius.circular(10.0),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.5),
//                                             blurRadius: 7,
//                                             offset: Offset(0, 3),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: ScreenConstant
//                                                     .defaultHeightTwentyfive,
//                                                 top: ScreenConstant
//                                                     .defaultHeightTwentyfive),
//                                             child: Row(
//                                               children: [
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                       bottom: ScreenConstant
//                                                           .defaultHeightTwentyThree),
//                                                   child: Text(
//                                                     "Note: ",
//                                                     style: TextStyle(
//                                                         fontSize:
//                                                             FontSizeStatic.mdSm,
//                                                         color: Colors.green,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Container(
//                                                       width: ScreenConstant
//                                                           .defaultHeightTwoHundredTen,
//                                                       child: Text(
//                                                         "If you cancel withipn 60 seconds of placing your order, you can get 100% refund. After 60 seconds no refund cancellation.",
//                                                         style: TextStyle(
//                                                           fontSize:
//                                                               FontSizeStatic.sm,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 )
//                                               ],
//                                             ),
//                                             // child: Container(
//                                             //   width: ScreenConstant
//                                             //       .defaultHeightTwoHundredTen,
//                                             //   child: Text(
//                                             //     "Please review your order and address details to avoid cancellation ",
//                                             //     style: TextStyle(
//                                             //         fontSize:
//                                             //             FontSizeStatic.lg,
//                                             //         fontWeight:
//                                             //             FontWeight.bold),
//                                             //   ),
//                                             // ),
//                                           ),
//                                           Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: ScreenConstant
//                                                     .defaultHeightTwentyfive,
//                                                 top: ScreenConstant
//                                                     .defaultWidthTen),
//                                             child: Row(
//                                               children: [
//                                                 Container(
//                                                   width: ScreenConstant
//                                                       .defaultHeightTwoHundredTen,
//                                                   child: Text(
//                                                     "Avoid cancellation as it results in item waste",
//                                                     style: TextStyle(
//                                                       fontSize:
//                                                           FontSizeStatic.sm,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: ScreenConstant.sizeMedium,
//                                                 top: ScreenConstant
//                                                     .defaultHeightFour),
//                                             child: Row(
//                                               children: [
//                                                 TextButton(
//                                                   onPressed: () {
//                                                     Get.to(
//                                                         CancelPolicyScreen());
//                                                   },
//                                                   child: Text(
//                                                     "READ GOPOTU CANCELLATION POLICY",
//                                                     style: TextStyle(
//                                                       decoration: TextDecoration
//                                                           .underline,
//                                                       fontSize:
//                                                           FontSizeStatic.sm,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: Colors.green,
//                                                     ),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                 bottomNavigationBar: _myBucketController.isLoading.value
//                     ? Container()
//                     : HiveStore().get(Keys.guestToken) == null
//                         ? Container(
//                             color: AppColors.secondary,
//                             height: ScreenConstant.defaultHeightOneThirty,
//                             child: Column(
//                               children: [
//                                 Container(
//                                   height: ScreenConstant.defaultHeightFifty,
//                                   width: screenWidth,
//                                   decoration: BoxDecoration(
//                                       border: Border.all(color: Colors.black)),
//                                   child: Center(
//                                     child: RichText(
//                                       text: TextSpan(
//                                         text: 'To receive ',
//                                         style: TextStyles.bottomOfferTitle,
//                                         children: <TextSpan>[
//                                           TextSpan(
//                                             text: 'Free delivery, ',
//                                             style: TextStyles.bottomOfferTitle
//                                                 .copyWith(
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                           ),
//                                           TextSpan(
//                                             text:
//                                                 'add products totaling at least 149',
//                                             style: TextStyles.bottomOfferTitle,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 // SizedBox(
//                                 //   height: ScreenConstant.defaultWidthTen,
//                                 // ),
//                                 // Divider(
//                                 //   thickness: 1,
//                                 // ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           _myBucketController
//                                                       .myBucketData
//                                                       .value
//                                                       .address!
//                                                       .fullAddress!
//                                                       .addressLine1 ==
//                                                   null
//                                               ? ""
//                                               : "",
//                                           style: TextStyles.yourPayableBill
//                                               .copyWith(
//                                                   color: _myBucketController
//                                                               .myBucketData
//                                                               .value
//                                                               .address!
//                                                               .fullAddress!
//                                                               .addressLine1 ==
//                                                           null
//                                                       ? AppColors.primary
//                                                       : AppColors
//                                                           .addressListWidgetContainsColor),
//                                         ),
//                                         Container(
//                                           height: ScreenConstant.sizeExtraSmall,
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(
//                                               bottom: ScreenConstant
//                                                   .defaultWidthTen),
//                                           child: Text(
//                                             "₹${(double.parse(_myBucketController.myBucketData.value.payableAmount!) + (selectedIndex != null ? 10 + selectedIndex * 10 : 0)).toStringAsFixed(2)}",
//                                             style: TextStyle(
//                                                 fontSize: FontSizeStatic.xxl,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                         Text(
//                                           "View Details Bill",
//                                           style: TextStyle(
//                                               fontSize: FontSizeStatic.maxMd,
//                                               color: Colors.green,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                     Container(
//                                       width: ScreenConstant.sizeMedium,
//                                     ),
//                                     Obx(
//                                       () => Padding(
//                                         padding: EdgeInsets.only(
//                                             top: ScreenConstant
//                                                 .screenWidthFifteen),
//                                         child: AppButton(
//                                           width: ScreenConstant
//                                               .defaultWidthOneSeventy,
//                                           color: Color(0xFF37B24B),
//                                           buttonText: "Procced To Pay",
//                                           onPressed: _myBucketController
//                                                   .myBucketData
//                                                   .value
//                                                   .defaultAddress!
//                                                   .deliverable!
//                                               ? _myBucketController
//                                                           .paymentMode.value ==
//                                                       "cash"
//                                                   ? () {
//                                                       if (_myBucketController
//                                                               .myBucketData
//                                                               .value
//                                                               .address!
//                                                               .fullAddress!
//                                                               .addressLine1 ==
//                                                           null) {
//                                                         // Fluttertoast.showToast(msg: 'Change the address');
//                                                         _showAddressBottomSheet();
//                                                         return;
//                                                       }
//
//                                                       _myBucketController
//                                                           .makeOrderInCashPress(
//                                                         _myBucketController
//                                                             .myBucketData
//                                                             .value
//                                                             .items![0]
//                                                             .shopId
//                                                             .toString(),
//                                                         _myBucketController
//                                                             .myBucketData
//                                                             .value
//                                                             .defaultAddress!
//                                                             .id
//                                                             .toString(),
//                                                         _myBucketController
//                                                                     .myBucketData
//                                                                     .value
//                                                                     ?.couponDetails
//                                                                     ?.code ==
//                                                                 null
//                                                             ? ""
//                                                             : _myBucketController
//                                                                 .myBucketData
//                                                                 .value
//                                                                 .couponDetails!
//                                                                 .code
//                                                                 .toString(),
//                                                       );
//                                                       //Get.offAllNamed(orderPlaced);
//                                                       //showBottomSheetTime(context);
//                                                     }
//                                                   : () {
//                                                       if (_myBucketController
//                                                               .myBucketData
//                                                               .value
//                                                               .address!
//                                                               .fullAddress!
//                                                               .addressLine1 ==
//                                                           null) {
//                                                         // Fluttertoast.showToast(msg: 'Change the address');
//                                                         _showAddressBottomSheet();
//                                                         return;
//                                                       }
//
//                                                       _myBucketController
//                                                           .makeOrderInOnlinePress(
//                                                         _myBucketController
//                                                             .myBucketData
//                                                             .value
//                                                             .items![0]
//                                                             .shopId
//                                                             .toString(),
//                                                         _myBucketController
//                                                             .myBucketData
//                                                             .value
//                                                             .defaultAddress!
//                                                             .id
//                                                             .toString(),
//                                                       );
//                                                     }
//                                               : null,
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           )
//                         : Container(
//                             color: AppColors.secondary,
//                             height: ScreenConstant.defaultHeightSeventy,
//                             child: Padding(
//                               padding: const EdgeInsets.all(15.0),
//                               child: AppButton(
//                                 onPressed: () {
//                                   final AddressController _addressController =
//                                       Get.put(AddressController());
//                                   _addressController.isCheckOutPage.value =
//                                       false;
//                                   Get.to(SignIn());
//                                 },
//                                 buttonText: "PLEASE LOGIN TO CONTINUE",
//                               ),
//                             ),
//                           ),
//               ),
//             );
//     });
//   }
//
//   showBottomSheetTime(BuildContext context) {
//     showBarModalBottomSheet(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(20), topLeft: Radius.circular(20))),
//         backgroundColor: AppColors.secondary,
//         topControl: Container(
//           decoration: BoxDecoration(
//               color: AppColors.accentColor,
//               borderRadius: BorderRadius.circular(40)),
//           child: GestureDetector(
//               onTap: () {
//                 Get.back();
//               },
//               child: Icon(
//                 Icons.cancel,
//                 color: AppColors.secondary,
//                 size: ScreenConstant.sizeXXL,
//               )),
//         ),
//         context: context,
//         builder: (context) {
//           return ScheduleScreen();
//         });
//   }
//
//   void _showAddressBottomSheet() {
//     final AddressController _addressController = Get.put(AddressController());
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(46.0),
//           topRight: Radius.circular(46.0),
//         ),
//       ),
//       builder: (BuildContext context) {
//         return Container(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context)
//                 .viewInsets
//                 .bottom, // Adjust padding for the keyboard
//             left: 16.0,
//             right: 16.0,
//             top: 16.0,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "Fill Address Data for Current Address",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold, fontSize: FontSizeStatic.lg),
//               ),
//               SizedBox(height: ScreenConstant.sizeLarge),
//               // TextField(
//               //   decoration: InputDecoration(labelText: 'Address Line 1'),
//               // ),
//               // SizedBox(height: ScreenConstant.sizeLarge),
//               RequireTextField(
//                 controller: _addressController.villageNameController,
//                 type: Type.addressLine,
//                 hintText: "Address Line 1",
//               ),
//               SizedBox(height: ScreenConstant.sizeLarge),
//               RequireTextField(
//                 controller: _addressController.landMarkController,
//                 type: Type.landmark,
//                 hintText: "LandMark",
//               ),
//               SizedBox(height: ScreenConstant.sizeLarge),
//               ElevatedButton(
//                 onPressed: () async {
//                   // Perform any actions here when the submit button is pressed
//                   _addressController.billNameController.text =
//                       _myBucketController
//                           .myBucketData.value.defaultAddress!.name!;
//                   _addressController.mobileController.text = _myBucketController
//                       .myBucketData.value.defaultAddress!.mobile!;
//                   _addressController.location.text = _myBucketController
//                       .myBucketData.value.defaultAddress!.location!;
//                   _addressController.city.value = _myBucketController
//                       .myBucketData.value.address!.fullAddress!.city!;
//                   _addressController.country.value = _myBucketController
//                       .myBucketData.value.address!.fullAddress!.country!;
//                   _addressController.postalCodeController.text =
//                       _myBucketController
//                           .myBucketData.value.address!.fullAddress!.postalCode!;
//                   _addressController.lat.value = double.parse(
//                       _myBucketController
//                           .myBucketData.value.defaultAddress!.latitude!);
//                   _addressController.lng.value = double.parse(
//                       _myBucketController
//                           .myBucketData.value.defaultAddress!.longitude!);
//                   _addressController.state.value = _myBucketController
//                       .myBucketData.value.address!.fullAddress!.state!;
//                   _addressController.addressType.value = "current";
//
//                   if (_addressController.landMarkController.text.isNotEmpty &&
//                       _addressController
//                           .villageNameController.text.isNotEmpty) {
//                     // Your existing button logic here
//
//                     _addressController.isCheckOutPage.value = true;
//                     _addressController.addCurrentAddressApiCall();
//
//                     // Close the bottom sheet
//                     // Navigator.pop(context);
//                   } else {
//                     Fluttertoast.showToast(msg: 'Fill Data Properly');
//                   }
//                   // Close the bottom sheet
//                 },
//                 child: Text('Submit'),
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(AppColors
//                       .buttonColorSecondary), // Change to your desired color
//                 ),
//               ),
//               SizedBox(height: ScreenConstant.sizeLarge),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddressController/AddressController.dart';
import 'package:go_potu_user/Controller/MyBucketController/MyBucketController.dart';
import 'package:go_potu_user/Controller/ProductController/ProductController.dart';
import 'package:go_potu_user/Controller/StoreController/StoreController.dart';
import 'package:go_potu_user/Controller/SubCategoryController/SubCategoryController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/NoResult.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ScopeStorage.dart';
import 'package:go_potu_user/Store/ShareStore.dart';
import 'package:go_potu_user/Views/CartScreen/ScheduleScreen.dart';
import 'package:go_potu_user/Views/SignInScreen/SignIn.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';
import 'package:go_potu_user/Widgets/CartWidgets/CartProductListWidget.dart';
import 'package:go_potu_user/Widgets/StoreWidgets/StoreListWidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../Widgets/TextFieldWidgets/RequireTextField.dart';
import '../AddressScreens/SelectAddress.dart';
import '../CompanyScreens/CancelPolicyScreen.dart';
import 'PromoApplyScreen.dart';

class CheckOutPage extends StatefulWidget {
  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final MyBucketController _myBucketController = Get.put(MyBucketController());
  final OrderListController _orderListController = Get.put(OrderListController());
  final AddressController _addressController = Get.put(AddressController());
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

  Future _refreshData() async {
    //await Future.delayed(Duration(seconds: 1));
    _myBucketController.getBucketPress(false, "");
  }
  int selectedIndex = -1;
  String selectedValue = '';
  Future<bool> _onBackPressed() {
    _myBucketController.isLoading.value = true;
    if (_myBucketController.isStoreDetails.value) {
      StoreController storeController = Get.find();
      storeController.storeDetailsPress(true);
      _myBucketController.isStoreDetails.value = false;
      Get.back();
    } else if (_myBucketController.subCategoryProductList.value) {
      SubCategoryController subCategoryController = Get.find();
      if (subCategoryController.allTap.value) {
        subCategoryController.loadProductListPress(
            subCategoryController.categoryParentId.toString(), true);
      } else {
        subCategoryController.loadProductListPress(
            subCategoryController.subcategoryId.toString(), true);
      }

      _myBucketController.subCategoryProductList.value = false;
      Get.back();
    } else if (_myBucketController.productDetails.value) {
      ProductController _productController = Get.find();
      Future.delayed(Duration(milliseconds: 100), () {
        _productController.productDetailsPress(false);
      });
      _productController.isLoading.value = true;
      _myBucketController.productDetails.value = false;
      Get.back();
    } else {
      Get.offAllNamed(dashBoard);
    }
    return Future.value(false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _myBucketController.isLoading.value = true;
  }
  Widget _buildLeading(BuildContext context) {
    final ModalRoute<Object?>? modalRoute = ModalRoute.of(context);

    // Show back button only when there's a route to pop
    if (modalRoute?.canPop ?? false) {
      return IconButton(
        icon: Icon(
          Icons.chevron_left,
          color: Colors.black,
          size: ScreenConstant.sizeXL,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }

    // No route to pop, return an empty container to not show any leading widget
    return Container(width: 0, height: 0);
  }
  @override
  Widget build(BuildContext context) {
    _myBucketController.paymentMode.value = "cash";
    return GetX<MyBucketController>(initState: (state) {
      Get.find<MyBucketController>().getBucketPress(true, "");
    }, builder: (_) {
      return _myBucketController.myBucketData.value.itemTotal == null ||
              _myBucketController.myBucketData.value.itemTotal == "0.00"
          ? WillPopScope(
              onWillPop: _onBackPressed,
              child: Scaffold(
                backgroundColor: AppColors.secondary,
                appBar: AppBar(
                  /*leading: BackButton(
                    onPressed: _onBackPressed,
                  ),*/
                  centerTitle: true,
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  title: Text(
                    AppStrings.MyBasket,
                    style: TextStyles.appBarTitle,
                  ),
                  actions: [
                    GestureDetector(
                      onTap: HiveStore().get(Keys.guestToken) == null
                          ? () {
                              Get.back();
                              Get.toNamed(notifications);
                            }
                          : () {
                              Get.to(SignIn());
                            },
                      child: Icon(Icons.notifications),
                    ),
                    Container(
                      width: ScreenConstant.sizeMedium,
                    ),
                  ],
                ),
                body: _myBucketController.isLoading.value
                    ? Container()
                    : Container(
                        child: Center(
                            child: NoResult(
                          titleText: "Sorry no item found!",
                          subTitle: "",
                        )),
                      ),
              ),
            )
          : WillPopScope(
              onWillPop: _onBackPressed,
              child: Scaffold(
                backgroundColor: Color(0xFFF0F0F0),
       appBar:   AppBar(
          leading:  _buildLeading(context),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
      "Cart",
      style: TextStyle(
      fontSize: FontSizeStatic.xxl,
      fontWeight: FontWeight.bold,
      color: Colors.black),
      ),
       ),     //drawer: DrawerFile(),
                body: _myBucketController.isLoading.value
                    ? Container()
                    : RefreshIndicator(
                  onRefresh: _refreshData,
                  child: ListView(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: [
                      Container(
                        child: Padding(
                          padding:
                          EdgeInsets.all(ScreenConstant.sizeLarge),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      ScreenConstant.defaultWidthTen),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenConstant.sizeSmall,
                                      bottom: ScreenConstant.sizeSmall,
                                  left: 60),
                                  child: Center(
                                    child: Row(
                                      // mainAxisAlignment:
                                      // MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          size: ScreenConstant.sizeXXL,
                                          color: Colors.green,
                                        ),
                                        Text(
                                          'Deliver in 30mins to Home',
                                          style: TextStyle(
                                              fontSize:
                                              FontSizeStatic.semiSm,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // Container(
                                        //   height: ScreenConstant
                                        //       .defaultHeightForty, // Adjust the height of the line as needed
                                        //   width:
                                        //   1, // Adjust the width of the line as needed
                                        //   color: Colors.black,
                                        // ),
                                        // Container(
                                        //   width:ScreenConstant.defaultHeightOneHundredFifty,
                                        //   child: Row(
                                        //     children: [
                                        //       Container(
                                        //         width:ScreenConstant.defaultHeightEightyTwo,
                                        //         child: Text(
                                        //           _myBucketController
                                        //               .myBucketData
                                        //               .value
                                        //               .defaultAddress!
                                        //               .location ??
                                        //               "",
                                        //           style: TextStyle(
                                        //               fontSize: FontSizeStatic.md,
                                        //               fontWeight: FontWeight.bold),
                                        //           overflow: TextOverflow.ellipsis,
                                        //         ),
                                        //       ),
                                        //       Container(width:ScreenConstant.defaultWidthTen),
                                        //       Icon(
                                        //         Icons.location_on,
                                        //         color: Colors.green,
                                        //         size: ScreenConstant.sizeXXL,
                                        //       )
                                        //     ],
                                        //   ),
                                        // ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: ScreenConstant.sizeExtraLarge,
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withOpacity(0.5),
                                          blurRadius: 7,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Container(
                                            color: AppColors.secondary,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                top: ScreenConstant
                                                    .sizeMedium,
                                                left: ScreenConstant
                                                    .sizeMedium,
                                                right: ScreenConstant
                                                    .sizeMedium,
                                              ),
                                              child: Center(
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                  ClampingScrollPhysics(),
                                                  itemCount:
                                                  _myBucketController
                                                      .myBucketData
                                                      .value
                                                      .items!
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return CartProductListWidget(
                                                      isDeliverable:
                                                      _myBucketController
                                                          .myBucketData
                                                          .value
                                                          .defaultAddress!
                                                          .deliverable,
                                                      items:
                                                      _myBucketController
                                                          .myBucketData
                                                          .value
                                                          .items,
                                                      index: index,
                                                      isCouponCode:
                                                      _myBucketController
                                                          .myBucketData
                                                          .value
                                                          ?.couponDetails
                                                          ?.code ??
                                                          "",
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: ScreenConstant
                                                .sizeExtraSmall,
                                          ),
                                          // Divider(
                                          //   color: Colors.black,
                                          // ),
                                          // Padding(
                                          //   padding: EdgeInsets.only(
                                          //     left: ScreenConstant
                                          //         .defaultWidthTwenty,
                                          //     top: ScreenConstant
                                          //         .defaultWidthTen,
                                          //     bottom: ScreenConstant
                                          //         .defaultWidthTen,
                                          //   ),
                                          //   // onTap: () {
                                          //   //   StoreController storeController = Get.find();
                                          //   //
                                          //   //   // Check if storeId is not null before converting it to a string
                                          //   //   String? storeId = storeController.shop_id?.toString();
                                          //   //
                                          //   //   if (storeId != null) {
                                          //   //     storeController.storeDetailsPress(true);
                                          //   //     Get.toNamed('/storeDetails', arguments: {'id': storeId});
                                          //   //   } else {
                                          //   //     // Handle the case where storeId is null
                                          //   //     print('storeController.storeId is null');
                                          //   //   }
                                          //   // },
                                          //   child: GestureDetector(
                                          //
                                          //     // onTap: () {
                                          //     //   StoreController _storeController = Get.find();
                                          //     //
                                          //     //   // Check if storeId is not null before converting it to a string
                                          //     //   String? storeId = _storeController.shop_id?.toString();
                                          //     //
                                          //     //   if (storeId != null) {
                                          //     //     storeController.storeDetailsPress(true);
                                          //     //     Get.toNamed('/storeDetails', arguments: {'id': storeId});
                                          //     //   } else {
                                          //     //     // Handle the case where storeId is null
                                          //     //     print('storeController.storeId is null');
                                          //     //   }
                                          //     // },
                                          //
                                          //
                                          //
                                          //     child: Container(
                                          //       child: Row(
                                          //         children: [
                                          //           Icon(Icons.add),
                                          //           SizedBox(
                                          //             width: ScreenConstant
                                          //                 .sizeSmall,
                                          //           ),
                                          //           Text("Add more items",
                                          //               style: TextStyle(
                                          //                 fontSize:
                                          //                 FontSizeStatic
                                          //                     .semiSm,
                                          //               )),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          // Divider(
                                          //   color: Colors.black,
                                          // ),
                                          // Padding(
                                          //   padding: EdgeInsets.only(
                                          //       left: ScreenConstant
                                          //           .defaultHeightTwentyeight),
                                          //   child: Row(
                                          //     children: [
                                          //       Text("Add description",
                                          //           style: TextStyle(
                                          //             fontSize:
                                          //                 FontSizeStatic
                                          //                     .semiSm,
                                          //           )),
                                          //       SizedBox(
                                          //           width: ScreenConstant
                                          //               .defaultWidthOneEighty),
                                          //       Container(
                                          //         width: ScreenConstant
                                          //             .sizeLarge,
                                          //         height: ScreenConstant
                                          //             .defaultHeightFiftyFive,
                                          //         decoration:
                                          //             BoxDecoration(
                                          //           color: Colors.white,
                                          //           shape:
                                          //               BoxShape.circle,
                                          //           border: Border.all(
                                          //             color: Colors.black,
                                          //             width: 2.0,
                                          //           ),
                                          //         ),
                                          //         child: Center(
                                          //           child: Icon(
                                          //             Icons.add,
                                          //             color: Colors.black,
                                          //             size: FontSizeStatic
                                          //                 .lg,
                                          //           ),
                                          //         ),
                                          //       )
                                          //     ],
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: ScreenConstant.defaultWidthTen,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Apply Offer",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizeStatic.md),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: ScreenConstant.defaultHeightFifteen,
                              ),
                              Container(
                                width: ScreenConstant
                                    .defaultHeightFiveHundred,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      ScreenConstant.defaultWidthTen),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: ScreenConstant
                                            .defaultWidthTen,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: ScreenConstant
                                                .defaultHeightFifty,
                                            width: ScreenConstant
                                                .defaultHeightFifty,
                                            child: Image.asset(
                                                "assets/offer.png"),
                                          ),
                                          SizedBox(
                                            width:
                                            ScreenConstant.sizeSmall,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: ScreenConstant
                                                    .defaultWidthTen),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                    top: ScreenConstant
                                                        .defaultHeightTwentyeight,
                                                  ),
                                                  child: Text(
                                                    "AVAILABLE OFFERS",
                                                    style: TextStyle(
                                                      fontSize:
                                                      FontSizeStatic
                                                          .md,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: ScreenConstant
                                                        .defaultHeightEight),
                                                Text(
                                                  "Save ${double.parse(_myBucketController.myBucketData.value.couponDiscount!).toStringAsFixed(2)} on this order",
                                                  style: TextStyle(
                                                    fontSize:
                                                    FontSizeStatic.sm,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: ScreenConstant
                                                .defaultHeightEightyTwo,
                                          ),
                                          // TextButton(
                                          //     onPressed: () {
                                          //       _myBucketController
                                          //           .applyCouponPress(
                                          //               _myBucketController
                                          //                   .thisController
                                          //                   .text);
                                          //     },
                                          //     child: Text(
                                          //       "Apply",
                                          //       style: TextStyle(
                                          //           fontSize:
                                          //               FontSizeStatic.lg,
                                          //           color: Colors.green,
                                          //           fontWeight:
                                          //               FontWeight.bold),
                                          //     )),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Container(
                                      height: ScreenConstant
                                          .defaultHeightFortyFive,
                                      child: GestureDetector(
                                        onTap: HiveStore().get(
                                            Keys.guestToken) ==
                                            null
                                            ? _myBucketController
                                            .myBucketData
                                            .value
                                            .defaultAddress!
                                            .deliverable!
                                            ? () {
                                          if (_myBucketController
                                              .walletUsed
                                              .value) {
                                            // set up the buttons
                                            Widget
                                            cancelButton =
                                            TextButton(
                                              child: Text(
                                                "Cancel",
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
                                                    /*'Proxima-Bold'*/ 'Poppins'),
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              },
                                            );
                                            Widget
                                            continueButton =
                                            TextButton(
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                    color: AppColors
                                                        .primary,
                                                    fontSize:
                                                    FontSizeStatic
                                                        .md,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontFamily:
                                                    /*'Proxima-Bold'*/ 'Poppins'),
                                              ),
                                              onPressed: () {
                                                print("press");
                                                Get.back();
                                                _myBucketController
                                                    .context =
                                                    context;
                                                print(
                                                    "${_myBucketController.myBucketData.value?.couponDetails?.code}");
                                                Get.to(
                                                    PromoApplyScreen(
                                                      couponCode: _myBucketController
                                                          .myBucketData
                                                          .value
                                                          ?.couponDetails
                                                          ?.code ??
                                                          "empty",
                                                      couponsList:
                                                      _myBucketController
                                                          .myBucketData
                                                          .value
                                                          .availableCoupons,
                                                    ));
                                                _myBucketController
                                                    .walletUsed
                                                    .value = false;
                                              },
                                            );

                                            // set up the AlertDialog
                                            AlertDialog alert =
                                            AlertDialog(
                                              title: Text(
                                                "Alert!",
                                                style: TextStyles
                                                    .productPrice,
                                              ),
                                              content: Text(
                                                "Coupon discounts cannot be combined with wallet balance. You are using wallet balance. After applying any coupon discount,you will not be able to use wallet balance for this order. Are you sure you want to replace it?",
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
                                                  (BuildContext
                                              context) {
                                                return alert;
                                              },
                                            );
                                          } else {
                                            _myBucketController
                                                .context =
                                                context;
                                            print(
                                                "${_myBucketController.myBucketData.value?.couponDetails?.code}");
                                            Get.to(
                                                PromoApplyScreen(
                                                  couponCode: _myBucketController
                                                      .myBucketData
                                                      .value
                                                      ?.couponDetails
                                                      ?.code ??
                                                      "empty",
                                                  couponsList:
                                                  _myBucketController
                                                      .myBucketData
                                                      .value
                                                      .availableCoupons,
                                                ));
                                          }
                                        }
                                            : () {}
                                            : () {
                                          Get.snackbar("Sorry!",
                                              "Please login to continue",
                                              backgroundColor:
                                              AppColors
                                                  .secondary,
                                              icon: Icon(
                                                Icons
                                                    .error_outline_sharp,
                                                color: Colors.red,
                                              ));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenConstant
                                                  .defaultWidthEighteen),
                                          child: Text(
                                            "View More Coupons >",
                                            style: TextStyle(
                                                fontSize:
                                                FontSizeStatic.maxMd,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenConstant.defaultWidthTen,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Wallet",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizeStatic.md),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: ScreenConstant.defaultWidthTen,
                              ),
                              Container(
                                width: defaultScreenWidth,
                                height: ScreenConstant
                                    .defaultWidthNinetyEight,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      ScreenConstant.defaultWidthTen),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: ScreenConstant
                                            .defaultWidthTwenty,
                                      ),
                                      child: Icon(
                                        Icons.wallet,
                                        size: FontSizeStatic.xxxl,
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenConstant.sizeSmall,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenConstant
                                                  .defaultHeightThirtyFive),
                                          child: Container(
                                            width:ScreenConstant.defaultHeightTwoHundred,
                                            child: Text(
                                              "Use Wallet (Balance: ₹${double.parse(_myBucketController.myBucketData.value.wallet!.balance.toString()).toStringAsFixed(2)})",
                                              style: TextStyle(
                                                fontSize:
                                                FontSizeStatic.mdSm,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Get ₹${double.parse(_myBucketController.myBucketData.value.wallet!.usable.toString()).toStringAsFixed(2)} off byusing your wallet balance",
                                              style: TextStyle(
                                                  fontSize:
                                                  FontSizeStatic.sm),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  String type = ShareStore()
                                                      .getData(
                                                      store: KeyStore
                                                          .type) ==
                                                      null
                                                      ? HiveStore().get(
                                                      Keys.shopType)
                                                      : ShareStore().getData(
                                                      store: KeyStore
                                                          .type);

                                                  // set up the AlertDialog
                                                  AlertDialog alert =
                                                  AlertDialog(
                                                    title: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "- You can use max ${double.parse(_myBucketController.myBucketData.value.wallet!.maxusagePer!).toStringAsFixed(2)}% of your wallet balance for $type category.",
                                                          style: TextStyles
                                                              .goPotuOfferSubTitle,
                                                        ),
                                                        Container(
                                                          height:
                                                          ScreenConstant
                                                              .sizeSmall,
                                                        ),
                                                        Text(
                                                          "- Max amount Rs.${double.parse(_myBucketController.myBucketData.value.wallet!.maxusageAllowed!).toStringAsFixed(2)} allowed to your order.",
                                                          style: TextStyles
                                                              .goPotuOfferSubTitle,
                                                        ),
                                                        Container(
                                                          height:
                                                          ScreenConstant
                                                              .sizeSmall,
                                                        ),
                                                        Text(
                                                          "- Usable amount Rs.${double.parse(_myBucketController.myBucketData.value.wallet!.usable!).toStringAsFixed(2)} for your order.",
                                                          style: TextStyles
                                                              .goPotuOfferSubTitle,
                                                        ),
                                                      ],
                                                    ),
                                                  );

                                                  // show the dialog
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                    context) {
                                                      return alert;
                                                    },
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.info_outline,
                                                  size: ScreenConstant
                                                      .defaultWidthTen,
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                    // SizedBox(
                                    //     width: ScreenConstant
                                    //         .defaultHeightFour),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: ScreenConstant
                                            .defaultHeightTen,),
                                      child: Container(
                                        width: ScreenConstant.defaultHeightSixty,
                                        child: TextButton(
                                          onPressed: () {
                                            if (_myBucketController
                                                .myBucketData
                                                .value
                                                .defaultAddress!
                                                .deliverable!) {
                                              if (_myBucketController
                                                  .isCouponApply.value) {
                                                // set up the buttons
                                                Widget cancelButton =
                                                TextButton(
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .accentColor,
                                                      fontSize:
                                                      FontSizeStatic.md,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                );
                                                Widget continueButton =
                                                TextButton(
                                                  child: Text(
                                                    "Yes",
                                                    style: TextStyle(
                                                      color:
                                                      AppColors.primary,
                                                      fontSize:
                                                      FontSizeStatic.md,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    _myBucketController
                                                        .walletUsed
                                                        .value =
                                                    !_myBucketController
                                                        .walletUsed
                                                        .value;
                                                    _myBucketController
                                                        .isCouponApply
                                                        .value = false;
                                                    _myBucketController
                                                        .getBucketPress(
                                                        true, "");
                                                    Get.back();
                                                  },
                                                );

                                                // set up the AlertDialog
                                                AlertDialog alert =
                                                AlertDialog(
                                                  title: Text(
                                                    "Alert!",
                                                    style: TextStyles
                                                        .productPrice,
                                                  ),
                                                  content: Text(
                                                    "Wallet balance cannot be combined with coupon discounts. You are using coupon discounts. After using your wallet balance, you will not be able to use a coupon discount for this order. Are you sure you want to replace it?",
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
                                                  builder: (BuildContext
                                                  context) {
                                                    return alert;
                                                  },
                                                );
                                              } else {
                                                _myBucketController
                                                    .walletUsed.value =
                                                !_myBucketController
                                                    .walletUsed.value;
                                                _myBucketController
                                                    .isCouponApply
                                                    .value = false;
                                                _myBucketController
                                                    .getBucketPress(
                                                    true, "");
                                              }
                                            }
                                          },
                                          child: Text(
                                            "Apply",
                                            style: TextStyle(
                                                fontSize: FontSizeStatic.sm,
                                                color: Colors.green,
                                                fontWeight:
                                                FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenConstant.defaultWidthTen,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Bill Details",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizeStatic.md),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(
                              //       right: ScreenConstant
                              //           .defaultHeightThreeHundread),
                              //   child: Container(
                              //     width:double.infinity,
                              //     child: Text(
                              //       "Bill Details",
                              //       style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: FontSizeStatic.md),
                              //       overflow: TextOverflow.ellipsis,
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                height: ScreenConstant.defaultWidthTen,
                              ),
                              Container(
                                width: defaultScreenWidth,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenConstant
                                                  .defaultHeightTwentyfive,
                                              left: ScreenConstant
                                                  .defaultHeightTwentyfive),
                                          child: Text(
                                            "Item Total",
                                            style: TextStyle(
                                                fontSize:
                                                FontSizeStatic.maxMd,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: ScreenConstant
                                                .defaultHeightTwentyfive,
                                            right: ScreenConstant
                                                .defaultHeightTwentyfive,
                                          ),
                                          child: Text(
                                            "₹${_myBucketController.myBucketData.value!.itemTotal!}",
                                            style: TextStyle(
                                                fontSize:
                                                FontSizeStatic.maxMd,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: ScreenConstant
                                          .defaultHeightFour,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: ScreenConstant
                                                .defaultHeightTwentyfive,
                                            left: ScreenConstant
                                                .defaultHeightTwentyfive,
                                          ),
                                          child: Text(
                                            "Delivery Fee For ${double.parse(_myBucketController.myBucketData.value.deliverychargeSettings!.deliveryDistance.toString()).toStringAsFixed(2)} kms",
                                            style: TextStyle(
                                              fontSize:
                                              FontSizeStatic.maxMd,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: ScreenConstant
                                                .defaultHeightTwentyfive,
                                            right: ScreenConstant
                                                .defaultHeightTwentyfive,
                                          ),
                                          child: Text(
                                            "₹${_myBucketController.myBucketData.value.deliveryCharge}",
                                            style: TextStyle(
                                              fontSize:
                                              FontSizeStatic.maxMd,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Visibility(
                                      visible: _myBucketController.myBucketData.value.couponDiscount != null &&
                                          double.parse(_myBucketController.myBucketData.value.couponDiscount!) > 0.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: ScreenConstant
                                                  .defaultHeightTwentyfive,
                                              left: ScreenConstant
                                                  .defaultHeightTwentyfive,
                                            ),
                                            child: Text(
                                              "You Have Applied Coupon",
                                              style: TextStyle(
                                                fontSize:
                                                FontSizeStatic.maxMd,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: ScreenConstant
                                                  .defaultHeightTwentyfive,
                                              right: ScreenConstant
                                                  .defaultHeightTwentyfive,
                                            ),
                                            child: Text(
                                              "₹${double.parse(_myBucketController.myBucketData.value.couponDiscount!).toStringAsFixed(2)}",
                                              style: TextStyle(
                                                fontSize:
                                                FontSizeStatic.maxMd,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: _myBucketController.myBucketData.value.walletDeduct != null &&
                                          double.parse(_myBucketController.myBucketData.value.walletDeduct!) > 0.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: ScreenConstant
                                                  .defaultHeightTwentyfive,
                                              left: ScreenConstant
                                                  .defaultHeightTwentyfive,
                                            ),
                                            child: Text(
                                              "Your Wallet Deduct",
                                              style: TextStyle(
                                                fontSize:
                                                FontSizeStatic.maxMd,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: ScreenConstant
                                                  .defaultHeightTwentyfive,
                                              right: ScreenConstant
                                                  .defaultHeightTwentyfive,
                                            ),
                                            child: Text(
                                              "₹${double.parse(_myBucketController.myBucketData.value.walletDeduct!).toStringAsFixed(2)}",
                                              style: TextStyle(
                                                fontSize:
                                                FontSizeStatic.maxMd,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
,

                                    Visibility(
                                      visible: selectedIndex != -1,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: ScreenConstant
                                                  .defaultHeightTwentyfive,
                                              left: ScreenConstant
                                                  .defaultHeightTwentyfive,
                                            ),
                                            child: Text(
                                              "Tips your Delivery partner",
                                              style: TextStyle(
                                                fontSize:
                                                FontSizeStatic.maxMd,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenConstant
                                                    .defaultHeightTwentyfive,
                                                right: ScreenConstant
                                                    .defaultHeightTwentyfive),
                                            child: Text(
                                              "₹${10 + selectedIndex * 10}",
                                              style: TextStyle(
                                                fontSize:
                                                FontSizeStatic.maxMd,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Padding(
                                    //       padding: EdgeInsets.only(
                                    //         top: ScreenConstant
                                    //             .defaultHeightTwentyfive,
                                    //         left: ScreenConstant
                                    //             .defaultHeightTwentyfive,
                                    //       ),
                                    //       child: Text(
                                    //         "GST charges",
                                    //         style: TextStyle(
                                    //           fontSize:
                                    //               FontSizeStatic.maxMd,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     Padding(
                                    //       padding: EdgeInsets.only(
                                    //           top: ScreenConstant
                                    //               .defaultHeightTwentyfive,
                                    //           right: ScreenConstant
                                    //               .defaultHeightTwentyfive),
                                    //       child: Text(
                                    //         "₹100",
                                    //         style: TextStyle(
                                    //           fontSize:
                                    //               FontSizeStatic.maxMd,
                                    //         ),
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                    SizedBox(
                                      height: ScreenConstant
                                          .defaultHeightEight,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenConstant
                                                  .defaultHeightTwentyfive,
                                              left: ScreenConstant
                                                  .defaultHeightTwentyfive),
                                          child: Text(
                                            "Grand Total",
                                            style: TextStyle(
                                                fontSize:
                                                FontSizeStatic.maxMd,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenConstant
                                                  .defaultHeightTwentyfive,
                                              right: ScreenConstant
                                                  .defaultHeightTwentyfive),
                                          child: Text(
                                            "₹${(double.parse(_myBucketController.myBucketData.value.payableAmount!) + (selectedIndex != null ? 10 + selectedIndex * 10 : 0)).toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontSize:
                                                FontSizeStatic.maxMd,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: ScreenConstant
                                          .defaultWidthTwenty,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenConstant.defaultWidthTen,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Tips your delivery partner",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizeStatic.maxMd),
                                  ),
                                  Container(
                                    height:
                                    ScreenConstant.screenWidthFifteen,
                                    width:
                                    ScreenConstant.screenWidthFifteen,
                                    child: Icon(Icons.info_outline_rounded),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: ScreenConstant.defaultWidthTen,
                              ),
                              Container(
                                width: defaultScreenWidth,
                                height: ScreenConstant.defaultHeightOneThirty,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenConstant
                                                  .defaultHeightTwentyfive,
                                              left: ScreenConstant
                                                  .defaultHeightTwentyfive),
                                          child: Container(
                                            width: ScreenConstant
                                                .defaultHeightTwoHundredTen,
                                            child: Container(
                                              width: ScreenConstant
                                                  .defaultSizeThreeTwenty,
                                              child: Text(
                                                "Helping your delivery partners by conveniently tipping them. Your kindness means a lot ",
                                                style: TextStyle(
                                                  fontSize: FontSizeStatic
                                                      .semiSm,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                      ScreenConstant.defaultWidthTen,
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: List.generate(
                                            4,
                                                (index) => GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex =
                                                  selectedIndex ==
                                                      index
                                                      ? -1
                                                      : index;
                                                  int selectedTip =
                                                  (selectedIndex ==
                                                      -1)
                                                      ? 0
                                                      : (selectedIndex +
                                                      1) *
                                                      10;
                                                  _myBucketController
                                                      .storeSelectedTip(
                                                      selectedTip);
                                                });
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: ScreenConstant
                                                        .defaultHeightTwentyThree), // Adjust as needed
                                                child: Container(
                                                  width: ScreenConstant
                                                      .defaultWidthSixty, // Adjust as needed
                                                  height: ScreenConstant
                                                      .defaultHeightThirtyFive, // Adjust as needed
                                                  decoration:
                                                  BoxDecoration(
                                                    color: selectedIndex ==
                                                        index
                                                        ? Color(
                                                        0xFF37B24B)
                                                        : Colors.white,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(6),
                                                    border: Border.all(
                                                        color:
                                                        Colors.grey),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(
                                                            0.5),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      selectedValue =
                                                      "₹${10 + index * 10}",
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color:
                                                        selectedIndex ==
                                                            index
                                                            ? Colors
                                                            .white
                                                            : Colors
                                                            .black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height: ScreenConstant.defaultWidthTen),
                              Row(
                                children: [
                                  Container(
                                    width: 327,
                                    child: Text(
                                      "Please review your order and address details to avoid cancellation ",
                                      style: TextStyle(
                                          fontSize: FontSizeStatic.semiSm,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: ScreenConstant.defaultWidthTen,
                              ),
                              Container(
                                width: defaultScreenWidth,
                                height:
                                ScreenConstant.defaultHeightOneForty,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenConstant
                                              .defaultHeightTwentyfive,
                                          top: ScreenConstant
                                              .defaultHeightTwentyfive),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: ScreenConstant
                                                    .defaultHeightTwentyThree),
                                            child: Text(
                                              "Note: ",
                                              style: TextStyle(
                                                  fontSize:
                                                  FontSizeStatic.mdSm,
                                                  color: Colors.green,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: ScreenConstant
                                                    .defaultHeightTwoHundredTen,
                                                child: Text(
                                                  "If you cancel withipn 60 seconds of placing your order, you can get 100% refund. After 60 seconds no refund cancellation.",
                                                  style: TextStyle(
                                                    fontSize:
                                                    FontSizeStatic.sm,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      // child: Container(
                                      //   width: ScreenConstant
                                      //       .defaultHeightTwoHundredTen,
                                      //   child: Text(
                                      //     "Please review your order and address details to avoid cancellation ",
                                      //     style: TextStyle(
                                      //         fontSize:
                                      //             FontSizeStatic.lg,
                                      //         fontWeight:
                                      //             FontWeight.bold),
                                      //   ),
                                      // ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenConstant
                                              .defaultHeightTwentyfive,
                                          top: ScreenConstant
                                              .defaultWidthTen),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: ScreenConstant
                                                .defaultHeightTwoHundredTen,
                                            child: Text(
                                              "Avoid cancellation as it results in item waste",
                                              style: TextStyle(
                                                fontSize:
                                                FontSizeStatic.sm,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenConstant.sizeMedium,
                                          top: ScreenConstant
                                              .defaultHeightFour),
                                      child: Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Get.to(
                                                  CancelPolicyScreen());
                                            },
                                            child: Text(
                                              "READ GOPOTU CANCELLATION POLICY",
                                              style: TextStyle(
                                                decoration: TextDecoration
                                                    .underline,
                                                fontSize:
                                                FontSizeStatic.sm,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                child: SizedBox(
                                  height: ScreenConstant.defaultHeightForty,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: ScreenConstant.sizeExtraSmall),
                                        child: Text(
                                          "Deliver to: ",
                                          style:
                                          TextStyle(fontSize: FontSizeStatic.md),
                                        ),
                                      ),
                                      Container(
                                        width: ScreenConstant.defaultHeightSeventySix,
                                        child: Row(

                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.green,
                                              size: ScreenConstant.sizeLarge,
                                            ),
                                            Container(
                                              width: ScreenConstant.defaultHeightFiftyFive,
                                              child: Text(
                                                _myBucketController
                                                    .myBucketData
                                                    .value
                                                    .defaultAddress!
                                                    .location ??
                                                    "",
                                                style: TextStyle(
                                                    fontSize: FontSizeStatic.md,
                                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        " - ",
                                        style: TextStyle(
                                            fontSize: FontSizeStatic.md,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        width: ScreenConstant.defaultHeightSeventySix,
                                        child: Text(
                                            "${_addressController.postalCode.toString()}",
                                          style: TextStyle(
                                              fontSize: FontSizeStatic.md,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                          ScreenConstant.defaultHeighttwenty),
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: _myBucketController.isLoading.value
                    ? Container()
                    : HiveStore().get(Keys.guestToken) == null
                    ? Container(
                  color: AppColors.secondary,
                  height: ScreenConstant.defaultHeightOneHundred,
                  child: Column(
                    children: [

                      // Container(
                      //   height: ScreenConstant.defaultHeightForty,
                      //   width: screenWidth,
                      //   decoration: BoxDecoration(
                      //       border: Border.all(color: Colors.black)),
                      //   child: Center(
                      //     child: RichText(
                      //       text: TextSpan(
                      //         text: 'To receive ',
                      //         style: TextStyles.bottomOfferTitle,
                      //         children: <TextSpan>[
                      //           TextSpan(
                      //             text: 'Free delivery, ',
                      //             style: TextStyles.bottomOfferTitle
                      //                 .copyWith(
                      //                 fontWeight:
                      //                 FontWeight.bold),
                      //           ),
                      //           TextSpan(
                      //             text:
                      //             'add products totaling at least 149',
                      //             style: TextStyles.bottomOfferTitle,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: ScreenConstant.defaultWidthTen,
                      // ),
                      // Divider(
                      //   thickness: 1,
                      // ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                _myBucketController
                                    .myBucketData
                                    .value
                                    .address!
                                    .fullAddress!
                                    .addressLine1 ==
                                    null
                                    ? ""
                                    : "",
                                style: TextStyles.yourPayableBill
                                    .copyWith(
                                    color: _myBucketController
                                        .myBucketData
                                        .value
                                        .address!
                                        .fullAddress!
                                        .addressLine1 ==
                                        null
                                        ? AppColors.primary
                                        : AppColors
                                        .addressListWidgetContainsColor),
                              ),
                              Container(
                                height: ScreenConstant.sizeExtraSmall,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: ScreenConstant
                                        .defaultHeightEight),
                                child: Text(
                                  "₹${(double.parse(_myBucketController.myBucketData.value.payableAmount!) + (selectedIndex != null ? 10 + selectedIndex * 10 : 0)).toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontSize: FontSizeStatic.xl,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Text(
                              //   "View Details Bill",
                              //   style: TextStyle(
                              //       fontSize: FontSizeStatic.md,
                              //       color: Colors.green,
                              //       fontWeight: FontWeight.bold),
                              // ),
                            ],
                          ),
                          Container(
                            width: ScreenConstant.sizeMedium,
                          ),
                          Obx(
                                () => Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenConstant
                                      .screenWidthFifteen),
                              child: AppButton(
                                width: ScreenConstant
                                    .defaultWidthOneSeventy,
                                color: Color(0xFF37B24B),
                                buttonText: "Proceed To Pay",
                                onPressed: _myBucketController
                                    .myBucketData
                                    .value
                                    .defaultAddress!
                                    .deliverable!
                                    ? _myBucketController
                                    .paymentMode.value ==
                                    "cash"
                                    ? () {
                                  if (_myBucketController
                                      .myBucketData
                                      .value
                                      .address!
                                      .fullAddress!
                                      .addressLine1 ==
                                      null) {
                                    // Fluttertoast.showToast(msg: 'Change the address');
                                    _showAddressBottomSheet();
                                    return;
                                  }

                                  _myBucketController
                                      .makeOrderInCashPress(
                                    _myBucketController
                                        .myBucketData
                                        .value
                                        .items![0]
                                        .shopId
                                        .toString(),
                                    _myBucketController
                                        .myBucketData
                                        .value
                                        .defaultAddress!
                                        .id
                                        .toString(),
                                    _myBucketController
                                        .myBucketData
                                        .value
                                        ?.couponDetails
                                        ?.code ==
                                        null
                                        ? ""
                                        : _myBucketController
                                        .myBucketData
                                        .value
                                        .couponDetails!
                                        .code
                                        .toString(),
                                  );
                                  //Get.offAllNamed(orderPlaced);
                                  //showBottomSheetTime(context);
                                }
                                    : () {
                                  if (_myBucketController
                                      .myBucketData
                                      .value
                                      .address!
                                      .fullAddress!
                                      .addressLine1 ==
                                      null) {
                                    // Fluttertoast.showToast(msg: 'Change the address');
                                    _showAddressBottomSheet();
                                    return;
                                  }

                                  _myBucketController
                                      .makeOrderInOnlinePress(
                                    _myBucketController
                                        .myBucketData
                                        .value
                                        .items![0]
                                        .shopId
                                        .toString(),
                                    _myBucketController
                                        .myBucketData
                                        .value
                                        .defaultAddress!
                                        .id
                                        .toString(),
                                  );
                                }
                                    : null,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
                    : Container(
                  color: AppColors.secondary,
                  height: ScreenConstant.defaultHeightSeventy,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: AppButton(
                      onPressed: () {
                        final AddressController _addressController =
                        Get.put(AddressController());
                        _addressController.isCheckOutPage.value =
                        false;
                        Get.to(SignIn());
                      },
                      buttonText: "PLEASE LOGIN TO CONTINUE",
                    ),
                  ),
                ),
              ),
            );
    });
  }

  showBottomSheetTime(BuildContext context) {
    showBarModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        backgroundColor: AppColors.secondary,
        topControl: Container(
          decoration: BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.circular(40)),
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.cancel,
                color: AppColors.secondary,
                size: ScreenConstant.sizeXXL,
              )),
        ),
        context: context,
        builder: (context) {
          return ScheduleScreen();
        });
  }

  void _showAddressBottomSheet() {
    final AddressController _addressController = Get.put(AddressController());
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(46.0),
          topRight: Radius.circular(46.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Adjust padding for the keyboard
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Fill Address Data for Current Address",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: FontSizeStatic.lg),
              ),
              SizedBox(height: ScreenConstant.sizeLarge),
              // TextField(
              //   decoration: InputDecoration(labelText: 'Address Line 1'),
              // ),
              // SizedBox(height: ScreenConstant.sizeLarge),
              RequireTextField(
                controller: _addressController.villageNameController,
                type: Type.addressLine,
                hintText: "Address Line 1",
              ),
              SizedBox(height: ScreenConstant.sizeLarge),
              RequireTextField(
                controller: _addressController.landMarkController,
                type: Type.landmark,
                hintText: "LandMark",
              ),
              SizedBox(height: ScreenConstant.sizeLarge),
              ElevatedButton(
                onPressed: () async {
                  // Perform any actions here when the submit button is pressed
                  _addressController.billNameController.text =
                      _myBucketController
                          .myBucketData.value.defaultAddress!.name!;
                  _addressController.mobileController.text = _myBucketController
                      .myBucketData.value.defaultAddress!.mobile!;
                  _addressController.location.text = _myBucketController
                      .myBucketData.value.defaultAddress!.location!;
                  _addressController.city.value = _myBucketController
                      .myBucketData.value.address!.fullAddress!.city!;
                  _addressController.country.value = _myBucketController
                      .myBucketData.value.address!.fullAddress!.country!;
                  _addressController.postalCodeController.text =
                      _myBucketController
                          .myBucketData.value.address!.fullAddress!.postalCode!;
                  _addressController.lat.value = double.parse(
                      _myBucketController
                          .myBucketData.value.defaultAddress!.latitude!);
                  _addressController.lng.value = double.parse(
                      _myBucketController
                          .myBucketData.value.defaultAddress!.longitude!);
                  _addressController.state.value = _myBucketController
                      .myBucketData.value.address!.fullAddress!.state!;
                  _addressController.addressType.value = "current";

                  if (_addressController.landMarkController.text.isNotEmpty &&
                      _addressController
                          .villageNameController.text.isNotEmpty) {
                    // Your existing button logic here

                    _addressController.isCheckOutPage.value = true;
                    _addressController.addCurrentAddressApiCall();

                    // Close the bottom sheet
                    // Navigator.pop(context);
                  } else {
                    Fluttertoast.showToast(msg: 'Fill Data Properly');
                  }
                  // Close the bottom sheet
                },
                child: Text('Submit',style: TextStyle(color: Colors.white),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(AppColors
                      .buttonColorSecondary), // Change to your desired color
                ),
              ),
              SizedBox(height: ScreenConstant.sizeLarge),
            ],
          ),
        );
      },
    );
  }
}
