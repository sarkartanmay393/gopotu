// To parse this JSON data, do
//
//     final returnRefundDetailsSendModel = returnRefundDetailsSendModelFromJson(jsonString);

import 'dart:convert';

ReturnRefundDetailsSendModel returnRefundDetailsSendModelFromJson(String str) =>
    ReturnRefundDetailsSendModel.fromJson(json.decode(str));

String returnRefundDetailsSendModelToJson(ReturnRefundDetailsSendModel data) =>
    json.encode(data.toJson());

class ReturnRefundDetailsSendModel {
  ReturnRefundDetailsSendModel({
    this.returnreplacementId,
  });

  String? returnreplacementId;

  factory ReturnRefundDetailsSendModel.fromJson(Map<String, dynamic> json) =>
      ReturnRefundDetailsSendModel(
        returnreplacementId: json["returnreplacement_id"],
      );

  Map<String, dynamic> toJson() => {
        "returnreplacement_id": returnreplacementId,
      };
}
