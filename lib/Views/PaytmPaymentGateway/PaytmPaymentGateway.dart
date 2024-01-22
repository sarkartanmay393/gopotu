import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/MyBucketController/MyBucketController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Views/CartScreen/OrderPlacedScreen.dart';
import 'package:http/http.dart' as http;
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

class PaytmConfig {
  final MyBucketController _myBucketController = Get.find();
  /*final String _mid = "VsisMx22532282245367";
  final String _mKey = "PwqO#0I0lNM%tFwl";
  final String _website = "DEFAULT";
  final String _url =
      'https://flutter-paytm-backend.herokuapp.com/generateTxnToken';

  String get mid => _mid;
  String get mKey => _mKey;
  String get website => _website;
  String get url => _url;

  String getMap(double amount, String callbackUrl, String orderId) {
    return json.encode({
      "mid": mid,
      "key_secret": mKey,
      "website": website,
      "orderId": orderId,
      "amount": amount.toString(),
      "callbackUrl": callbackUrl,
      "custId": "122",
    });
  }

  Future<void> generateTxnToken(double amount, String orderId) async {
    final callBackUrl =
        'https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=$orderId';
    final body = getMap(amount, callBackUrl, orderId);

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {'Content-type': "application/json"},
      );
      String txnToken = response.body;

      await initiateTransaction(orderId, amount, txnToken, callBackUrl);
    } catch (e) {
      print(e);
    }
  }*/

  Future<void> initiateTransaction(
    String orderId,
    double amount,
    String txnToken,
    String callBackUrl,
    String mid,
  ) async {
    String result = '';
    try {
      var response = AllInOneSdk.startTransaction(
        mid,
        orderId,
        amount.toString(),
        txnToken,
        callBackUrl,
        true,
        false,
      );
      response.then((value) {
        // Transaction successfull
        print("Value :$value}");
        _myBucketController.cartCallBackPress();
      }).catchError((onError) {
        if (onError is PlatformException) {
          result = onError.message! + " \n  " + onError.details.toString();
          Get.snackbar(
            "Sorry!",
            result,
            backgroundColor: AppColors.secondary,
            icon: Icon(
              Icons.error_outline_sharp,
              color: Colors.red,
            ),
            titleText: Text(
              "Sorry!",
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the title
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              result,
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the message
              ),
            ),
          );
          print(result);
        } else {
          result = onError.toString();
          Get.snackbar(
            "Sorry!",
            result,
            backgroundColor: AppColors.secondary,
            icon: Icon(
              Icons.error_outline_sharp,
              color: Colors.red,
            ),
            titleText: Text(
              "Sorry!",
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the title
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              result,
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the message
              ),
            ),
          );
          print(result);
        }
      });
    } catch (err) {
      // Transaction failed
      result = err.toString();
      print(result);
      Get.snackbar(
        "Sorry!",
        result,
        backgroundColor: AppColors.secondary,
        icon: Icon(
          Icons.error_outline_sharp,
          color: Colors.red,
        ),
        titleText: Text(
          "Sorry!",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the title
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: Text(
          result,
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the message
          ),
        ),
      );
    }
  }
}
