import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/ProductController/ProductController.dart';
import 'package:go_potu_user/Controller/SubCategoryController/SubCategoryController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartButtonWidget.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartNotShowButton.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/ItemIncrementDecrementButton.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SubCategoryProductListWidget extends StatelessWidget {
  final int? index;
  final List<dynamic>? productList;

  SubCategoryProductListWidget({this.index, this.productList});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: productList![index!]['availability'] == "comingsoon"
          ? () {}
          : () {
              final ProductController _productController =
                  Get.put(ProductController());
              _productController.productId.value =
                  productList![index!]['id'].toString();
              Future.delayed(Duration(milliseconds: 500), () {
                _productController.productDetailsPress(false);
              });

              Get.toNamed(
                productDetails,
              );
            },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: AppColors.secondary,
          child: Row(
            children: [
              Column(
                children: [
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: productList![index!]['details']['image_path'] ??
                          "https://corp.sellerscommerce.com//SCAssets/images/noimage.png",
                      placeholder: (context, url) =>
                          Image.asset(Assets.loadingImageGif),
                      errorWidget: (context, url, error) => Image.network(
                          "https://corp.sellerscommerce.com//SCAssets/images/noimage.png"),
                      fit: BoxFit.contain,
                      height: ScreenConstant.defaultHeightOneForty,
                      width: ScreenConstant.defaultHeightOneForty,
                    ),
                  ),
                ],
              ),
              Container(
                width: ScreenConstant.sizeXL,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                          productList![index!]['details']['name'],
                          style: TextStyles.productDetailsProductName,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    Row(
                      children: [
                        productList![index!]['product_variants'].isEmpty
                            ? Offstage()
                            : Text(
                                "Rs. ${productList![index!]['product_variants'][0]['listingprice'] != null ? double.parse(productList![index!]['product_variants'][0]['listingprice'].toString()).toStringAsFixed(2) : (productList?[index!]['product_variants'][0]['purchase_price'] != null ? double.parse(productList![index!]['product_variants'][0]['purchase_price'].toString()).toStringAsFixed(2) : "")}",

                                // "Rs. ${double.parse(productList[index]['product_variants'][0]['purchase_price'].toString()).toStringAsFixed(2)}" ??
                                //     "",
                                style: TextStyles.productPriceInProductDetails,
                              ),
                        productList![index!]['product_variants'].isEmpty
                            ? Offstage()
                            : Container(
                                width: ScreenConstant.sizeSmall,
                              ),
                        productList![index!]['product_variants'].isEmpty
                            ? Offstage()
                            : Text(
                                "Rs. ${double.parse(productList![index!]['product_variants'][0]['price'].toString()).toStringAsFixed(2)}",
                                style: TextStyles.fakePriceInOrderDetails,
                              ),
                      ],
                    ),
                    productList![index!]['product_variants'].isEmpty
                        ? Offstage()
                        : (productList![index!]['product_variants'][0]
                                        ['price']) -
                                    (productList![index!]['product_variants'][0]
                                        ['purchase_price']) ==
                                0
                            ? Offstage()
                            : (productList![index!]['product_variants'][0]
                                            ['price']) -
                                        (productList![index!]
                                                ['product_variants'][0]
                                            ['purchase_price']) ==
                                    1
                                ? Text(
                                    "You Save Re. 1 in this order",
                                    style:
                                        TextStyles.productDetailsDiscountText,
                                  )
                                : Text(
                                    "You Save Rs. ${(productList![index!]['product_variants'][0]['price']) - (productList?[index!]['product_variants'][0]['purchase_price'])} in this order",
                                    style:
                                        TextStyles.productDetailsDiscountText,
                                  ),
                    Container(
                      height: ScreenConstant.sizeMedium,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.sizeSmall),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          /* Padding(
                            padding:
                                EdgeInsets.only(right: ScreenConstant.sizeXL),
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
                                        color:
                                            AppColors.productListingScreenColor),
                                    shape: BoxShape.circle),
                                child: Center(
                                    child: GestureDetector(
                                        onTap: () {
                                          print("hi");
                                        },
                                        child: Icon(Icons.favorite,
                                            color: index % 2 == 0
                                                ? Colors.red
                                                : Colors.black26,
                                            size: ScreenConstant.sizeLarge))),
                              ),
                            ),
                          ),*/
                          productList![index!]['availability'] == "comingsoon"
                              ? Text(
                                  "Coming Soon",
                                  style: TextStyles.outOfStock,
                                )
                              : productList![index!]['product_variants'].isEmpty
                                  ? Offstage()
                                  : HiveStore().get(Keys.shopType) ==
                                          "restaurant"
                                      ? productList![index!]['product_variants']
                                                      [0]['cart_quantity'] ==
                                                  null ||
                                              productList![index!]['product_variants']
                                                      [0]['cart_quantity'] ==
                                                  0
                                          ? productList![index!]["deliverable"] ==
                                                  false
                                              ? AddToCartNotShowButtonWidget(
                                                  addToCart: () {},
                                                  horizontalPadding:
                                                      ScreenConstant.sizeLarge,
                                                  verticalPadding:
                                                      ScreenConstant
                                                          .sizeExtraSmall,
                                                )
                                              : AddToCartButtonWidget(
                                                  horizontalPadding:
                                                      ScreenConstant.sizeLarge,
                                                  verticalPadding:
                                                      ScreenConstant
                                                          .sizeExtraSmall,
                                                  addToCart: () {
                                                    final SubCategoryController
                                                        _subCategoryController =
                                                        Get.find();
                                                    _subCategoryController
                                                            .shopIdForCart
                                                            .value =
                                                        _subCategoryController
                                                            .shopId.value
                                                            .toString();
                                                    _subCategoryController
                                                        .variantId
                                                        .value = productList![
                                                                    index!][
                                                                'product_variants']
                                                            [0]['id']
                                                        .toString();
                                                    _subCategoryController
                                                        .subCategoryAddToCartPress(
                                                            "1", context);
                                                  },
                                                )
                                          : productList![index!]["deliverable"] ==
                                                  false
                                              ? AddToCartNotShowButtonWidget(
                                                  addToCart: () {},
                                                  horizontalPadding:
                                                      ScreenConstant.sizeLarge,
                                                  verticalPadding:
                                                      ScreenConstant
                                                          .sizeExtraSmall,
                                                )
                                              : ItemIncrementDecrementButton(
                                                  incrementCart: () {
                                                    final SubCategoryController
                                                        _subCategoryController =
                                                        Get.find();
                                                    _subCategoryController
                                                            .shopIdForCart
                                                            .value =
                                                        _subCategoryController
                                                            .shopId.value
                                                            .toString();
                                                    _subCategoryController
                                                        .variantId
                                                        .value = productList![
                                                                    index!][
                                                                'product_variants']
                                                            [0]['id']
                                                        .toString();
                                                    _subCategoryController
                                                        .subCategoryAddToCartPress(
                                                            "+1", context);
                                                  },
                                                  decrementCart: () {
                                                    final SubCategoryController
                                                        _subCategoryController =
                                                        Get.find();
                                                    _subCategoryController
                                                            .shopIdForCart
                                                            .value =
                                                        _subCategoryController
                                                            .shopId.value
                                                            .toString();
                                                    _subCategoryController
                                                        .variantId
                                                        .value = productList![
                                                                    index!][
                                                                'product_variants']
                                                            [0]['id']
                                                        .toString();
                                                    _subCategoryController
                                                        .subCategoryAddToCartPress(
                                                            "-1", context);
                                                  },
                                                  quantity: productList![index!]
                                                              [
                                                              'product_variants']
                                                          [0]['cart_quantity']
                                                      .toString(),
                                                )
                                      : productList![index!]['product_variants']
                                                  [0]['quantity'] <
                                              1
                                          ? Text(
                                              "Out Of Stock",
                                              style: TextStyles.outOfStock,
                                            )
                                          : productList![index!]['product_variants']
                                                          [0]['cart_quantity'] ==
                                                      null ||
                                                  productList![index!]['product_variants'][0]['cart_quantity'] == 0
                                              ? productList![index!]["deliverable"] == false
                                                  ? AddToCartNotShowButtonWidget(
                                                      addToCart: () {},
                                                      horizontalPadding:
                                                          ScreenConstant
                                                              .sizeLarge,
                                                      verticalPadding:
                                                          ScreenConstant
                                                              .sizeExtraSmall,
                                                    )
                                                  : AddToCartButtonWidget(
                                                      horizontalPadding:
                                                          ScreenConstant
                                                              .sizeLarge,
                                                      verticalPadding:
                                                          ScreenConstant
                                                              .sizeExtraSmall,
                                                      addToCart: () {
                                                        final SubCategoryController
                                                            _subCategoryController =
                                                            Get.find();
                                                        _subCategoryController
                                                                .shopIdForCart
                                                                .value =
                                                            _subCategoryController
                                                                .shopId.value
                                                                .toString();
                                                        _subCategoryController
                                                            .variantId
                                                            .value = productList![
                                                                        index!][
                                                                    'product_variants']
                                                                [0]['id']
                                                            .toString();
                                                        _subCategoryController
                                                            .subCategoryAddToCartPress(
                                                                "1", context);
                                                      },
                                                    )
                                              : productList![index!]["deliverable"] == false
                                                  ? AddToCartNotShowButtonWidget(
                                                      addToCart: () {},
                                                      horizontalPadding:
                                                          ScreenConstant
                                                              .sizeLarge,
                                                      verticalPadding:
                                                          ScreenConstant
                                                              .sizeExtraSmall,
                                                    )
                                                  : ItemIncrementDecrementButton(
                                                      incrementCart: () {
                                                        final SubCategoryController
                                                            _subCategoryController =
                                                            Get.find();
                                                        _subCategoryController
                                                                .shopIdForCart
                                                                .value =
                                                            _subCategoryController
                                                                .shopId.value
                                                                .toString();
                                                        _subCategoryController
                                                            .variantId
                                                            .value = productList![
                                                                        index!][
                                                                    'product_variants']
                                                                [0]['id']
                                                            .toString();
                                                        _subCategoryController
                                                            .subCategoryAddToCartPress(
                                                                "+1", context);
                                                      },
                                                      decrementCart: () {
                                                        final SubCategoryController
                                                            _subCategoryController =
                                                            Get.find();
                                                        _subCategoryController
                                                                .shopIdForCart
                                                                .value =
                                                            _subCategoryController
                                                                .shopId.value
                                                                .toString();
                                                        _subCategoryController
                                                            .variantId
                                                            .value = productList![
                                                                        index!][
                                                                    'product_variants']
                                                                [0]['id']
                                                            .toString();
                                                        _subCategoryController
                                                            .subCategoryAddToCartPress(
                                                                "-1", context);
                                                      },
                                                      quantity: productList![
                                                                      index!][
                                                                  'product_variants']
                                                              [
                                                              0]['cart_quantity']
                                                          .toString(),
                                                    ),
                        ],
                      ),
                    ),
                    Container(
                      height: ScreenConstant.sizeMedium,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: ScreenConstant.sizeSmall),
                      child: Divider(
                        thickness: 1,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
