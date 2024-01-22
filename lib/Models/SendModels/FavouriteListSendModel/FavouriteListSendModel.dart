// To parse this JSON data, do
//
//     final favouriteListSendModel = favouriteListSendModelFromJson(jsonString);

import 'dart:convert';

FavouriteListSendModel favouriteListSendModelFromJson(String str) => FavouriteListSendModel.fromJson(json.decode(str));

String favouriteListSendModelToJson(FavouriteListSendModel data) => json.encode(data.toJson());

class FavouriteListSendModel {
  FavouriteListSendModel({
    this.type,
  });

  String? type;

  factory FavouriteListSendModel.fromJson(Map<String, dynamic> json) => FavouriteListSendModel(
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
  };
}
