// To parse this JSON data, do
//
//     final fetchCartCountResponseModel = fetchCartCountResponseModelFromJson(jsonString);

import 'dart:convert';

FetchCartCountResponseModel fetchCartCountResponseModelFromJson(String str) =>
    FetchCartCountResponseModel.fromJson(json.decode(str));

String fetchCartCountResponseModelToJson(FetchCartCountResponseModel data) =>
    json.encode(data.toJson());

class FetchCartCountResponseModel {
  FetchCartCountResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  CartCountData? data;

  factory FetchCartCountResponseModel.fromJson(Map<String, dynamic> json) =>
      FetchCartCountResponseModel(
        status: json["status"],
        message: json["message"],
        data: CartCountData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class CartCountData {
  CartCountData({
    this.cartcount,
    this.carttotal,
  });

  String? cartcount;
  String? carttotal;

  factory CartCountData.fromJson(Map<String, dynamic> json) => CartCountData(
        cartcount:
            json["cartcount"] != null ? json["cartcount"].toString() : null,
        carttotal:
            json["carttotal"] != null ? json["carttotal"].toString() : null,
      );

  Map<String, dynamic> toJson() => {
        "cartcount": cartcount,
        "carttotal": carttotal,
      };
}
