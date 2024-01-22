// To parse this JSON data, do
//
//     final productDetailsSendModel = productDetailsSendModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsSendModel productDetailsSendModelFromJson(String str) => ProductDetailsSendModel.fromJson(json.decode(str));

String productDetailsSendModelToJson(ProductDetailsSendModel data) => json.encode(data.toJson());

class ProductDetailsSendModel {
  ProductDetailsSendModel({
    this.productId,
  });

  String? productId;

  factory ProductDetailsSendModel.fromJson(Map<String, dynamic> json) => ProductDetailsSendModel(
    productId: json["product_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
  };
}
