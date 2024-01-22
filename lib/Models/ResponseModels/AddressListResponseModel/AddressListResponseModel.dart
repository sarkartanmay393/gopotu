// To parse this JSON data, do
//
//     final addressListResponseModel = addressListResponseModelFromJson(jsonString);

import 'dart:convert';

AddressListResponseModel addressListResponseModelFromJson(String str) =>
    AddressListResponseModel.fromJson(json.decode(str));

String addressListResponseModelToJson(AddressListResponseModel data) =>
    json.encode(data.toJson());

class AddressListResponseModel {
  AddressListResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory AddressListResponseModel.fromJson(Map<String, dynamic> json) =>
      AddressListResponseModel(
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
    this.addresses,
  });

  List<Address>? addresses;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        addresses: List<Address>.from(
            json["addresses"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "addresses": List<dynamic>.from(addresses!.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    this.id,
    this.userId,
    this.guestId,
    this.type,
    this.name,
    this.mobile,
    this.alternativeMobile,
    this.location,
    this.latitude,
    this.longitude,
    this.fullAddress,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
    this.deliverable,
  });

  int? id;
  int? userId;
  dynamic guestId;
  String? type;
  String? name;
  String? mobile;
  String? alternativeMobile;
  String? location;
  String? latitude;
  String? longitude;
  FullAddress? fullAddress;
  int? isDefault;
  String? createdAt;
  String? updatedAt;
  bool? deliverable;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["user_id"],
        guestId: json["guest_id"],
        type: json["type"],
        name: json["name"],
        mobile: json["mobile"],
        alternativeMobile: json["alternative_mobile"] == null
            ? null
            : json["alternative_mobile"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        fullAddress: FullAddress.fromJson(json["full_address"]),
        isDefault: json["is_default"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deliverable: json["deliverable"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "guest_id": guestId,
        "type": type,
        "name": name,
        "mobile": mobile,
        "alternative_mobile":
            alternativeMobile == null ? null : alternativeMobile,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "full_address": fullAddress!.toJson(),
        "is_default": isDefault,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deliverable": deliverable,
      };
}

class FullAddress {
  FullAddress({
    this.addressLine1,
    this.addressLine2,
    this.postalCode,
    this.city,
    this.state,
    this.country,
    this.landmark,
  });

  String? addressLine1;
  dynamic addressLine2;
  String? postalCode;
  String? city;
  String? state;
  String? country;
  String? landmark;

  factory FullAddress.fromJson(Map<String, dynamic> json) => FullAddress(
        addressLine1: json["address_line1"],
        addressLine2: json["address_line2"],
        postalCode: json["postal_code"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        landmark: json["landmark"],
      );

  Map<String, dynamic> toJson() => {
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "postal_code": postalCode,
        "city": city,
        "state": state,
        "country": country,
        "landmark": landmark,
      };
}
