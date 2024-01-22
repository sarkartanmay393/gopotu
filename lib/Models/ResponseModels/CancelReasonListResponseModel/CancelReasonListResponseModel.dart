// To parse this JSON data, do
//
//     final cancelReasonListResponseModel = cancelReasonListResponseModelFromJson(jsonString);

import 'dart:convert';

CancelReasonListResponseModel cancelReasonListResponseModelFromJson(
        String str) =>
    CancelReasonListResponseModel.fromJson(json.decode(str));

String cancelReasonListResponseModelToJson(
        CancelReasonListResponseModel data) =>
    json.encode(data.toJson());

class CancelReasonListResponseModel {
  CancelReasonListResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory CancelReasonListResponseModel.fromJson(Map<String, dynamic> json) =>
      CancelReasonListResponseModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.reasons,
  });

  List<Reason>? reasons;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        reasons:
            List<Reason>.from(json["reasons"].map((x) => Reason.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reasons": List<dynamic>.from(reasons!.map((x) => x.toJson())),
      };
}

class Reason {
  Reason({
    this.id,
    this.description,
    this.usertype,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? description;
  String? usertype;
  String? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  factory Reason.fromJson(Map<String, dynamic> json) => Reason(
        id: json["id"],
        description: json["description"],
        usertype: json["usertype"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "usertype": usertype,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
