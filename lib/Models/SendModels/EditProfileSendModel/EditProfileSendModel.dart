// To parse this JSON data, do
//
//     final editProfileSendModel = editProfileSendModelFromJson(jsonString);

import 'dart:convert';

EditProfileSendModel editProfileSendModelFromJson(String str) => EditProfileSendModel.fromJson(json.decode(str));

String editProfileSendModelToJson(EditProfileSendModel data) => json.encode(data.toJson());

class EditProfileSendModel {
  EditProfileSendModel({
    this.name,
    this.email,
  });

  String? name;
  String? email;

  factory EditProfileSendModel.fromJson(Map<String, dynamic> json) => EditProfileSendModel(
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
  };
}
