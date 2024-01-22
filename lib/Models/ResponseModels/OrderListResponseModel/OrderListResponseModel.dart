// To parse this JSON data, do
//
//     final orderListResponseModel = orderListResponseModelFromJson(jsonString);

import 'dart:convert';

OrderListResponseModel orderListResponseModelFromJson(String str) =>
    OrderListResponseModel.fromJson(json.decode(str));

String orderListResponseModelToJson(OrderListResponseModel data) =>
    json.encode(data.toJson());

class OrderListResponseModel {
  OrderListResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory OrderListResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderListResponseModel(
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
    this.orders,
  });

  List<Order>? orders;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  Order({
    this.id,
    this.shopId,
    this.type,
    this.userId,
    this.code,
    this.custName,
    this.custMobile,
    this.custLatitude,
    this.custLongitude,
    this.custLocation,
    this.custAddress,
    this.itemTotal,
    this.deliveryCharge,
    this.couponDiscount,
    this.payableAmount,
    this.status,
    this.expectedDeliveryDate,
    this.statusLog,
    this.couponId,
    this.paymentMode,
    this.paymentTxnid,
    this.deliveryboyId,
    this.rating,
    this.review,
    this.createdAt,
    this.updatedAt,
    this.invoice,
    this.orderProducts,

  });

  int? id;
  int? shopId;
  String? type;
  int? userId;
  String? code;
  String? custName;
  String? custMobile;
  String? custLatitude;
  String? custLongitude;
  String? custLocation;
  CustAddress? custAddress;
  String? itemTotal;
  String? deliveryCharge;
  String? couponDiscount;
  String? payableAmount;
  String? status;
  String? expectedDeliveryDate;
  List<StatusLog>? statusLog;
  dynamic couponId;
  String? paymentMode;
  dynamic paymentTxnid;
  dynamic deliveryboyId;
  dynamic rating;
  dynamic review;
  String? createdAt;
  String? updatedAt;
  dynamic invoice;
  List<OrderProduct>? orderProducts;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        shopId: json["shop_id"],
        type: json["type"],
        userId: json["user_id"],
        code: json["code"],
        custName: json["cust_name"],
        custMobile: json["cust_mobile"],
        custLatitude: json["cust_latitude"],
        custLongitude: json["cust_longitude"],
        custLocation: json["cust_location"],
        custAddress: CustAddress.fromJson(json["cust_address"]),
        itemTotal: json["item_total"].toString(),
        deliveryCharge: json["delivery_charge"].toString(),
        couponDiscount: json["coupon_discount"].toString(),
        payableAmount: json["payable_amount"].toString(),
        status: json["status"],
        expectedDeliveryDate: json["expected_delivery"] != null
            ? json["expected_delivery"]
            : null,
        statusLog: List<StatusLog>.from(
            json["status_log"].map((x) => StatusLog.fromJson(x))),
        couponId: json["coupon_id"],
        paymentMode: json["payment_mode"],
        paymentTxnid: json["payment_txnid"],
        deliveryboyId: json["deliveryboy_id"],
        rating: json["rating"],
        review: json["review"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        invoice: json["invoice"],
        orderProducts: List<OrderProduct>.from(
            json["order_products"].map((x) => OrderProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "type": type,
        "user_id": userId,
        "code": code,
        "cust_name": custName,
        "cust_mobile": custMobile,
        "cust_latitude": custLatitude,
        "cust_longitude": custLongitude,
        "cust_location": custLocation,
        "cust_address": custAddress!.toJson(),
        "item_total": itemTotal,
        "delivery_charge": deliveryCharge,
        "coupon_discount": couponDiscount,
        "payable_amount": payableAmount,
        "status": status,
        "expected_delivery": expectedDeliveryDate,
        "status_log": List<dynamic>.from(statusLog!.map((x) => x.toJson())),
        "coupon_id": couponId,
        "payment_mode": paymentMode,
        "payment_txnid": paymentTxnid,
        "deliveryboy_id": deliveryboyId,
        "rating": rating,
        "review": review,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "invoice": invoice,
        "order_products":
            List<dynamic>.from(orderProducts!.map((x) => x.toJson())),
      };
}

class CustAddress {
  CustAddress({
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

  factory CustAddress.fromJson(Map<String, dynamic> json) => CustAddress(
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

class OrderProduct {
  OrderProduct({
    this.id,
    this.orderId,
    this.productId,
    this.variantSelected,
    this.price,
    this.quantity,
    this.subTotal,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  int? id;
  int? orderId;
  int? productId;
  VariantSelected? variantSelected;
  int? price;
  int? quantity;
  int? subTotal;
  String? createdAt;
  String? updatedAt;
  Product? product;

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        variantSelected: VariantSelected.fromJson(json["variant_selected"]),
        price: json["price"],
        quantity: json["quantity"],
        subTotal: json["sub_total"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        product:
            json["product"] != null ? Product.fromJson(json["product"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "variant_selected": variantSelected!.toJson(),
        "price": price,
        "quantity": quantity,
        "sub_total": subTotal,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "product": product!.toJson(),
      };
}

class Product {
  Product({
    this.id,
    this.shopId,
    this.masterId,
    this.colors,
    this.variant,
    this.variantOptions,
    this.status,
    this.topOffer,
    this.availability,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.isWishlist,
    this.details,
  });

  int? id;
  int? shopId;
  int? masterId;
  dynamic colors;
  String? variant;
  List<String>? variantOptions;
  String? status;
  String? topOffer;
  String? availability;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  bool? isWishlist;
  Details? details;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        shopId: json["shop_id"],
        masterId: json["master_id"],
        colors: json["colors"],
        variant: json["variant"],
        variantOptions: json["variant_options"] != null
            ? List<String>.from(json["variant_options"].map((x) => x))
            : null,
        status: json["status"],
        topOffer: json["top_offer"],
        availability: json["availability"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        isWishlist: json["is_wishlist"],
        details: Details.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "master_id": masterId,
        "colors": colors,
        "variant": variant,
        "variant_options": List<dynamic>.from(variantOptions!.map((x) => x)),
        "status": status,
        "top_offer": topOffer,
        "availability": availability,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "is_wishlist": isWishlist,
        "details": details!.toJson(),
      };
}

class Details {
  Details({
    this.id,
    this.name,
    this.categoryId,
    this.brandId,
    this.description,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.imagePath,
    this.category,
    this.brand,
    this.galleryImages,
  });

  int? id;
  String? name;
  int? categoryId;
  int? brandId;
  String? description;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? imagePath;
  Category? category;
  Brand? brand;
  List<dynamic>? galleryImages;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"],
        brandId: json["brand_id"],
        description: json["description"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        imagePath: json["image_path"],
        category: Category.fromJson(json["category"]),
        brand: Brand.fromJson(json["brand"]),
        galleryImages: List<dynamic>.from(json["gallery_images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "brand_id": brandId,
        "description": description,
        "image": image,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "image_path": imagePath,
        "category": category!.toJson(),
        "brand": brand!.toJson(),
        "gallery_images": List<dynamic>.from(galleryImages!.map((x) => x)),
      };
}

class Brand {
  Brand({
    this.id,
    this.name,
    this.icon,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.iconPath,
  });

  int? id;
  String? name;
  dynamic icon;
  String? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? iconPath;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        iconPath: json["icon_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "icon_path": iconPath,
      };
}

class Category {
  Category({
    this.id,
    this.parentId,
    this.name,
    this.icon,
    this.type,
    this.status,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.iconPath,
  });

  int? id;
  int? parentId;
  String? name;
  String? icon;
  String? type;
  String? status;
  String? isFeatured;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? iconPath;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        icon: json["icon"],
        type: json["type"],
        status: json["status"],
        isFeatured: json["is_featured"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        iconPath: json["icon_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "icon": icon,
        "type": type,
        "status": status,
        "is_featured": isFeatured,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "icon_path": iconPath,
      };
}

class VariantSelected {
  VariantSelected({
    this.colorCode,
    this.colorName,
    this.variantCode,
    this.variantName,
  });

  dynamic colorCode;
  dynamic colorName;
  String? variantCode;
  String? variantName;

  factory VariantSelected.fromJson(Map<String, dynamic> json) =>
      VariantSelected(
        colorCode: json["color_code"],
        colorName: json["color_name"],
        variantCode: json["variant_code"],
        variantName: json["variant_name"],
      );

  Map<String, dynamic> toJson() => {
        "color_code": colorCode,
        "color_name": colorName,
        "variant_code": variantCode,
        "variant_name": variantName,
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
