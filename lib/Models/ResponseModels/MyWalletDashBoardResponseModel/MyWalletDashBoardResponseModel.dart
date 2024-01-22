// To parse this JSON data, do
//
//     final myWalletDashBoardResponseModel = myWalletDashBoardResponseModelFromJson(jsonString);

import 'dart:convert';

MyWalletDashBoardResponseModel myWalletDashBoardResponseModelFromJson(
        String str) =>
    MyWalletDashBoardResponseModel.fromJson(json.decode(str));

String myWalletDashBoardResponseModelToJson(
        MyWalletDashBoardResponseModel data) =>
    json.encode(data.toJson());

class MyWalletDashBoardResponseModel {
  MyWalletDashBoardResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  WalletData? data;

  factory MyWalletDashBoardResponseModel.fromJson(Map<String, dynamic> json) =>
      MyWalletDashBoardResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? WalletData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class WalletData {
  WalletData({
    this.balance,
    this.totalused,
  });

  String? balance;
  String? totalused;

  factory WalletData.fromJson(Map<String, dynamic> json) => WalletData(
        balance: json["balance"].toString(),
        totalused: json["totalused"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "totalused": totalused,
      };
}
