// To parse this JSON data, do
//
//     final getOrderDetailsResponseModel = getOrderDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'GetOrderDetailsResponseModel.dart';
import 'GetOrderDetailsResponseModel.dart';

GetOrderDetailsResponseModel getOrderDetailsResponseModelFromJson(String str) =>
    GetOrderDetailsResponseModel.fromJson(json.decode(str));

String getOrderDetailsResponseModelToJson(GetOrderDetailsResponseModel data) =>
    json.encode(data.toJson());

class GetOrderDetailsResponseModel {
  GetOrderDetailsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory GetOrderDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetOrderDetailsResponseModel(
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
    this.adv_banners,
    this.order,
  });

  OrderDetailsData? order;
  AdvertisementBanner? adv_banners;


  factory Data.fromJson(Map<String, dynamic> json) => Data(
        order: json["order"] != null
            ? OrderDetailsData.fromJson(json["order"])
            : null,
    // adv_banners: json["adv_banners"] != null?AdvertisementBanner.fromJson(json["adv_banners"]):null
      );

  Map<String, dynamic> toJson() => {
        "order": order!.toJson(),
          // "adv_banners": adv_banners!.toJson()
      };
}
class AdvertisementBanner {
  int? id;
  String? position;
  String? type;
  String? bannerType;
  int? shopId;
  String? image;
  String? status;
  String? isFeatured;
  String? createdAt;
  String? updatedAt;
  String? imagePath;

  AdvertisementBanner({
    this.id,
    this.position,
    this.type,
    this.bannerType,
    this.shopId,
    this.image,
    this.status,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
    this.imagePath,
  });

  factory AdvertisementBanner.fromJson(Map<String, dynamic> json) {
    return AdvertisementBanner(
      id: json['id'],
      position: json['position'],
      type: json['type'],
      bannerType: json['banner_type'],
      shopId: json['shop_id'],
      image: json['image'],
      status: json['status'],
      isFeatured: json['is_featured'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      imagePath: json['image_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'position': position,
      'type': type,
      'banner_type': bannerType,
      'shop_id': shopId,
      'image': image,
      'status': status,
      'is_featured': isFeatured,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'image_path': imagePath,
    };
  }
}



class OrderDetailsData {
  OrderDetailsData(
      {this.id,
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
      this.walletDeducted,
      this.payableAmount,
      this.walletCashback,
      this.adminCharge,
      this.status,
      this.expectedDelivery,
      this.expectedIntransit,
      this.statusLog,
      this.couponId,
      this.paymentMode,
      this.paymentTxnid,
      this.paymentRefid,
      this.deliveryboyId,
      this.deliveryboyStatus,
      this.deliveryboyReachedstore,
      this.shopRating,
      this.shopReview,
      this.deliveryboyRating,
      this.deliveryboyReview,
      this.createdAt,
      this.updatedAt,
      this.distance,
      this.invoice,
      this.orderProducts,
      this.shop,
      this.deliveryboy,
        this.expected_intransit,
      this.returnReplacements});
String? expected_intransit;
  dynamic id;
  dynamic shopId;
  String? type;
  dynamic userId;
  String? code;
  String? custName;
  String? custMobile;
  String? custLatitude;
  String? custLongitude;
  String? custLocation;
  Address? custAddress;
  String? itemTotal;
  String? deliveryCharge;
  String? couponDiscount;
  String? walletDeducted;
  String? payableAmount;
  String? walletCashback;
  String? adminCharge;
  String? status;
  String? expectedDelivery;
  DateTime? expectedIntransit;
  List<StatusLog>? statusLog;
  dynamic couponId;
  String? paymentMode;
  dynamic paymentTxnid;
  dynamic paymentRefid;
  dynamic deliveryboyId;
  String? deliveryboyStatus;
  String? deliveryboyReachedstore;
  String? shopRating;
  String? shopReview;
  dynamic deliveryboyRating;
  dynamic deliveryboyReview;
  String? createdAt;
  String? updatedAt;
  Distance? distance;
  dynamic invoice;
  List<OrderProduct>? orderProducts;
  Shop? shop;
  Deliveryboy? deliveryboy;
  List<ReturnReplacement>? returnReplacements;

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) =>
      OrderDetailsData(
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
        custAddress: Address.fromJson(json["cust_address"]),
        itemTotal: json["item_total"].toString(),
        deliveryCharge: json["delivery_charge"].toString(),
        couponDiscount: json["coupon_discount"].toString(),
        walletDeducted: json["wallet_deducted"].toString(),
        payableAmount: json["payable_amount"].toString(),
        walletCashback: json["wallet_cashback"].toString(),
        adminCharge: json["admin_charge"].toString(),
        expected_intransit: json["expected_intransit"].toString(),
        status: json["status"],
        expectedDelivery: json["expected_delivery"],
        expectedIntransit: json["expected_intransit"] != null
            ? DateTime.parse(json["expected_intransit"])
            : null,
        statusLog: List<StatusLog>.from(
            json["status_log"].map((x) => StatusLog.fromJson(x))),
        couponId: json["coupon_id"],
        paymentMode: json["payment_mode"],
        paymentTxnid: json["payment_txnid"],
        paymentRefid: json["payment_refid"],
        deliveryboyId: json["deliveryboy_id"],
        deliveryboyStatus: json["deliveryboy_status"],
        deliveryboyReachedstore: json["deliveryboy_reachedstore"],
        shopRating: json["shop_rating"].toString(),
        shopReview: json["shop_review"].toString(),

        deliveryboyRating: json["deliveryboy_rating"],
        deliveryboyReview: json["deliveryboy_review"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        distance: json["distance"] != null
            ? Distance.fromJson(json["distance"])
            : null,
        invoice: json["invoice"],
        orderProducts: List<OrderProduct>.from(
            json["order_products"].map((x) => OrderProduct.fromJson(x))),
        shop: Shop.fromJson(json["shop"]),
        deliveryboy: json["deliveryboy"] != null
            ? Deliveryboy.fromJson(json["deliveryboy"])
            : null,
        returnReplacements: json["return_replacements"] != null
            ? List<ReturnReplacement>.from(json["return_replacements"]
                .map((x) => ReturnReplacement.fromJson(x)))
            : null,
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
        "wallet_deducted": walletDeducted,
        "payable_amount": payableAmount,
        "wallet_cashback": walletCashback,
        "admin_charge": adminCharge,
        "status": status,
        "expected_delivery": expectedDelivery,
        "expected_intransit": expectedIntransit!.toIso8601String(),
        "status_log": List<dynamic>.from(statusLog!.map((x) => x.toJson())),
        "coupon_id": couponId,
        "payment_mode": paymentMode,
    "expected_intransit":expected_intransit,
        "payment_txnid": paymentTxnid,
        "payment_refid": paymentRefid,
        "deliveryboy_id": deliveryboyId,
        "deliveryboy_status": deliveryboyStatus,
        "deliveryboy_reachedstore": deliveryboyReachedstore,
        "shop_rating": shopRating,
        "shop_review": shopReview,
        "deliveryboy_rating": deliveryboyRating,
        "deliveryboy_review": deliveryboyReview,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "distance": distance!.toJson(),
        "invoice": invoice,
        "order_products":
            List<dynamic>.from(orderProducts!.map((x) => x.toJson())),
        "shop": shop!.toJson(),
        "deliveryboy": deliveryboy!.toJson(),
        "return_replacements":
            List<dynamic>.from(returnReplacements!.map((x) => x.toJson())),
      };
}

class ReturnReplacement {
  ReturnReplacement({
    this.id,
    this.orderId,
    this.code,
    this.status,
    this.type,
    this.statusLog,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  dynamic id;
  dynamic orderId;
  String? code;
  String? status;
  String? type;
  List<StatusLog>? statusLog;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  factory ReturnReplacement.fromJson(Map<String, dynamic> json) =>
      ReturnReplacement(
        id: json["id"],
        orderId: json["order_id"],
        code: json["code"],
        status: json["status"].toString().toLowerCase() ==
                "deliverypartnerassigned"
            ? "Delivery Partner Assigned".toUpperCase()
            : json["status"].toString().toLowerCase() == "readyforpickup"
                ? "Ready for pickup".toUpperCase()
                : json["status"].toString().toLowerCase() == "outfordelivery"
                    ? "Out for delivery".toUpperCase()
                    : json["status"].toString().toLowerCase() == "outforpickup"
                        ? "Out for pickup".toUpperCase()
                        : json["status"].toString().toLowerCase() ==
                                "outforstore"
                            ? "Out for store".toUpperCase()
                            : json["status"].toString().toLowerCase() ==
                                    "deliveredtostore"
                                ? "Delivered to store".toUpperCase()
                                : json["status"].toString().toUpperCase(),
        type: json["type"].toString().toUpperCase(),
        statusLog: List<StatusLog>.from(
            json["status_log"].map((x) => StatusLog.fromJson(x))),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "code": code,
        "status": status,
        "type": type,
        "status_log": List<dynamic>.from(statusLog!.map((x) => x.toJson())),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}

class Address {
  Address({
    this.addressLine1,
    this.addressLine2,
    this.postalCode,
    this.city,
    this.state,
    this.country,
    this.landmark,
  });

  String? addressLine1;
  String? addressLine2;
  String? postalCode;
  String? city;
  String? state;
  String? country;
  String? landmark;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressLine1: json["address_line1"],
        addressLine2:
            json["address_line2"] == null ? null : json["address_line2"],
        postalCode: json["postal_code"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        landmark: json["landmark"] == null ? null : json["landmark"],
      );

  Map<String, dynamic> toJson() => {
        "address_line1": addressLine1,
        "address_line2": addressLine2 == null ? null : addressLine2,
        "postal_code": postalCode,
        "city": city,
        "state": state,
        "country": country,
        "landmark": landmark == null ? null : landmark,
      };
}

class Deliveryboy {
  Deliveryboy({
    this.id,
    this.roleId,
    this.name,
    this.email,
    this.mobile,
    this.profileImage,
    this.referralCode,
    this.parentId,
    this.schemeId,
    this.businessCategory,
    this.userwallet,
    this.branchwallet,
    this.riderwallet,
    this.creditwallet,
    this.vaccination,
    this.latitude,
    this.longitude,
    this.emailVerifiedAt,
    this.mobileVerifiedAt,
    this.resetpwd,
    this.online,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.avatar,
    this.role,
  });

  dynamic id;
  dynamic roleId;
  String? name;
  String? email;
  String? mobile;
  String? profileImage;
  dynamic referralCode;
  dynamic parentId;
  dynamic schemeId;
  dynamic businessCategory;
  dynamic userwallet;
  dynamic branchwallet;
  dynamic riderwallet;
  dynamic creditwallet;
  dynamic vaccination;
  String? latitude;
  String? longitude;
  dynamic emailVerifiedAt;
  dynamic mobileVerifiedAt;
  String? resetpwd;
  String? online;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? avatar;
  Role? role;

  factory Deliveryboy.fromJson(Map<String, dynamic> json) => Deliveryboy(
        id: json["id"],
        roleId: json["role_id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        profileImage: json["profile_image"],
        referralCode: json["referral_code"],
        parentId: json["parent_id"],
        schemeId: json["scheme_id"],
        businessCategory: json["business_category"],
        userwallet: json["userwallet"],
        branchwallet: json["branchwallet"],
        riderwallet: json["riderwallet"],
        creditwallet: json["creditwallet"],
        vaccination: json["vaccination"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        emailVerifiedAt: json["email_verified_at"],
        mobileVerifiedAt: json["mobile_verified_at"],
        resetpwd: json["resetpwd"],
        online: json["online"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        avatar: json["avatar"],
        role: Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "name": name,
        "email": email,
        "mobile": mobile,
        "profile_image": profileImage,
        "referral_code": referralCode,
        "parent_id": parentId,
        "scheme_id": schemeId,
        "business_category": businessCategory,
        "userwallet": userwallet,
        "branchwallet": branchwallet,
        "riderwallet": riderwallet,
        "creditwallet": creditwallet,
        "vaccination": vaccination,
        "latitude": latitude,
        "longitude": longitude,
        "email_verified_at": emailVerifiedAt,
        "mobile_verified_at": mobileVerifiedAt,
        "resetpwd": resetpwd,
        "online": online,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "avatar": avatar,
        "role": role!.toJson(),
      };
}

class Role {
  Role({
    this.id,
    this.name,
    this.slug,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  String? name;
  String? slug;
  String? createdAt;
  String? updatedAt;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Distance {
  Distance({
    this.deliveryboytocustomer,
    this.shoptocustomer,
  });

  Tocustomer? deliveryboytocustomer;
  Tocustomer? shoptocustomer;

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
        deliveryboytocustomer:
            Tocustomer.fromJson(json["deliveryboytocustomer"]),
        shoptocustomer: Tocustomer.fromJson(json["shoptocustomer"]),
      );

  Map<String, dynamic> toJson() => {
        "deliveryboytocustomer": deliveryboytocustomer!.toJson(),
        "shoptocustomer": shoptocustomer!.toJson(),
      };
}

class Tocustomer {
  Tocustomer({
    this.distanceValue,
    this.distanceText,
    this.durationValue,
    this.durationText,
  });

  dynamic distanceValue;
  String? distanceText;
  dynamic durationValue;
  String? durationText;

  factory Tocustomer.fromJson(Map<String, dynamic> json) => Tocustomer(
        distanceValue: json["distance_value"],
        distanceText: json["distance_text"],
        durationValue: json["duration_value"],
        durationText: json["duration_text"],
      );

  Map<String, dynamic> toJson() => {
        "distance_value": distanceValue,
        "distance_text": distanceText,
        "duration_value": durationValue,
        "duration_text": durationText,
      };
}

class Deliveryboytocustomer {
  Deliveryboytocustomer({
    this.distanceValue,
    this.distanceText,
    this.durationValue,
    this.durationText,
  });

  dynamic distanceValue;
  String? distanceText;
  dynamic durationValue;
  String? durationText;

  factory Deliveryboytocustomer.fromJson(Map<String, dynamic> json) =>
      Deliveryboytocustomer(
        distanceValue: json["distance_value"],
        distanceText: json["distance_text"],
        durationValue: json["duration_value"],
        durationText: json["duration_text"],
      );

  Map<String, dynamic> toJson() => {
        "distance_value": distanceValue,
        "distance_text": distanceText,
        "duration_value": durationValue,
        "duration_text": durationText,
      };
}

class OrderProduct {
  OrderProduct({
    this.id,
    this.orderId,
    this.productId,
    this.variantId,
    this.variantSelected,
    this.price,
    this.tax,
    this.quantity,
    this.subTotal,
    this.taxTotal,
    this.shopTin,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  dynamic id;
  dynamic orderId;
  dynamic productId;
  dynamic variantId;
  VariantSelected? variantSelected;
  dynamic price;
  dynamic tax;
  dynamic quantity;
  dynamic subTotal;
  dynamic taxTotal;
  dynamic shopTin;
  String? createdAt;
  String? updatedAt;
  Product? product;

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        variantId: json["variant_id"],
        variantSelected: VariantSelected.fromJson(json["variant_selected"]),
        price: json["listingprice"] ?? json["price"],
        tax: json["tax"],
        quantity: json["quantity"],
        subTotal: json["sub_total"],
        taxTotal: json["tax_total"],
        shopTin: json["shop_tin"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "variant_id": variantId,
        "variant_selected": variantSelected!.toJson(),
        "price": price,
        "tax": tax,
        "quantity": quantity,
        "sub_total": subTotal,
        "tax_total": taxTotal,
        "shop_tin": shopTin,
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
    this.type,
    this.colors,
    this.variant,
    this.variantOptions,
    this.status,
    this.topOffer,
    this.availability,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.details,
  });

  dynamic id;
  dynamic shopId;
  dynamic masterId;
  String? type;
  List<String>? colors;
  String? variant;
  List<String>? variantOptions;
  String? status;
  String? topOffer;
  String? availability;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Details? details;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        shopId: json["shop_id"],
        masterId: json["master_id"],
        type: json["type"],
        colors: json["colors"] != null
            ? List<String>.from(json["colors"].map((x) => x))
            : json["colors"],
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
        details: Details.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "master_id": masterId,
        "type": type,
        "colors": List<dynamic>.from(colors!.map((x) => x)),
        "variant": variant,
        "variant_options": List<dynamic>.from(variantOptions!.map((x) => x)),
        "status": status,
        "top_offer": topOffer,
        "availability": availability,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "details": details!.toJson(),
      };
}

class Details {
  Details({
    this.id,
    this.type,
    this.name,
    this.categoryId,
    this.brandId,
    this.description,
    this.taxRate,
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

  dynamic id;
  String? type;
  String? name;
  dynamic categoryId;
  dynamic brandId;
  String? description;
  dynamic taxRate;
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
        type: json["type"],
        name: json["name"],
        categoryId: json["category_id"],
        brandId: json["brand_id"],
        description: json["description"],
        taxRate: json["tax_rate"],
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
        "type": type,
        "name": name,
        "category_id": categoryId,
        "brand_id": brandId,
        "description": description,
        "tax_rate": taxRate,
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

  dynamic id;
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

  dynamic id;
  dynamic parentId;
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

  String? colorCode;
  String? colorName;
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

class Shop {
  Shop({
    this.id,
    this.userId,
    this.shopName,
    this.shopTagline,
    this.shopMobile,
    this.shopWhatsapp,
    this.shopEmail,
    this.shopLocation,
    this.shopDeliveryRadius,
    this.shopLatitude,
    this.shopLongitude,
    this.shopAddress,
    this.shopLogo,
    this.status,
    this.online,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
    this.shopLogoPath,
    this.isWishlist,
  });

  dynamic id;
  dynamic userId;
  String? shopName;
  dynamic shopTagline;
  String? shopMobile;
  String? shopWhatsapp;
  String? shopEmail;
  String? shopLocation;
  String? shopDeliveryRadius;
  String? shopLatitude;
  String? shopLongitude;
  Address? shopAddress;
  String? shopLogo;
  String? status;
  String? online;
  String? isFeatured;
  String? createdAt;
  String? updatedAt;
  String? shopLogoPath;
  bool? isWishlist;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        userId: json["user_id"],
        shopName: json["shop_name"],
        shopTagline: json["shop_tagline"],
        shopMobile: json["shop_mobile"],
        shopWhatsapp: json["shop_whatsapp"],
        shopEmail: json["shop_email"],
        shopLocation: json["shop_location"],
        shopDeliveryRadius: json["shop_delivery_radius"],
        shopLatitude: json["shop_latitude"],
        shopLongitude: json["shop_longitude"],
        shopAddress: Address.fromJson(json["shop_address"]),
        shopLogo: json["shop_logo"],
        status: json["status"],
        online: json["online"],
        isFeatured: json["is_featured"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        shopLogoPath: json["shop_logo_path"],
        isWishlist: json["is_wishlist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "shop_name": shopName,
        "shop_tagline": shopTagline,
        "shop_mobile": shopMobile,
        "shop_whatsapp": shopWhatsapp,
        "shop_email": shopEmail,
        "shop_location": shopLocation,
        "shop_delivery_radius": shopDeliveryRadius,
        "shop_latitude": shopLatitude,
        "shop_longitude": shopLongitude,
        "shop_address": shopAddress!.toJson(),
        "shop_logo": shopLogo,
        "status": status,
        "online": online,
        "is_featured": isFeatured,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "shop_logo_path": shopLogoPath,
        "is_wishlist": isWishlist,
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
