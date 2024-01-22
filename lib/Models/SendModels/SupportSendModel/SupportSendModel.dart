// To parse this JSON data, do
//
//     final supportSendModel = supportSendModelFromJson(jsonString);

import 'dart:convert';

SupportSendModel supportSendModelFromJson(String str) =>
    SupportSendModel.fromJson(json.decode(str));

String supportSendModelToJson(SupportSendModel data) =>
    json.encode(data.toJson());

class SupportSendModel {
  SupportSendModel({
    this.name,
    this.mobile,
    this.alternativeMobile,
    this.email,
    this.subject,
    this.orderCode,
    this.message,
  });

  String? name;
  String? mobile;
  String? alternativeMobile;
  String? email;
  String? subject;
  String? orderCode;
  String? message;

  factory SupportSendModel.fromJson(Map<String, dynamic> json) =>
      SupportSendModel(
        name: json["name"],
        mobile: json["mobile"],
        alternativeMobile: json["alternate_mobile"],
        email: json["email"],
        subject: json["subject"],
        orderCode: json["order_code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mobile": mobile,
        "alternate_mobile": alternativeMobile,
        "email": email,
        "subject": subject,
        "order_code": orderCode,
        "message": message,
      };
}
