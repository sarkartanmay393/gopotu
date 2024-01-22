// To parse this JSON data, do
//
//     final loginSendModel = loginSendModelFromJson(jsonString);

import 'dart:convert';

LoginSendModel loginSendModelFromJson(String str) => LoginSendModel.fromJson(json.decode(str));

String loginSendModelToJson(LoginSendModel data) => json.encode(data.toJson());

class LoginSendModel {
  LoginSendModel({
    this.mobile,
    this.password,
    this.fcmToken,
    this.guestToken
  });

  String? mobile;
  String? password;
  String? fcmToken;
  String? guestToken;

  factory LoginSendModel.fromJson(Map<String, dynamic> json) => LoginSendModel(
    mobile: json["mobile"],
    password: json["password"],
    fcmToken: json["fcm_token"],
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile,
    "password": password,
    "fcm_token": fcmToken,
    "guest_token":guestToken
  };
}
