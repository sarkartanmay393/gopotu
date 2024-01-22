import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/ProfileController/ProfileController.dart';
import 'package:go_potu_user/Controller/SupportTicketController/SupportTicketController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ShareStore.dart';
import 'package:go_potu_user/Views/CompanyScreens/CustomerCareService.dart';
import 'package:go_potu_user/Views/FavouriteScreen/FavouriteScreen.dart';
import 'package:go_potu_user/Views/OrdersScreen/DrawerOrderListingScreen.dart';
import 'package:go_potu_user/Views/ProfileScreen/MyProfileScreen.dart';
import 'package:go_potu_user/Views/SignInScreen/SignIn.dart';
import 'package:us_states/us_states.dart';

import '../../Controller/SplashController/SplashController.dart';
import '../../Views/ProfileScreen/SecondMyProfileSreen.dart';
import '../../Views/WalletScreens/UserWalletScreen.dart';

class DrawerFile extends StatelessWidget {
  final ProfileController profileController = Get.find();
  final SplashController _splashController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors
              .primary, //This will change the drawer background to blue.
        ),
        child: Drawer(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenConstant.sizeXXL,
                    bottom: ScreenConstant.sizeMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: ScreenConstant.defaultHeightSeventy,
                      width: ScreenConstant.defaultHeightSeventy,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondary,
                      ),
                      child: Obx(() => Center(
                              child: Text(
                            HiveStore().get(Keys.guestToken) == null
                                ? profileController.profileName
                                    .toString()
                                    .substring(0, 1)
                                    .toUpperCase()
                                : "G",
                            style: TextStyles.profileNameFirstLetter2,
                          ))),
                    ),
                    Container(
                      height: ScreenConstant.sizeSmall,
                    ),
                    Obx(
                      () => Text(
                        profileController.profileName.toUpperCase(),
                        style: TextStyles.drawerMyProfileName,
                      ),
                    ),
                    Container(
                      height: ScreenConstant.sizeSmall,
                    ),
                    Text(
                      HiveStore().get(Keys.guestToken) == null
                          ? "+91 ${HiveStore().get(Keys.profileData)['mobile']}"
                          : "",
                      style: TextStyles.drawerSubTitle,
                    ),
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    GestureDetector(
                        onTap: HiveStore().get(Keys.guestToken) == null
                            ? () {
                                Get.to(SecondMyProfileScreen());
                              }
                            : () {
                                Get.to(SignIn());
                              },
                        child: Text(
                          'My Account',
                          style: TextStyles.drawerSubTitle2,
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.secondary,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: ScreenConstant.sizeExtraSmall),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.offAllNamed(dashBoard);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: ScreenConstant.sizeLarge,
                                width: ScreenConstant.sizeXXXL,
                                child: Image(
                                  fit: BoxFit.contain,
                                  color: AppColors.buttonColorSecondary,
                                  image: AssetImage(
                                    Assets.home,
                                  ),
                                ),
                              ),
                              Container(
                                width: ScreenConstant.sizeSmall,
                              ),
                              Text(
                                'Home',
                                style: TextStyles.drawerItems,
                              ),
                              Expanded(
                                  child: Container(
                                color: AppColors.secondary,
                                height: ScreenConstant.sizeXL,
                              )),
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.to(FavouriteScreen());
                              //Get.toNamed(needHelp);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: ScreenConstant.sizeLarge,
                                  width: ScreenConstant.sizeXXXL,
                                  child: Icon(
                                    Icons.favorite_outlined,
                                    color: AppColors.buttonColorSecondary,
                                  ),
                                ),
                                Container(
                                  width: ScreenConstant.sizeSmall,
                                ),
                                Text(
                                  'My Favourite',
                                  style: TextStyles.drawerItems,
                                ),
                                Expanded(
                                    child: Container(
                                  color: AppColors.secondary,
                                  height: ScreenConstant.sizeXL,
                                )),
                              ],
                            )),
                        GestureDetector(
                          onTap: () {
                            Get.to(UserWalletScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: ScreenConstant.sizeXL,
                                width: ScreenConstant.sizeXXXL,
                                child: Icon(
                                  Icons.account_balance_wallet_sharp,
                                  color: AppColors.buttonColorSecondary,
                                ),
                              ),
                              Container(
                                width: ScreenConstant.sizeSmall,
                              ),
                              Text(
                                'My Wallet',
                                style: TextStyles.drawerItems,
                              ),
                              Expanded(
                                  child: Container(
                                color: AppColors.secondary,
                                height: ScreenConstant.sizeXL,
                              )),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.to(DrawerOrderListingScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: ScreenConstant.sizeLarge,
                                width: ScreenConstant.sizeXXXL,
                                child: Image(
                                  fit: BoxFit.contain,
                                  color: AppColors.buttonColorSecondary,
                                  image: AssetImage(
                                    Assets.orders,
                                  ),
                                ),
                              ),
                              Container(
                                width: ScreenConstant.sizeSmall,
                              ),
                              Text(
                                'My Orders',
                                style: TextStyles.drawerItems,
                              ),
                              Expanded(
                                  child: Container(
                                color: AppColors.secondary,
                                height: ScreenConstant.sizeXL,
                              )),
                            ],
                          ),
                        ),
                        /* Container(
                          height: ScreenConstant.sizeLarge,
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.back();
                            Get.toNamed(myBasket);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: ScreenConstant.sizeLarge,
                                width: ScreenConstant.sizeXXXL,
                                child: Image(
                                  fit: BoxFit.contain,
                                  color: AppColors.primary,
                                  image: AssetImage(
                                    Assets.basket,
                                  ),),
                              ),
                              Container(
                                width: ScreenConstant.sizeSmall,
                              ),
                              Text('My Basket',style: TextStyles.drawerItems,),
                            ],
                          ),
                        ),*/

                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.toNamed(notifications);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: ScreenConstant.sizeLarge,
                                width: ScreenConstant.sizeXXXL,
                                child: Icon(
                                  Icons.notifications,
                                  color: AppColors.buttonColorSecondary,
                                ),
                              ),
                              Container(
                                width: ScreenConstant.sizeSmall,
                              ),
                              Text(
                                'Notifications',
                                style: TextStyles.drawerItems,
                              ),
                              Expanded(
                                  child: Container(
                                color: AppColors.secondary,
                                height: ScreenConstant.sizeXL,
                              )),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            share();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: ScreenConstant.sizeLarge,
                                width: ScreenConstant.sizeXXXL,
                                child: Icon(
                                  Icons.share,
                                  color: AppColors.buttonColorSecondary,
                                ),
                              ),
                              Container(
                                width: ScreenConstant.sizeSmall,
                              ),
                              Text(
                                'Share App',
                                style: TextStyles.drawerItems,
                              ),
                              Expanded(
                                  child: Container(
                                color: AppColors.secondary,
                                height: ScreenConstant.sizeXL,
                              )),
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.back();
                              Get.toNamed(aboutUs);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: ScreenConstant.sizeMidLarge,
                                  width: ScreenConstant.sizeXXXL,
                                  child: Image(
                                    fit: BoxFit.contain,
                                    color: AppColors.buttonColorSecondary,
                                    image: AssetImage(
                                      Assets.about,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: ScreenConstant.sizeSmall,
                                ),
                                Text(
                                  'About Us',
                                  style: TextStyles.drawerItems,
                                ),
                                Expanded(
                                    child: Container(
                                  color: AppColors.secondary,
                                  height: ScreenConstant.sizeXL,
                                )),
                              ],
                            )),
                        GestureDetector(
                            onTap: () {
                              Get.back();
                              final SupportTicketController supportController =
                                  Get.put(SupportTicketController());
                              supportController.issueTypeController!.text =
                                  "Contact Request";
                              supportController.isCancel.value = false;
                              Get.to(CustomerCareService());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: ScreenConstant.sizeMidLarge,
                                  width: ScreenConstant.sizeXXXL,
                                  child: Image(
                                    fit: BoxFit.contain,
                                    color: AppColors.buttonColorSecondary,
                                    image: AssetImage(
                                      Assets.customerSupport,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: ScreenConstant.sizeSmall,
                                ),
                                Text(
                                  'Help & Support',
                                  style: TextStyles.drawerItems,
                                ),
                                Expanded(
                                    child: Container(
                                  color: AppColors.secondary,
                                  height: ScreenConstant.sizeXL,
                                )),
                              ],
                            )),
                        GestureDetector(
                          onTap: () {
                            showAlertDialog(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: ScreenConstant.sizeMidLarge,
                                width: ScreenConstant.sizeXXXL,
                                child: Image(
                                  fit: BoxFit.contain,
                                  color: AppColors.buttonColorSecondary,
                                  image: AssetImage(
                                    Assets.logout,
                                  ),
                                ),
                              ),
                              Container(
                                width: ScreenConstant.sizeSmall,
                              ),
                              Text(
                                'Sign out',
                                style: TextStyles.drawerItems,
                              ),
                              Expanded(
                                  child: Container(
                                color: AppColors.secondary,
                                height: ScreenConstant.sizeXL,
                              )),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              //height: ScreenConstant.defaultHeightSeventy,
                              width: ScreenConstant.defaultWidthOneNinety,
                              child: Image(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                  Assets.drawerLogo,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenConstant.sizeSmall,
                    bottom: ScreenConstant.sizeSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    Text(
                      'Version 0.0.2',
                      style: TextStyles.drawerTitle,
                    ),
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    Text(
                      'Developed by Syscogen Cognitech Pvt. Ltd.',
                      style: TextStyles.drawerSubTitle,
                    ),
                    Container(
                      height: ScreenConstant.sizeSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Download GoPotu App Now',
        text:
            'Hey, Give it a try. Download gopotu app using this link - https://play.google.com/store/apps/details?id=com.gopotu.user and use my referral code *${HiveStore().get(Keys.profileData)['referral_code'].toString()}* while joining to get${_splashController.accountSettingsData.value.firstorder!.userwallet!.type == "flat" ? " flat Rs. " : ' '}${_splashController.accountSettingsData.value.firstorder!.userwallet!.value}${_splashController.accountSettingsData.value.firstorder!.userwallet!.type == "percentage" ? '%' : ' '} and your friend will get${_splashController.accountSettingsData.value.firstorder!.parentwallet!.type == "flat" ? " flat\n Rs. " : ' '}${_splashController.accountSettingsData.value.firstorder!.parentwallet!.value}${_splashController.accountSettingsData.value.firstorder!.parentwallet!.type == "percentage" ? '%' : ' '}as wallet cash back after first order complete.',
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
}
