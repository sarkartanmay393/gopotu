// To parse this JSON data, do
//
//     final changeAddressFromCheckoutPageSendModel = changeAddressFromCheckoutPageSendModelFromJson(jsonString);

import 'dart:convert';

ChangeAddressFromCheckoutPageSendModel changeAddressFromCheckoutPageSendModelFromJson(String str) => ChangeAddressFromCheckoutPageSendModel.fromJson(json.decode(str));

String changeAddressFromCheckoutPageSendModelToJson(ChangeAddressFromCheckoutPageSendModel data) => json.encode(data.toJson());

class ChangeAddressFromCheckoutPageSendModel {
  ChangeAddressFromCheckoutPageSendModel({
    this.shopId,
  });

  String? shopId;

  factory ChangeAddressFromCheckoutPageSendModel.fromJson(Map<String, dynamic> json) => ChangeAddressFromCheckoutPageSendModel(
    shopId: json["shop_id"],
  );

  Map<String, dynamic> toJson() => {
    "shop_id": shopId,
  };
}
