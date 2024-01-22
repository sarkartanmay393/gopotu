// To parse this JSON data, do
//
//     final getDashboardSendModel = getDashboardSendModelFromJson(jsonString);

import 'dart:convert';

GetDashboardSendModel getDashboardSendModelFromJson(String str) => GetDashboardSendModel.fromJson(json.decode(str));

String getDashboardSendModelToJson(GetDashboardSendModel data) => json.encode(data.toJson());

class GetDashboardSendModel {
  GetDashboardSendModel({
    this.type,
    this.shopId,
  });

  String? type;
  String? shopId;

  factory GetDashboardSendModel.fromJson(Map<String, dynamic> json) => GetDashboardSendModel(
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "shop_id": shopId,
  };
}
