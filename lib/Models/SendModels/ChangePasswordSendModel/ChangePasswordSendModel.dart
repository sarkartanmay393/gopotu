// To parse this JSON data, do
//
//     final changePasswordSendModel = changePasswordSendModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordSendModel changePasswordSendModelFromJson(String str) => ChangePasswordSendModel.fromJson(json.decode(str));

String changePasswordSendModelToJson(ChangePasswordSendModel data) => json.encode(data.toJson());

class ChangePasswordSendModel {
  ChangePasswordSendModel({
    this.currentPassword,
    this.newPassword,
    this.newPasswordConfirmation,
  });

  String? currentPassword;
  String? newPassword;
  String? newPasswordConfirmation;

  factory ChangePasswordSendModel.fromJson(Map<String, dynamic> json) => ChangePasswordSendModel(
    currentPassword: json["current_password"],
    newPassword: json["new_password"],
    newPasswordConfirmation: json["new_password_confirmation"],
  );

  Map<String, dynamic> toJson() => {
    "current_password": currentPassword,
    "new_password": newPassword,
    "new_password_confirmation": newPasswordConfirmation,
  };
}
