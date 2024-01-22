// To parse this JSON data, do
//
//     final productVariantDetailsResponseModel = productVariantDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

ProductVariantDetailsResponseModel productVariantDetailsResponseModelFromJson(
        String str) =>
    ProductVariantDetailsResponseModel.fromJson(json.decode(str));

String productVariantDetailsResponseModelToJson(
        ProductVariantDetailsResponseModel data) =>
    json.encode(data.toJson());

class ProductVariantDetailsResponseModel {
  ProductVariantDetailsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  ProductVariantData? data;

  factory ProductVariantDetailsResponseModel.fromJson(
          Map<String, dynamic> json) =>
      ProductVariantDetailsResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null
            ? ProductVariantData.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class ProductVariantData {
  ProductVariantData({
    this.variantDetails,
  });

  VariantDetails? variantDetails;

  factory ProductVariantData.fromJson(Map<String, dynamic> json) =>
      ProductVariantData(
        variantDetails: VariantDetails.fromJson(json["variant_details"]),
      );

  Map<String, dynamic> toJson() => {
        "variant_details": variantDetails!.toJson(),
      };
}

class VariantDetails {
  VariantDetails({
    this.id,
    this.productId,
    this.variant,
    this.color,
    this.price,
    this.offeredprice,
    // this.listingPrice, //listingPrice
    this.quantity,
    this.status,
    this.sku,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.variantDetailsContinue,
    this.purchasePrice,
    this.cartQuantity,
    this.variantName,
  });

  int? id;
  int? productId;
  String? variant;
  String? color;
  String? price;
  String? offeredprice;
  // String listingPrice;
  int? quantity;
  String? status;
  String? sku;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  bool? variantDetailsContinue;
  String? purchasePrice;
  dynamic cartQuantity;
  String? variantName;

  factory VariantDetails.fromJson(Map<String, dynamic> json) => VariantDetails(
        id: json["id"],
        productId: json["product_id"],
        variant: json["variant"],
        color: json["color"],
        price: json["price"].toString(),
        offeredprice: json["offeredprice"].toString(),
        // listingPrice: json["listingprice"].toString(),
        quantity: json["quantity"],
        status: json["status"],
        sku: json["sku"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        variantDetailsContinue: json["continue"],
        purchasePrice: (json["listingprice"]== null ? json["purchase_price"] : json["listingprice"]).toString(),
        cartQuantity: json["cart_quantity"],
        variantName: json["variant_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "variant": variant,
        "color": color,
        "price": price,
        "offeredprice": offeredprice,
        // "listingPrice": listingPrice,
        "quantity": quantity,
        "status": status,
        "sku": sku,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "continue": variantDetailsContinue,
        "purchase_price": purchasePrice,
        "cart_quantity": cartQuantity,
        "variant_name": variantName,
      };
}
