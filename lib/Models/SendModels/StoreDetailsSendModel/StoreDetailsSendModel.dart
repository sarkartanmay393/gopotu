// To parse this JSON data, do
//
//     final storeDetailsSendModel = storeDetailsSendModelFromJson(jsonString);

import 'dart:convert';

StoreDetailsSendModel storeDetailsSendModelFromJson(String str) => StoreDetailsSendModel.fromJson(json.decode(str));

String storeDetailsSendModelToJson(StoreDetailsSendModel data) => json.encode(data.toJson());

class StoreDetailsSendModel {
  StoreDetailsSendModel({
    this.shopId,
    this.type,
  });

  String? shopId;
  String? type;

  factory StoreDetailsSendModel.fromJson(Map<String, dynamic> json) => StoreDetailsSendModel(
    shopId: json["shop_id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "shop_id": shopId,
    "type": type,
  };
}
