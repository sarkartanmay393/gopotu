// To parse this JSON data, do
//
//     final otpVerifyResponseModel = otpVerifyResponseModelFromJson(jsonString);

import 'dart:convert';

OtpVerifyResponseModel otpVerifyResponseModelFromJson(String str) => OtpVerifyResponseModel.fromJson(json.decode(str));

String otpVerifyResponseModelToJson(OtpVerifyResponseModel data) => json.encode(data.toJson());

class OtpVerifyResponseModel {
  OtpVerifyResponseModel({
    this.status,
    this.message,
    this.data,

  });

  String? status;
  String? message;
  dynamic data;


  factory OtpVerifyResponseModel.fromJson(Map<String, dynamic> json) => OtpVerifyResponseModel(
    status: json["status"].toString(),
    message: json["message"],
    data: json["data"] != null ? json["data"]:null,

  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),

  };
}
