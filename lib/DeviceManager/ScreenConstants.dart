import './DeviceManeger.dart';
import 'package:flutter/material.dart';

Size screenSize = Size(0,0);
double defaultScreenWidth = 400.0;
double defaultScreenHeight = 810.0;
double screenWidth = defaultScreenWidth;
double screenHeight = defaultScreenHeight;

class ScreenConstant {
  /*Template constants*/
  static double defaultHeightThirtyFive = 32;
  static double defaultHeightSixtyEight = 68;
  static double defaultHeightSixtySeven = 67;

  static double defaultHeightFour = 4;
  static double defaultHeightThree = 3;
  static double defaultHeightNinetyEight = 98;
  static double defaultHeightEightyTwo = 82;
  static double defaultHeightSeventySix = 76;
  static double defaultHeightNinety = 90;
  static double defaultHeightForty = 40;
  static double defaultHeightFortyFive = 45;
  static double defaultHeightFifty = 50;
  static double defaultHeightFiftyFive = 55;
  static double defaultHeightFifteen = 15;
  static double defaultHeightEight = 8;
  static double defaultHeightFive = 5;

  static double defaultHeightTwentyThree = 23;
  static double defaultHeightSixty = 60;
  static double defaultHeightTen = 10;
  //
  static double defaultHeighttwenty = 20;
  // static double defaultHeightEight = 8;
  // static double defaultHeightFive = 5;
  // static double defaultHeightFour = 4;
  static double defaultHeightthirty = 30;
  static double defaultHeightTwentyfive = 25;
  //
  static double defaultHeightSeventy = 70;
  static double defaultHeightTwentyeight = 28;
  // static double defaultHeightTwentyfive = 25;
  static double defaultHeightOneTwenty = 120;
  static double defaultHeightOneThirty = 130;
  static double defaultHeightOneForty = 150;
  static double defaultHeightOneHundred = 100;
  static double defaultHeightOneHundredTen = 110;
  static double defaultHeightOneHundredFifty = 150;
  static double defaultHeightOneHundredNighty = 190;
  static double defaultHeightOneHundredSeventy = 170;
  static double defaultHeightOneHundredEifhty = 180;
  static double defaultHeightTwoHundred = 200;
  static double defaultHeightTwoHundredTen = 280;
  static double defaultHeightThreeHundredFifty = 350;
  static double defaultHeightFourHundred = 350;
  static double defaultHeightFiveHundred = 500;

  static double defaultHeightThreeHundredEighty = 380;
  // static double defaultHeightFiveHundred = 450;
  static double defaultHeightFourHundredFifty = 450;
  static double defaultHeightThreeHundredFortyEight = 248;
  static double defaultHeightSevenHundred = 700;
  static double defaultHeightTwoHundredThirtyFive = 235;

  static double defaultWidthNinetyEight = 98;
  static double defaultWidthOneEighty = 180;
  static double defaultWidthOneSeventy = 170;
  static double defaultWidthThreeThirtySix = 336;
  static double defaultWidthOneHundredSeven = 107;
  static double defaultWidthSixty = 60;
  static double defaultWidthTen = 10;
  static double defaultWidthTwenty = 20;
  static double defaultWidthEighteen = 18;
  static double defaultWidthFourteen = 14;
  static double defaultWidthOneNinety = 210;

  /*Padding & Margin Constants*/
  static double sizeExtraSmall = 5.0;
  static double sizeDefault = 8.0;
  static double sizeSmall = 10.0;
  static double sizeMedium = 15.0;
  static double sizeLarge = 20.0;
  static double sizeMidLarge = 25.0;
  static double sizeExtraLarge = 30.0;
  static double sizeHighest = 160.0;
  static double sizeXL = 30.0;
  static double sizeXXL = 40.0;
  static double sizeXXXL = 50.0;
  static double sizeUltraXXXL = 65.0;

  /*Screen Size dependent Constants*/
  static double screenHeightOneSeventh = screenHeight / 1.5;
  static double screenWidthHalf = screenWidth / 2;
  static double screenWidthThird = screenWidth / 3;
  static double screenWidthFourth = screenWidth / 4;
  static double screenWidthFifth = screenWidth / 5;
  static double screenWidthSixth = screenWidth / 6;
  static double screenWidthTenth = screenWidth / 10;
  static double screenWidthEleven = screenWidth / 11;
  static double screenWidthTwelve = screenWidth / 12;
  static double screenWidthThirteen = screenWidth / 13;
  static double screenWidthFourteen = screenWidth / 14;
  static double screenWidthFifteen = screenWidth / 15;
  static double screenWidthMinimum = screenWidth / 25;

  /*Screen Size dependent Constants*/
  static double screenHeightHalf = screenHeight / 2;
  static double screenHeightThird = screenHeight / 3;
  static double screenHeightFourth = screenHeight / 4;
  static double screenHeightFifth = screenHeight / 5;
  static double screenHeightSixth = screenHeight / 6;
  static double screenHeightEight = screenHeight / 8;
  static double screenHeightTenth = screenHeight / 10;
  static double screenHeightEleven = screenHeight / 11;
  static double screenHeightTwelve = screenHeight / 12;
  static double screenHeightThirteen = screenHeight / 13;
  static double screenHeightFourteen = screenHeight / 14;
  static double screenHeightFifteen = screenHeight / 15;
  static double screenHeightMinimum = screenHeight / 25;

  /*Image Dimensions*/

  static double defaultIconSize = 80.0;
  static double miniIconSize = 66.0;
  static double defaultImageHeight = 120.0;
  static double defaultDialogHeight = 450.0;
  static double defaultMidHeight = 350.0;
  static double defaultImageWidth = screenWidth;
  static double defaultImageWidthThird = screenWidth / 3;
  static double snackBarHeight = 50.0;
  static double texIconSize = 30.0;
  static double drawerIconSize = 25.0;

  /*Default Height&Width*/
  static double defaultHelpBoxHeight = 226.8;
  static double defaultSizeTwoFifty = 250;
  static double defaultSizeThreeTwenty = 320;
  static double defaultSizeFourFifty = 450;
  static double defaultSizeOneTwenty = 120;
  static double defaultSizeOneForty = 140;
  static double defaultSizeOneTen = 110;
  static double defaultIndicatorWidth = screenWidthFourth;

  /*EdgeInsets*/
  static EdgeInsets spacingAllZero = EdgeInsets.all(0);
  static EdgeInsets spacingAllDefault = EdgeInsets.all(sizeDefault);
  static EdgeInsets spacingAllSmall = EdgeInsets.all(sizeSmall);
  static EdgeInsets spacingAllMedium = EdgeInsets.all(sizeMedium);
  static EdgeInsets spacingAllLarge = EdgeInsets.all(sizeLarge);
  static EdgeInsets spacingOnlySmall =
      EdgeInsets.only(top: sizeSmall, bottom: sizeSmall);
  static EdgeInsets spacingLeftOnly = EdgeInsets.only(left: sizeDefault);

  static void setDefaultSize(context) {
    screenSize = MediaQuery.of(context).size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;

    sizeLarge = 20.0;
    sizeXL = 30.0;
    sizeXXL = 40.0;
    sizeXXXL = 50.0;
    sizeUltraXXXL = 65.0;

    screenWidthHalf = screenWidth / 2;
    screenWidthThird = screenWidth / 3;
    screenWidthFourth = screenWidth / 4;
    screenWidthFifth = screenWidth / 5;
    screenWidthSixth = screenWidth / 6;
    screenWidthTenth = screenWidth / 10;
    screenWidthEleven = screenWidth / 11;
    screenWidthTwelve = screenWidth / 12;
    screenWidthThirteen = screenWidth / 13;
    screenWidthFourteen = screenWidth / 14;
    screenWidthFifteen = screenWidth / 15;
    screenWidthMinimum = screenWidth / 25;

    screenHeightHalf = screenHeight / 2;
    screenHeightThird = screenHeight / 3;
    screenHeightFourth = screenHeight / 4;
    screenHeightFifth = screenHeight / 5;
    screenHeightSixth = screenHeight / 6;
    screenHeightEight = screenHeight / 8;
    screenHeightTenth = screenHeight / 10;
    screenHeightEleven = screenHeight / 11;
    screenHeightTwelve = screenHeight / 12;
    screenHeightThirteen = screenHeight / 13;
    screenHeightFourteen = screenHeight / 14;
    screenHeightFifteen = screenHeight / 15;
    screenHeightMinimum = screenHeight / 25;

    defaultIconSize = 80.0;
    defaultImageHeight = 120.0;
    snackBarHeight = 50.0;
    texIconSize = 30.0;

    defaultHelpBoxHeight = 226.8;
    defaultIndicatorWidth = screenWidthFourth;

    spacingAllDefault = EdgeInsets.all(sizeDefault);
    spacingAllSmall = EdgeInsets.all(sizeSmall);

    FontSizeStatic.setDefaultFontSize();
  }

  static void setScreenAwareConstant(context) {
    setDefaultSize(context);
    DeviceManager.instance = DeviceManager(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    FontSizeStatic.setScreenAwareFontSize();

    /*Padding & Margin Constants*/

    sizeExtraSmall = DeviceManager.instance.setWidth(5.0);
    sizeDefault = DeviceManager.instance.setWidth(8.0);
    sizeSmall = DeviceManager.instance.setWidth(10.0);
    sizeMedium = DeviceManager.instance.setWidth(15.0);
    sizeLarge = DeviceManager.instance.setWidth(20.0);
    sizeMidLarge = DeviceManager.instance.setWidth(25.0);
    sizeXL = DeviceManager.instance.setWidth(30.0);
    sizeXXL = DeviceManager.instance.setWidth(40.0);
    sizeXXXL = DeviceManager.instance.setWidth(50.0);
    sizeUltraXXXL = DeviceManager.instance.setWidth(65.0);

    /*EdgeInsets*/
    spacingAllZero = EdgeInsets.all(0);
    spacingAllDefault = EdgeInsets.all(sizeDefault);
    spacingAllSmall = EdgeInsets.all(sizeSmall);
    spacingAllMedium = EdgeInsets.all(sizeMedium);
    spacingAllLarge =
        EdgeInsets.only(right: sizeLarge, bottom: sizeLarge, top: sizeLarge);
    spacingOnlySmall = EdgeInsets.only(
      top: sizeSmall,
      bottom: sizeSmall,
    );
    spacingLeftOnly = EdgeInsets.only(
      left: sizeDefault,
    );

    /*Screen Size dependent Constants*/
    screenWidthHalf = DeviceManager.instance.width / 2;
    screenWidthThird = DeviceManager.instance.width / 3;
    screenWidthFourth = DeviceManager.instance.width / 4;
    screenWidthFifth = DeviceManager.instance.width / 5;
    screenWidthSixth = DeviceManager.instance.width / 6;
    screenWidthTenth = DeviceManager.instance.width / 10;

    /*Image Dimensions*/

    defaultIconSize = DeviceManager.instance.setWidth(80.0);
    miniIconSize = DeviceManager.instance.setWidth(66.0);
    defaultImageHeight = DeviceManager.instance.setHeight(120.0);
    snackBarHeight = DeviceManager.instance.setHeight(50.0);
    texIconSize = DeviceManager.instance.setWidth(30.0);
    drawerIconSize = DeviceManager.instance.setWidth(25.0);

    /*Default Height&Width*/
    defaultHelpBoxHeight = DeviceManager.instance.setHeight(226.8);
    defaultSizeTwoFifty = DeviceManager.instance.setHeight(250);
    defaultSizeThreeTwenty = DeviceManager.instance.setHeight(320);
    defaultSizeFourFifty = DeviceManager.instance.setHeight(450);
    defaultSizeOneTwenty = DeviceManager.instance.setHeight(120);
    defaultSizeOneTen = DeviceManager.instance.setHeight(110);
    defaultIndicatorWidth = screenWidthFourth;

    /* Nimmio Default Height*/
    defaultHeightNinetyEight = DeviceManager.instance.setHeight(98.0);
    defaultHeightEightyTwo = DeviceManager.instance.setHeight(82.0);
    defaultHeightSeventySix = DeviceManager.instance.setHeight(76.0);
    defaultHeightNinety = DeviceManager.instance.setHeight(90.0);
    defaultHeightForty = DeviceManager.instance.setHeight(40.0);
    defaultHeightSixty = DeviceManager.instance.setHeight(60.0);
    defaultHeightTwentyThree = DeviceManager.instance.setHeight(23.0);
    defaultHeightFifteen = DeviceManager.instance.setHeight(15.0);
    defaultHeightTen = DeviceManager.instance.setHeight(10.0);
    defaultHeightSeventy = DeviceManager.instance.setHeight(70.0);
    defaultHeightOneThirty = DeviceManager.instance.setHeight(130.0);
    defaultHeightOneForty = DeviceManager.instance.setHeight(140.0);
    defaultHeightOneHundred = DeviceManager.instance.setHeight(100.0);
    defaultHeightTwoHundred = DeviceManager.instance.setHeight(200.0);
    defaultHeightThreeHundredFifty = DeviceManager.instance.setHeight(350.0);
    defaultHeightTwoHundredTen = DeviceManager.instance.setHeight(280.0);
    defaultHeightFourHundred = DeviceManager.instance.setHeight(350.0);
    defaultHeightFiveHundred = DeviceManager.instance.setHeight(450.0);
    /* Nimmio Default Width*/
    defaultWidthNinetyEight = DeviceManager.instance.setWidth(98.0);
    defaultWidthOneEighty = DeviceManager.instance.setWidth(180.0);
    defaultWidthOneSeventy = DeviceManager.instance.setWidth(170.0);
    defaultWidthThreeThirtySix = DeviceManager.instance.setWidth(336.0);
    defaultWidthOneHundredSeven = DeviceManager.instance.setWidth(107.0);
    defaultWidthSixty = DeviceManager.instance.setWidth(60.0);
    defaultWidthTen = DeviceManager.instance.setWidth(10.0);
    defaultWidthTwenty = DeviceManager.instance.setWidth(20.0);
    defaultWidthOneNinety = DeviceManager.instance.setWidth(210.0);

    /* Template Default Height*/
    defaultHeightThirtyFive = DeviceManager.instance.setHeight(32.0);
    defaultHeightSixtyEight = DeviceManager.instance.setHeight(68.0);
  }
}

class FontSizeStatic {
  static double sm = 11.0;
  static double mdSm = 12.0;
  static double semiSm = 13.0;
  static double md = 14.0;
  static double maxMd = 15.0;
  static double lg = 17.0;
  static double xl = 19.0;
  static double xll = 21.0;
  static double xxl = 25.0;
  static double xxxl = 33.0;


  static setDefaultFontSize() {
    sm = 11.0;
    mdSm = 12.0;
    semiSm = 13.0;
    md = 14.0;
    maxMd = 15.0;
    lg = 17.0;
    xl = 19.0;
    xll = 21.0;
    xxl = 25.0;
    xxxl = 33.0;
  }

  static setScreenAwareFontSize() {
    sm = DeviceManager.instance.setSp(11.0);
    mdSm = DeviceManager.instance.setSp(12.0);
    semiSm = DeviceManager.instance.setSp(13.0);
    md = DeviceManager.instance.setSp(14.0);
    maxMd = DeviceManager.instance.setSp(15.0);
    lg = DeviceManager.instance.setSp(17.0);
    xl = DeviceManager.instance.setSp(19.0);
    xll = DeviceManager.instance.setSp(21.0);
    xxl = DeviceManager.instance.setSp(25.0);
    xxxl = DeviceManager.instance.setSp(33.0);
  }
}
