// To parse this JSON data, do
//
//     final applyCouponSendModel = applyCouponSendModelFromJson(jsonString);

import 'dart:convert';

ApplyCouponSendModel applyCouponSendModelFromJson(String str) => ApplyCouponSendModel.fromJson(json.decode(str));

String applyCouponSendModelToJson(ApplyCouponSendModel data) => json.encode(data.toJson());

class ApplyCouponSendModel {
  ApplyCouponSendModel({
    this.couponCode,
    this.type,
  });

  String? couponCode;
  String? type;

  factory ApplyCouponSendModel.fromJson(Map<String, dynamic> json) => ApplyCouponSendModel(
    couponCode: json["coupon_code"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "coupon_code": couponCode,
    "type": type,
  };
}
