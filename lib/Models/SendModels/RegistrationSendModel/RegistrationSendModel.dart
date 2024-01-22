// To parse this JSON data, do
//
//     final registrationSendModel = registrationSendModelFromJson(jsonString);

import 'dart:convert';

RegistrationSendModel registrationSendModelFromJson(String str) => RegistrationSendModel.fromJson(json.decode(str));

String registrationSendModelToJson(RegistrationSendModel data) => json.encode(data.toJson());

class RegistrationSendModel {
  RegistrationSendModel({
    this.name,
    this.email,
    // this.mobile,
    // this.password,
    // this.passwordConfirmation,
    // this.guestToken,
    this.referralCode
  });

  String? name;
  String? email;
  // String mobile;
  // String password;
  // String passwordConfirmation;
  // String guestToken;
  String? referralCode;

  factory RegistrationSendModel.fromJson(Map<String, dynamic> json) => RegistrationSendModel(
    name: json["name"],
    email: json["email"],
    // mobile: json["mobile"],
    // password: json["password"],
    // passwordConfirmation: json["password_confirmation"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    // "mobile": mobile,
    // "password": password,
    // "password_confirmation": passwordConfirmation,
    // "guest_token":guestToken,
    "referred_code":referralCode
  };
}
