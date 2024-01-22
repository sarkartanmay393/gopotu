// To parse this JSON data, do
//
//     final searchResponseModel = searchResponseModelFromJson(jsonString);

import 'dart:convert';

SearchResponseModel searchResponseModelFromJson(String str) => SearchResponseModel.fromJson(json.decode(str));

String searchResponseModelToJson(SearchResponseModel data) => json.encode(data.toJson());

class SearchResponseModel {
  SearchResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) => SearchResponseModel(
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
    this.shops,
    this.products,
  });

  List<Shop>? shops;
  List<Product>? products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    shops: List<Shop>.from(json["shops"].map((x) => Shop.fromJson(x))),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "shops": List<dynamic>.from(shops!.map((x) => x.toJson())),
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
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

  int? id;
  int? shopId;
  int? masterId;
  String? type;
  List<String>? colors;
  dynamic variant;
  dynamic variantOptions;
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
    colors: json["colors"] == null ? null : List<String>.from(json["colors"].map((x) => x)),
    variant: json["variant"],
    variantOptions: json["variant_options"],
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
    "colors": colors == null ? null : List<dynamic>.from(colors!.map((x) => x)),
    "variant": variant,
    "variant_options": variantOptions,
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

  int? id;
  String? type;
  String? name;
  int? categoryId;
  int? brandId;
  String? description;
  int? taxRate;
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

  int? id;
  int? userId;
  String? shopName;
  String? shopTagline;
  String? shopMobile;
  String? shopWhatsapp;
  String? shopEmail;
  String? shopLocation;
  String? shopDeliveryRadius;
  String? shopLatitude;
  String? shopLongitude;
  ShopAddress? shopAddress;
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
    shopAddress: ShopAddress.fromJson(json["shop_address"]),
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

class ShopAddress {
  ShopAddress({
    this.addressLine1,
    this.addressLine2,
    this.postalCode,
    this.city,
    this.state,
    this.country,
  });

  String? addressLine1;
  String? addressLine2;
  String? postalCode;
  String? city;
  String? state;
  String? country;

  factory ShopAddress.fromJson(Map<String, dynamic> json) => ShopAddress(
    addressLine1: json["address_line1"],
    addressLine2: json["address_line2"],
    postalCode: json["postal_code"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "address_line1": addressLine1,
    "address_line2": addressLine2,
    "postal_code": postalCode,
    "city": city,
    "state": state,
    "country": country,
  };
}
