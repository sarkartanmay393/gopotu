// To parse this JSON data, do
//
//     final makeFinalOrderSendModel = makeFinalOrderSendModelFromJson(jsonString);

import 'dart:convert';

MakeFinalOrderSendModel makeFinalOrderSendModelFromJson(String str) => MakeFinalOrderSendModel.fromJson(json.decode(str));

String makeFinalOrderSendModelToJson(MakeFinalOrderSendModel data) => json.encode(data.toJson());

class MakeFinalOrderSendModel {
  MakeFinalOrderSendModel({
     this.shopId,
     this.type,
     this.addressId,
     this.paymentMode,
     this.couponCode,
     this.walletUse,
  });

  String? shopId;
  String? type;
  String? addressId;
  String? paymentMode;
  String? couponCode;
  String? walletUse;

  factory MakeFinalOrderSendModel.fromJson(Map<String, dynamic> json) => MakeFinalOrderSendModel(
    shopId: json["shop_id"],
    type: json["type"],
    addressId: json["address_id"],
    paymentMode: json["payment_mode"],
    couponCode: json["coupon_code"], walletUse: '',
  );

  Map<String, dynamic> toJson() => {
    "shop_id": shopId,
    "type": type,
    "address_id": addressId,
    "payment_mode": paymentMode,
    "coupon_code": couponCode,
    "wallet_used":walletUse
  };
}
