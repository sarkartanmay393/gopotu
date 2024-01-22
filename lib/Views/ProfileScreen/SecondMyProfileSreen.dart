import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:go_potu_user/Controller/ProfileController/ProfileController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ShareStore.dart';
import 'package:go_potu_user/Views/WalletScreens/UserWalletScreen.dart';

import 'package:flutter_share/flutter_share.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Controller/AddressController/AddressController.dart';
import '../../Controller/SplashController/SplashController.dart';

class SecondMyProfileScreen extends StatelessWidget {
  final ProfileController profileController = Get.find();
  final SplashController _splashController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          AppStrings.MyAccount,
          style: TextStyles.appBarTitle,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(notifications);
            },
            child: Icon(Icons.notifications),
          ),
          Container(
            width: ScreenConstant.sizeMedium,
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(children: <Widget>[
              Container(
                height: ScreenConstant.defaultHeightSeventy,
                color: AppColors.primary,
              ),
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
                  Container(
                    height: ScreenConstant.defaultHeightOneHundred,
                    width: ScreenConstant.defaultHeightOneHundred,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                      border: Border.all(
                        width: 5,
                        color: AppColors.profileCircleBorder,
                      ),
                    ),
                    child: Obx(() => Center(
                            child: Text(
                          profileController.profileName
                              .toString()
                              .substring(0, 1)
                              .toUpperCase(),
                          style: TextStyles.profileNameFirstLetter,
                        ))),
                  ),
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
                    height: ScreenConstant.sizeLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 5, bottom: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.buttonColorSecondary,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Share your code",
                                    style: TextStyle(
                                        fontSize: FontSizeStatic.md,
                                        /* fontFamily: 'Proxima-Regular' */ fontFamily:
                                            'Poppins',
                                        color: AppColors.secondary),
                                  ),
                                  Container(
                                    height: ScreenConstant.sizeMedium,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: ScreenConstant.sizeXXL,
                                            child: Center(
                                                child: Text(
                                              "${HiveStore().get(Keys.profileData)['referral_code']}",
                                              style: TextStyle(
                                                  letterSpacing: 1,
                                                  fontSize: FontSizeStatic.md,
                                                  fontWeight: FontWeight.bold,
                                                  /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                                      'Poppins'),
                                            )),
                                            color: Colors.white,
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
                                            height: ScreenConstant.sizeXXL,
                                            width: ScreenConstant.sizeUltraXXXL,
                                            color: AppColors.secondary
                                                .withOpacity(.8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.copy,
                                                  size: 20,
                                                  color: AppColors
                                                      .buttonColorSecondary,
                                                ),
                                                Text(
                                                  "Copy",
                                                  style: TextStyle(
                                                      fontSize:
                                                          FontSizeStatic.sm,
                                                      color: AppColors
                                                          .buttonColorSecondary,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Proxima-Bold'),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              leading: Container(
                                height:
                                    ScreenConstant.defaultWidthThreeThirtySix,
                                width: ScreenConstant.defaultHeightOneHundred,
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    Assets.referIcon,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: ScreenConstant.sizeSmall,
                          ),
                          Divider(
                            thickness: 1,
                            color: AppColors.secondary.withOpacity(.4),
                          ),
                          Container(
                            height: ScreenConstant.sizeLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              "Refer a friend.",
                              style: TextStyle(
                                  fontSize: FontSizeStatic.md,
                                  /* fontFamily: 'Proxima-Regular' */ fontFamily:
                                      'Poppins',
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
                                              fontSize: FontSizeStatic.md,
                                              /* fontFamily: 'Proxima-Regular' */ fontFamily:
                                                  'Poppins',
                                              color: AppColors.secondary
                                                  .withOpacity(.7)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    openWhatsapp(context);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    child: Image(
                                      image: AssetImage(Assets.whatsapp),
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: ScreenConstant.sizeSmall,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    share();
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.secondary
                                              .withOpacity(.8),
                                          shape: BoxShape.circle),
                                      height: 30,
                                      width: 30,
                                      child: Icon(
                                        Icons.share,
                                        size: 20,
                                        color: AppColors.buttonColorSecondary,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          /*ListTile(
                                title: Text("Refer GOPOTU to a friend and get 25%",style: TextStyle(
                                fontSize: FontSizeStatic.md,
                                    /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
                                    color: AppColors.secondary.withOpacity(.7)
                                ),),
                                subtitle: Text("off your next order!",style: TextStyle(
                                    fontSize: FontSizeStatic.md,
                                    /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
                                    color: AppColors.secondary.withOpacity(.7)
                                ),),
                              ),*/

                          Container(
                            height: ScreenConstant.sizeLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(editProfile);
                    },
                    leading: Container(
                      height: ScreenConstant.sizeXL,
                      width: ScreenConstant.sizeXL,
                      child: Image(
                        fit: BoxFit.contain,
                        color: AppColors.buttonColorSecondary,
                        image: AssetImage(
                          Assets.profile,
                        ),
                      ),
                    ),
                    title: Text(
                      "Edit Account details",
                      style: TextStyles.profileOptionsTitle,
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: AppColors.buttonColorSecondary,
                      size: ScreenConstant.sizeXL,
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeSmall,
                  ),
                  ListTile(
                    onTap: () {
                      final AddressController _addressController =
                          Get.put(AddressController());
                      _addressController.isHomeScreen.value = true;
                      Get.toNamed(addressList);
                    },
                    leading: Icon(
                      Icons.location_on_rounded,
                      color: AppColors.buttonColorSecondary,
                      size: ScreenConstant.sizeXL,
                    ),
                    title: Text(
                      "Manage Address",
                      style: TextStyles.profileOptionsTitle,
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: AppColors.buttonColorSecondary,
                      size: ScreenConstant.sizeXL,
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeSmall,
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(UserWalletScreen());
                    },
                    leading: Icon(
                      Icons.account_balance_wallet,
                      color: AppColors.buttonColorSecondary,
                      size: ScreenConstant.sizeXL,
                    ),
                    title: Text(
                      "My Wallet",
                      style: TextStyles.profileOptionsTitle,
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: AppColors.buttonColorSecondary,
                      size: ScreenConstant.sizeXL,
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeSmall,
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(changePassword);
                    },
                    leading: Icon(
                      Icons.password,
                      color: AppColors.buttonColorSecondary,
                      size: ScreenConstant.sizeXL,
                    ),
                    title: Text(
                      "Change Password",
                      style: TextStyles.profileOptionsTitle,
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: AppColors.buttonColorSecondary,
                      size: ScreenConstant.sizeXL,
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeSmall,
                  ),
                  ListTile(
                    onTap: () {
                      //Get.toNamed(rateUs);
                      showDialog(
                        context: context,
                        builder: (context) => _dialog,
                      );
                    },
                    leading: Container(
                      height: ScreenConstant.sizeXL,
                      width: ScreenConstant.sizeXL,
                      child: Image(
                        fit: BoxFit.contain,
                        color: AppColors.buttonColorSecondary,
                        image: AssetImage(
                          Assets.rate,
                        ),
                      ),
                    ),
                    title: Text(
                      "Rate App",
                      style: TextStyles.profileOptionsTitle,
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: AppColors.buttonColorSecondary,
                      size: ScreenConstant.sizeXL,
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeSmall,
                  ),
                  GestureDetector(
                    onTap: () {
                      share();
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.share,
                        color: AppColors.buttonColorSecondary,
                        size: ScreenConstant.sizeXL,
                      ),
                      title: Text(
                        "Share App",
                        style: TextStyles.profileOptionsTitle,
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.buttonColorSecondary,
                        size: ScreenConstant.sizeXL,
                      ),
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeXL,
                  ),
                  GestureDetector(
                    onTap: () {
                      showAlertDialog(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFfffafa),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: ScreenConstant.sizeLarge,
                          bottom: ScreenConstant.sizeSmall,
                          right: ScreenConstant.sizeLarge,
                          top: ScreenConstant.sizeSmall,
                        ),
                        child: Container(
                          child: Text(
                            "SIGN OUT",
                            style: TextStyles.signOut,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeLarge,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  final _dialog = RatingDialog(
    starSize: 30,
    // your app's name?
    title: Text('Rate Us On App Store'),
    // encourage your user to leave a high rating?
    message: Text('Select Number of Stars 1 - 5 to Rate This App'),
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
            androidAppId: 'shri.complete.fitness.gymtrainingapp',
            iOSAppId: 'com.example.rating');
      }
    },
  );
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

  openWhatsapp(BuildContext context) async {
    var whatsapp = "+91${HiveStore().get(Keys.profileData)['mobile']}";
    var whatsAppURlAndroid =
        "https://wa.me/?text= Hey, Give it a try. Download gopotu app using this link - https://play.google.com/store/apps/details?id=com.gopotu.user and use my referral code *${HiveStore().get(Keys.profileData)['referral_code'].toString()}* while joining to get${_splashController.accountSettingsData.value.firstorder!.userwallet!.type == "flat" ? " flat Rs. " : ' '}${_splashController.accountSettingsData.value.firstorder!.userwallet!.value}${_splashController.accountSettingsData.value.firstorder!.userwallet!.type == "percentage" ? '%25' : ' '} and your friend will get${_splashController.accountSettingsData.value.firstorder!.parentwallet!.type == "flat" ? " flat\n Rs. " : ' '}${_splashController.accountSettingsData.value.firstorder!.parentwallet!.value}${_splashController.accountSettingsData.value.firstorder!.parentwallet!.type == "percentage" ? '%25' : ' '}as wallet cash back after first order complete.";
    var whatAppURLIos =
        "${_splashController.accountSettingsData.value.referralText}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(whatAppURLIos as Uri)) {
        await launchUrl(
          whatAppURLIos as Uri,
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsAppURlAndroid)) {
        await launch(
          whatsAppURlAndroid,
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }
}
