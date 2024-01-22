// To parse this JSON data, do
//
//     final CategoryByShopResponseModel = CategoryByShopResponseModelFromJson(jsonString);

import 'dart:convert';

CategoryByShopResponseModel CategoryByShopResponseModelFromJson(String str) =>
    CategoryByShopResponseModel.fromJson(json.decode(str));

String CategoryByShopResponseModelToJson(CategoryByShopResponseModel data) =>
    json.encode(data.toJson());

class CategoryByShopResponseModel {
  CategoryByShopResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  dynamic? data;

  factory CategoryByShopResponseModel.fromJson(Map<String, dynamic> json) =>
      CategoryByShopResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!,
      };
}



