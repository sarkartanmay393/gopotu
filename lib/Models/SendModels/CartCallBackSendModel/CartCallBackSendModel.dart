// To parse this JSON data, do
//
//     final cartCallBackSendModel = cartCallBackSendModelFromJson(jsonString);

import 'dart:convert';

CartCallBackSendModel cartCallBackSendModelFromJson(String str) => CartCallBackSendModel.fromJson(json.decode(str));

String cartCallBackSendModelToJson(CartCallBackSendModel data) => json.encode(data.toJson());

class CartCallBackSendModel {
  CartCallBackSendModel({
    this.orderId,
  });

  String? orderId;

  factory CartCallBackSendModel.fromJson(Map<String, dynamic> json) => CartCallBackSendModel(
    orderId: json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
  };
}
