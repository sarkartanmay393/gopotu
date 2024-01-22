// To parse this JSON data, do
//
//     final addToCartSendModel = addToCartSendModelFromJson(jsonString);

import 'dart:convert';

AddToCartSendModel addToCartSendModelFromJson(String str) =>
    AddToCartSendModel.fromJson(json.decode(str));

String addToCartSendModelToJson(AddToCartSendModel data) =>
    json.encode(data.toJson());

class AddToCartSendModel {
  AddToCartSendModel({
    this.shopId,
    this.type,
    this.quantity,
    this.variantId,
    this.strictConfirm,
  });

  String? shopId;
  String? type;
  String? quantity;
  String? variantId;
  String? strictConfirm;

  factory AddToCartSendModel.fromJson(Map<String, dynamic> json) =>
      AddToCartSendModel(
        shopId: json["shop_id"],
        type: json["type"],
        quantity: json["quantity"],
        variantId: json["variant_id"],
      );

  Map<String, dynamic> toJson() => {
        "shop_id": shopId,
        "type": type,
        "quantity": quantity,
        "variant_id": variantId,
        "strictconfirm": strictConfirm,
      };
}
