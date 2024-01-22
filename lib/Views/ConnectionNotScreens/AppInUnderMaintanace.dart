import 'package:flutter/material.dart';

import '../../DeviceManager/Assets.dart';
import '../../DeviceManager/Colors.dart';
import '../../DeviceManager/ScreenConstants.dart';

class AppInUnderMaintanace extends StatelessWidget {
  String? mess;
  AppInUnderMaintanace({Key? key, this.mess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(Assets.maintanace)),
          Text("We build somthing new for you",
              style: TextStyle(
                  color: AppColors.loginTitle,
                  fontSize: FontSizeStatic.xl,
                  fontWeight: FontWeight.bold,
                  /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins')),
          Container(
            height: ScreenConstant.sizeSmall,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26),
            child: Text(mess ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.doNotAccount,
                    fontSize: FontSizeStatic.maxMd,
                    /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins')),
          )
        ],
      ),
    );
  }
}
