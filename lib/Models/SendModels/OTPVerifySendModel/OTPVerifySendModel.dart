// To parse this JSON data, do
//
//     final otpVerifySendModel = otpVerifySendModelFromJson(jsonString);

import 'dart:convert';

OtpVerifySendModel otpVerifySendModelFromJson(String str) => OtpVerifySendModel.fromJson(json.decode(str));

String otpVerifySendModelToJson(OtpVerifySendModel data) => json.encode(data.toJson());

class OtpVerifySendModel {
  OtpVerifySendModel({
    this.verificationToken,
    this.otp,
    this.guestToken,
    this.mobile
  });

  String? verificationToken;
  String? otp;
  String? mobile;
  String? guestToken;

  factory OtpVerifySendModel.fromJson(Map<String, dynamic> json) => OtpVerifySendModel(
    verificationToken: json["verification_token"],
    otp: json["otp"],
    mobile: json["mobile"],

  );

  Map<String, dynamic> toJson() => {
    "verification_token": verificationToken,
    "otp": otp,
    "mobile": mobile,
    "guest_token":guestToken
  };
}
