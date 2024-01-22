import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:go_potu_user/Controller/OrderListController/OrderListController.dart';

import 'package:go_potu_user/Controller/ProfileController/ProfileController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Models/ResponseModels/GetMyBucketResponseModel/GetMyBucketResponseModel.dart';

import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ShareStore.dart';
import 'package:go_potu_user/Views/AboutUsScreens/AboutUs.dart';
import 'package:go_potu_user/Views/AboutUsScreens/Privacy_Policy.dart';
import 'package:go_potu_user/Views/AboutUsScreens/Terms_Condition.dart';
import 'package:go_potu_user/Views/CartScreen/CheckOutPage.dart';
import 'package:go_potu_user/Views/FavouriteScreen/FavouriteFilterScreen.dart';
import 'package:go_potu_user/Views/Favourite_Screen/Favourite.dart';
import 'package:go_potu_user/Views/HelpScreen/Help.dart';
import 'package:go_potu_user/Views/OrdersScreen/OrderListingScreen.dart';
import 'package:go_potu_user/Views/OrdersScreen/ReturnReplaceRequestScreen.dart';
import 'package:go_potu_user/Views/ProductDetailsScreen/ProductDetails.dart';
import 'package:go_potu_user/Views/StoreScreens/Strore.dart';
import 'package:go_potu_user/Views/TrackingScreen/Tracking.dart';

import 'package:go_potu_user/Views/WalletScreens/UserWalletScreen.dart';
import 'package:go_potu_user/Widgets/DrawerWidget/DrawerFile.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import '../../Controller/AddressController/AddressController.dart';
import '../../Controller/SplashController/SplashController.dart';
import '../NotificationScreen/NotificationScreen.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  final SplashController _splashController = Get.find();


  // void selectImage() async {
  Uint8List? _image;

  File? SelectImage;

  bool isDropdownOpen = false;
  bool isButtonClicked = false;
  List<String> items = ['About us', 'Privacy Policy', 'Terms & Conditions'];
  String selectedItem = 'Select an item';

  void toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
      isButtonClicked = !isButtonClicked;
    });
  }

  // void selectItem(String item) {
  //   setState(() {
  //     selectedItem = item;
  //     isDropdownOpen = false;
  //     openAnotherPage(item);
  //   });
  // }

  // void openAnotherPage(String selectedItem) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => AboutUs(),
  //     ),
  //   );
  // }
  void selectItem(String items) {
    setState(() {
      selectedItem = items;
      isDropdownOpen = false;
    });

    if (items == 'About us') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => About_us(),
        ),
      );
    } else if (items == 'Privacy Policy') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Privacy_Policy(),
        ),
      );
    } else if (items == 'Terms & Conditions') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Terms_Condition(),
        ),
      );
    }
  }

  bool isContainerVisible = false;

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.keyboard_arrow_left,
        //     color: Colors.white,
        //     size: ScreenConstant.sizeXL,
        //   ),
        //   onPressed: () {
        //     // Navigator.of(context).pop();
        //   },
        // ),
        title: Text(
          "My Profile",
          style: TextStyles.appBarTitle,
        ),
      ),
      // drawer: DrawerFile(),
      body: Stack(
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
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                          backgroundImage: MemoryImage(_image!),
                          radius: 80,
                        )
                            : CircleAvatar(
                          backgroundImage: AssetImage(
                              "assets/profile (1).png"),
                          radius: 80,
                          // foregroundColor: Colors.white,
                        ),
                        Positioned(
                            bottom: -0,
                            left: 110,
                            child: IconButton(
                                onPressed: () {
                                  showImagePickerOption(context);
                                },
                                icon: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle),
                                    height: ScreenConstant.sizeExtraLarge,
                                    width: ScreenConstant.sizeExtraLarge,
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 20,
                                      color: Colors.white,
                                    ))))
                      ],
                    ),
                  ),
                  // Container(
                  //   height: ScreenConstant.defaultHeightOneHundred,
                  //   width: ScreenConstant.defaultHeightOneHundred,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: AppColors.primary,
                  //     border: Border.all(
                  //       width: 5,
                  //       color: AppColors.profileCircleBorder,
                  //     ),
                  //   ),),

                  // child: Obx(() => Center(
                  //         child: Text(
                  //       profileController.profileName
                  //           .toString()
                  //           .substring(0, 1)
                  //           .toUpperCase(),
                  //       style: TextStyles.profileNameFirstLetter,
                  //     ))),
                  // child: Obx(() => Center(
                  //         child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Stack(
                  //           children: [
                  //             CircleAvatar(
                  //               radius: 50,
                  //             ),
                  //             Positioned(
                  //               child: IconButton(
                  //                   onPressed: () {
                  //                     // selectImage();
                  //                   },
                  //                   icon: Icon(
                  //                     Icons.camera_alt,
                  //                     color: Colors.white,
                  //                   )),
                  //               bottom: -10,
                  //               left: 65,
                  //             )
                  //           ],
                  //         )
                  //       ],
                  //     )))),

                  Container(
                    height: ScreenConstant.sizeMedium,
                  ),
                  Obx(
                        () => Text(
                      profileController.profileName.toUpperCase(),
                      style: TextStyles.profileName,
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeExtraSmall,
                  ),
                  Text(
                    "+91 ${HiveStore().get(Keys.profileData)['mobile']}",
                    style: TextStyles.profileContact,
                  ),
                  Container(
                    height: ScreenConstant.sizeExtraLarge,
                  ),

                  Padding(
                    padding:
                    EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.buttonColorSecondary,
                          borderRadius: BorderRadius.circular(
                              ScreenConstant.defaultWidthTen)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: ScreenConstant.defaultWidthTwenty,
                                top: ScreenConstant.defaultWidthTen),
                            child: Row(
                              children: [
                                Container(
                                    height:
                                    ScreenConstant.defaultHeightThirtyFive,
                                    width:
                                    ScreenConstant.defaultHeightThirtyFive,
                                    child:
                                    Image.asset("assets/surprise 1.png")),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenConstant.defaultWidthTen,
                                          top: ScreenConstant
                                              .defaultHeightEight),
                                      child: Text(
                                        "Invite friends, get rewards",
                                        style: TextStyle(
                                            fontSize: FontSizeStatic.xl,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: ScreenConstant
                                                  .defaultWidthTen),
                                          child: Text("Share your code",
                                              style: TextStyle(
                                                  fontSize: FontSizeStatic.sm,
                                                  color: Colors.white)),
                                        ),
                                        SizedBox(
                                          width:
                                          ScreenConstant.defaultHeightEight,
                                        ),
                                        Container(
                                          height: ScreenConstant.sizeLarge,
                                          width: 80,
                                          color: Colors.white,
                                          child: Center(
                                            child: Text(
                                              "${HiveStore().get(Keys.profileData)['referral_code']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: FontSizeStatic.sm),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await Clipboard.setData(
                                                ClipboardData(
                                                    text: HiveStore().get(
                                                        Keys.profileData)[
                                                    'referral_code']));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Copied to Clipboard')));
                                          },
                                          child: Container(
                                            height: ScreenConstant.sizeLarge,
                                            width: ScreenConstant.sizeXL,
                                            color: AppColors.secondary
                                                .withOpacity(.8),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Icon(
                                                      Icons.copy,
                                                      size: FontSizeStatic.md,
                                                      color: Color(0xFFD32033),
                                                    ),
                                                    Text(
                                                      "Copy",
                                                      style: TextStyle(
                                                        fontSize: 3,
                                                        color:
                                                        Color(0xFFD32033),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: ScreenConstant.sizeSmall,
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 10,),
                                          child: GestureDetector(
                                              onTap: () {
                                                openWhatsapp(context);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                                height: ScreenConstant
                                                    .sizeExtraLarge,
                                                width: ScreenConstant
                                                    .sizeExtraLarge,
                                                child: Image.asset(
                                                    "assets/whatsappp.png"),
                                                // child: Icon(
                                                //   Ima
                                                //   size: 20,
                                                //   color: AppColors
                                                //       .buttonColorSecondary,
                                                // )),
                                              )),
                                        ),
                                        SizedBox(
                                          width:
                                          ScreenConstant.defaultHeightEight,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: ScreenConstant
                                                  .defaultWidthTen),
                                          child: GestureDetector(
                                              onTap: () {
                                                share();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                                height: ScreenConstant
                                                    .sizeExtraLarge,
                                                width: ScreenConstant
                                                    .sizeExtraLarge,
                                                child: Image.asset(
                                                    "assets/octicon_share.png"),
                                                // child: Icon(
                                                //   Ima
                                                //   size: 20,
                                                //   color: AppColors
                                                //       .buttonColorSecondary,
                                                // )),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 2, color: Color(0xFFD9D9D9)),
                          Container(
                            height: ScreenConstant.sizeSmall,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              "Refer a friend.",
                              style: TextStyle(
                                  fontSize: FontSizeStatic.md,
                                  fontFamily: 'Proxima-Regular',
                                  color: AppColors.secondary),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, top: 8, right: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 20.0),
                                        child: Text(
                                          _splashController.accountSettingsData
                                              .value.referralText!,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              fontSize: FontSizeStatic.sm,
                                              fontFamily: 'Proxima-Regular',
                                              color: AppColors.secondary
                                                  .withOpacity(.7)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: ScreenConstant.sizeLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenConstant.screenWidthFifteen,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: ScreenConstant.defaultHeightTwoHundredTen),
                    child: Text(
                      "Settings",
                      style: TextStyle(
                          fontSize: FontSizeStatic.lg,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: ScreenConstant.defaultWidthTwenty,
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(editProfile);
                    },
                    leading: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Container(
                        height: ScreenConstant.defaultHeightTwentyeight,
                        width:  ScreenConstant.defaultHeightTwentyfive,
                        child: Image(
                          color: Colors.black,
                          fit: BoxFit.contain,
                          image: AssetImage(Assets.profile1),
                        ),
                      ),
                    ),
                    title: Text("User Information",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: FontSizeStatic.maxMd)),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                      size: ScreenConstant.sizeXL,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(orderListing);
                    },
                    leading: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Container(
                        height: ScreenConstant.defaultHeightTwentyeight,
                        width:  ScreenConstant.defaultHeightTwentyfive,
                        child: Image(
                          color: Colors.black,
                          fit: BoxFit.contain,
                          image: AssetImage(Assets.MyOrders),
                        ),
                      ),
                    ),
                    title: Text("My Orders",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: FontSizeStatic.maxMd)),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                      size: ScreenConstant.sizeXL,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(CheckOutPage());
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => CheckOutPage(),
                      //     ));
                    },
                    leading: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Container(
                        height: ScreenConstant.defaultHeightTwentyeight,
                        width:  ScreenConstant.defaultHeightTwentyfive,
                        child: Image(
                          color: Colors.black,
                          fit: BoxFit.contain,
                          image: AssetImage(Assets.Cart),
                        ),
                      ),
                    ),
                    title: Text("My Cart",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: FontSizeStatic.maxMd)),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                      size: ScreenConstant.sizeXL,
                    ),
                  ),
                  // Container(
                  //   height: ScreenConstant.sizeSmall,
                  // ),
                  // ListTile(
                  //   onTap: () {
                  //     final AddressController _addressController =
                  //         Get.put(AddressController());
                  //     _addressController.isHomeScreen.value = true;
                  //     Get.toNamed(addressList);
                  //   },
                  //   leading: Icon(
                  //     Icons.location_on_rounded,
                  //     color: AppColors.buttonColorSecondary,
                  //     size: ScreenConstant.sizeXL,
                  //   ),
                  //   title: Text(
                  //     "Manage Address",
                  //     style: TextStyles.profileOptionsTitle,
                  //   ),
                  //   trailing: Icon(
                  //     Icons.keyboard_arrow_right,
                  //     color: AppColors.buttonColorSecondary,
                  //     size: ScreenConstant.sizeXL,
                  //   ),
                  // ),
                  // Container(
                  //   height: ScreenConstant.sizeSmall,
                  // ),
                  // ListTile(
                  //   onTap: () {
                  //     Get.to(UserWalletScreen());
                  //     // Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //       builder: (context) => BankDetails1(),
                  //     //     ));
                  //     // Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //       builder: (context) => Return_Page(),
                  //     //     ));
                  //     // Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //       builder: (context) => Order_Details_Screen1(),
                  //     // //     ));
                  //     // Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //       builder: (context) => Store_Details(),
                  //     //     ));
                  //   },
                  //   leading: Padding(
                  //     padding: EdgeInsets.only(left: 10),
                  //     child: Container(
                  //       height: ScreenConstant.screenWidthFifteen,
                  //       width: ScreenConstant.defaultWidthTwenty,
                  //       child: Image(
                  //         color: Colors.black,
                  //         fit: BoxFit.contain,
                  //         image: AssetImage("assets/wallet.png"),
                  //       ),
                  //     ),
                  //   ),
                  //   title: Text("My Wallet",
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: FontSizeStatic.maxMd)),
                  //   trailing: Icon(
                  //     Icons.keyboard_arrow_right,
                  //     color: Colors.black,
                  //     size: ScreenConstant.sizeXL,
                  //   ),
                  // ),

                  // ListTile(
                  //   onTap: () {
                  //     Get.toNamed(editProfile);
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => My_Favourite(),
                  //         ));
                  //   },
                  //   leading: Padding(
                  //     padding: EdgeInsets.only(left: 10),
                  //     child: Container(
                  //       height: ScreenConstant.screenWidthFifteen,
                  //       width: ScreenConstant.defaultWidthTwenty,
                  //       child: Image(
                  //         color: Colors.black,
                  //         fit: BoxFit.contain,
                  //         image: AssetImage("assets/favourit.png"),
                  //       ),
                  //     ),
                  //   ),
                  //   title: Text("My Favorites",
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: FontSizeStatic.maxMd)),
                  //   trailing: Icon(
                  //     Icons.keyboard_arrow_right,
                  //     color: Colors.black,
                  //     size: ScreenConstant.sizeXL,
                  //   ),
                  // ),
                  ListTile(
                    onTap: () {
                      // Get.toNamed(editProfile);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>NotificationScreen()));
                    },
                    leading: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Container(
                        height: ScreenConstant.screenWidthFifteen,
                        width: ScreenConstant.defaultWidthTwenty,
                        child: Icon(Icons.notifications_none_sharp,size: 25,),
                        // child: Image(
                        //   color: Colors.black,
                        //   fit: BoxFit.contain,
                        //   image: AssetImage("assets/notificatio.png"),
                        // ),
                      ),
                    ),
                    title: Text("Notification",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: FontSizeStatic.maxMd)),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                      size: ScreenConstant.sizeXL,
                    ),
                  ),
                  // ListTile(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => Help_Screen()));
                  //     // Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //         builder: (context) => TrcakingScreen1()));
                  //
                  //   },
                  //   leading: Padding(
                  //     padding: EdgeInsets.only(left: 10),
                  //     child: Container(
                  //       height: ScreenConstant.screenWidthFifteen,
                  //       width: ScreenConstant.defaultWidthTwenty,
                  //       child: Image(
                  //         color: Colors.black,
                  //         fit: BoxFit.contain,
                  //         image: AssetImage("assets/headse.png"),
                  //       ),
                  //     ),
                  //   ),
                  //   title: Text("Help",
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: FontSizeStatic.maxMd)),
                  //   trailing: Icon(
                  //     Icons.keyboard_arrow_right,
                  //     color: Colors.black,
                  //     size: ScreenConstant.sizeXL,
                  //   ),
                  // ),
                  ListTile(
                    onTap: toggleDropdown,
                    leading: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Container(
                        height: ScreenConstant.screenWidthFifteen,
                        width: ScreenConstant.defaultWidthTwenty,
                        // child: Image(
                        //   color: Colors.black,
                        //   fit: BoxFit.contain,
                        //   image: AssetImage("assets/infor.png"),
                        // ),
                        child: Icon(Icons.info_outline_rounded),
                      ),
                    ),
                    title: Text(
                      'About Us',
                      style: TextStyle(
                        color: isButtonClicked ? Colors.green : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSizeStatic.maxMd,
                      ),
                    ),
                    trailing: Icon(
                      isDropdownOpen ? Icons.chevron_left : Icons.chevron_right,
                      color: Colors.black,
                      size: ScreenConstant.sizeXL,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenConstant.defaultHeightOneHundred),
                    child: isDropdownOpen
                        ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(items[index]),
                          onTap: () {
                            selectItem(items[index]);
                          },
                        );
                      },
                    )
                        : Container(),
                  ),

                  // Center(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Padding(
                  //             padding: EdgeInsets.only(
                  //                 left: ScreenConstant.defaultHeightFour),
                  //             child: ElevatedButton(
                  //               onPressed: toggleDropdown,
                  //               style: ElevatedButton.styleFrom(
                  //                   backgroundColor: Colors.white,
                  //                   elevation: 0),
                  //               child: Row(
                  //                 children: [
                  //                   Image(
                  //                     color: Colors.black,
                  //                     fit: BoxFit.contain,
                  //                     image: AssetImage("assets/info.png"),
                  //                   ),
                  //                   SizedBox(
                  //                     width: 25,
                  //                   ),
                  //                   Text(
                  //                     'About Us',
                  //                     style: TextStyle(
                  //                       color: isButtonClicked
                  //                           ? Colors.green
                  //                           : Colors.black,
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: FontSizeStatic.maxMd,
                  //                     ),
                  // //                   ),
                  //                   SizedBox(
                  //                       width: ScreenConstant
                  //                           .defaultWidthTwoHundredForty),
                  // Icon(
                  //   isDropdownOpen
                  //       ? Icons.chevron_left
                  //       : Icons.chevron_right,
                  //   color: Colors.black,
                  //   size: ScreenConstant.sizeXL,
                  // ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Padding(
                  //         padding: EdgeInsets.only(
                  //             left: ScreenConstant.defaultHeightOneHundred),
                  //         child: isDropdownOpen
                  //             ? ListView.builder(
                  //                 shrinkWrap: true,
                  //                 itemCount: items.length,
                  //                 itemBuilder: (context, index) {
                  //                   return ListTile(
                  //                     title: Text(items[index]),
                  //                     onTap: () {
                  //                       selectItem(items[index]);
                  //                     },
                  //                   );
                  //                 },
                  //               )
                  //             : Container(),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  GestureDetector(
                    onTap: () {
                      share();
                    },
                    child: ListTile(
                      leading: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Container(
                          height: ScreenConstant.screenWidthFifteen,
                          width: ScreenConstant.defaultWidthTwenty,
                          child: Image(
                            color: Colors.black,
                            fit: BoxFit.contain,
                            image: AssetImage("assets/shared.png"),
                          ),
                        ),
                      ),
                      title: Text("Share App",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizeStatic.maxMd)),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black,
                        size: ScreenConstant.sizeXL,
                      ),
                    ),
                  ),

                  ListTile(
                    onTap: () {
                      showAlertDialog(context);
                    },
                    leading: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Container(
                        height: ScreenConstant.screenWidthFifteen,
                        width: ScreenConstant.defaultWidthTwenty,
                        child: Image(
                          color: Colors.black,
                          fit: BoxFit.contain,
                          image: AssetImage("assets/exit.png"),
                        ),
                      ),
                    ),
                    title: Text("Logout",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: FontSizeStatic.maxMd)),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                      size: ScreenConstant.sizeXL,
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     showAlertDialog(context);
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       border: Border.all(color: AppColors.primary),
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: Color(0xFFfffafa),
                  //     ),
                  //     child: Padding(
                  //       padding: EdgeInsets.only(
                  //         left: ScreenConstant.sizeLarge,
                  //         bottom: ScreenConstant.sizeSmall,
                  //         right: ScreenConstant.sizeLarge,
                  //         top: ScreenConstant.sizeSmall,
                  //       ),
                  //       child: Container(
                  //         child: Text(
                  //           "SIGN OUT",
                  //           style: TextStyles.signOut,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    height: ScreenConstant.sizeExtraLarge,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SizedBox(
            height: ScreenConstant.defaultHeightTwoHundred,
            width: 500,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 90, top: 80),
                  child: InkWell(
                    onTap: (() {
                      _pickImageFromGallery();
                    }),
                    child: SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 80,
                          ),
                          Text(
                            "Gallery",
                            style: TextStyle(
                              fontSize: FontSizeStatic.maxMd,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenConstant.sizeXL,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 80),
                  child: InkWell(
                    onTap: (() {
                      _pickImageFromCamera();
                    }),
                    child: SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 80,
                          ),
                          Text(
                            "Camera",
                            style: TextStyle(
                              fontSize: FontSizeStatic.maxMd,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }


  Future _pickImageFromGallery() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    SelectImage = File(returnImage.path);
    setState(() {
      _image = File(returnImage.path).readAsBytesSync();
    });
  }

  Future _pickImageFromCamera() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;

    SelectImage = File(returnImage.path);
    setState(() {
      _image = File(returnImage.path).readAsBytesSync();
    });
  }

  final _dialog = RatingDialog(
    starSize: 30,
    // your app's name?
    title: Text(
      'Rate us on play store',
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),

    // encourage your user to leave a high rating?
    // message: Text('Select Number of Stars 1 - 5 to Rate This App'),
    // your app's logo?
    image: Image(
      image: AssetImage(Assets.splashLogo),
      height: ScreenConstant.sizeXXXL,
      width: ScreenConstant.sizeXXXL,
    ),

    submitButtonText: 'Submit',
    onCancelled: () => print('cancelled'),
    onSubmitted: (response) {
      print('rating: ${response.rating}, comment: ${response.comment}');
      // TODO: add your own logic
      if (response.rating < 3.0) {
        // send their comments to your email or anywhere you wish
        // ask the user to contact you instead of leaving a bad review
      } else {
        //go to app store
        StoreRedirect.redirect(
            androidAppId: 'com.gopotu.user', iOSAppId: 'com.gopotu.user');
      }
    },
  );

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Download GoPotu App Now',
        // text:
        //     'Hey, Give it a try. Download gopotu app using this link - https://play.google.com/store/apps/details?id=com.gopotu.user and use my referral code *${HiveStore().get(Keys.profileData)['referral_code'].toString()}* while joining to get${_splashController.accountSettingsData.value.firstorder!.userwallet.type == "flat" ? " flat Rs. " : ' '}${_splashController.accountSettingsData.value.firstorder.userwallet.value}${_splashController.accountSettingsData.value.firstorder.userwallet.type == "percentage" ? '%' : ' '} and your friend will get${_splashController.accountSettingsData.value.firstorder.parentwallet.type == "flat" ? " flat\n Rs. " : ' '}${_splashController.accountSettingsData.value.firstorder.parentwallet.value}${_splashController.accountSettingsData.value.firstorder.parentwallet.type == "percentage" ? '%' : ' '}as wallet cash back after first order complete.',
        text:
        'Hey, Give it a try. Download gopotu app using this link - https://play.google.com/store/apps/details?id=com.gopotu.user and use my referral code *${HiveStore().get(Keys.profileData)['referral_code'].toString()}* while joining to get${_splashController.accountSettingsData.value.firstorder!.userwallet != null && _splashController.accountSettingsData.value.firstorder!.userwallet!.type == "flat" ? " flat Rs. " : ' '}${_splashController.accountSettingsData.value.firstorder!.userwallet != null ? _splashController.accountSettingsData.value.firstorder!.userwallet!.value : ''}${_splashController.accountSettingsData.value.firstorder!.userwallet != null && _splashController.accountSettingsData.value.firstorder!.userwallet!.type == "percentage" ? '%' : ' '} and your friend will get${_splashController.accountSettingsData.value.firstorder!.parentwallet != null && _splashController.accountSettingsData.value.firstorder!.parentwallet!.type == "flat" ? " flat\n Rs. " : ' '}${_splashController.accountSettingsData.value.firstorder!.parentwallet != null ? _splashController.accountSettingsData.value.firstorder!.parentwallet!.value : ''}${_splashController.accountSettingsData.value.firstorder!.parentwallet != null && _splashController.accountSettingsData.value.firstorder!.parentwallet!.type == "percentage" ? '%' : ' '}as wallet cashback after the first order complete.',
        chooserTitle: '');
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
        //await HiveStore().delete(Keys.deviceID);
        ShareStore().clear();
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

// ${HiveStore().get(Keys.profileData)['referral_code']}
  openWhatsapp(BuildContext context) async {
    var whatsapp = "+91${HiveStore().get(Keys.profileData)['mobile']}";
    var whatsAppURlAndroid =
        "https://wa.me/?text= Hey, Give it a try. Download gopotu app using this link - https://play.google.com/store/apps/details?id=com.gopotu.user and use my referral code *${HiveStore().get(Keys.profileData)['referral_code'].toString()}* while joining to get${_splashController.accountSettingsData.value.firstorder!.userwallet!.type == "flat" ? " flat Rs. " : ' '}${_splashController.accountSettingsData.value.firstorder!.userwallet!.value}${_splashController.accountSettingsData.value.firstorder!.userwallet!.type == "percentage" ? '%25' : ' '} and your friend will get${_splashController.accountSettingsData.value.firstorder!.parentwallet!.type == "flat" ? " flat\n Rs. " : ' '}${_splashController.accountSettingsData.value.firstorder!.parentwallet!.value}${_splashController.accountSettingsData.value.firstorder!.parentwallet!.type == "percentage" ? '%25' : ' '}as wallet cash back after the first order is complete.";
    var whatAppURLIos =
        "${_splashController.accountSettingsData.value.referralText}";

    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatAppURLIos))) {
        await launchUrl(
          Uri.parse(whatAppURLIos),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("WhatsApp is not installed")));
      }
    } else {
      // android, web
      if (await canLaunchUrl(Uri.parse(whatsAppURlAndroid))) {
        await launchUrl(
          Uri.parse(whatsAppURlAndroid),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("WhatsApp is not installed")));
      }
    }
  }

}
