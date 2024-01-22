// To parse this JSON data, do
//
//     final ShopByCategory = ShopByCategoryFromJson(jsonString);

import 'dart:convert';

ShopByCategorySendModel ShopByCategoryFromJson(String str) =>
    ShopByCategorySendModel.fromJson(json.decode(str));

String ShopByCategoryToJson(ShopByCategorySendModel data) =>
    json.encode(data.toJson());

class ShopByCategorySendModel {
  ShopByCategorySendModel({this.categoryId, this.storeId
      // required int storeId,
      // this.type,
      });

  int? categoryId;
  int? storeId;
  // String? type;

  factory ShopByCategorySendModel.fromJson(Map<String, dynamic> json) =>
      ShopByCategorySendModel(
        categoryId: json["shop_id"],
        storeId: json["store_id"],
        // type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "shop_id": categoryId,
        "store_id": storeId

        // "type": type,
      };
}
