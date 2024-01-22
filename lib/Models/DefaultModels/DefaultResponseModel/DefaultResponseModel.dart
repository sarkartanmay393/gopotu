// To parse this JSON data, do
//
//     final defaultResponseModel = defaultResponseModelFromJson(jsonString);

import 'dart:convert';

DefaultResponseModel defaultResponseModelFromJson(String str) =>
    DefaultResponseModel.fromJson(json.decode(str));

String defaultResponseModelToJson(DefaultResponseModel data) =>
    json.encode(data.toJson());

class DefaultResponseModel {
  DefaultResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  dynamic data;

  factory DefaultResponseModel.fromJson(Map<String, dynamic> json) =>
      DefaultResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? json["data"] : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}
