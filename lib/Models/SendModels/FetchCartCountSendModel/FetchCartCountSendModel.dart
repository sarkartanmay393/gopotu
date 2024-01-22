// To parse this JSON data, do
//
//     final fetchCartCountSendModel = fetchCartCountSendModelFromJson(jsonString);

import 'dart:convert';

FetchCartCountSendModel fetchCartCountSendModelFromJson(String str) => FetchCartCountSendModel.fromJson(json.decode(str));

String fetchCartCountSendModelToJson(FetchCartCountSendModel data) => json.encode(data.toJson());

class FetchCartCountSendModel {
  FetchCartCountSendModel({
    this.shopId,
    this.type,
  });

  String? shopId;
  String? type;

  factory FetchCartCountSendModel.fromJson(Map<String, dynamic> json) => FetchCartCountSendModel(
    shopId: json["shop_id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "shop_id": shopId,
    "type": type,
  };
}
