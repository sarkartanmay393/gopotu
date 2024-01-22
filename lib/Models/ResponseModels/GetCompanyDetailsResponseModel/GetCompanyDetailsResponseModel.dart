// To parse this JSON data, do
//
//     final getCompanyDetailsResponseModel = getCompanyDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

GetCompanyDetailsResponseModel getCompanyDetailsResponseModelFromJson(String str) => GetCompanyDetailsResponseModel.fromJson(json.decode(str));

String getCompanyDetailsResponseModelToJson(GetCompanyDetailsResponseModel data) => json.encode(data.toJson());

class GetCompanyDetailsResponseModel {
  GetCompanyDetailsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  CompanyDetailsData? data;

  factory GetCompanyDetailsResponseModel.fromJson(Map<String, dynamic> json) => GetCompanyDetailsResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] != null ?CompanyDetailsData.fromJson(json["data"]):null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class CompanyDetailsData {
  CompanyDetailsData({
    this.contactDetails,
  });

  ContactDetails? contactDetails;

  factory CompanyDetailsData.fromJson(Map<String, dynamic> json) => CompanyDetailsData(
    contactDetails: json["contact_details"]!= null ?ContactDetails.fromJson(json["contact_details"]):null,
  );

  Map<String, dynamic> toJson() => {
    "contact_details": contactDetails!.toJson(),
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
