// To parse this JSON data, do
//
//     final cmsPageSendModel = cmsPageSendModelFromJson(jsonString);

import 'dart:convert';

CmsPageSendModel cmsPageSendModelFromJson(String str) => CmsPageSendModel.fromJson(json.decode(str));

String cmsPageSendModelToJson(CmsPageSendModel data) => json.encode(data.toJson());

class CmsPageSendModel {
  CmsPageSendModel({
    this.slug,
  });

  String? slug;

  factory CmsPageSendModel.fromJson(Map<String, dynamic> json) => CmsPageSendModel(
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
  };
}
