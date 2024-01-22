// To parse this JSON data, do
//
//     final setDefaultAddressSendModel = setDefaultAddressSendModelFromJson(jsonString);

import 'dart:convert';

SetDefaultAddressSendModel setDefaultAddressSendModelFromJson(String str) => SetDefaultAddressSendModel.fromJson(json.decode(str));

String setDefaultAddressSendModelToJson(SetDefaultAddressSendModel data) => json.encode(data.toJson());

class SetDefaultAddressSendModel {
  SetDefaultAddressSendModel({
    this.id,
  });

  String? id;

  factory SetDefaultAddressSendModel.fromJson(Map<String, dynamic> json) => SetDefaultAddressSendModel(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
