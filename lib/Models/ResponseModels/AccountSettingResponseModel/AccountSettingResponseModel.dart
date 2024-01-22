// To parse this JSON data, do
//
//     final accountSettingResponseModel = accountSettingResponseModelFromJson(jsonString);

import 'dart:convert';

AccountSettingResponseModel accountSettingResponseModelFromJson(String str) =>
    AccountSettingResponseModel.fromJson(json.decode(str));

String accountSettingResponseModelToJson(AccountSettingResponseModel data) =>
    json.encode(data.toJson());

class AccountSettingResponseModel {
  AccountSettingResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory AccountSettingResponseModel.fromJson(Map<String, dynamic> json) =>
      AccountSettingResponseModel(
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
    this.contactDetails,
    this.firstorder,
    this.appsettings,
    this.referralText,
  });

  ContactDetails? contactDetails;
  Firstorder? firstorder;
  Appsettings? appsettings;
  String? referralText;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        contactDetails: ContactDetails.fromJson(json["contact_details"]),
        firstorder: Firstorder.fromJson(json["firstorder"]),
        appsettings: Appsettings.fromJson(json["appsettings"]),
        referralText: json["referral_text"],
      );

  Map<String, dynamic> toJson() => {
        "contact_details": contactDetails!.toJson(),
        "firstorder": firstorder!.toJson(),
        "appsettings": appsettings!.toJson(),
        "referral_text": referralText,
      };
}

class Appsettings {
  Appsettings({
    this.version,
    this.maintenanceMessage,
  });

  String? version;
  dynamic maintenanceMessage;

  factory Appsettings.fromJson(Map<String, dynamic> json) => Appsettings(
        version: json["version"],
        maintenanceMessage: json["maintenance_message"],
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "maintenance_message": maintenanceMessage,
      };
}

class ContactDetails {
  ContactDetails({
    this.mobile,
    this.whatsapp,
    this.email,
    this.address,
  });

  String? mobile;
  String? whatsapp;
  String? email;
  String? address;

  factory ContactDetails.fromJson(Map<String, dynamic> json) => ContactDetails(
        mobile: json["mobile"],
        whatsapp: json["whatsapp"],
        email: json["email"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "whatsapp": whatsapp,
        "email": email,
        "address": address,
      };
}

class Firstorder {
  Firstorder({
    this.userwallet,
    this.parentwallet,
  });

  Wallet? userwallet;
  Wallet? parentwallet;

  factory Firstorder.fromJson(Map<String, dynamic> json) => Firstorder(
        userwallet: Wallet.fromJson(json["userwallet"]),
        parentwallet: Wallet.fromJson(json["parentwallet"]),
      );

  Map<String, dynamic> toJson() => {
        "userwallet": userwallet!.toJson(),
        "parentwallet": parentwallet!.toJson(),
      };
}

class Wallet {
  Wallet({
    this.type,
    this.value,
  });

  String? type;
  int? value;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}
