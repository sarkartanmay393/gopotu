// To parse this JSON data, do
//
//     final getOrderFilterSendModel = getOrderFilterSendModelFromJson(jsonString);

import 'dart:convert';

GetOrderFilterSendModel getOrderFilterSendModelFromJson(String str) => GetOrderFilterSendModel.fromJson(json.decode(str));

String getOrderFilterSendModelToJson(GetOrderFilterSendModel data) => json.encode(data.toJson());

class GetOrderFilterSendModel {
  GetOrderFilterSendModel({
    this.status,
  });

  String? status;

  factory GetOrderFilterSendModel.fromJson(Map<String, dynamic> json) => GetOrderFilterSendModel(
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
  };
}
