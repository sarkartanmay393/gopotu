import 'package:flutter/material.dart';

import '../../DeviceManager/Assets.dart';
import '../../DeviceManager/Colors.dart';
import '../../DeviceManager/ScreenConstants.dart';

class ConnectionNotScreens extends StatelessWidget {
  const ConnectionNotScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(Assets.networkOff)),
          Text("Connection Error",
              style: TextStyle(
                  color: AppColors.loginTitle,
                  fontSize: FontSizeStatic.xl,
                  fontWeight: FontWeight.bold,
                  /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins')),
          Container(
            height: ScreenConstant.sizeSmall,
          ),
          Text("Check your network settings and try again",
              style: TextStyle(
                  color: AppColors.loginTitle,
                  fontSize: FontSizeStatic.maxMd,
                  /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins'))
        ],
      ),
    );
  }
}
