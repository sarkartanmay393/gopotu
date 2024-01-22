// To parse this JSON data, do
//
//     final resetPasswordSendModel = resetPasswordSendModelFromJson(jsonString);

import 'dart:convert';

ResetPasswordSendModel resetPasswordSendModelFromJson(String str) => ResetPasswordSendModel.fromJson(json.decode(str));

String resetPasswordSendModelToJson(ResetPasswordSendModel data) => json.encode(data.toJson());

class ResetPasswordSendModel {
  ResetPasswordSendModel({
    this.mobile,
  });

  String? mobile;

  factory ResetPasswordSendModel.fromJson(Map<String, dynamic> json) => ResetPasswordSendModel(
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile,
  };
}
