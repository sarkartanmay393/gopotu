import 'dart:convert';

GetMyBucketSendModel getMyBucketSendModelFromJson(String str) =>
    GetMyBucketSendModel.fromJson(json.decode(str));

String getMyBucketSendModelToJson(GetMyBucketSendModel data) =>
    json.encode(data.toJson());

class GetMyBucketSendModel {
  GetMyBucketSendModel({
    this.type,
    this.couponCode,
    this.walletUse,
    this.tips,
  });

  String? type;
  String? couponCode;
  String? walletUse;
  double? tips;

  factory GetMyBucketSendModel.fromJson(Map<String, dynamic> json) =>
      GetMyBucketSendModel(
        type: json["type"],
        couponCode: json["coupon_code"],
        walletUse: json["wallet_used"],
        tips: json["tips"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coupon_code": couponCode,
        "wallet_used": walletUse,
        "tips": tips,
      };
}
