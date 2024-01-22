import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddToCartController/AddToCartController.dart';
import 'package:go_potu_user/Controller/ProductController/ProductController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartButtonWidget.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartButtonWidget1.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartNotShowButton.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartNotShowButton1.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/ItemIncrementDecrementButton.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/ItemIncrementDecrementButtonWidget1.dart';

class ProductListWidget1 extends StatelessWidget {
  final String? productName;
  // final String listingPrice;
  final String? purchasePrice;
  final String? fakePrice;
  final String? variant;
  final String? productImage;
  final String? productId;
  final bool? addCart;
  final String? productCartQuantity;
  final String? shopId;
  final String? variantId;
  final bool? isStore;
  final bool? isProductDetails;
  final int? productQuantity;
  final bool? isProductVariant;
  final String? availability;
  final bool? isDeliverable;
  final bool? color;

  final AddToCartController _cartController = Get.put(AddToCartController());
  final ProductController _productController = Get.put(ProductController());

  ProductListWidget1(
      {
        // this.listingPrice,
        this.purchasePrice,
        this.productName,
        this.fakePrice,
        this.variant,
        this.productImage,
        this.productId,
        this.addCart,
        this.productCartQuantity,
        this.shopId,
        this.variantId,
        this.isStore = false,
        this.isProductDetails = false,
        this.productQuantity,
        this.isProductVariant,
        this.availability,
        this.color,
        this.isDeliverable});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: availability == "comingsoon"
          ? () {}
          : () {
        final ProductController _productController =
        Get.put(ProductController());
        _productController.productId.value = productId!;
        Future.delayed(Duration(milliseconds: 500), () {
          _productController.productDetailsPress(false);
        });
        Get.toNamed(
          productDetails,
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: ScreenConstant.sizeLarge),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  height: ScreenConstant.defaultHeightSeventy,
                  width: ScreenConstant.defaultHeightSeventy,
                  child: CachedNetworkImage(
                    imageUrl: productImage ??
                        "https://corp.sellerscommerce.com//SCAssets/images/noimage.png",
                    placeholder: (context, url) =>
                        Image.asset(Assets.loadingImageGif),
                    errorWidget: (context, url, error) => Image.network(
                        "https://corp.sellerscommerce.com//SCAssets/images/noimage.png"),
                    height: ScreenConstant.defaultHeightFifty,
                    width: ScreenConstant.defaultHeightFifty,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: ScreenConstant.defaultHeightEight,
                ),
                Container(
                  width: ScreenConstant.defaultHeightFifty,
                  height: ScreenConstant.defaultWidthTwenty,
                  child: Text(
                    productName ?? "",
                    style: TextStyle(
                        fontSize: FontSizeStatic.sm,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: ScreenConstant.defaultHeightEight,
                ),
                Row(
                  children: [
                    Visibility(
                      visible: _productController.productDetailsData.value
                          .product?.productVariants?.isNotEmpty ==
                          true &&
                          _productController
                              .productDetailsData.value.product?.variant !=
                              null,
                      child: Column(
                        children: _productController
                            .productDetailsData.value.product!.productVariants!
                            .map((e) => Text(
                          "${e.variantName ?? ''}",
                          style: TextStyle(
                            fontSize: FontSizeStatic.sm,
                            color: Colors.grey,
                          ),
                        ))
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "${((double.parse(fakePrice ?? "0.0") - double.parse(purchasePrice ?? "0.0")) / double.parse(fakePrice ?? "1.0") * 100).toStringAsFixed(2)}%",
                      style: TextStyle(
                          fontSize: FontSizeStatic.sm, color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenConstant.defaultHeightEight,
                ),
                Row(
                  children: [
                    Text(
                      "₹$purchasePrice" ?? "",
                      style: TextStyle(fontSize: FontSizeStatic.md),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "$fakePrice " ?? "",
                      style: TextStyle(
                          fontSize: FontSizeStatic.md,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenConstant.defaultHeightFive,
                ),
                availability == "comingsoon"
                    ? Padding(
                  padding: EdgeInsets.only(
                      left: ScreenConstant.sizeSmall,
                      right: ScreenConstant.sizeXXL),
                  child: Text(
                    "Coming Soon",
                    style: TextStyles.outOfStock,
                  ),
                )
                    : isProductVariant!
                    ? Offstage()
                    : HiveStore().get(Keys.shopType) == "Mart"
                    ? Padding(
                  padding: EdgeInsets.only(
                      left: ScreenConstant.sizeSmall,
                      right: ScreenConstant.sizeXXL),
                  child: addCart!
                      ? !isDeliverable!
                      ? AddToCartNotShowButtonWidget(
                    addToCart: () {},
                    horizontalPadding:
                    ScreenConstant.sizeLarge,
                    verticalPadding:
                    ScreenConstant.sizeExtraSmall,
                  )
                      : ItemIncrementDecrementButton(
                    incrementCart: () {
                      _cartController.isStore.value =
                      isStore!;
                      _cartController.isProductDetails
                          .value = isProductDetails!;
                      _cartController.shopId.value =
                      shopId!;
                      _cartController.variantId.value =
                      variantId!;
                      _cartController.addToCartPress(
                          "1", context);
                    },
                    decrementCart: () {
                      _cartController.isStore.value =
                      isStore!;
                      _cartController.isProductDetails
                          .value = isProductDetails!;
                      _cartController.shopId.value =
                      shopId!;
                      _cartController.variantId.value =
                      variantId!;
                      _cartController.addToCartPress(
                          "-1", context);
                    },
                    quantity: productCartQuantity!,
                  )
                      : !isDeliverable!
                      ? AddToCartNotShowButtonWidget(
                    addToCart: () {},
                    horizontalPadding:
                    ScreenConstant.sizeLarge,
                    verticalPadding:
                    ScreenConstant.sizeExtraSmall,
                  )
                      : AddToCartButtonWidget(
                    addToCart: () {
                      _cartController.isStore.value =
                      isStore!;
                      _cartController.isProductDetails
                          .value = isProductDetails!;
                      _cartController.shopId.value =
                      shopId!;
                      _cartController.variantId.value =
                      variantId!;
                      _cartController.addToCartPress(
                          "1", context);
                    },
                    horizontalPadding:
                    ScreenConstant.sizeLarge,
                    verticalPadding:
                    ScreenConstant.sizeExtraSmall,
                  ),
                )
               : productQuantity != null && productQuantity! < 1
                    ? Text(
                  "Out Of Stock",
                  style: TextStyles.outOfStock,
                )
                        : addCart!
                        ? !isDeliverable!
                        ? AddToCartNotShowButtonWidget(
                      addToCart: () {},
                      horizontalPadding:
                      ScreenConstant.sizeLarge,
                      verticalPadding:
                      ScreenConstant.sizeExtraSmall,
                    )
                        : ItemIncrementDecrementButton1(
                      incrementCart: () {
                        _cartController.isStore.value =
                        isStore!;
                        _cartController.isProductDetails
                            .value = isProductDetails!;
                        _cartController.shopId.value =
                        shopId!;
                        _cartController.variantId
                            .value = variantId!;
                        _cartController.addToCartPress(
                            "1", context);
                      },
                      decrementCart: () {
                        _cartController.isStore.value =
                        isStore!;
                        _cartController.isProductDetails
                            .value = isProductDetails!;
                        _cartController.shopId.value =
                        shopId!;
                        _cartController.variantId
                            .value = variantId!;
                        _cartController.addToCartPress(
                            "-1", context);
                      },
                      quantity: productCartQuantity!,
                    )
                        : !isDeliverable!
                        ? AddToCartNotShowButtonWidget1(
                      addToCart: () {},
                      horizontalPadding:
                      ScreenConstant.sizeLarge,
                      verticalPadding:
                      ScreenConstant.sizeExtraSmall,
                    )
                        : AddToCartButtonWidget1(
                      addToCart: () {
                        _cartController.isStore.value =
                        isStore!;
                        _cartController.isProductDetails
                            .value = isProductDetails!;
                        _cartController.shopId.value =
                        shopId!;
                        _cartController.variantId
                            .value = variantId!;
                        _cartController.addToCartPress(
                            "1", context);
                      },

                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
