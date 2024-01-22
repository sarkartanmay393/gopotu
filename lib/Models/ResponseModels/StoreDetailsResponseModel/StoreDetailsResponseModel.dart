// class StoreDetailsResponseModel {
//   StoreDetailsResponseModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//   late final String status;
//   late final String message;
//   late final Data data;

//   StoreDetailsResponseModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = Data.fromJson(json['data']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['message'] = message;
//     _data['data'] = data.toJson();
//     return _data;
//   }
// }

// class Data {
//   Data({
//     this.products,
//   });

//   final List<Products>? products;

//   Data.fromJson(Map<String, dynamic> json) : products = _parseProducts(json);

//   static List<Products>? _parseProducts(Map<String, dynamic> json) {
//     if (json.containsKey('products') && json['products'] != null) {
//       return List.from(json['products'])
//           .map((e) => Products.fromJson(e))
//           .toList();
//     }
//     return null;
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['products'] = products?.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }

// class Products {
//   Products({
//     required this.id,
//     required this.shopId,
//     required this.masterId,
//     this.schemeId,
//     this.offerId,
//     required this.type,
//     this.colors,
//     this.variant,
//     this.variantOptions,
//     required this.status,
//     required this.masterStatus,
//     required this.verificationStatus,
//     required this.topOffer,
//     required this.availability,
//     this.foodType,
//     required this.priority,
//     this.merchantImage,
//     this.imageApproveFlag,
//     required this.foodQty,
//     required this.createdAt,
//     required this.updatedAt,
//     this.deletedAt,
//     required this.deliverable,
//     required this.imagePath,
//     this.details,
//     required this.productVariants,
//     required this.shop,
//   });
//   late final int id;
//   late final int shopId;
//   late final int masterId;
//   late final Null schemeId;
//   late final int? offerId;
//   late final String type;
//   late final Null colors;
//   late final String? variant;
//   late final List<String>? variantOptions;
//   late final String status;
//   late final String masterStatus;
//   late final String verificationStatus;
//   late final String topOffer;
//   late final String availability;
//   late final Null foodType;
//   late final int priority;
//   late final Null merchantImage;
//   late final String? imageApproveFlag;
//   late final String foodQty;
//   late final String createdAt;
//   late final String updatedAt;
//   late final Null deletedAt;
//   late final bool deliverable;
//   late final String imagePath;
//   late final Details? details;
//   late final List<ProductVariants> productVariants;
//   late final Shop shop;

//   Products.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     shopId = json['shop_id'];
//     masterId = json['master_id'];
//     schemeId = null;
//     offerId = null;
//     type = json['type'];
//     colors = null;
//     variant = null;
//     variantOptions = null;
//     status = json['status'];
//     masterStatus = json['master_status'];
//     verificationStatus = json['verification_status'];
//     topOffer = json['top_offer'];
//     availability = json['availability'];
//     foodType = null;
//     priority = json['priority'];
//     merchantImage = null;
//     imageApproveFlag = null;
//     foodQty = json['food_qty'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = null;
//     deliverable = json['deliverable'];
//     imagePath = json['image_path'];
//     details = null;
//     productVariants = List.from(json['product_variants'])
//         .map((e) => ProductVariants.fromJson(e))
//         .toList();
//     shop = Shop.fromJson(json['shop']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['shop_id'] = shopId;
//     _data['master_id'] = masterId;
//     _data['scheme_id'] = schemeId;
//     _data['offer_id'] = offerId;
//     _data['type'] = type;
//     _data['colors'] = colors;
//     _data['variant'] = variant;
//     _data['variant_options'] = variantOptions;
//     _data['status'] = status;
//     _data['master_status'] = masterStatus;
//     _data['verification_status'] = verificationStatus;
//     _data['top_offer'] = topOffer;
//     _data['availability'] = availability;
//     _data['food_type'] = foodType;
//     _data['priority'] = priority;
//     _data['merchant_image'] = merchantImage;
//     _data['image_approve_flag'] = imageApproveFlag;
//     _data['food_qty'] = foodQty;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['deleted_at'] = deletedAt;
//     _data['deliverable'] = deliverable;
//     _data['image_path'] = imagePath;
//     _data['details'] = details;
//     _data['product_variants'] = productVariants.map((e) => e.toJson()).toList();
//     _data['shop'] = shop.toJson();
//     return _data;
//   }
// }

// class Details {
//   Details({
//     required this.id,
//     required this.type,
//     required this.name,
//     required this.categoryId,
//     required this.brandId,
//     required this.schemeId,
//     required this.description,
//     required this.taxRate,
//     required this.image,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     this.deletedAt,
//     required this.imagePath,
//     required this.category,
//     required this.brand,
//     required this.galleryImages,
//   });
//   late final int id;
//   late final String type;
//   late final String name;
//   late final int categoryId;
//   late final int brandId;
//   late final int schemeId;
//   late final String description;
//   late final int taxRate;
//   late final String image;
//   late final String status;
//   late final String createdAt;
//   late final String updatedAt;
//   late final String? deletedAt;
//   late final String imagePath;
//   late final Category category;
//   late final Brand brand;
//   late final List<dynamic> galleryImages;

//   Details.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     type = json['type'];
//     name = json['name'];
//     categoryId = json['category_id'];
//     brandId = json['brand_id'];
//     schemeId = json['scheme_id'];
//     description = json['description'];
//     taxRate = json['tax_rate'];
//     image = json['image'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = null;
//     imagePath = json['image_path'];
//     category = Category.fromJson(json['category']);
//     brand = Brand.fromJson(json['brand']);
//     galleryImages = List.castFrom<dynamic, dynamic>(json['gallery_images']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['type'] = type;
//     _data['name'] = name;
//     _data['category_id'] = categoryId;
//     _data['brand_id'] = brandId;
//     _data['scheme_id'] = schemeId;
//     _data['description'] = description;
//     _data['tax_rate'] = taxRate;
//     _data['image'] = image;
//     _data['status'] = status;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['deleted_at'] = deletedAt;
//     _data['image_path'] = imagePath;
//     _data['category'] = category.toJson();
//     _data['brand'] = brand.toJson();
//     _data['gallery_images'] = galleryImages;
//     return _data;
//   }
// }

// class Category {
//   Category({
//     required this.id,
//     this.parentId,
//     required this.schemeId,
//     required this.name,
//     required this.icon,
//     required this.type,
//     required this.status,
//     required this.isFeatured,
//     required this.createdAt,
//     required this.updatedAt,
//     this.deletedAt,
//     required this.iconPath,
//   });
//   late final int id;
//   late final int? parentId;
//   late final int schemeId;
//   late final String name;
//   late final String icon;
//   late final String type;
//   late final String status;
//   late final String isFeatured;
//   late final String createdAt;
//   late final String updatedAt;
//   late final String? deletedAt;
//   late final String iconPath;

//   Category.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     parentId = null;
//     schemeId = json['scheme_id'];
//     name = json['name'];
//     icon = json['icon'];
//     type = json['type'];
//     status = json['status'];
//     isFeatured = json['is_featured'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = null;
//     iconPath = json['icon_path'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['parent_id'] = parentId;
//     _data['scheme_id'] = schemeId;
//     _data['name'] = name;
//     _data['icon'] = icon;
//     _data['type'] = type;
//     _data['status'] = status;
//     _data['is_featured'] = isFeatured;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['deleted_at'] = deletedAt;
//     _data['icon_path'] = iconPath;
//     return _data;
//   }
// }

// class Brand {
//   Brand({
//     required this.id,
//     required this.name,
//     this.icon,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     this.deletedAt,
//     required this.iconPath,
//   });
//   late final int id;
//   late final String name;
//   late final Null icon;
//   late final String status;
//   late final String createdAt;
//   late final String updatedAt;
//   late final Null deletedAt;
//   late final String iconPath;

//   Brand.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     icon = null;
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = null;
//     iconPath = json['icon_path'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['name'] = name;
//     _data['icon'] = icon;
//     _data['status'] = status;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['deleted_at'] = deletedAt;
//     _data['icon_path'] = iconPath;
//     return _data;
//   }
// }

// class ProductVariants {
//   ProductVariants({
//     required this.id,
//     required this.productId,
//     this.variant,
//     this.color,
//     required this.price,
//     required this.offeredprice,
//     required this.listingprice,
//     required this.quantity,
//     required this.status,
//     this.foodType,
//     required this.sku,
//     required this.createdAt,
//     required this.updatedAt,
//     this.deletedAt,
//     required this.purchasePrice,
//     required this.cartQuantity,
//     this.variantName,
//   });
//   late final int id;
//   late final int productId;
//   late final String? variant;
//   late final Null color;
//   late final int price;
//   late final int offeredprice;
//   late final int listingprice;
//   late final int quantity;
//   late final String status;
//   late final String? foodType;
//   late final String sku;
//   late final String createdAt;
//   late final String updatedAt;
//   late final Null deletedAt;
//   late final int purchasePrice;
//   late final int cartQuantity;
//   late final String? variantName;

//   ProductVariants.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     productId = json['product_id'];
//     variant = null;
//     color = null;
//     price = json['price'];
//     offeredprice = json['offeredprice'];
//     listingprice = json['listingprice'];
//     quantity = json['quantity'];
//     status = json['status'];
//     foodType = null;
//     sku = json['sku'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = null;
//     purchasePrice = json['purchase_price'];
//     cartQuantity = json['cart_quantity'];
//     variantName = null;
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['product_id'] = productId;
//     _data['variant'] = variant;
//     _data['color'] = color;
//     _data['price'] = price;
//     _data['offeredprice'] = offeredprice;
//     _data['listingprice'] = listingprice;
//     _data['quantity'] = quantity;
//     _data['status'] = status;
//     _data['food_type'] = foodType;
//     _data['sku'] = sku;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['deleted_at'] = deletedAt;
//     _data['purchase_price'] = purchasePrice;
//     _data['cart_quantity'] = cartQuantity;
//     _data['variant_name'] = variantName;
//     return _data;
//   }
// }

// class Shop {
//   Shop({
//     required this.id,
//     required this.userId,
//     required this.adminId,
//     required this.shopName,
//     required this.shopTagline,
//     required this.shopMobile,
//     required this.shopWhatsapp,
//     required this.shopEmail,
//     required this.shopLocation,
//     required this.shopDeliveryRadius,
//     required this.shopLatitude,
//     required this.shopLongitude,
//     required this.shopAddress,
//     required this.shopLogo,
//     required this.status,
//     required this.online,
//     required this.openningTime,
//     required this.closingTime,
//     required this.isFeatured,
//     required this.createdAt,
//     required this.updatedAt,
//     this.deletedAt,
//     required this.shopLogoPath,
//     required this.isWishlist,
//   });
//   late final int id;
//   late final int userId;
//   late final int adminId;
//   late final String shopName;
//   late final String shopTagline;
//   late final String shopMobile;
//   late final String shopWhatsapp;
//   late final String shopEmail;
//   late final String shopLocation;
//   late final String shopDeliveryRadius;
//   late final String shopLatitude;
//   late final String shopLongitude;
//   late final ShopAddress shopAddress;
//   late final String shopLogo;
//   late final String status;
//   late final String online;
//   late final String openningTime;
//   late final String closingTime;
//   late final String isFeatured;
//   late final String createdAt;
//   late final String updatedAt;
//   late final Null deletedAt;
//   late final String shopLogoPath;
//   late final bool isWishlist;

//   Shop.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     adminId = json['admin_id'];
//     shopName = json['shop_name'];
//     shopTagline = json['shop_tagline'];
//     shopMobile = json['shop_mobile'];
//     shopWhatsapp = json['shop_whatsapp'];
//     shopEmail = json['shop_email'];
//     shopLocation = json['shop_location'];
//     shopDeliveryRadius = json['shop_delivery_radius'];
//     shopLatitude = json['shop_latitude'];
//     shopLongitude = json['shop_longitude'];
//     shopAddress = ShopAddress.fromJson(json['shop_address']);
//     shopLogo = json['shop_logo'];
//     status = json['status'];
//     online = json['online'];
//     openningTime = json['openning_time'];
//     closingTime = json['closing_time'];
//     isFeatured = json['is_featured'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = null;
//     shopLogoPath = json['shop_logo_path'];
//     isWishlist = json['is_wishlist'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['user_id'] = userId;
//     _data['admin_id'] = adminId;
//     _data['shop_name'] = shopName;
//     _data['shop_tagline'] = shopTagline;
//     _data['shop_mobile'] = shopMobile;
//     _data['shop_whatsapp'] = shopWhatsapp;
//     _data['shop_email'] = shopEmail;
//     _data['shop_location'] = shopLocation;
//     _data['shop_delivery_radius'] = shopDeliveryRadius;
//     _data['shop_latitude'] = shopLatitude;
//     _data['shop_longitude'] = shopLongitude;
//     _data['shop_address'] = shopAddress.toJson();
//     _data['shop_logo'] = shopLogo;
//     _data['status'] = status;
//     _data['online'] = online;
//     _data['openning_time'] = openningTime;
//     _data['closing_time'] = closingTime;
//     _data['is_featured'] = isFeatured;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['deleted_at'] = deletedAt;
//     _data['shop_logo_path'] = shopLogoPath;
//     _data['is_wishlist'] = isWishlist;
//     return _data;
//   }
// }

// class ShopAddress {
//   ShopAddress({
//     this.addressLine1,
//     this.addressLine2,
//     required this.postalCode,
//     required this.city,
//     required this.state,
//     required this.country,
//   });
//   late final Null addressLine1;
//   late final Null addressLine2;
//   late final String postalCode;
//   late final String city;
//   late final String state;
//   late final String country;

//   ShopAddress.fromJson(Map<String, dynamic> json) {
//     addressLine1 = null;
//     addressLine2 = null;
//     postalCode = json['postal_code'];
//     city = json['city'];
//     state = json['state'];
//     country = json['country'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['address_line1'] = addressLine1;
//     _data['address_line2'] = addressLine2;
//     _data['postal_code'] = postalCode;
//     _data['city'] = city;
//     _data['state'] = state;
//     _data['country'] = country;
//     return _data;
//   }
// }

import 'dart:convert';

StoreDetailsResponseModel storeDetailsResponseModelFromJson(String str) =>
    StoreDetailsResponseModel.fromJson(json.decode(str));

String storeDetailsResponseModelToJson(StoreDetailsResponseModel data) =>
    json.encode(data.toJson());

class StoreDetailsResponseModel {
  StoreDetailsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory StoreDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      StoreDetailsResponseModel(
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
    this.shop,
    this.featuredCategories,
    this.topofferedProducts,
    this.appbanners,
  });

  Shop? shop;
  List<Category>? featuredCategories;
  List<TopofferedProduct>? topofferedProducts;
  Appbanners? appbanners;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        shop: json["shop"] != null ? Shop.fromJson(json["shop"]) : null,
        featuredCategories: List<Category>.from(
            json["featured_categories"].map((x) => Category.fromJson(x))),
        topofferedProducts: List<TopofferedProduct>.from(
            json["all_products"].map((x) => TopofferedProduct.fromJson(x))),
        appbanners: Appbanners.fromJson(json["appbanners"]),
      );

  get shopName => null;

  Map<String, dynamic> toJson() => {
        "shop": shop!.toJson(),
        "featured_categories":
            List<dynamic>.from(featuredCategories!.map((x) => x.toJson())),
        "topoffered_products":
            List<dynamic>.from(topofferedProducts!.map((x) => x.toJson())),
        "appbanners": appbanners!.toJson(),
      };
}

class Appbanners {
  Appbanners({this.top, this.middle, this.footer});

  List<Top>? top;
  List<dynamic>? middle;
  List<dynamic>? footer;

  factory Appbanners.fromJson(Map<String, dynamic> json) => Appbanners(
        top: List<Top>.from(json["footer"].map((x) => Top.fromJson(x))),
        // middle: List<dynamic>.from(json["middle"].map((x) => x)),
        // footer: List<dynamic>.from(json["footer"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "top": List<dynamic>.from(top!.map((x) => x.toJson())),
        "middle": List<dynamic>.from(middle!.map((x) => x)),
      };
}

class Top {
  Top({
    this.id,
    this.position,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.imagePath,
  });

  int? id;
  String? position;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? imagePath;

  factory Top.fromJson(Map<String, dynamic> json) => Top(
        id: json["id"],
        position: json["position"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position,
        "image": image,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "image_path": imagePath,
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
    this.shop_cover_path,
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
   String? shop_cover_path;
  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
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
        "parent_id": parentId == null ? null : parentId,
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
    this.deliverable,
    this.distanceaway,
    this.avg_rating,
    this.document,
    this.shopCoverPath
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
  ShopAddress? shopAddress;
  String? shopLogo;
  String? status;
  String? isFeatured;
  String? createdAt;
  String? updatedAt;
  String? shopLogoPath;
  String? shopCoverPath;
  bool? deliverable;
  String? distanceaway;
  double? avg_rating;
  Document? document;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
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
        shopAddress: ShopAddress.fromJson(json["shop_address"]),
        shopLogo: json["shop_logo"],
        status: json["status"],
        isFeatured: json["is_featured"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        shopLogoPath: json["shop_logo_path"],
    shopCoverPath: json["shop_cover_path"],
        deliverable: json["deliverable"],
        distanceaway: json["distanceaway"],
        avg_rating: double.parse(json["avg_rating"].toString()),
        document: Document.fromJson(json["document"]),
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
            "shop_cover_path":shopCoverPath
      };
}

class Document {
  Document({
    this.tradelicenseNumber,
    this.fssairegNumber,
    this.gstinNumber,
  });

  String? tradelicenseNumber;
  String? fssairegNumber;
  String? gstinNumber;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        tradelicenseNumber: json["tradelicense_number"],
        fssairegNumber: json["fssaireg_number"],
        gstinNumber: json["gstin_number"],
      );

  Map<String, dynamic> toJson() => {
        "tradelicense_number": tradelicenseNumber,
        "fssaireg_number": fssairegNumber,
        "gstin_number": gstinNumber,
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

  dynamic addressLine1;
  dynamic addressLine2;
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

class TopofferedProduct {
  TopofferedProduct({
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
    this.productVariants,
    this.food_type
  });
String? food_type;
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
  dynamic isWishlist;
  Details? details;
  List<ProductVariant>? productVariants;

  factory TopofferedProduct.fromJson(Map<String, dynamic> json) =>
      TopofferedProduct(
        id: json["id"],
        shopId: json["shop_id"],
        food_type: json["food_type"],
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
        details:
            json["details"] != null ? Details.fromJson(json["details"]) : null,
        productVariants: json["product_variants"] != null
            ? List<ProductVariant>.from(
                json["product_variants"].map((x) => ProductVariant.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
    "food_type":food_type,
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
        "product_variants":
            List<dynamic>.from(productVariants!.map((x) => x.toJson())),
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
        // brand: Brand.fromJson(json["brand"]),
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

class ProductVariant {
  ProductVariant({
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
    this.purchasePrice,
    this.cartQuantity,
    this.variantName,
    this.food_type
  });
String? food_type;
  int? id;
  int? productId;
  String? variant;
  dynamic color;
  int? price;
  int? offeredprice;
  // int listingPrice; //listingPrice
  int? quantity;
  String? status;
  String? sku;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  int? purchasePrice;
  dynamic cartQuantity;
  String? variantName;

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
        id: json["id"],
        productId: json["product_id"],
        variant: json["variant"],
        color: json["color"],
        price: json["price"],
        offeredprice:
            json["offeredprice"] == null ? null : json["offeredprice"],
        // listingPrice: json["listingprice"] == null ? json["purchase_price"] : json["listingprice"],
        quantity: json["quantity"],
        food_type: json["food_type"],
        status: json["status"],
        sku: json["sku"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        purchasePrice: (json["listingprice"] == null
                ? json["purchase_price"].toInt()
                : json["listingprice"])
            .toInt(),
        cartQuantity: json["cart_quantity"],
        variantName: json["variant_name"].toString().toUpperCase(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "variant": variant,
        "color": color,
        "price": price,
        "offeredprice": offeredprice == null ? null : offeredprice,
        // "listingPrice": listingPrice,
        "quantity": quantity,
        "status": status,
        "sku": sku,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "purchase_price": purchasePrice,
        "cart_quantity": cartQuantity,
        "variant_name": variantName,
    "food_type":food_type
      };
}
