// To parse this JSON data, do
//
//     final orderRatingSendModel = orderRatingSendModelFromJson(jsonString);

import 'dart:convert';

OrderRatingSendModel orderRatingSendModelFromJson(String str) => OrderRatingSendModel.fromJson(json.decode(str));

String orderRatingSendModelToJson(OrderRatingSendModel data) => json.encode(data.toJson());

class OrderRatingSendModel {
  OrderRatingSendModel({
    this.orderId,
    this.shopRating,
    this.shopReview,
    this.deliveryboyRating,
    this.deliveryboyReview,
  });

  String? orderId;
  String? shopRating;
  String? shopReview;
  String? deliveryboyRating;
  String? deliveryboyReview;

  factory OrderRatingSendModel.fromJson(Map<String, dynamic> json) => OrderRatingSendModel(
    orderId: json["order_id"],
    shopRating: json["shop_rating"],
    shopReview: json["shop_review"],
    deliveryboyRating: json["deliveryboy_rating"],
    deliveryboyReview: json["deliveryboy_review"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "shop_rating": shopRating,
    "shop_review": shopReview,
    "deliveryboy_rating": deliveryboyRating,
    "deliveryboy_review": deliveryboyReview,
  };
}
