// To parse this JSON data, do
//
//     final addToCartResponseModel = addToCartResponseModelFromJson(jsonString);

import 'dart:convert';

AddToCartResponseModel addToCartResponseModelFromJson(String str) =>
    AddToCartResponseModel.fromJson(json.decode(str));

String addToCartResponseModelToJson(AddToCartResponseModel data) =>
    json.encode(data.toJson());

class AddToCartResponseModel {
  AddToCartResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  AddToCartData? data;

  factory AddToCartResponseModel.fromJson(Map<String, dynamic> json) =>
      AddToCartResponseModel(
        status: json["status"],
        message: json["message"],
        data: AddToCartData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class AddToCartData {
  AddToCartData({
    this.cartcount,
    this.carttotal,
    this.variantDetails,
  });

  String? cartcount;
  String? carttotal;
  VariantDetails? variantDetails;

  factory AddToCartData.fromJson(Map<String, dynamic> json) => AddToCartData(
        cartcount: json["cartcount"].toString(),
        carttotal: json["carttotal"].toString(),
        variantDetails: VariantDetails.fromJson(json["variant_details"]),
      );

  Map<String, dynamic> toJson() => {
        "cartcount": cartcount,
        "carttotal": carttotal,
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
  int? price;
  int? offeredprice;
  // int? listingPrice; //listingPrice
  int? quantity;
  String? status;
  String? sku;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  bool? variantDetailsContinue;
  int? purchasePrice;
  int? cartQuantity;
  String? variantName;

  factory VariantDetails.fromJson(Map<String, dynamic> json) => VariantDetails(
        id: json["id"],
        productId: json["product_id"],
        variant: json["variant"],
        color: json["color"],
        price: json["price"],
        offeredprice: json["offeredprice"],
        // listingPrice: json["listingprice"], //listingPrice
        quantity: json["quantity"],
        status: json["status"],
        sku: json["sku"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        variantDetailsContinue: json["continue"],
        purchasePrice: (json["listingprice"] == null
            ? json["purchase_price"]
            : json["listingprice"]),
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
        // "listingPrice":listingPrice,//listingPrice
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
