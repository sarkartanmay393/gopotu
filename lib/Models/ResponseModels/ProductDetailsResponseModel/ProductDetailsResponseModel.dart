// To parse this JSON data, do
//
//     final productDetailsResponseModel = productDetailsResponseModelFromJson(jsonString);

import 'dart:convert';
import 'dart:typed_data';

ProductDetailsResponseModel productDetailsResponseModelFromJson(String str) =>
    ProductDetailsResponseModel.fromJson(json.decode(str));

String productDetailsResponseModelToJson(ProductDetailsResponseModel data) =>
    json.encode(data.toJson());

class ProductDetailsResponseModel {
  ProductDetailsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  ProductData? data;

  factory ProductDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsResponseModel(
        status: json["status"],
        message: json["message"],
        data: ProductData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class ProductData {
  ProductData({
    this.relatedProducts,
    this.product,
  });

  List<Product>? relatedProducts;
  Product? product;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        relatedProducts: List<Product>.from(
            json["related_products"].map((x) => Product.fromJson(x))),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "related_products":
            List<dynamic>.from(relatedProducts!.map((x) => x.toJson())),
        "product": product!.toJson(),
      };
}

class Product {
  Product(
      {this.id,
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
      this.isWishlist,
      this.details,
      this.shop,
      this.productVariants,
      this.deliverable});

  int? id;
  int? shopId;
  int? masterId;
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
  bool? isWishlist;
  Details? details;
  Shop? shop;
  List<ProductVariant>? productVariants;
  bool? deliverable;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        shopId: json["shop_id"],
        masterId: json["master_id"],
        type: json["type"],
        colors: json["colors"] == null
            ? null
            : List<String>.from(json["colors"].map((x) => x)),
        variant: json["variant"] == null ? null : json["variant"],
        variantOptions: json["variant_options"] == null
            ? null
            : List<String>.from(json["variant_options"].map((x) => x)),
        status: json["status"],
        topOffer: json["top_offer"],
        availability: json["availability"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        isWishlist: json["is_wishlist"],
        details: Details.fromJson(json["details"]),
        shop: json["shop"] != null ? Shop.fromJson(json["shop"]) : null,
        productVariants: List<ProductVariant>.from(
            json["product_variants"].map((x) => ProductVariant.fromJson(x))),
        deliverable: json["deliverable"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "master_id": masterId,
        "type": type,
        "colors":
            colors == null ? null : List<dynamic>.from(colors!.map((x) => x)),
        "variant": variant == null ? null : variant,
        "variant_options": variantOptions == null
            ? null
            : List<dynamic>.from(variantOptions!.map((x) => x)),
        "status": status,
        "top_offer": topOffer,
        "availability": availability,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "is_wishlist": isWishlist,
        "details": details!.toJson(),
        "shop": shop!.toJson(),
        "product_variants":
            List<dynamic>.from(productVariants!.map((x) => x.toJson())),
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
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.productImages,
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
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<String>? productImages;
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
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        productImages: json["product_images"] == null
            ? null
            : List<String>.from(json["product_images"].map((x) => x)),
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
        "image": image,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "product_images": productImages == null
            ? null
            : List<dynamic>.from(productImages!.map((x) => x)),
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

class Shop {
  Shop({
    this.id,
    this.user_id,
    this.shop_name,
    this.shop_tagline,
  });

  int? id;
  int? user_id;
  // ignore: non_constant_identifier_names
  String? shop_name;
  String? shop_tagline;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        user_id: json["user_id"],
        shop_name: json["shop_name"],
        shop_tagline: json["shop_tagline"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": user_id,
        "shop_name": shop_name,
        "shop_tagline": shop_tagline,
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
  });

  int? id;
  int? productId;
  String? variant;
  String? color;
  double? price;
  double? offeredprice;
  // int listingPrice; //listingPrice
  int? quantity;
  String? status;
  String? sku;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  double? purchasePrice;
  int? cartQuantity;
  String? variantName;

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
        id: json["id"],
        productId: json["product_id"],
        variant: json["variant"],
        color: json["color"],
        price: json["price"].toDouble(),
        offeredprice: json["offeredprice"].toDouble(),
        // listingPrice: json["listingprice"], //listingPrice
        quantity: json["quantity"],
        status: json["status"],
        sku: json["sku"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        purchasePrice: (json["listingprice"] == null
                ? json["purchase_price"].toDouble()
                : json["listingprice"])
            .toDouble(),
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
        // "listingPrice": listingPrice, //listingPrice
        "quantity": quantity,
        "status": status,
        "sku": sku,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "purchase_price": purchasePrice,
        "cart_quantity": cartQuantity,
        "variant_name": variantName,
      };
}
