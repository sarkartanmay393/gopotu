// To parse this JSON data, do
//
//     final loadCategorySendModel = loadCategorySendModelFromJson(jsonString);

import 'dart:convert';

LoadCategorySendModel loadCategorySendModelFromJson(String str) =>
    LoadCategorySendModel.fromJson(json.decode(str));

String loadCategorySendModelToJson(LoadCategorySendModel data) =>
    json.encode(data.toJson());

class LoadCategorySendModel {
  LoadCategorySendModel({required this.type, required this.parentId, required this.shopId});

  String type;
  String parentId;
  String shopId;

  factory LoadCategorySendModel.fromJson(Map<String, dynamic> json) =>
      LoadCategorySendModel(
        type: json["type"],
        parentId: json["parent_id"],
        shopId: json["shop_id"],
      );

  Map<String, dynamic> toJson() =>
      {"type": type, "parent_id": parentId, "shop_id": shopId};
}
