// To parse this JSON data, do
//
//     final cancelOrderSendModel = cancelOrderSendModelFromJson(jsonString);

import 'dart:convert';

CancelOrderSendModel cancelOrderSendModelFromJson(String str) => CancelOrderSendModel.fromJson(json.decode(str));

String cancelOrderSendModelToJson(CancelOrderSendModel data) => json.encode(data.toJson());

class CancelOrderSendModel {
  CancelOrderSendModel({
    this.orderId,
    this.cancelReason,
  });

  String? orderId;
  String? cancelReason;

  factory CancelOrderSendModel.fromJson(Map<String, dynamic> json) => CancelOrderSendModel(
    orderId: json["order_id"],
    cancelReason: json["cancel_reason"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "cancel_reason": cancelReason,
  };
}
