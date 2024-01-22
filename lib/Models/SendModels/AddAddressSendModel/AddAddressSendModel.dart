// To parse this JSON data, do
//
//     final addAddressSendModel = addAddressSendModelFromJson(jsonString);

import 'dart:convert';

AddAddressSendModel addAddressSendModelFromJson(String str) => AddAddressSendModel.fromJson(json.decode(str));

String addAddressSendModelToJson(AddAddressSendModel data) => json.encode(data.toJson());

class AddAddressSendModel {
  AddAddressSendModel({
    this.name,
    this.mobile,
    this.location,
    this.latitude,
    this.longitude,
    this.postalCode,
    this.city,
    this.state,
    this.country,
    this.landmark,
    this.type,
    this.alternativePhoneNumber,
    this.addressLine1,
  });

  String? name;
  String? mobile;
  String? location;
  String? latitude;
  String? longitude;
  String? postalCode;
  String? city;
  String? state;
  String? country;
  String? landmark;
  String? type;
  String? alternativePhoneNumber;
  String? addressLine1;

  factory AddAddressSendModel.fromJson(Map<String, dynamic> json) => AddAddressSendModel(
    name: json["name"],
    mobile: json["mobile"],
    location: json["location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    postalCode: json["postal_code"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    landmark: json["landmark"],
    type: json["type"],
    alternativePhoneNumber: json["alternative_mobile"],
    addressLine1: json["address_line1"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile": mobile,
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
    "postal_code": postalCode,
    "city": city,
    "state": state,
    "country": country,
    "landmark": landmark,
    "type": type,
    "alternative_mobile": alternativePhoneNumber,
    "address_line1": addressLine1,
  };
}
