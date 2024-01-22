import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/OTPController/OTPController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Views/HomeScreen/HomeScreen.dart';
import 'package:go_potu_user/Views/SignInScreen/SignIn.dart';

import '../../Controller/SignInController/SignInController.dart';

class OTPScreen extends StatefulWidget {

  String? number  ;
  OTPScreen({this.number});

   //Output: Fallback Value



  @override
  _OTPScreenState createState() => new _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen>
    with SingleTickerProviderStateMixin {
  // Constants

  final int time = 30;

  OTPController _otpController = Get.put(OTPController());
  SignInController _signInController = Get.put(SignInController());

  // Variables
  Size? _screenSize;
  int? _currentDigit;
  int? _firstDigit;
  int? _secondDigit;
  int? _thirdDigit;
  int? _fourthDigit;
  // int _fifthDigit;
  // int _sixthDigit;
  String finalNumber = ''; // Declare finalNumber here

  String userName = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;

  Timer? timer;
  int start = 20;


  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  // Returns "Appbar"
  get _getAppbar {
    return new AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: new InkWell(
        borderRadius: BorderRadius.circular(30.0),
        child: new Icon(
          Icons.arrow_back,
          color: Colors.black54,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        "Back",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      ),
    );
  }

  // Return "OTP" input field
  get _getInputField {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: ScreenConstant.sizeSmall,
        ),
        _otpTextField(_firstDigit ),
        _otpTextField(_secondDigit),
        _otpTextField(_thirdDigit ),
        _otpTextField(_fourthDigit),

        // _otpTextField(_fifthDigit),
        // _otpTextField(_sixthDigit),
        Container(
          width: ScreenConstant.sizeSmall,
        ),
      ],
    );
  }

  // Returns "OTP" input part
  get _getInputPart {
    String? phoneNumber = finalNumber;

    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        Container(
          height: ScreenConstant.defaultHeightThirtyFive,
        ),
        Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              AppStrings.verificationCode,
              style: TextStyles.otpTitleText,
            )),
        Container(
          height: ScreenConstant.sizeSmall,
        ),
        Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              AppStrings.wehavesentverificationcode,
              style: TextStyles.otpSubTitleText,
              textAlign: TextAlign.left,
            )),
        Container(
          height: ScreenConstant.sizeSmall,
        ),
        Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFF6F5F8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "+91 $phoneNumber",
                      style: TextStyles.otpSubTitleText,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenConstant.sizeSmall,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.edit))
              ],
            )),
        Container(
          height: ScreenConstant.sizeXXXL,
        ),
        Center(
          child: new Container(
            width: _screenSize!.width,
//        padding: new EdgeInsets.only(bottom: 16.0),
            child: _getInputField,
          ),
        ),
        Container(
          height: ScreenConstant.sizeXXL,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.DoReceivedAnyOtp,
              style: TextStyles.doNotAccount,
            ),
            Container(
              width: ScreenConstant.sizeExtraSmall,
            ),
            GestureDetector(
              onTap: start == 0
                  ? () {
                      setState(() {
                        // _otpController.resendOTPPress();
                        _signInController.signInPress();
                        start = 20;
                        startTimer();
                      });
                    }
                  : null,
              child: Text(
                start == 0 ? "Get a New one" : "${"Resend"}(${start}s)",
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: ScreenConstant.sizeMedium,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'LeagueSpartan'),
              ),
            )
          ],
        ),
        Container(
          height: ScreenConstant.sizeDefault,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            onPressed: () {
              //This is brought here from line 504 and This will concatenate all the otp and send it to server for verification through api call
              var otp = _firstDigit.toString() +
                  _secondDigit.toString() +
                  _thirdDigit.toString() +
                  _fourthDigit.toString();
              // _fifthDigit.toString() +
              // _sixthDigit.toString();
              _otpController.otpVerifyPress(otp, phoneNumber!);

              // this will send the user to the home screen
              // Navigator.push(context,
              //
              //   MaterialPageRoute(
              //       builder: (context) => HomeScreen())
              // );
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    10.0), // Same value as the container's borderRadius
              ),
              backgroundColor:
                  AppColors.buttonColorSecondary, // Background color
            ),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20.0),
              child: Text(
                AppStrings.verifyAndContinue,
                style: TextStyles.bottomTextStyle,
              ),
            ),
          ),
        ),
        _getOtpKeyboard
      ],
    );
  }

  // Returns "Otp" keyboard
  get _getOtpKeyboard {
    return new Container(
        height: _screenSize!.width - 80,
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        _setCurrentDigit(1);
                      }),
                  _otpKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        _setCurrentDigit(2);
                      }),
                  _otpKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        _setCurrentDigit(3);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "4",
                      onPressed: () {
                        _setCurrentDigit(4);
                      }),
                  _otpKeyboardInputButton(
                      label: "5",
                      onPressed: () {
                        _setCurrentDigit(5);
                      }),
                  _otpKeyboardInputButton(
                      label: "6",
                      onPressed: () {
                        _setCurrentDigit(6);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "7",
                      onPressed: () {
                        _setCurrentDigit(7);
                      }),
                  _otpKeyboardInputButton(
                      label: "8",
                      onPressed: () {
                        _setCurrentDigit(8);
                      }),
                  _otpKeyboardInputButton(
                      label: "9",
                      onPressed: () {
                        _setCurrentDigit(9);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new SizedBox(
                    width: 80.0,
                  ),
                  _otpKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        _setCurrentDigit(0);
                      }),
                  _otpKeyboardActionButton(
                      label: new Icon(
                        Icons.backspace,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          // if (_sixthDigit != null) {
                          //   _sixthDigit = null;
                          // } else if (_fifthDigit != null) {
                          //   _fifthDigit = null;
                          // } else
                          if (_fourthDigit != null) {
                            _fourthDigit = null;
                          } else if (_thirdDigit != null) {
                            _thirdDigit = null;
                          } else if (_secondDigit != null) {
                            _secondDigit = null;
                          } else if (_firstDigit != null) {
                            _firstDigit = null;
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  // Overridden methods
  @override
  void initState() {
    FocusManager.instance.primaryFocus!.unfocus();
    startTimer();
    super.initState();

      // Access widget's number property correctly
    finalNumber = widget.number ?? 'Default Value';

      // Use finalNumber as needed

  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    _screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: _getAppbar,
      backgroundColor: Colors.white,
      body: _getInputPart,
    );
  }

  // Returns "Otp custom text field"
Widget _otpTextField(int? digit) {
  return Stack(
    children: [
      Container(
        width: ScreenConstant.defaultHeightFortyFive,
        height: ScreenConstant.defaultHeightFifty,
        alignment: Alignment.center,
        child: Text(
          digit != null ? digit.toString() : "",
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.black,
          ),
        ),
        decoration: BoxDecoration(

          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      if (digit != null)
        Positioned(
          bottom: 0,
          child: Container(
            height: 3,
            width: ScreenConstant.defaultHeightSeventy,
          ),
        ),
    ],
  );
}


  // Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton({String? label, VoidCallback? onPressed}) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(40.0),
        child: new Container(
          height: 80.0,
          width: 80.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: new Center(
            child: new Text(
              label!,
              style: new TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Returns "Otp keyboard action Button"
  _otpKeyboardActionButton({Widget? label, VoidCallback? onPressed}) {
    return new InkWell(
      onTap: onPressed,
      borderRadius: new BorderRadius.circular(40.0),
      child: new Container(
        height: 80.0,
        width: 80.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: new Center(
          child: label,
        ),
      ),
    );
  }

  // Current digit
  void _setCurrentDigit(int i) {
    setState(() {
      _currentDigit = i;
      if (_firstDigit == null) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == null) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == null) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == null) {
        _fourthDigit = _currentDigit;

        // }else if (_fifthDigit == null) {
        //   _fifthDigit = _currentDigit;
        // }else if (_sixthDigit == null) {
        //   _sixthDigit = _currentDigit;

        var otp = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString();
        // _fifthDigit.toString() +
        // _sixthDigit.toString();
        print("OTP IS : $otp");
        // _otpController.otpVerifyPress(otp);
        //Get.offAllNamed(signIn);
        // Verify your otp by here. API call
      }
    });
  }

  void clearOtp() {
    // _sixthDigit = null;
    // _fifthDigit = null;
    _fourthDigit = null;
    _thirdDigit = null;
    _secondDigit = null;
    _firstDigit = null;
    setState(() {});
  }
}
