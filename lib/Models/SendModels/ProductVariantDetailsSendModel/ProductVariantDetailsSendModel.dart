// To parse this JSON data, do
//
//     final productVariantDetailsSendModel = productVariantDetailsSendModelFromJson(jsonString);

import 'dart:convert';

ProductVariantDetailsSendModel productVariantDetailsSendModelFromJson(String str) => ProductVariantDetailsSendModel.fromJson(json.decode(str));

String productVariantDetailsSendModelToJson(ProductVariantDetailsSendModel data) => json.encode(data.toJson());

class ProductVariantDetailsSendModel {
  ProductVariantDetailsSendModel({
    this.productId,
    this.variant,
    this.color,
  });

  String? productId;
  String? variant;
  String? color;

  factory ProductVariantDetailsSendModel.fromJson(Map<String, dynamic> json) => ProductVariantDetailsSendModel(
    productId: json["product_id"],
    variant: json["variant"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "variant": variant,
    "color": color,
  };
}
