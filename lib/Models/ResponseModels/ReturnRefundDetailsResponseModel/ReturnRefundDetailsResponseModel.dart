// To parse this JSON data, do
//
//     final returnRefundDetailsResponseModel = returnRefundDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

ReturnRefundDetailsResponseModel returnRefundDetailsResponseModelFromJson(
        String str) =>
    ReturnRefundDetailsResponseModel.fromJson(json.decode(str));

String returnRefundDetailsResponseModelToJson(
        ReturnRefundDetailsResponseModel data) =>
    json.encode(data.toJson());

class ReturnRefundDetailsResponseModel {
  ReturnRefundDetailsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory ReturnRefundDetailsResponseModel.fromJson(
          Map<String, dynamic> json) =>
      ReturnRefundDetailsResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.returnreplace,
  });

  Returnreplace? returnreplace;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        returnreplace: json["returnreplace"] != null
            ? Returnreplace.fromJson(json["returnreplace"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "returnreplace": returnreplace!.toJson(),
      };
}

class Returnreplace {
  Returnreplace({
    this.id,
    this.code,
    this.statusLog,
    this.returnreplacementItems,
  });

  int? id;

  String? code;

  List<StatusLog>? statusLog;

  List<ReturnreplacementItem>? returnreplacementItems;

  factory Returnreplace.fromJson(Map<String, dynamic> json) => Returnreplace(
        id: json["id"],
        code: json["code"],
        statusLog: json["status_log"] != null
            ? List<StatusLog>.from(
                json["status_log"].map((x) => StatusLog.fromJson(x)))
            : null,
        returnreplacementItems: json["returnreplacement_items"] != null
            ? List<ReturnreplacementItem>.from(json["returnreplacement_items"]
                .map((x) => ReturnreplacementItem.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "status_log": List<dynamic>.from(statusLog!.map((x) => x.toJson())),
        "returnreplacement_items":
            List<dynamic>.from(returnreplacementItems!.map((x) => x.toJson())),
      };
}

class StatusLog {
  StatusLog({
    this.key,
    this.label,
    this.timestamp,
  });

  String? key;
  String? label;
  DateTime? timestamp;

  factory StatusLog.fromJson(Map<String, dynamic> json) => StatusLog(
        key: json["key"],
        label: json["label"],
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "label": label,
        "timestamp": timestamp == null ? null : timestamp!.toIso8601String(),
      };
}

class ReturnreplacementItem {
  ReturnreplacementItem({
    this.orderproduct,
  });

  Orderproduct? orderproduct;

  factory ReturnreplacementItem.fromJson(Map<String, dynamic> json) =>
      ReturnreplacementItem(
        orderproduct: Orderproduct.fromJson(json["orderproduct"]),
      );

  Map<String, dynamic> toJson() => {
        "orderproduct": orderproduct!.toJson(),
      };
}

class Orderproduct {
  Orderproduct({
    this.variantSelected,
    this.quantity,
    this.subTotal,
    this.product,
  });

  VariantSelected? variantSelected;

  int? quantity;
  int? subTotal;

  Product? product;

  factory Orderproduct.fromJson(Map<String, dynamic> json) => Orderproduct(
        variantSelected: json["variant_selected"] != null
            ? VariantSelected.fromJson(json["variant_selected"])
            : null,
        quantity: json["quantity"],
        subTotal: json["sub_total"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "variant_selected": variantSelected!.toJson(),
        "quantity": quantity,
        "sub_total": subTotal,
        "product": product!.toJson(),
      };
}

class Product {
  Product({
    this.details,
  });

  Details? details;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        details: Details.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "details": details?.toJson(),
      };
}

class Details {
  Details({
    this.name,
    this.imagePath,
    this.brand,
  });

  String? name;

  String? imagePath;

  Brand? brand;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        name: json["name"],
        imagePath: json["image_path"],
        brand: Brand.fromJson(json["brand"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image_path": imagePath,
        "brand": brand!.toJson(),
      };
}

class Brand {
  Brand({
    this.name,
  });

  String? name;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class VariantSelected {
  VariantSelected({
    this.colorName,
    this.variantName,
  });

  String? colorName;
  String? variantName;

  factory VariantSelected.fromJson(Map<String, dynamic> json) =>
      VariantSelected(
        colorName: json["color_name"] == null ? "" : json["color_name"],
        variantName: json["variant_name"] == null ? "" : json["variant_name"],
      );

  Map<String, dynamic> toJson() => {
        "color_name": colorName,
        "variant_name": variantName,
      };
}
