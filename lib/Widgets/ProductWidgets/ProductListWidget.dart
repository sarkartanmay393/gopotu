import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddToCartController/AddToCartController.dart';
import 'package:go_potu_user/Controller/ProductController/ProductController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartButtonWidget.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartNotShowButton.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/ItemIncrementDecrementButton.dart';

class ProductListWidget extends StatelessWidget {
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

  ProductListWidget(
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
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primary)),

          // height: ScreenConstant.defaultWidthOneEighty,
          width: ScreenConstant.defaultWidthOneEighty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   height: ScreenConstant.sizeExtraSmall,
              // ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: productImage ??
                            "https://corp.sellerscommerce.com//SCAssets/images/noimage.png",
                        placeholder: (context, url) =>
                            Image.asset(Assets.loadingImageGif),
                        errorWidget: (context, url, error) => Image.network(
                            "https://corp.sellerscommerce.com//SCAssets/images/noimage.png"),
                        height: ScreenConstant.defaultWidthOneEighty,
                        width: ScreenConstant.defaultWidthOneNinety,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )

                  /*Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        side: BorderSide(
                            color: AppColors.productListingScreenColor),
                      ),
                      child: Container(
                        height: ScreenConstant.sizeXL,
                        width: ScreenConstant.sizeXL,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: AppColors.productListingScreenColor),
                            shape: BoxShape.circle),
                        child: Center(
                            child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.favorite,
                            color: Colors.black26,
                            size: ScreenConstant.sizeLarge,
                          ),
                        )),
                      ),
                    ),
                  ),*/
                ],
              ),
              Container(
                height: ScreenConstant.sizeMedium,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenConstant.sizeSmall,
                  //vertical: ScreenConstant.sizeSmall
                ),
                child: Row(
                  children: [
                    /*Container(
                      height: ScreenConstant.sizeMedium,
                      width: ScreenConstant.sizeMedium,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.green)),
                      child: Center(
                          child: Icon(
                        Icons.circle,
                        size: ScreenConstant.sizeSmall,
                        color: Colors.green,
                      )),
                    ),
                    Container(
                      width: ScreenConstant.sizeSmall,
                    ),*/
                    Flexible(
                      child: Text(
                        productName ?? "",
                        style: TextStyles.productName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: ScreenConstant.sizeExtraSmall,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenConstant.sizeSmall,
                  //vertical: ScreenConstant.sizeSmall
                ),
                child: Row(
                  children: [
                    isProductVariant!
                        ? Offstage()
                        : Text(
                            "Rs. $purchasePrice" ?? "",
                            style: TextStyles.productPrice,
                          ),
                    isProductVariant!
                        ? Offstage()
                        : Container(
                            width: ScreenConstant.sizeExtraSmall,
                          ),
                    isProductVariant!
                        ? Offstage()
                        : (purchasePrice == fakePrice)
                            ? Offstage()
                            : Text(
                                "Rs $fakePrice " ?? "",
                                style: TextStyles.fakePrice,
                              ),
                  ],
                ),
              ),
              Container(
                height: ScreenConstant.sizeExtraSmall,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenConstant.sizeSmall,
                ),
                child: Text(
                  variant == null || variant!.isEmpty
                      ? ""
                      : "${variant![0].toUpperCase()}${variant!.substring(1).toLowerCase()}" ??
                          "",
                  style: TextStyles.productQuantity,
                ),
              ),
              Container(
                height: ScreenConstant.sizeLarge,
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
                      : HiveStore().get(Keys.shopType) == "restaurant"
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
                          : Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenConstant.sizeSmall,
                                  right: ScreenConstant.sizeXXL),
                              child: productQuantity! < 1
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
                                          : ItemIncrementDecrementButton(
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
                                                _cartController.variantId
                                                    .value = variantId!;
                                                _cartController.addToCartPress(
                                                    "1", context);
                                              },
                                              horizontalPadding:
                                                  ScreenConstant.sizeLarge,
                                              verticalPadding:
                                                  ScreenConstant.sizeExtraSmall,
                                            ),
                            ),
            ],
          )),
    );
  }
}
