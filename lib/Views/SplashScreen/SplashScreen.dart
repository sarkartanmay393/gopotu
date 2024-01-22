import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Views/ConnectionNotScreens/AppInUpdate.dart';
import 'package:go_potu_user/Widgets/SplashWidgets/SplashLogoWidgets.dart';

import '../../Controller/AddressController/AddressController.dart';
import '../../Controller/ContectivityController/ContectivityController.dart';
import '../../Controller/DashboardController/DashboardController.dart';
import '../../Controller/SplashController/SplashController.dart';
import '../../main.dart';
import '../ConnectionNotScreens/AppInUnderMaintanace.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<dynamic> onSelectNotification(String payload) async {
    /*Do whatever you want to do on notification click. In this case, I'll show an alert dialog*/
    print("payload");
  }

  SplashController _splashController = Get.put(SplashController());

  ContectivityController _contectivityController = Get.put(ContectivityController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HiveStore().initBox();

    _splashController.getAccountSetting(false).then((value) {
      debugPrint("Value --- $value");
      if (value) {
        if (_splashController.isUpdate.value) {
          print("Update");
          Get.offAll(AppInUpdate());
        } else {
          Get.offAll(AppInUnderMaintanace(
            mess: _splashController.maintenanceMess.value,
          ));
        }
      } else {
        print("Value2 - $value");
        Future.delayed(const Duration(seconds: 7), () async {
          if (_contectivityController.isNotConnectionPage.value &&
              _contectivityController.isNotLocationPage.value &&
              Get.currentRoute != "/ConnectionNotScreens" &&
              Get.currentRoute != "/LocationPermissionNotAvailable") {
            _saveDeviceToken();
            var initializationSettingsAndroid =
            new AndroidInitializationSettings('@mipmap/ic_launcher');
            var initializationSettingsIOS = DarwinInitializationSettings();
            var initializationSettings = InitializationSettings(
                android: initializationSettingsAndroid,
                iOS: initializationSettingsIOS);

            flutterLocalNotificationsPlugin.initialize(initializationSettings,
                onDidReceiveNotificationResponse: (NotificationResponse response) async {
                  // Handle notification interaction here
                  print("User interacted with notification. Action: ${response.actionId}, Payload: ${response.payload}");
                } );
            FirebaseMessaging.instance.requestPermission();
            FirebaseMessaging.onMessage.listen((RemoteMessage message) {
              RemoteNotification? notification = message.notification;
              AndroidNotification? android;
              AppleNotification? ios;
              if (GetPlatform.isIOS) {
                ios = message.notification?.apple;
                if (notification != null && ios != null) {
                  flutterLocalNotificationsPlugin.show(
                      notification.hashCode,
                      notification.title,
                      notification.body,
                      NotificationDetails(
                        iOS: DarwinNotificationDetails(),
                      ));
                }
              } else {
                android = message.notification!.android;
                if (notification != null && android != null) {
                  flutterLocalNotificationsPlugin.show(
                      notification.hashCode,
                      notification.title,
                      notification.body,
                      NotificationDetails(
                        android: AndroidNotificationDetails(
                          channel.id,
                          channel.name,

                          //  icon: 'launcher_icon',
                        ),
                      ));
                }
              }
              print("Message : ${message.data}");
            });

            FirebaseMessaging.onMessageOpenedApp
                .listen((RemoteMessage message) {
              print('A new onMessageOpenedApp event was published!');
            });
            String? deviceId = await _getId();

            if (deviceId != null) {
              await HiveStore().put(Keys.deviceID, deviceId);
              debugPrint("========DeviceID " + deviceId);
            }
            String? accessToken = await HiveStore().get(
              Keys.accessToken,
            );
            String? guestToken = await HiveStore().get(
              Keys.guestToken,
            );
            String? landingShow = await HiveStore().get(
              Keys.landingShow,
            );
            String? isDefaultAddress = await HiveStore().get(
              Keys.isDefaultAddressSet,
            );
            HiveStore().put(Keys.isDefaultAddressSet, "false");
            if (landingShow == "true") {
              print("isDefaultAddress: $isDefaultAddress");
              if (accessToken != null || guestToken != null) {
                if (isDefaultAddress == "false" || isDefaultAddress == null) {
                  // Get.offAllNamed(addressList);
                  // navigateToDashboard();
                  Get.offAllNamed(loading);
                } else {
                  // Call navigateToDashboard when you want to start the process
                  // navigateToDashboard();

                  Get.offAllNamed(loading);
                }
              } else {
                Get.offAllNamed(signIn);
              }
            } else {
              Get.offAllNamed(landing);
            }
          }
        });
      }
    });

    // Timer(Duration(seconds: 7), () async {

    // });
  }

  @override
  Widget build(BuildContext context) {
    ScreenConstant.setScreenAwareConstant(context);
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image:
        //     AssetImage('assets/splash.jpg'), // Replace with your image path
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SplashLogoWidget(
                  padding:
                  EdgeInsets.all(ScreenConstant.defaultHeightOneHundred),
                  image: Assets.splashGif,
                ),
              ),
              // activate the below column to se the developed by
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.developBy,
                        style: TextStyles.splashBottomTitle,
                      ),
                      Container(
                        width: ScreenConstant.sizeExtraSmall,
                      ),
                      Text(
                        AppStrings.syscogen,
                        style: TextStyles.splashBottomSubTitle,
                      )
                    ],
                  ),
                  /*Container(
                    height: ScreenConstant.sizeExtraSmall,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.technologyPartner,style: TextStyles.splashBottomTitle,),
                      Container(
                        width: ScreenConstant.sizeSmall,
                      ),
                      Text(AppStrings.teamTechInVein,style: TextStyles.splashBottomSubTitle,)
                    ],
                  )*/
                ],
              ),
              /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(AppStrings.developBy,style: TextStyles.splashBottomTitle,),
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    Text(AppStrings.syscogen,style: TextStyles.splashBottomSubTitle,)
                  ],
                ),
                Container(
                  width: ScreenConstant.sizeSmall,
                ),
                Container(
                  width: 1,
                  height: ScreenConstant.sizeXL,
                  color: AppColors.accentColor.withOpacity(.1),
                ),
                Container(
                  width: ScreenConstant.sizeSmall,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.technologyPartner,style: TextStyles.splashBottomTitle,),
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    Text(AppStrings.teamTechInVein,style: TextStyles.splashBottomSubTitle,)
                  ],
                )
              ],
            ),*/
              Container(
                height: ScreenConstant.sizeXL,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

  _saveDeviceToken() async {
    await HiveStore().initBox();
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM token : $fcmToken");
    if (fcmToken != null) {
      await HiveStore().put(Keys.playerID, fcmToken);
      // Hive.box(HiveString.hiveName).put(HiveString.fcmToken,fcmToken);
    }
  }
}
