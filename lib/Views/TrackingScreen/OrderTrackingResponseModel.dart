

class ApiResponse {
  final String status;
  final String message;
  final ApiData data;

  ApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      message: json['message'],
      data: ApiData.fromJson(json['data']),
    );
  }
}

class ApiData {
  final Order order;
  final List<Banner> banner;

  ApiData({
    required this.order,
    required this.banner,
  });

  factory ApiData.fromJson(Map<String, dynamic> json) {
    return ApiData(
      order: Order.fromJson(json['order']),
      banner: List<Banner>.from(
        json['banner'].map((banner) => Banner.fromJson(banner)),
      ),
    );
  }
}

class Order {
  final int id;
  final int shopId;
  final String type;
  final String custName;
  final String custMobile;
  final String custLatitude;
  final String custLongitude;
  final String custLocation;
  final CustAddress custAddress;
  final int itemTotal;
  final int merchantTotal;
  final int deliveryCharge;
  final int couponDiscount;
  final int walletDeducted;
  final int payableAmount;
  final int walletCashback;
  final int adminCharge;
  final int tips;
  final String status;
  final String expectedDelivery;
  final String deliveryStatus;
  final String deliveredTime;
  final String expectedIntransit;
  final String intransitTime;
  final String outfordeliveryTime;
  final String operationTime;
  final List<StatusLog> statusLog;
  final int couponId;
  final String paymentMode;
  final String paymentTxnid;
  final String paymentRefid;
  final int deliveryboyId;
  final String deliveryboyStatus;
  final String deliveryboyReachedstore;
  final dynamic shopRating;
  final dynamic shopReview;
  final dynamic deliveryboyRating;
  final dynamic deliveryboyReview;
  final dynamic userCancelReason;
  final dynamic adminCancellationReason;
  final dynamic merchantCancellationReason;
  final String createdAt;
  final String updatedAt;
  final dynamic invoice;
  final List<OrderProduct> orderProducts;
  final dynamic deliveryboy;
  final Shop shop;

  Order({
    required this.id,
    required this.shopId,
    required this.type,
    required this.custName,
    required this.custMobile,
    required this.custLatitude,
    required this.custLongitude,
    required this.custLocation,
    required this.custAddress,
    required this.itemTotal,
    required this.merchantTotal,
    required this.deliveryCharge,
    required this.couponDiscount,
    required this.walletDeducted,
    required this.payableAmount,
    required this.walletCashback,
    required this.adminCharge,
    required this.tips,
    required this.status,
    required this.expectedDelivery,
    required this.deliveryStatus,
    required this.deliveredTime,
    required this.expectedIntransit,
    required this.intransitTime,
    required this.outfordeliveryTime,
    required this.operationTime,
    required this.statusLog,
    required this.couponId,
    required this.paymentMode,
    required this.paymentTxnid,
    required this.paymentRefid,
    required this.deliveryboyId,
    required this.deliveryboyStatus,
    required this.deliveryboyReachedstore,
    required this.shopRating,
    required this.shopReview,
    required this.deliveryboyRating,
    required this.deliveryboyReview,
    required this.userCancelReason,
    required this.adminCancellationReason,
    required this.merchantCancellationReason,
    required this.createdAt,
    required this.updatedAt,
    required this.invoice,
    required this.orderProducts,
    required this.deliveryboy,
    required this.shop,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      shopId: json['shop_id'] ?? 0,
      type: json['type'] ?? '',
      custName: json['cust_name'] ?? '',
      custMobile: json['cust_mobile'] ?? '',
      custLatitude: json['cust_latitude'] ?? '',
      custLongitude: json['cust_longitude'] ?? '',
      custLocation: json['cust_location'] ?? '',
      custAddress: CustAddress.fromJson(json['cust_address'] ?? {}),
      itemTotal: json['item_total'] ?? 0,
      merchantTotal: json['merchant_total'] ?? 0,
      deliveryCharge: json['delivery_charge'] ?? 0,
      couponDiscount: json['coupon_discount'] ?? 0,
      walletDeducted: json['wallet_deducted'] ?? 0,
      payableAmount: json['payable_amount'] ?? 0,
      walletCashback: json['wallet_cashback'] ?? 0,
      adminCharge: json['admin_charge'] ?? 0,
      tips: json['tips'] ?? 0,
      status: json['status'] ?? '',
      expectedDelivery: json['expected_delivery'] ?? '',
      deliveryStatus: json['delivery_status'] ?? '',
      deliveredTime: json['delivered_time'] ?? '',
      expectedIntransit: json['expected_intransit'] ?? '',
      intransitTime: json['intransit_time'] ?? '',
      outfordeliveryTime: json['outfordelivery_time'] ?? '',
      operationTime: json['operation_time'] ?? '',
      statusLog: (json['status_log'] as List<dynamic>?)
          ?.map((e) => StatusLog.fromJson(e))
          .toList() ??
          [],
      couponId: json['coupon_id'] ?? 0,
      paymentMode: json['payment_mode'] ?? '',
      paymentTxnid: json['payment_txnid'] ?? '',
      paymentRefid: json['payment_refid'] ?? '',
      deliveryboyId: json['deliveryboy_id'] ?? 0,
      deliveryboyStatus: json['deliveryboy_status'] ?? '',
      deliveryboyReachedstore: json['deliveryboy_reachedstore'] ?? '',
      shopRating: json['shop_rating'],
      shopReview: json['shop_review'],
      deliveryboyRating: json['deliveryboy_rating'],
      deliveryboyReview: json['deliveryboy_review'],
      userCancelReason: json['user_cancel_reason'],
      adminCancellationReason: json['admin_cancellation_reason'],
      merchantCancellationReason: json['merchant_cancellation_reason'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      invoice: json['invoice'],
      orderProducts: (json['order_products'] as List<dynamic>?)
          ?.map((e) => OrderProduct.fromJson(e))
          .toList() ??
          [],
      deliveryboy: json['deliveryboy'],
      shop: Shop.fromJson(json['shop'] ?? {}),
    );
  }
}

class Shop {
  final int id;
  final String shopName;
  // ... other fields

  Shop({
    required this.id,
    required this.shopName,
    // ... other required fields
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'] ?? 0,
      shopName: json['shop_name'] ?? '',
      // ... initialize other fields
    );
  }
}

class CustAddress {
  final dynamic addressLine1;
  final dynamic addressLine2;
  final String postalCode;
  final String city;
  final String state;
  final String country;
  final String landmark;

  CustAddress({
    required this.addressLine1,
    required this.addressLine2,
    required this.postalCode,
    required this.city,
    required this.state,
    required this.country,
    required this.landmark,
  });

  factory CustAddress.fromJson(Map<String, dynamic> json) {
    return CustAddress(
      addressLine1: json['address_line1'],
      addressLine2: json['address_line2'],
      postalCode: json['postal_code'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      landmark: json['landmark'],
    );
  }
}

class StatusLog {
  final String key;
  final String label;
  final String timestamp;

  StatusLog({
    required this.key,
    required this.label,
    required this.timestamp,
  });

  factory StatusLog.fromJson(Map<String, dynamic> json) {
    return StatusLog(
      key: json['key'],
      label: json['label'],
      timestamp: json['timestamp'],
    );
  }
}

class OrderProduct {
  final int id;
  final int orderId;
  final int productId;
  final int variantId;
  final VariantSelected variantSelected;
  final int price;
  final int listingprice;
  final int tax;
  final int quantity;
  final int subTotal;
  final int taxTotal;
  final int shopTin;
  final String createdAt;
  final String updatedAt;
  final Product product;

  OrderProduct({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.variantId,
    required this.variantSelected,
    required this.price,
    required this.listingprice,
    required this.tax,
    required this.quantity,
    required this.subTotal,
    required this.taxTotal,
    required this.shopTin,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      variantId: json['variant_id'],
      variantSelected: VariantSelected.fromJson(json['variant_selected']),
      price: json['price'],
      listingprice: json['listingprice'],
      tax: json['tax'],
      quantity: json['quantity'],
      subTotal: json['sub_total'],
      taxTotal: json['tax_total'],
      shopTin: json['shop_tin'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      product: Product.fromJson(json['product']),
    );
  }
}

class VariantSelected {
  final dynamic colorCode;
  final dynamic colorName;
  final dynamic variantCode;
  final String variantName;

  VariantSelected({
    required this.colorCode,
    required this.colorName,
    required this.variantCode,
    required this.variantName,
  });

  factory VariantSelected.fromJson(Map<String, dynamic> json) {
    return VariantSelected(
      colorCode: json['color_code'],
      colorName: json['color_name'],
      variantCode: json['variant_code'],
      variantName: json['variant_name'],
    );
  }
}

class Product {
  final int id;
  final int shopId;
  final int masterId;
  final dynamic schemeId;
  final dynamic offerId;
  final String type;
  final dynamic colors;
  final dynamic variant;
  final dynamic variantOptions;
  final String status;
  final String masterStatus;
  final String verificationStatus;
  final String topOffer;
  final String availability;
  final dynamic foodType;
  final int priority;
  final dynamic merchantImage;
  final String imageApproveFlag;
  final String foodQty;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final String imagePath;
  final Details details;

  Product({
    required this.id,
    required this.shopId,
    required this.masterId,
    required this.schemeId,
    required this.offerId,
    required this.type,
    required this.colors,
    required this.variant,
    required this.variantOptions,
    required this.status,
    required this.masterStatus,
    required this.verificationStatus,
    required this.topOffer,
    required this.availability,
    required this.foodType,
    required this.priority,
    required this.merchantImage,
    required this.imageApproveFlag,
    required this.foodQty,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.imagePath,
    required this.details,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0, // Provide a default value if 'id' is null
      shopId: json['shop_id'] ?? 0, // Provide a default value if 'shop_id' is null
      masterId: json['master_id'] ?? 0, // Provide a default value if 'master_id' is null
      schemeId: json['scheme_id'],
      offerId: json['offer_id'],
      type: json['type'] ?? '',
      colors: json['colors'],
      variant: json['variant'],
      variantOptions: json['variant_options'],
      status: json['status'] ?? '',
      masterStatus: json['master_status'] ?? '',
      verificationStatus: json['verification_status'] ?? '',
      topOffer: json['top_offer'] ?? '',
      availability: json['availability'] ?? '',
      foodType: json['food_type'],
      priority: json['priority'] ?? 0, // Provide a default value if 'priority' is null
      merchantImage: json['merchant_image'],
      imageApproveFlag: json['image_approve_flag'] ?? '',
      foodQty: json['food_qty'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'],
      imagePath: json['image_path'] ?? '',
      details: Details.fromJson(json['details'] ?? {}),
    );
  }
}


class Details {
  final int id;
  final String type;
  final String name;
  final int categoryId;
  final int brandId;
  final int schemeId;
  final String description;
  final int taxRate;
  final String image;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final String imagePath;
  final Category category;
  final Brand brand;
  final List<dynamic> galleryImages;

  Details({
    required this.id,
    required this.type,
    required this.name,
    required this.categoryId,
    required this.brandId,
    required this.schemeId,
    required this.description,
    required this.taxRate,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.imagePath,
    required this.category,
    required this.brand,
    required this.galleryImages,
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      id: json['id'] ?? 0, // Provide a default value if 'id' is null
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      categoryId: json['category_id'] ?? 0, // Provide a default value if 'category_id' is null
      brandId: json['brand_id'] ?? 0, // Provide a default value if 'brand_id' is null
      schemeId: json['scheme_id'] ?? 0, // Provide a default value if 'scheme_id' is null
      description: json['description'] ?? '',
      taxRate: json['tax_rate'] ?? 0, // Provide a default value if 'tax_rate' is null
      image: json['image'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'] ?? '',
      imagePath: json['image_path'] ?? '',
      category: Category.fromJson(json['category'] ?? {}), // Handle nullable 'category'
      brand: Brand.fromJson(json['brand'] ?? {}), // Handle nullable 'brand'
      galleryImages: List<dynamic>.from(json['gallery_images'] ?? []),
    );
  }
}


class Category {
  final int id;
  final dynamic parentId;
  final int schemeId;
  final String name;
  final String icon;
  final String type;
  final String status;
  final String isFeatured;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final String iconPath;

  Category({
    required this.id,
    required this.parentId,
    required this.schemeId,
    required this.name,
    required this.icon,
    required this.type,
    required this.status,
    required this.isFeatured,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.iconPath,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0, // Provide a default value if 'id' is null
      parentId: json['parent_id'],
      schemeId: json['scheme_id'] ?? 0, // Provide a default value if 'scheme_id' is null
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      isFeatured: json['is_featured'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'] ?? '',
      iconPath: json['icon_path'] ?? '', // Provide a default value if 'icon_path' is null
    );
  }
}

class Brand {
  final int id;
  final String name;
  final dynamic icon;
  final String status;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final String iconPath;

  Brand({
    required this.id,
    required this.name,
    required this.icon,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.iconPath,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'] ?? 0, // Provide a default value if 'id' is null
      name: json['name'] ?? '',
      icon: json['icon'],
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'],
      iconPath: json['icon_path'] ?? '', // Provide a default value if 'icon_path' is null
    );
  }
}


class Banner {
  final int id;
  final String position;
  final dynamic type;
  final dynamic bannerType;
  final dynamic shopId;
  final String image;
  final String status;
  final String isFeatured;
  final String createdAt;
  final String updatedAt;
  final String imagePath;

  Banner({
    required this.id,
    required this.position,
    required this.type,
    required this.bannerType,
    required this.shopId,
    required this.image,
    required this.status,
    required this.isFeatured,
    required this.createdAt,
    required this.updatedAt,
    required this.imagePath,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
   return Banner(
      id: json['id'] ?? 0, // Provide a default value if 'id' is null
      position: json['position'] ?? '',
      type: json['type'],
      bannerType: json['banner_type'],
      shopId: json['shop_id'],
      image: json['image'] ?? '', // Provide a default value if 'image' is null
      status: json['status'] ?? '',
      isFeatured: json['is_featured'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      imagePath: json['image_path'] ?? '',
    );
  }
}



// Add other classes for nested structures (e.g., customer details, product details)
