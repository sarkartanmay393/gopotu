// To parse this JSON data, do
//
//     final getSocialLinksResponseModel = getSocialLinksResponseModelFromJson(jsonString);

import 'dart:convert';

GetSocialLinksResponseModel getSocialLinksResponseModelFromJson(String str) => GetSocialLinksResponseModel.fromJson(json.decode(str));

String getSocialLinksResponseModelToJson(GetSocialLinksResponseModel data) => json.encode(data.toJson());

class GetSocialLinksResponseModel {
  GetSocialLinksResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  SocialLinksData? data;

  factory GetSocialLinksResponseModel.fromJson(Map<String, dynamic> json) => GetSocialLinksResponseModel(
    status: json["status"],
    message: json["message"],
    data: SocialLinksData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class SocialLinksData {
  SocialLinksData({
    this.socialLinks,
  });

  List<SocialLink>? socialLinks;

  factory SocialLinksData.fromJson(Map<String, dynamic> json) => SocialLinksData(
    socialLinks: List<SocialLink>.from(json["social_links"].map((x) => SocialLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "social_links": List<dynamic>.from(socialLinks!.map((x) => x.toJson())),
  };
}

class SocialLink {
  SocialLink({
    this.id,
    this.tittle,
    this.link,
    this.icon,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.avatar,
  });

  int? id;
  String? tittle;
  String? link;
  String? icon;
  String? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? avatar;

  factory SocialLink.fromJson(Map<String, dynamic> json) => SocialLink(
    id: json["id"],
    tittle: json["tittle"],
    link: json["link"],
    icon: json["icon"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tittle": tittle,
    "link": link,
    "icon": icon,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "avatar": avatar,
  };
}
