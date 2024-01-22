// To parse this JSON data, do
//
//     final loadProductsSendModel = loadProductsSendModelFromJson(jsonString);

import 'dart:convert';

LoadProductsSendModel loadProductsSendModelFromJson(String str) => LoadProductsSendModel.fromJson(json.decode(str));

String loadProductsSendModelToJson(LoadProductsSendModel data) => json.encode(data.toJson());

class LoadProductsSendModel {
  LoadProductsSendModel({
    this.page,
    this.categoryId,
    this.brandId,
    this.searchkey,
    this.shopId,
  });

  String? page;
  String? categoryId;
  String? brandId;
  String? searchkey;
  String? shopId;

  factory LoadProductsSendModel.fromJson(Map<String, dynamic> json) => LoadProductsSendModel(
    page: json["page"],
    categoryId: json["category_id"],
    brandId: json["brand_id"],
    searchkey: json["searchkey"],
    shopId: json["shop_id"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "category_id": categoryId,
    "brand_id": brandId,
    "searchkey": searchkey,
    "shop_id": shopId,
  };
}
