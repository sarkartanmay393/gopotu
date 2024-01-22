// To parse this JSON data, do
//
//     final getMyBucketResponseModel = getMyBucketResponseModelFromJson(jsonString);

import 'dart:convert';

GetMyBucketResponseModel getMyBucketResponseModelFromJson(String str) =>
    GetMyBucketResponseModel.fromJson(json.decode(str));

String getMyBucketResponseModelToJson(GetMyBucketResponseModel data) =>
    json.encode(data.toJson());

class GetMyBucketResponseModel {
  GetMyBucketResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  BucketData? data;

  factory GetMyBucketResponseModel.fromJson(Map<String, dynamic> json) =>
      GetMyBucketResponseModel(
        status: json["status"],
        message: json["message"],
        data: BucketData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class BucketData {
  BucketData({
    this.defaultAddress,
    this.selectedShop,
    this.availableCoupons,
    this.address,
    this.items,
    this.itemTotal,
    this.deliveryCharge,
    this.couponDiscount,
    this.payableAmount,
    this.checkout,
    this.couponDetails,
    this.walletDeduct,
    this.wallet,
    this.deliverychargeSettings,
  });

  Address? defaultAddress;
  SelectedShop? selectedShop;
  List<AvailableCoupon>? availableCoupons;
  Address? address;
  List<Item>? items;
  String? itemTotal;
  String? deliveryCharge;
  String? couponDiscount;
  String? payableAmount;
  Checkout? checkout;
  CouponDetails? couponDetails;
  String? walletDeduct;
  Wallet? wallet;
  DeliverychargeSettings? deliverychargeSettings;

  factory BucketData.fromJson(Map<String, dynamic> json) => BucketData(
        defaultAddress: json["default_address"] != null
            ? Address.fromJson(json["default_address"])
            : null,
        availableCoupons: json["available_coupons"] != null
            ? List<AvailableCoupon>.from(json["available_coupons"]
                .map((x) => AvailableCoupon.fromJson(x)))
            : null,
        address:
            json["address"] != null ? Address.fromJson(json["address"]) : null,
        items: json["items"] != null
            ? List<Item>.from(json["items"].map((x) => Item.fromJson(x)))
            : null,
        itemTotal:
            json["item_total"] != null ? json["item_total"].toString() : "0.00",
        deliveryCharge: json["delivery_charge"].toString(),
        couponDiscount: json["coupon_discount"].toString(),
        payableAmount: json["payable_amount"].toString(),
        couponDetails: json["coupon_details"] != null
            ? CouponDetails.fromJson(json["coupon_details"])
            : null,
        checkout: json["checkout"] != null
            ? Checkout.fromJson(json["checkout"])
            : null,
        selectedShop: json["selected_shop"] != null
            ? SelectedShop.fromJson(json["selected_shop"])
            : null,
        walletDeduct: json["wallet_deducted"],
        wallet: Wallet.fromJson(json["wallet"]),
        deliverychargeSettings: json["deliverycharge_settings"] != null
            ? DeliverychargeSettings.fromJson(json["deliverycharge_settings"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "default_address": defaultAddress!.toJson(),
        "selected_shop": selectedShop!.toJson(),
        "available_coupons":
            List<dynamic>.from(availableCoupons!.map((x) => x.toJson())),
        "address": address!.toJson(),
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "item_total": itemTotal,
        "delivery_charge": deliveryCharge,
        "coupon_details": couponDetails!.toJson(),
        "coupon_discount": couponDiscount,
        "payable_amount": payableAmount,
        "checkout": checkout!.toJson(),
      };
}

class DeliverychargeSettings {
  DeliverychargeSettings({
    this.deliveryDistance,
    this.deliverychargePerkm,
    this.deliverychargeMin,
  });

  String? deliveryDistance;
  String? deliverychargePerkm;
  String? deliverychargeMin;

  factory DeliverychargeSettings.fromJson(Map<String, dynamic> json) =>
      DeliverychargeSettings(
        deliveryDistance: json["delivery_distance"] != null
            ? json["delivery_distance"].toString()
            : "",
        deliverychargePerkm: json["deliverycharge_perkm"] != null
            ? json["deliverycharge_perkm"].toString()
            : "",
        deliverychargeMin: json["deliverycharge_min"] != null
            ? json["deliverycharge_min"].toString()
            : "",
      );

  Map<String, dynamic> toJson() => {
        "delivery_distance": deliveryDistance,
        "deliverycharge_perkm": deliverychargePerkm,
        "deliverycharge_min": deliverychargeMin,
      };
}

class Wallet {
  Wallet({
    this.balance,
    this.maxusagePer,
    this.maxusageAllowed,
    this.usable,
  });

  String? balance;
  String? maxusagePer;
  String? maxusageAllowed;
  String? usable;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        balance: json["balance"].toString(),
        maxusagePer: json["maxusage_per"].toString(),
        maxusageAllowed: json["maxusage_allowed"].round().toString(),
        usable: json["usable"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "maxusage_per": maxusagePer,
        "maxusage_allowed": maxusageAllowed,
        "usable": usable,
      };
}

class CouponDetails {
  CouponDetails({
    this.id,
    this.code,
    this.description,
    this.type,
    this.value,
    this.maxDiscount,
    this.minOrder,
    this.maxUsages,
    this.validTill,
    this.appliedForUsers,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.couponUsedCount,
    this.selected,
  });

  int? id;
  String? code;
  String? description;
  String? type;
  int? value;
  int? maxDiscount;
  int? minOrder;
  int? maxUsages;
  dynamic validTill;
  List<String>? appliedForUsers;
  String? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  int? couponUsedCount;
  bool? selected;

  factory CouponDetails.fromJson(Map<String, dynamic> json) => CouponDetails(
        id: json["id"],
        code: json["code"],
        description: json["description"],
        type: json["type"],
        value: json["value"],
        maxDiscount: json["max_discount"],
        minOrder: json["min_order"],
        maxUsages: json["max_usages"],
        validTill: json["valid_till"],
        appliedForUsers:
            List<String>.from(json["applied_for_users"].map((x) => x)),
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        couponUsedCount: json["coupon_used_count"],
        selected: json["selected"] == null ? null : json["selected"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "description": description,
        "type": type,
        "value": value,
        "max_discount": maxDiscount,
        "min_order": minOrder,
        "max_usages": maxUsages,
        "valid_till": validTill,
        "applied_for_users": List<dynamic>.from(appliedForUsers!.map((x) => x)),
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "coupon_used_count": couponUsedCount,
        "selected": selected == null ? null : selected,
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
  dynamic alternativeMobile;
  String? location;
  String? latitude;
  String? longitude;
  FullAddressClass? fullAddress;
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
        alternativeMobile: json["alternative_mobile"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        fullAddress: FullAddressClass.fromJson(json["full_address"]),
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
        "alternative_mobile": alternativeMobile,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "full_address": fullAddress!.toJson(),
        "is_default": isDefault,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class FullAddressClass {
  FullAddressClass({
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

  factory FullAddressClass.fromJson(Map<String, dynamic> json) =>
      FullAddressClass(
        addressLine1:
            json["address_line1"] == null ? null : json["address_line1"],
        addressLine2: json["address_line2"],
        postalCode: json["postal_code"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        landmark: json["landmark"] == null ? null : json["landmark"],
      );

  Map<String, dynamic> toJson() => {
        "address_line1": addressLine1 == null ? null : addressLine1,
        "address_line2": addressLine2,
        "postal_code": postalCode,
        "city": city,
        "state": state,
        "country": country,
        "landmark": landmark == null ? null : landmark,
      };
}

class AvailableCoupon {
  AvailableCoupon({
    this.id,
    this.code,
    this.description,
    this.type,
    this.value,
    this.maxDiscount,
    this.minOrder,
    this.maxUsages,
    this.validTill,
    this.appliedForUsers,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.couponUsedCount,
    this.selected,
  });

  int? id;
  String? code;
  String? description;
  String? type;
  int? value;
  int? maxDiscount;
  int? minOrder;
  int? maxUsages;
  dynamic validTill;
  List<String>? appliedForUsers;
  String? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  int? couponUsedCount;
  bool? selected;

  factory AvailableCoupon.fromJson(Map<String, dynamic> json) =>
      AvailableCoupon(
        id: json["id"],
        code: json["code"],
        description: json["description"],
        type: json["type"],
        value: json["value"],
        maxDiscount: json["max_discount"],
        minOrder: json["min_order"],
        maxUsages: json["max_usages"],
        validTill: json["valid_till"],
        appliedForUsers:
            List<String>.from(json["applied_for_users"].map((x) => x)),
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        couponUsedCount: json["coupon_used_count"],
        selected: json["selected"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "description": description,
        "type": type,
        "value": value,
        "max_discount": maxDiscount,
        "min_order": minOrder,
        "max_usages": maxUsages,
        "valid_till": validTill,
        "applied_for_users": List<dynamic>.from(appliedForUsers!.map((x) => x)),
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "coupon_used_count": couponUsedCount,
        "selected": selected,
      };
}

class Checkout {
  Checkout({
    this.status,
    this.exception,
  });

  bool? status;
  dynamic exception;

  factory Checkout.fromJson(Map<String, dynamic> json) => Checkout(
        status: json["status"],
        exception: json["exception"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "exception": exception,
      };
}

class Item {
  Item({
    this.id,
    this.userId,
    this.variantId,
    this.quantity,
    this.shopId,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.subTotal,
    this.variant,
  });

  int? id;
  int? userId;
  int? variantId;
  String? quantity;
  int? shopId;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? subTotal;
  Variant? variant;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        userId: json["user_id"],
        variantId: json["variant_id"],
        quantity: json["quantity"].toString(),
        shopId: json["shop_id"],
        type: json["type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        subTotal: json["sub_total"].toInt(),
        variant: Variant.fromJson(json["variant"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "variant_id": variantId,
        "quantity": quantity,
        "shop_id": shopId,
        "type": type,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "sub_total": subTotal,
        "variant": variant!.toJson(),
      };
}

class Variant {
  Variant({
    this.id,
    this.productId,
    this.variant,
    this.color,
    this.price,
    this.offeredprice,
    // this.listingPrice,//listingPrice
    this.quantity,
    this.status,
    this.sku,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.purchasePrice,
    this.cartQuantity,
    this.variantName,
    this.product,
    this.colorDetails,
  });

  int? id;
  int? productId;
  String? variant;
  dynamic color;
  String? price;
  String? offeredprice;
  // String listingPrice;//listingPrice
  String? quantity;
  String? status;
  String? sku;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? purchasePrice;
  String? cartQuantity;
  String? variantName;
  Product? product;
  dynamic colorDetails;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["id"],
        productId: json["product_id"],
        variant: json["variant"] != null
            ? json["variant"].toString().toUpperCase()
            : "",
        color: json["color"],
        price: json["price"].toString(),
        offeredprice: json["offeredprice"].toString(),
        // listingPrice: json["listingprice"].toString(),//listingPrice
        quantity: json["quantity"].toString(),
        status: json["status"],
        sku: json["sku"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        purchasePrice: (json["listingprice"] == null
                ? json["purchase_price"]
                : json["listingprice"])
            .toString(),
        cartQuantity: json["cart_quantity"].toString(),
        variantName: json["variant_name"],
        product: Product.fromJson(json["product"]),
        colorDetails:
            json["color_details"] != null ? json["color_details"] : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "variant": variant,
        "color": color,
        "price": price,
        "offeredprice": offeredprice,
        // "listingPrice": listingPrice,//listingPrice
        "quantity": quantity,
        "status": status,
        "sku": sku,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "purchase_price": purchasePrice,
        "cart_quantity": cartQuantity,
        "variant_name": variantName,
        "product": product!.toJson(),
        "color_details": colorDetails,
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

class SelectedShop {
  SelectedShop({
    this.id,
    this.userId,
    this.shopName,
    this.shopTagline,
    this.shopMobile,
    this.shopEmail,
    this.shopLocation,
    this.shopDeliveryRadius,
    this.shopLatitude,
    this.shopLongitude,
    this.shopAddress,
    this.shopLogo,
    this.status,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
    this.shopLogoPath,
  });

  int? id;
  int? userId;
  String? shopName;
  dynamic shopTagline;
  String? shopMobile;
  String? shopEmail;
  String? shopLocation;
  String? shopDeliveryRadius;
  String? shopLatitude;
  String? shopLongitude;
  FullAddressClass? shopAddress;
  String? shopLogo;
  String? status;
  String? isFeatured;
  String? createdAt;
  String? updatedAt;
  String? shopLogoPath;

  factory SelectedShop.fromJson(Map<String, dynamic> json) => SelectedShop(
        id: json["id"],
        userId: json["user_id"],
        shopName: json["shop_name"],
        shopTagline: json["shop_tagline"],
        shopMobile: json["shop_mobile"],
        shopEmail: json["shop_email"],
        shopLocation: json["shop_location"],
        shopDeliveryRadius: json["shop_delivery_radius"],
        shopLatitude: json["shop_latitude"],
        shopLongitude: json["shop_longitude"],
        shopAddress: FullAddressClass.fromJson(json["shop_address"]),
        shopLogo: json["shop_logo"],
        status: json["status"],
        isFeatured: json["is_featured"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        shopLogoPath: json["shop_logo_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "shop_name": shopName,
        "shop_tagline": shopTagline,
        "shop_mobile": shopMobile,
        "shop_email": shopEmail,
        "shop_location": shopLocation,
        "shop_delivery_radius": shopDeliveryRadius,
        "shop_latitude": shopLatitude,
        "shop_longitude": shopLongitude,
        "shop_address": shopAddress!.toJson(),
        "shop_logo": shopLogo,
        "status": status,
        "is_featured": isFeatured,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "shop_logo_path": shopLogoPath,
      };
}
