// To parse this JSON data, do
//
//     final guestLoginSendModel = guestLoginSendModelFromJson(jsonString);

import 'dart:convert';

GuestLoginSendModel guestLoginSendModelFromJson(String str) => GuestLoginSendModel.fromJson(json.decode(str));

String guestLoginSendModelToJson(GuestLoginSendModel data) => json.encode(data.toJson());

class GuestLoginSendModel {
  GuestLoginSendModel({
     this.fcmToken,
  });

  String? fcmToken;

  factory GuestLoginSendModel.fromJson(Map<String, dynamic> json) => GuestLoginSendModel(
    fcmToken: json["fcm_token"],
  );

  Map<String, dynamic> toJson() => {
    "fcm_token": fcmToken,
  };
}
