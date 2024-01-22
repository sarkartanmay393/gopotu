import 'package:flutter/material.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';

import '../../DeviceManager/Assets.dart';
import '../../DeviceManager/Colors.dart';
import '../../DeviceManager/ScreenConstants.dart';
import 'package:store_redirect/store_redirect.dart';

class AppInUpdate extends StatelessWidget {
  const AppInUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(Assets.appUpdate)),
          Text("New version available",
              style: TextStyle(
                  color: AppColors.loginTitle,
                  fontSize: FontSizeStatic.xl,
                  fontWeight: FontWeight.bold,
                  /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins')),
          Container(
            height: ScreenConstant.sizeSmall,
          ),
          Text("Please, update app to new version to continue.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.loginTitle,
                  fontSize: FontSizeStatic.maxMd,
                  /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins')),
          Container(
            height: ScreenConstant.sizeXXL,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: AppButton(
              width: screenWidth,
              buttonText: "Update",
              onPressed: () {
                StoreRedirect.redirect(
                    androidAppId: 'com.gopotu.user',
                    iOSAppId: 'com.gopotu.user');
              },
            ),
          )
        ],
      ),
    );
  }
}
