// To parse this JSON data, do
//
//     final searchSendModel = searchSendModelFromJson(jsonString);

import 'dart:convert';

SearchSendModel searchSendModelFromJson(String str) => SearchSendModel.fromJson(json.decode(str));

String searchSendModelToJson(SearchSendModel data) => json.encode(data.toJson());

class SearchSendModel {
  SearchSendModel({
    this.type,
    this.searchkeyword,
  });

  String? type;
  String? searchkeyword;

  factory SearchSendModel.fromJson(Map<String, dynamic> json) => SearchSendModel(
    type: json["type"],
    searchkeyword: json["searchkeyword"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "searchkeyword": searchkeyword,
  };
}
