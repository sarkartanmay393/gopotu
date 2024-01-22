// To parse this JSON data, do
//
//     final guestLoginResponseModel = guestLoginResponseModelFromJson(jsonString);

import 'dart:convert';

GuestLoginResponseModel guestLoginResponseModelFromJson(String str) => GuestLoginResponseModel.fromJson(json.decode(str));

String guestLoginResponseModelToJson(GuestLoginResponseModel data) => json.encode(data.toJson());

class GuestLoginResponseModel {
  GuestLoginResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  dynamic data;

  factory GuestLoginResponseModel.fromJson(Map<String, dynamic> json) => GuestLoginResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"]!= null ? json["data"]:null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}
