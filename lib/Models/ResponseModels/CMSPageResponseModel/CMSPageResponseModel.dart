// To parse this JSON data, do
//
//     final cmsPageResponseModel = cmsPageResponseModelFromJson(jsonString);

import 'dart:convert';

CmsPageResponseModel cmsPageResponseModelFromJson(String str) =>
    CmsPageResponseModel.fromJson(json.decode(str));

String cmsPageResponseModelToJson(CmsPageResponseModel data) =>
    json.encode(data.toJson());

class CmsPageResponseModel {
  CmsPageResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory CmsPageResponseModel.fromJson(Map<String, dynamic> json) =>
      CmsPageResponseModel(
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
    this.cmscontent,
  });

  Cmscontent? cmscontent;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cmscontent: json["cmscontent"] != null
            ? Cmscontent.fromJson(json["cmscontent"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "cmscontent": cmscontent!.toJson(),
      };
}

class Cmscontent {
  Cmscontent({
    this.id,
    this.slug,
    this.pageName,
    this.pageTitle,
    this.content,
    this.metaTags,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? slug;
  String? pageName;
  String? pageTitle;
  String? content;
  dynamic metaTags;
  dynamic metaTitle;
  dynamic metaDescription;
  dynamic metaKeywords;
  String? createdAt;
  String? updatedAt;

  factory Cmscontent.fromJson(Map<String, dynamic> json) => Cmscontent(
        id: json["id"],
        slug: json["slug"],
        pageName: json["page_name"],
        pageTitle: json["page_title"],
        content: json["content"] != null
            ? json["content"]
            : "NO POLICY CONTENT FOUND",
        metaTags: json["meta_tags"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaKeywords: json["meta_keywords"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "page_name": pageName,
        "page_title": pageTitle,
        "content": content,
        "meta_tags": metaTags,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_keywords": metaKeywords,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
