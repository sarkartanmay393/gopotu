// To parse this JSON data, do
//
//     final onlinePaymentSendModel = onlinePaymentSendModelFromJson(jsonString);

import 'dart:convert';

OnlinePaymentSendModel onlinePaymentSendModelFromJson(String str) => OnlinePaymentSendModel.fromJson(json.decode(str));

String onlinePaymentSendModelToJson(OnlinePaymentSendModel data) => json.encode(data.toJson());

class OnlinePaymentSendModel {
  OnlinePaymentSendModel({
    this.orderId,
  });

  String? orderId;

  factory OnlinePaymentSendModel.fromJson(Map<String, dynamic> json) => OnlinePaymentSendModel(
    orderId: json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
  };
}
