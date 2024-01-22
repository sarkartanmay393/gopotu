// To parse this JSON data, do
//
//     final getOrderDetailsSendModel = getOrderDetailsSendModelFromJson(jsonString);

import 'dart:convert';

GetOrderDetailsSendModel getOrderDetailsSendModelFromJson(String str) => GetOrderDetailsSendModel.fromJson(json.decode(str));

String getOrderDetailsSendModelToJson(GetOrderDetailsSendModel data) => json.encode(data.toJson());

class GetOrderDetailsSendModel {
  GetOrderDetailsSendModel({
    this.orderId,
  });

  String? orderId;

  factory GetOrderDetailsSendModel.fromJson(Map<String, dynamic> json) => GetOrderDetailsSendModel(
    orderId: json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
  };
}
