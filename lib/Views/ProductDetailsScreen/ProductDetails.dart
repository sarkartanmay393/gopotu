import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddToCartController/AddToCartController.dart';
import 'package:go_potu_user/Controller/AddressController/AddressController.dart';
import 'package:go_potu_user/Controller/DashboardController/DashboardController.dart';
import 'package:go_potu_user/Controller/MyBucketController/MyBucketController.dart';
import 'package:go_potu_user/Controller/ProductController/ProductController.dart';
import 'package:go_potu_user/Controller/StoreController/StoreController.dart';
import 'package:go_potu_user/Controller/SubCategoryController/SubCategoryController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/HexColor.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Views/AddressScreens/AddNewAddressScreen.dart';
import 'package:go_potu_user/Views/AddressScreens/SelectAddress.dart';
import 'package:go_potu_user/Views/HomeScreen/HomeScreen.dart';
import 'package:go_potu_user/Views/HomeScreen/Return_Refund.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartButtonWidget.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartButtonWidget1.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartNotShowButton.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/ItemIncrementDecrementButton.dart';
import 'package:go_potu_user/Widgets/ProductWidgets/ProductListWidget.dart';
import 'package:go_potu_user/Widgets/ProductWidgets/ProductListWidget1.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Models/ResponseModels/AddToCartResponseModel/AddToCartResponseModel.dart';
import '../../Widgets/AppButtonWidget/ItemIncrementDecrementButtonWidget1.dart';
import '../OrdersScreen/RefundAndReturnDetailsScreen.dart';
import 'PhotoViewScreen.dart';

class ProductDetails extends StatefulWidget {
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final ProductController _productController = Get.put(ProductController());
  final AddToCartController _cartController = Get.put(AddToCartController());

  final AddressController _addressController = Get.put(AddressController());
  final DashboardController _dashboardController =
      Get.put(DashboardController());

  setInitialAddress({LatLng? latLng, String description = ''}) async {
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(latLng!.latitude, latLng.longitude);
    var place = placeMarks.first;
    print(place);
    var _address = '';
    if (description.isNotEmpty) {
      _address = description + ' - ${place.postalCode}';
    } else {
      _address =
          '${place.street}, ${place.thoroughfare},${place.subLocality}, ${place.locality}, ${place.country} - ${place.postalCode}';
    }
    setState(() {
      _addressController.location.text = _address;
      _addressController.city.value = place.locality!;
      _addressController.state.value = place.administrativeArea!;
      _addressController.postalCode.value = place.postalCode!;
      _addressController.country.value = place.country!;
      _addressController.postalCodeController.text = place.postalCode!;
    });
  }

  setLatLng(LatLng _position) async {
    _addressController.lat.value = _position.latitude;
    _addressController.lng.value = _position.longitude;
    _addressController.lat2.value = _position.latitude;
    _addressController.lng2.value = _position.longitude;

    print("Lat : ${_addressController.lat.value}");
    print("Lng : ${_addressController.lng.value}");
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<bool> _onBackPressed() {
    _productController.isLoading.value = true;
    _productController.purchasePrice.value = "0.00";
    // _productController.listingPrice.value = "0.00"; //listingPrice
    _productController.fakePrice.value = "0.00";
    _productController.discountAmount.value = "0.00";
    if (_productController.isSearch.value) {
      _productController.isSearch.value = false;
      Get.back();
      // return Future.value(true);
    } else {
      StoreController storeController = Get.find();
      storeController.storeDetailsPress(false);
      SubCategoryController subCategoryController =
          Get.put(SubCategoryController());

      if (subCategoryController.allTap.value) {
        subCategoryController.loadProductListPress(
            subCategoryController.categoryParentId.toString(), true);
      } else {
        subCategoryController.loadProductListPress(
            subCategoryController.subcategoryId.toString(), true);
      }

      Get.back();
    }

    return Future.value(false);
  }

  String? _stripHtmlTags(String? htmlString) {
    if (htmlString == null) return null;

    // Use a regular expression to remove HTML tags
    final strippedString = htmlString.replaceAll(RegExp(r'<[^>]*>'), '');

    // Decode HTML entities
    final unescape = HtmlUnescape();
    return unescape.convert(strippedString);
  }

  bool isContainer1Selected = true;
  bool isContainer2Selected = false;
  bool showDescription = false;
  bool _isRadioButtonSelected = true;
  VariantDetails? selectedVariantDetails;
  String shopType = HiveStore().get(Keys.shopType);
  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
        onWillPop:() async {
    // Your logic for handling the back button press
    Navigator.pop(context);
    return true; // Return true to allow the back navigation, false to prevent it
    },
        child: Scaffold(
          backgroundColor: AppColors.secondary,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                size: FontSizeStatic.xxxl,color: Colors.white,
              ),
              onPressed: (() {
                Navigator.pop(context);
              }),
            ),
            centerTitle: true,
            backgroundColor: AppColors.primary,
            elevation: 0,
            title: Text(
              AppStrings.ProductDetails,
              style: TextStyles.appBarTitle,
            ),
            // actions: [
            //   GestureDetector(
            //     onTap: () {
            //       Get.toNamed(notifications);
            //     },
            //     child: Icon(Icons.notifications),
            //   ),
            //   Container(
            //     width: ScreenConstant.sizeMedium,
            //   ),
            // ],
          ),
          body: _productController.isLoading.value
              ? Container()
              : _productController.productDetailsData.value.product == null
                  ? Container()
                  : Stack(alignment: Alignment.topRight, children: [
                      ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(ScreenConstant.sizeMedium),
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
                                // Flexible(
                                // child: Text(
                                // _productController.productDetailsData
                                //     .value.product!.details!.name!,
                                //   style: TextStyles
                                //       .productDetailsProductName,
                                // ),
                                // ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: CarouselSlider.builder(
                              itemCount: _productController
                                  .productDetailsData
                                  .value
                                  .product!
                                  .details!
                                  .productImages!
                                  .length,
                              options: CarouselOptions(
                                  autoPlay: _productController
                                              .productDetailsData
                                              .value
                                              .product!
                                              .details!
                                              .productImages!
                                              .length ==
                                          1
                                      ? false
                                      : true,
                                  enlargeCenterPage: false,
                                  viewportFraction: 1,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  }),
                              itemBuilder: (context, index, realIdx) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(PhotoViewScreen(
                                      imageList: _productController
                                          .productDetailsData
                                          .value
                                          .product!
                                          .details!
                                          .productImages,
                                    ));
                                  },
                                  child: Container(
                                    child: Center(
                                        child: Image.network(
                                      _productController
                                          .productDetailsData
                                          .value
                                          .product!
                                          .details!
                                          .productImages![index],
                                      fit: BoxFit.contain,
                                    )),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            height: ScreenConstant.sizeMedium,
                          ),
                          _productController.productDetailsData.value.product!
                                      .details!.productImages!.length ==
                                  1
                              ? Offstage()
                              : Container(
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: _productController
                                        .productDetailsData
                                        .value
                                        .product!
                                        .details!
                                        .productImages!
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      return GestureDetector(
                                        onTap: () => _controller
                                            .animateToPage(entry.key),
                                        child: Container(
                                          width: ScreenConstant.sizeDefault,
                                          height: ScreenConstant.sizeDefault,
                                          margin: EdgeInsets.symmetric(
                                              vertical:
                                                  ScreenConstant.sizeExtraSmall,
                                              horizontal: ScreenConstant
                                                  .sizeExtraSmall),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: (Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : Colors.black)
                                                  .withOpacity(
                                                      _current == entry.key
                                                          ? 0.9
                                                          : 0.4)),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                          Container(
                            height: ScreenConstant.sizeXL,
                          ),
                          Column(
                            children: [
                              Row(children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenConstant.defaultWidthTwenty),
                                  child: Container(
                                    width: ScreenConstant.defaultWidthOneEighty,
                                    child: Text(
                                      _productController.productDetailsData
                                          .value.product!.details!.name!,
                                      style: TextStyle(
                                          fontSize: FontSizeStatic.maxMd),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenConstant.defaultHeightSeventy,
                                ),
                                Container(
                                    height: ScreenConstant.defaultHeightForty,
                                    width: ScreenConstant.defaultHeightOneHundred,
                                  child:  HiveStore().get(Keys.shopType) ==
                                      "restaurant"
                                      ? _productController
                                      .productVariantDetailsData
                                      .value
                                      .variantDetails !=
                                      null
                                      ? Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      _productController
                                          .productVariantDetailsData
                                          .value
                                          .variantDetails!
                                          .cartQuantity ==
                                          0 ||
                                          _productController
                                              .productVariantDetailsData
                                              .value
                                              .variantDetails!
                                              .cartQuantity ==
                                              null
                                          ? !_productController
                                          .productDetailsData
                                          .value
                                          .product!
                                          .deliverable!
                                          ? AddToCartNotShowButtonWidget(
                                        addToCart:
                                            () {},
                                        horizontalPadding:
                                        ScreenConstant
                                            .sizeLarge,
                                        verticalPadding:
                                        ScreenConstant
                                            .sizeExtraSmall,
                                      )
                                          : AddToCartButtonWidget(
                                        addToCart:
                                            () {
                                          _cartController
                                              .isProductDetailsAdd
                                              .value = _productController.isFirstCallVariant.value ==
                                              1
                                              ? false
                                              : true;
                                          _cartController
                                              .isStore
                                              .value = false;
                                          _cartController
                                              .isProductDetails
                                              .value = _productController.isFirstCallVariant.value ==
                                              1
                                              ? true
                                              : false;
                                          _cartController.shopId.value = _productController
                                              .productDetailsData
                                              .value
                                              .product!
                                              .shopId
                                              .toString();
                                          _cartController
                                              .variantId
                                              .value =
                                              _productController
                                                  .productVariantDetailsData
                                                  .value
                                                  .variantDetails!
                                                  .id
                                                  .toString();
                                          _cartController
                                              .addToCartPress(
                                              "1",
                                              context);
                                        },
                                        horizontalPadding:
                                        ScreenConstant
                                            .sizeLarge,
                                        verticalPadding:
                                        ScreenConstant
                                            .sizeExtraSmall,
                                      )
                                          : !_productController
                                          .productDetailsData
                                          .value
                                          .product!
                                          .deliverable!
                                          ? AddToCartNotShowButtonWidget(
                                        addToCart:
                                            () {},
                                        horizontalPadding:
                                        ScreenConstant
                                            .sizeLarge,
                                        verticalPadding:
                                        ScreenConstant
                                            .sizeExtraSmall,
                                      )
                                          : ItemIncrementDecrementButton(
                                        incrementCart:
                                            () {
                                          _cartController
                                              .isStore
                                              .value = false;
                                          _cartController
                                              .isProductDetailsAdd
                                              .value = _productController.isFirstCallVariant.value ==
                                              1
                                              ? false
                                              : true;

                                          _cartController
                                              .isCart
                                              .value = false;
                                          _cartController
                                              .isProductDetails
                                              .value = _productController.isFirstCallVariant.value ==
                                              1
                                              ? true
                                              : false;
                                          _cartController.shopId.value = _productController
                                              .productDetailsData
                                              .value
                                              .product!
                                              .shopId
                                              .toString();
                                          _cartController
                                              .variantId
                                              .value =
                                              _productController
                                                  .productVariantDetailsData
                                                  .value
                                                  .variantDetails!
                                                  .id
                                                  .toString();
                                          _cartController
                                              .addToCartPress(
                                              "1",
                                              context);
                                        },
                                        decrementCart:
                                            () {
                                          _cartController
                                              .isStore
                                              .value = false;
                                          _cartController
                                              .isProductDetailsAdd
                                              .value = _productController.isFirstCallVariant.value ==
                                              1
                                              ? false
                                              : true;
                                          _cartController
                                              .isCart
                                              .value = false;
                                          _cartController
                                              .isProductDetails
                                              .value = _productController.isFirstCallVariant.value ==
                                              1
                                              ? true
                                              : false;
                                          _cartController.shopId.value = _productController
                                              .productDetailsData
                                              .value
                                              .product!
                                              .shopId
                                              .toString();
                                          _cartController
                                              .variantId
                                              .value =
                                              _productController
                                                  .productVariantDetailsData
                                                  .value
                                                  .variantDetails!
                                                  .id
                                                  .toString();
                                          _cartController
                                              .addToCartPress(
                                              "-1",
                                              context);
                                        },
                                        quantity: _productController
                                            .productVariantDetailsData
                                            .value
                                            .variantDetails!
                                            .cartQuantity
                                            .toString(),
                                      ),
                                    ],
                                  )
                                      : Offstage()
                                      : _productController
                                      .productVariantDetailsData
                                      .value
                                      .variantDetails !=
                                      null
                                      ? Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      _productController
                                          .productVariantDetailsData
                                          .value
                                          .variantDetails!
                                          .quantity! <
                                          1
                                          ? Text(
                                        "Out Of Stock",
                                        style: TextStyles
                                            .outOfStock,
                                      )
                                          : _productController
                                          .productVariantDetailsData
                                          .value
                                          .variantDetails!
                                          .cartQuantity ==
                                          0 ||
                                          _productController
                                              .productVariantDetailsData
                                              .value
                                              .variantDetails!
                                              .cartQuantity ==
                                              null
                                          ? !_productController
                                          .productDetailsData
                                          .value
                                          .product!
                                          .deliverable!
                                          ? AddToCartNotShowButtonWidget(
                                        addToCart:
                                            () {},
                                        horizontalPadding:
                                        ScreenConstant
                                            .sizeLarge,
                                        verticalPadding:
                                        ScreenConstant
                                            .sizeExtraSmall,
                                      )
                                          : AddToCartButtonWidget(
                                        addToCart:
                                            () {
                                          _cartController
                                              .isProductDetailsAdd
                                              .value = _productController.isFirstCallVariant.value ==
                                              1
                                              ? false
                                              : true;
                                          _cartController
                                              .isStore
                                              .value = false;
                                          _cartController
                                              .isProductDetails
                                              .value = _productController.isFirstCallVariant.value ==
                                              1
                                              ? true
                                              : false;
                                          _cartController.shopId.value = _productController
                                              .productDetailsData
                                              .value
                                              .product!
                                              .shopId
                                              .toString();
                                          _cartController.variantId.value = _productController
                                              .productVariantDetailsData
                                              .value
                                              .variantDetails!
                                              .id
                                              .toString();
                                          _cartController.addToCartPress(
                                              "1",
                                              context);
                                        },
                                        horizontalPadding:
                                        ScreenConstant
                                            .sizeLarge,
                                        verticalPadding:
                                        ScreenConstant
                                            .sizeExtraSmall,
                                      )
                                          : !_productController
                                          .productDetailsData
                                          .value
                                          .product!
                                          .deliverable!
                                          ? AddToCartNotShowButtonWidget(
                                        addToCart:
                                            () {},
                                        horizontalPadding:
                                        ScreenConstant
                                            .sizeLarge,
                                        verticalPadding:
                                        ScreenConstant
                                            .sizeExtraSmall,
                                      )
                                          : ItemIncrementDecrementButton(
                                        incrementCart:
                                            () {
                                          _cartController
                                              .isProductDetailsAdd
                                              .value = _productController.isFirstCallVariant.value ==
                                              1
                                              ? false
                                              : true;

                                          _cartController
                                              .isCart
                                              .value = false;
                                          _cartController
                                              .isProductDetails
                                              .value = _productController.isFirstCallVariant.value ==
                                              1
                                              ? true
                                              : false;
                                          _cartController.shopId.value = _productController
                                              .productDetailsData
                                              .value
                                              .product!
                                              .shopId
                                              .toString();
                                          _cartController.variantId.value = _productController
                                              .productVariantDetailsData
                                              .value
                                              .variantDetails!
                                              .id
                                              .toString();
                                          _cartController.addToCartPress(
                                              "1",
                                              context);
                                        },
                                        decrementCart:
                                            () {
                                          _cartController
                                              .isProductDetailsAdd
                                              .value = _productController.isFirstCallVariant.value ==
                                              1
                                              ? false
                                              : true;
                                          _cartController
                                              .isCart
                                              .value = false;
                                          _cartController
                                              .isProductDetails
                                              .value = _productController.isFirstCallVariant.value ==
                                              1
                                              ? true
                                              : false;
                                          _cartController.shopId.value = _productController
                                              .productDetailsData
                                              .value
                                              .product!
                                              .shopId
                                              .toString();
                                          _cartController.variantId.value = _productController
                                              .productVariantDetailsData
                                              .value
                                              .variantDetails!
                                              .id
                                              .toString();
                                          _cartController.addToCartPress(
                                              "-1",
                                              context);
                                        },
                                        quantity: _productController
                                            .productVariantDetailsData
                                            .value
                                            .variantDetails!
                                            .cartQuantity
                                            .toString(),
                                      ),
                                    ],
                                  )
                                      : Offstage(),
                                )
                                // Container(
                                //   height: ScreenConstant.defaultHeightForty,
                                //   width: ScreenConstant.defaultHeightOneHundred,
                                //   child: (shopType == "mart" || shopType == "restaurant") &&
                                //           _productController
                                //                   .productVariantDetailsData
                                //                   .value
                                //                   .variantDetails !=
                                //               null
                                //       ? (_productController
                                //                       .productVariantDetailsData
                                //                       .value
                                //                       .variantDetails!
                                //                       .quantity !=
                                //                   null &&
                                //               _productController
                                //                       .productVariantDetailsData
                                //                       .value
                                //                       .variantDetails!
                                //                       .quantity! <
                                //                   1)
                                //           ? Container(
                                //               width: ScreenConstant
                                //                   .defaultHeightOneHundred,
                                //               child: Text(
                                //                 "Out Of Stock",
                                //                 style: TextStyle(
                                //                     fontSize:
                                //                         FontSizeStatic.md),
                                //                 overflow: TextOverflow.ellipsis,
                                //               ),
                                //             )
                                //           : (_productController
                                //                           .productVariantDetailsData
                                //                           .value
                                //                           .variantDetails ==
                                //                       null ||
                                //                   _productController
                                //                           .productVariantDetailsData
                                //                           .value
                                //                           .variantDetails!
                                //                           .cartQuantity ==
                                //                       0)
                                //               ? (!_productController
                                //                       .productDetailsData
                                //                       .value
                                //                       .product!
                                //                       .deliverable!)
                                //                   ? AddToCartNotShowButtonWidget(
                                //                       addToCart: () {},
                                //                       horizontalPadding:
                                //                           ScreenConstant
                                //                               .sizeLarge,
                                //                       verticalPadding:
                                //                           ScreenConstant
                                //                               .sizeExtraSmall,
                                //                     )
                                //                   : AddToCartButtonWidget(
                                //                       addToCart: () {
                                //                         bool hasVariants = _productController
                                //                                     .productDetailsData
                                //                                     .value
                                //                                     .product!
                                //                                     .variantOptions !=
                                //                                 null &&
                                //                             _productController
                                //                                 .productDetailsData
                                //                                 .value
                                //                                 .product!
                                //                                 .variantOptions!
                                //                                 .isNotEmpty;
                                //
                                //                         // Check if variantId is set before proceeding
                                //                         if ((_cartController
                                //                                         .variantId
                                //                                         .value ==
                                //                                     null ||
                                //                                 _cartController
                                //                                     .variantId
                                //                                     .value
                                //                                     .isEmpty) &&
                                //                             hasVariants) {
                                //                           // Show a SnackBar with a message
                                //                           ScaffoldMessenger.of(
                                //                                   context)
                                //                               .showSnackBar(
                                //                             SnackBar(
                                //                               content: Text(
                                //                                   'Please choose a option to add the product to the cart.'),
                                //                             ),
                                //                           );
                                //                         } else {
                                //                           // Proceed with adding to the cart
                                //                           _cartController
                                //                               .isProductDetailsAdd
                                //                               .value = _productController
                                //                                       .isFirstCallVariant
                                //                                       .value ==
                                //                                   1
                                //                               ? false
                                //                               : true;
                                //                           _cartController
                                //                               .isStore
                                //                               .value = false;
                                //                           _cartController
                                //                               .isProductDetails
                                //                               .value = _productController
                                //                                       .isFirstCallVariant
                                //                                       .value ==
                                //                                   1
                                //                               ? true
                                //                               : false;
                                //                           _cartController.shopId
                                //                                   .value =
                                //                               _productController
                                //                                   .productDetailsData
                                //                                   .value
                                //                                   .product!
                                //                                   .shopId
                                //                                   .toString();
                                //
                                //                           if (!hasVariants) {
                                //                             _cartController
                                //                                     .variantId
                                //                                     .value =
                                //                                 _productController
                                //                                     .productVariantDetailsData
                                //                                     .value
                                //                                     .variantDetails!
                                //                                     .id
                                //                                     .toString();
                                //                           }
                                //                           // _cartController.addToCartPress(_cartController.variantId.value, context);
                                //                           // Add the product to the cart
                                //                           _cartController
                                //                               .addToCartPress(
                                //                                   "1", context);
                                //                         }
                                //                       },
                                //                       horizontalPadding:
                                //                           ScreenConstant
                                //                               .sizeLarge,
                                //                       verticalPadding:
                                //                           ScreenConstant
                                //                               .sizeExtraSmall,
                                //                     )
                                //               : (!_productController
                                //                       .productDetailsData
                                //                       .value
                                //                       .product!
                                //                       .deliverable!)
                                //                   ? AddToCartNotShowButtonWidget(
                                //                       addToCart: () {},
                                //                       horizontalPadding:
                                //                           ScreenConstant
                                //                               .sizeLarge,
                                //                       verticalPadding:
                                //                           ScreenConstant
                                //                               .sizeExtraSmall,
                                //                     )
                                //                   : ItemIncrementDecrementButton(
                                //                       incrementCart: () {
                                //                         bool hasVariants = _productController
                                //                                     .productDetailsData
                                //                                     .value
                                //                                     .product!
                                //                                     .variantOptions !=
                                //                                 null &&
                                //                             _productController
                                //                                 .productDetailsData
                                //                                 .value
                                //                                 .product!
                                //                                 .variantOptions!
                                //                                 .isNotEmpty;
                                //                         _cartController
                                //                             .isProductDetailsAdd
                                //                             .value = _productController
                                //                                     .isFirstCallVariant
                                //                                     .value ==
                                //                                 1
                                //                             ? false
                                //                             : true;
                                //                         _cartController.isStore
                                //                             .value = false;
                                //                         _cartController
                                //                                 .isProductDetails
                                //                                 .value =
                                //                             _productController
                                //                                         .isFirstCallVariant
                                //                                         .value ==
                                //                                     1
                                //                                 ? true
                                //                                 : false;
                                //                         _cartController
                                //                                 .shopId.value =
                                //                             _productController
                                //                                 .productDetailsData
                                //                                 .value
                                //                                 .product!
                                //                                 .shopId
                                //                                 .toString();
                                //
                                //                         if (!hasVariants) {
                                //                           _cartController
                                //                                   .variantId
                                //                                   .value =
                                //                               _productController
                                //                                   .productVariantDetailsData
                                //                                   .value
                                //                                   .variantDetails!
                                //                                   .id
                                //                                   .toString();
                                //                         }
                                //                         _cartController
                                //                             .addToCartPress(
                                //                                 "1", context);
                                //                       },
                                //                       decrementCart: () {
                                //                         bool hasVariants = _productController
                                //                                     .productDetailsData
                                //                                     .value
                                //                                     .product!
                                //                                     .variantOptions !=
                                //                                 null &&
                                //                             _productController
                                //                                 .productDetailsData
                                //                                 .value
                                //                                 .product!
                                //                                 .variantOptions!
                                //                                 .isNotEmpty;
                                //                         _cartController
                                //                             .isProductDetailsAdd
                                //                             .value = _productController
                                //                                     .isFirstCallVariant
                                //                                     .value ==
                                //                                 1
                                //                             ? false
                                //                             : true;
                                //                         _cartController.isStore
                                //                             .value = false;
                                //                         _cartController
                                //                                 .isProductDetails
                                //                                 .value =
                                //                             _productController
                                //                                         .isFirstCallVariant
                                //                                         .value ==
                                //                                     1
                                //                                 ? true
                                //                                 : false;
                                //                         _cartController
                                //                                 .shopId.value =
                                //                             _productController
                                //                                 .productDetailsData
                                //                                 .value
                                //                                 .product!
                                //                                 .shopId
                                //                                 .toString();
                                //                         if (!hasVariants) {
                                //                           _cartController
                                //                                   .variantId
                                //                                   .value =
                                //                               _productController
                                //                                   .productVariantDetailsData
                                //                                   .value
                                //                                   .variantDetails!
                                //                                   .id
                                //                                   .toString();
                                //                         }
                                //                         _cartController
                                //                             .addToCartPress(
                                //                                 "-1", context);
                                //                       },
                                //                       quantity: _productController
                                //                           .productVariantDetailsData
                                //                           .value
                                //                           .variantDetails!
                                //                           .cartQuantity
                                //                           .toString(),
                                //                     )
                                //       : Offstage(),
                                // )

                              ]),

                            ],
                          ),


                          SizedBox(
                            height: ScreenConstant.defaultHeightTen,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: ScreenConstant.defaultWidthTwenty),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Toggle the visibility of the description
                                  showDescription = !showDescription;
                                });
                              },
                              child: Text(
                                "Read More",
                                style: TextStyle(
                                  fontSize: FontSizeStatic.maxMd,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
// Display the description if showDescription is true
                          if (showDescription)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _stripHtmlTags(_productController
                                        .productDetailsData
                                        .value
                                        .product
                                        ?.details
                                        ?.description) ??
                                    "No description available",
                                style:
                                    TextStyle(fontSize: FontSizeStatic.maxMd),
                                textAlign: TextAlign
                                    .left, // Adjust the alignment as needed
                              ),
                            ),

                          // SizedBox(
                          //   height: ScreenConstant.defaultWidthTen,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //       left: ScreenConstant.defaultWidthTwenty),
                          //   child: Text(
                          //     "Special Price",
                          //     style: TextStyle(
                          //         fontSize: FontSizeStatic.maxMd,
                          //         color: Colors.green,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                          SizedBox(
                            height: ScreenConstant.defaultWidthTwenty,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: ScreenConstant.defaultWidthTwenty),
                            child: Row(
                              children: [
                                Text(
                                  "MRP",
                                  style: TextStyle(
                                      fontSize: FontSizeStatic.md,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  width: ScreenConstant.defaultHeightTen,
                                ),
                                Text(
                                  "${_productController.fakePrice.value}",
                                  style: TextStyle(
                                      fontSize: FontSizeStatic.md,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                SizedBox(
                                  width: ScreenConstant.defaultHeightTen,
                                ),
                                Text(
                                  "₹${_productController.purchasePrice.value}",
                                  style: TextStyle(
                                      fontSize: FontSizeStatic.md,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: ScreenConstant.defaultHeightTen,
                                ),
                                Text(
                                  "${((double.parse(_productController.fakePrice.value) - double.parse(_productController.purchasePrice.value)) / double.parse(_productController.fakePrice.value) * 100).toStringAsFixed(0)}% off",
                                  style: TextStyle(
                                      fontSize: FontSizeStatic.md,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                                SizedBox(
                                  width: ScreenConstant.defaultSizeOneForty,
                                ),
                                // Text(
                                //   "@₹25/kg",
                                //   style: TextStyle(
                                //       fontSize: 9,
                                //       fontWeight: FontWeight.bold,
                                //       color: Colors.grey),
                                // ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: ScreenConstant.defaultHeightFifteen,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //       left: ScreenConstant.defaultWidthTwenty),
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         "Free Delivery on orders over ₹450",
                          //         style:
                          //             TextStyle(fontSize: FontSizeStatic.mdSm),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: ScreenConstant.defaultWidthTwenty,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: ScreenConstant.defaultWidthTwenty),
                            child: Row(
                              children: [
                                Text(
                                  "⭐ ⭐ ⭐ ⭐ ⭐",
                                  style: TextStyle(fontSize: FontSizeStatic.sm),
                                ),
                                SizedBox(
                                  width: ScreenConstant.defaultHeightTen,
                                ),
                                Text(
                                  "(1000)",
                                  style: TextStyle(fontSize: FontSizeStatic.sm),
                                ),
                                SizedBox(
                                  width: ScreenConstant.defaultHeightOneHundred,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Get.to(
                                    //     // RefundAndReturnDetailsScreen());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Return_Refund(),
                                        ));
                                  },
                                  child: Container(
                                    width:
                                        ScreenConstant.defaultHeightOneThirty,
                                    child: Text(
                                      "Return & Refund Policy",
                                      style: TextStyle(
                                          fontSize: FontSizeStatic.mdSm,
                                          decoration: TextDecoration.underline,
                                          color: Colors.green),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ScreenConstant.defaultWidthTwenty,
                          ),

                          _productController.productDetailsData.value.product!
                                          .variantOptions !=
                                      null &&
                                  _productController.productDetailsData.value
                                          .product!.variantOptions!.length !=
                                      0
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenConstant
                                              .defaultWidthTwenty),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Select Option",
                                            style: TextStyle(
                                                fontSize: FontSizeStatic.xl,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),



                                    _productController.productDetailsData.value
                                        .product!.variantOptions ==
                                        null ||
                                        _productController
                                            .productDetailsData
                                            .value
                                            .product!
                                            .variantOptions!
                                            .length ==
                                            0
                                        ? Offstage()
                                        : Container(
                                      height: ScreenConstant.defaultHeightOneThirty,
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: _productController
                                            .productDetailsData
                                            .value
                                            .product!
                                            .variantOptions!
                                            .length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              _productController
                                                  .onTapIndexForVariant
                                                  .value = index;

                                              _cartController
                                                  .variantType.value =
                                              _productController
                                                  .productDetailsData
                                                  .value
                                                  .product!
                                                  .variant!;
                                              _cartController.variantOption
                                                  .value = (_productController
                                                  .productDetailsData
                                                  .value
                                                  .product!
                                                  .variantOptions! !=
                                                  null
                                                  ? _productController
                                                  .productDetailsData
                                                  .value
                                                  .product!
                                                  .variantOptions![index]
                                                  : null)!;

                                              _productController
                                                  .productVariantDetailsPress(
                                                _productController
                                                    .productDetailsData
                                                    .value
                                                    .product!
                                                    .variant,
                                                _productController
                                                    .productDetailsData
                                                    .value
                                                    .product!
                                                    .variantOptions !=
                                                    null
                                                    ? _productController
                                                    .productDetailsData
                                                    .value
                                                    .product!
                                                    .variantOptions![index]
                                                    : null,
                                                _productController.productDetailsData.value.product!.colors != null
                                                    ? _productController.productDetailsData.value.product!.colors![
                                                _productController.onTapIndexForColor.value]
                                                    : null,

                                                true,
                                              );
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: ScreenConstant.sizeMedium,
                                                top: ScreenConstant.sizeMedium,
                                                right:ScreenConstant.sizeMedium,
                                              ),
                                              child: index ==
                                                  _productController
                                                      .onTapIndexForVariant
                                                      .value
                                                  ? Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(5)),
                                                child: Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 8.0,
                                                      bottom: 8.0),
                                                  child: Row(

                                                    children: [
                                                      Container(
                                                        width:ScreenConstant.defaultHeightSixty,
                                                        child: Text(
                                                          _productController
                                                              .productDetailsData
                                                              .value
                                                              .product!
                                                              .variantOptions![index],
                                                          style: TextStyle(
                                                              fontSize:
                                                              FontSizeStatic
                                                                  .md,
                                                              color: AppColors
                                                                  .secondary,
                                                              fontFamily:
                                                              'Poppins',
                                                            overflow: TextOverflow.ellipsis
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: ScreenConstant
                                                            .defaultHeightthirty,
                                                      ),
                                                      Text(
                                                        "${((double.parse(_productController.productDetailsData.value.product!.productVariants![index].price.toString()) - double.parse(_productController.productDetailsData.value.product!.productVariants![index].purchasePrice.toString())) / double.parse(_productController.productDetailsData.value.product!.productVariants![index].price.toString()) * 100).toStringAsFixed(0)}% off",
                                                        style: TextStyle(
                                                            color:
                                                            Colors.white,
                                                            fontSize: FontSizeStatic.sm,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      SizedBox(
                                                        width: ScreenConstant
                                                            .defaultHeightthirty,
                                                      ),
                                                      Center(
                                                        child:
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(3),
                                                              color: Colors.green),
                                                          width:
                                                          ScreenConstant.defaultHeightFiftyFive, // Set the width as needed
                                                          height:
                                                          ScreenConstant.defaultHeightFifteen,
                                                          // Set the height as needed
                                                          // color: Colors.green,
                                                          child:
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.only(top: 3, left: ScreenConstant.defaultHeightFive),
                                                            child:
                                                            Text(
                                                              "Save ₹${((double.parse(_productController.productDetailsData.value.product!.productVariants![index].price.toString()) - double.parse(_productController.productDetailsData.value.product!.productVariants![index].purchasePrice.toString())).round())}",

                                                              style: TextStyle(fontSize: ScreenConstant.sizeSmall, color: Colors.white),
                                                            ),
                                                          ), // Set the background color to green
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: ScreenConstant
                                                            .sizeExtraLarge,
                                                      ),
                                                      Text(
                                                        "${(_productController.productDetailsData.value.product!.productVariants![index].price)}",
                                                        style: TextStyle(
                                                            fontSize:
                                                            FontSizeStatic.sm,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.white,
                                                            decoration: TextDecoration.lineThrough),
                                                      ),
                                                      SizedBox(
                                                        width: ScreenConstant
                                                            .defaultHeightFour,
                                                      ),
                                                      Container(
                                                        width:
                                                        40,
                                                        child:
                                                        Text(
                                                          "₹${_productController
                                                              .productDetailsData
                                                              .value
                                                              .product!
                                                              .productVariants![index].purchasePrice}",
                                                          style: TextStyle(
                                                              fontSize: FontSizeStatic.sm,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                                  : Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .secondary,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(5),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .productType)),
                                                child: Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 8.0,
                                                      bottom: 8.0),
                                                  child: Row(

                                                    children: [
                                                      Container(
                                                        width:ScreenConstant.defaultHeightSixty,
                                                        child: Text(
                                                          _productController
                                                              .productDetailsData
                                                              .value
                                                              .product!
                                                              .variantOptions![index],
                                                          style: TextStyle(
                                                              fontSize:
                                                              FontSizeStatic
                                                                  .md,
                                                              color: AppColors
                                                                  .accentColor,
                                                              fontFamily:
                                                              'Poppins',
                                                              overflow: TextOverflow.ellipsis),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: ScreenConstant
                                                            .defaultHeightthirty,
                                                      ),
                                                      Text(
                                                        "${((double.parse(_productController.productDetailsData.value.product!.productVariants![index].price.toString()) - double.parse(_productController.productDetailsData.value.product!.productVariants![index].purchasePrice.toString())) / double.parse(_productController.productDetailsData.value.product!.productVariants![index].price.toString()) * 100).toStringAsFixed(0)}% off",
                                                        style: TextStyle(
                                                            color:
                                                            Colors.green,
                                                            fontSize: FontSizeStatic.sm,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      SizedBox(
                                                        width: ScreenConstant
                                                            .defaultHeightthirty,
                                                      ),
                                                      Center(
                                                        child:
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(3),
                                                              color: Colors.green),
                                                          width:
                                                          ScreenConstant.defaultHeightFiftyFive, // Set the width as needed
                                                          height:
                                                          ScreenConstant.defaultHeightFifteen,
                                                          // Set the height as needed
                                                          // color: Colors.green,
                                                          child:
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.only(top: 3, left: ScreenConstant.defaultHeightFive),
                                                            child:
                                                            Text(
                                                              "Save ₹${((double.parse(_productController.productDetailsData.value.product!.productVariants![index].price.toString()) - double.parse(_productController.productDetailsData.value.product!.productVariants![index].purchasePrice.toString())).round())}",

                                                              style: TextStyle(fontSize: ScreenConstant.sizeSmall, color: Colors.white),
                                                            ),
                                                          ), // Set the background color to green
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: ScreenConstant
                                                            .sizeExtraLarge,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          "${(_productController.productDetailsData.value.product!.productVariants![index].price)}",
                                                          style: TextStyles.fakePriceInOrderDetails,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: ScreenConstant
                                                            .defaultHeightFour,
                                                      ),
                                                      Container(
                                                        width:
                                                        40,
                                                        child:
                                                        Text(
                                                          "₹${_productController
                                                              .productDetailsData
                                                              .value
                                                              .product!
                                                              .productVariants![index].purchasePrice}",
                                                          style: TextStyle(
                                                              fontSize: FontSizeStatic.sm,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),


                                    _productController.productDetailsData.value
                                        .product!.colors ==
                                        null ||
                                        _productController.productDetailsData
                                            .value.product!.colors!.length ==
                                            0
                                        ? Offstage()
                                        : Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenConstant.sizeMedium,
                                          top: ScreenConstant.sizeMedium),
                                      child: Text(
                                        "color".toUpperCase(),
                                        style: TextStyles
                                            .productPriceInProductDetails,
                                      ),
                                    ),
                                    _productController.productDetailsData.value
                                        .product!.colors ==
                                        null ||
                                        _productController.productDetailsData
                                            .value.product!.colors!.length ==
                                            0
                                        ? Offstage()
                                        : Container(
                                      height: ScreenConstant.sizeXXXL,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _productController
                                            .productDetailsData
                                            .value
                                            .product!
                                            .colors!
                                            .length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              _productController
                                                  .onTapIndexForColor
                                                  .value = index;

                                              _cartController
                                                  .variantType.value =
                                              _productController
                                                  .productDetailsData
                                                  .value
                                                  .product!
                                                  .variant!;

                                              _cartController.variantOption
                                                  .value = (_productController
                                                  .productDetailsData
                                                  .value
                                                  .product!
                                                  .variantOptions !=
                                                  null
                                                  ? _productController
                                                  .productDetailsData
                                                  .value
                                                  .product!
                                                  .variantOptions![
                                              _productController
                                                  .onTapIndexForVariant
                                                  .value]
                                                  : null)!;
                                              _cartController.colorOption
                                                  .value = (_productController
                                                  .productDetailsData
                                                  .value
                                                  .product!
                                                  .colors !=
                                                  null
                                                  ? _productController
                                                  .productDetailsData
                                                  .value
                                                  .product!
                                                  .colors![index]
                                                  : null)!;
                                              _productController.productVariantDetailsPress(
                                                  _productController
                                                      .productDetailsData
                                                      .value
                                                      .product!
                                                      .variant!,
                                                  _productController
                                                      .productDetailsData
                                                      .value
                                                      .product!
                                                      .variantOptions !=
                                                      null
                                                      ? _productController
                                                      .productDetailsData
                                                      .value
                                                      .product!
                                                      .variantOptions![
                                                  _productController
                                                      .onTapIndexForVariant
                                                      .value]
                                                      : null,
                                                  _productController.productDetailsData.value.product!.colors != null
                                                      ? _productController
                                                      .productDetailsData
                                                      .value
                                                      .product!
                                                      .colors![index]
                                                      : null,
                                                  true);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: ScreenConstant.sizeMedium,
                                                top: ScreenConstant.sizeMedium,
                                              ),
                                              child: index ==
                                                  _productController
                                                      .onTapIndexForColor
                                                      .value
                                                  ? Container(
                                                decoration: BoxDecoration(
                                                    color: HexColor(
                                                        _productController
                                                            .productDetailsData
                                                            .value
                                                            .product!
                                                            .colors![
                                                        index]),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .accentColor,
                                                        width: 5),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(5)),
                                                child: Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 8.0,
                                                      bottom: 8.0),
                                                  child: Text(
                                                    'col',
                                                    style: TextStyle(
                                                        fontSize:
                                                        FontSizeStatic
                                                            .md,
                                                        color: Colors
                                                            .transparent,
                                                        fontFamily:
                                                        'Proxima-Regular'),
                                                  ),
                                                ),
                                              )
                                                  : Container(
                                                decoration: BoxDecoration(
                                                    color: HexColor(
                                                        _productController
                                                            .productDetailsData
                                                            .value
                                                            .product!
                                                            .colors![
                                                        index]),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .secondary,
                                                        width: 5),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(5)),
                                                child: Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 8.0,
                                                      bottom: 8.0),
                                                  child: Text(
                                                    'col',
                                                    style: TextStyle(
                                                        fontSize:
                                                        FontSizeStatic
                                                            .md,
                                                        color: Colors
                                                            .transparent,
                                                        fontFamily:
                                                        'Proxima-Regular'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    // Column(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.center,
                                    //   children:
                                    //       _productController.productDetailsData
                                    //           .value.product!.productVariants!
                                    //           .map((e) => GestureDetector(
                                    //                 onTap: () {
                                    //                   setState(() {
                                    //                     _cartController
                                    //                             .variantId
                                    //                             .value =
                                    //                         e.id.toString();
                                    //                     _isRadioButtonSelected =
                                    //                         true;
                                    //
                                    //                     // Additional logic or updates if needed
                                    //                   });
                                    //                 },
                                    //                 child: Container(
                                    //                     padding: EdgeInsets
                                    //                         .symmetric(
                                    //                             vertical: 4),
                                    //                     child: Column(
                                    //                       children: [
                                    //                         Container(
                                    //                           decoration: BoxDecoration(
                                    //                               border: Border
                                    //                                   .all(),
                                    //                               borderRadius:
                                    //                                   BorderRadius
                                    //                                       .circular(
                                    //                                           8)),
                                    //                           width: ScreenConstant
                                    //                               .defaultHeightThreeHundredFifty,
                                    //                           height: ScreenConstant
                                    //                               .defaultHeightThirtyFive,
                                    //                           child: Row(
                                    //                             children: [
                                    //                               Row(
                                    //                                 children: [
                                    //                                   Padding(
                                    //                                     padding:
                                    //                                         EdgeInsets.only(left: ScreenConstant.defaultWidthTen),
                                    //                                     child:
                                    //                                         Container(
                                    //                                       width:
                                    //                                           ScreenConstant.defaultWidthSixty,
                                    //                                       child:
                                    //                                           Text(
                                    //                                         "${e.variantName} ${_productController.productDetailsData.value.product!.details!.name!}",
                                    //                                         style:
                                    //                                             TextStyle(fontSize: FontSizeStatic.sm, fontWeight: FontWeight.bold),
                                    //                                         overflow:
                                    //                                             TextOverflow.ellipsis,
                                    //                                       ),
                                    //                                     ),
                                    //                                   ),
                                    //                                   SizedBox(
                                    //                                     width: ScreenConstant
                                    //                                         .defaultHeightFour,
                                    //                                   ),
                                    //                                   // Text(
                                    //                                   //   "@₹25/kg",
                                    //                                   //   style: TextStyle(
                                    //                                   //       color: Colors.grey,
                                    //                                   //       fontSize: FontSizeStatic.sm),
                                    //                                   // ),
                                    //                                   SizedBox(
                                    //                                     width: ScreenConstant
                                    //                                         .defaultHeightFour,
                                    //                                   ),
                                    //                                   Text(
                                    //                                     "${((double.parse(_productController.fakePrice.value) - double.parse(_productController.purchasePrice.toString())) / double.parse(_productController.fakePrice.value) * 100).toStringAsFixed(0)}% off",
                                    //                                     style: TextStyle(
                                    //                                         color:
                                    //                                             Colors.green,
                                    //                                         fontSize: FontSizeStatic.sm,
                                    //                                         fontWeight: FontWeight.bold),
                                    //                                   ),
                                    //                                   SizedBox(
                                    //                                     width: ScreenConstant
                                    //                                         .defaultHeightFortyFive,
                                    //                                   ),
                                    //                                   Center(
                                    //                                     child:
                                    //                                         Container(
                                    //                                       decoration: BoxDecoration(
                                    //                                           borderRadius: BorderRadius.circular(3),
                                    //                                           color: Colors.green),
                                    //                                       width:
                                    //                                           ScreenConstant.defaultHeightFiftyFive, // Set the width as needed
                                    //                                       height:
                                    //                                           ScreenConstant.defaultHeightFifteen,
                                    //                                       // Set the height as needed
                                    //                                       // color: Colors.green,
                                    //                                       child:
                                    //                                           Padding(
                                    //                                         padding:
                                    //                                             EdgeInsets.only(top: 3, left: ScreenConstant.defaultHeightFive),
                                    //                                         child:
                                    //                                             Text(
                                    //                                           "Save ₹${((double.parse(_productController.fakePrice.toString()) - double.parse(_productController.purchasePrice.toString())) / double.parse(_productController.fakePrice.value) * 100).toStringAsFixed(0)}",
                                    //                                           style: TextStyle(fontSize: ScreenConstant.sizeSmall, color: Colors.white),
                                    //                                         ),
                                    //                                       ), // Set the background color to green
                                    //                                     ),
                                    //                                   ),
                                    //                                   SizedBox(
                                    //                                     width: ScreenConstant
                                    //                                         .sizeExtraLarge,
                                    //                                   ),
                                    //
                                    //                                   Text(
                                    //                                     "${_productController.fakePrice}",
                                    //                                     style: TextStyle(
                                    //                                         fontSize:
                                    //                                             FontSizeStatic.sm,
                                    //                                         fontWeight: FontWeight.bold,
                                    //                                         color: Colors.grey,
                                    //                                         decoration: TextDecoration.lineThrough),
                                    //                                   ),
                                    //                                   SizedBox(
                                    //                                     width: ScreenConstant
                                    //                                         .defaultHeightFour,
                                    //                                   ),
                                    //                                   Container(
                                    //                                     width:
                                    //                                         40,
                                    //                                     child:
                                    //                                         Text(
                                    //                                       "₹${e.purchasePrice}",
                                    //                                       style: TextStyle(
                                    //                                           fontSize: FontSizeStatic.sm,
                                    //                                           fontWeight: FontWeight.bold),
                                    //                                     ),
                                    //                                   ),
                                    //                                   Radio(
                                    //                                     fillColor:
                                    //                                         MaterialStateProperty.all(Colors.green),
                                    //                                     value: e
                                    //                                         .id
                                    //                                         .toString(),
                                    //                                     groupValue: _cartController
                                    //                                         .variantId
                                    //                                         .value,
                                    //                                     onChanged:
                                    //                                         (value) {
                                    //                                       setState(
                                    //                                           () {
                                    //                                         _cartController.variantId.value =
                                    //                                             value.toString();
                                    //                                         _isRadioButtonSelected =
                                    //                                             true;
                                    //
                                    //                                         // Find the selected variant and print its details
                                    //                                         var selectedVariant =
                                    //                                             _productController.productDetailsData.value.product!.productVariants!.firstWhere(
                                    //                                           (variant) => variant.id.toString() == value.toString(),
                                    //                                         );
                                    //
                                    //                                         if (selectedVariant !=
                                    //                                             null) {
                                    //                                           print("Selected Variant Details: ${selectedVariant.purchasePrice}");
                                    //                                         }
                                    //                                       });
                                    //                                     },
                                    //                                   ),
                                    //                                 ],
                                    //                               )
                                    //                             ],
                                    //                           ),
                                    //                         )
                                    //                       ],
                                    //                     )
                                    //                     // Text(e.variantName ?? ''),
                                    //                     ),
                                    //               ))
                                    //           .toList(),
                                    // ),
                                  ],
                                )
                              : Container(),
                          // SizedBox(
                          //   height: ScreenConstant.defaultWidthTwenty,
                          // ),
                          Divider(
                            thickness: 10,
                            color: AppColors.gapColor,
                          ),
                          SizedBox(
                            height: ScreenConstant.defaultHeightForty,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenConstant.sizeMidLarge),
                                  child: Text(
                                    "Deliver to: ",
                                    style:
                                        TextStyle(fontSize: FontSizeStatic.md),
                                  ),
                                ),
                                Container(
                                  width: ScreenConstant.defaultWidthSixty,
                                  child: Text(
                                    _dashboardController.location.toString(),
                                    style: TextStyle(
                                        fontSize: FontSizeStatic.md,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  " - ",
                                  style: TextStyle(
                                      fontSize: FontSizeStatic.md,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width: ScreenConstant.defaultHeightSeventySix,
                                  child: Text(
                                    "${_addressController.postalCode.toString()}",
                                    style: TextStyle(
                                        fontSize: FontSizeStatic.md,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        ScreenConstant.defaultHeightFiftyFive),
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.green),
                                    width: ScreenConstant
                                        .defaultHeightSeventySix, // Set the width as needed
                                    height: ScreenConstant.sizeExtraLarge,

                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: ScreenConstant.defaultHeightFive,
                                          left:
                                              ScreenConstant.defaultHeightTen),
                                      child: GestureDetector(
                                        onTap: () {
                                          _addressController
                                              .isHomeScreen.value = true;
                                          Get.to(SelectAddress(
                                            value: LatLng(
                                                HiveStore().get(Keys.currLat),
                                                HiveStore().get(Keys.currLong)),
                                          ));
                                        },
                                        child: Text(
                                          "Change",
                                          style: TextStyle(
                                              fontSize: FontSizeStatic.maxMd,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ), // Set the background color to green
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 10, color: AppColors.gapColor),
                          SizedBox(
                            height: ScreenConstant.defaultHeightNinety,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenConstant.defaultWidthTwenty),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: ScreenConstant.sizeMidLarge,
                                        ),
                                        child: Text(
                                          "Sold by",
                                          style: TextStyle(
                                              fontSize: FontSizeStatic.md),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      GestureDetector(
                                        // onTap: () {
                                        //   Get.toNamed(
                                        //     storeDetails,
                                        //     arguments: JsonEncoder().convert({
                                        //       "id": _dashboardController.nearestStore[index]['id'].toString(),
                                        //       "isFavourite": false,
                                        //     }),
                                        //   );
                                        // },
                                        child: Container(
                                          width: ScreenConstant
                                              .defaultHeightSeventy,
                                          child: Text(
                                            _productController
                                                .productDetailsData
                                                .value
                                                .product!
                                                .shop!
                                                .shop_name!
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: FontSizeStatic.md,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            ScreenConstant.defaultHeightFifteen,
                                      ),
                                      Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.green),
                                          width: ScreenConstant
                                              .defaultWidthSixty, // Set the width as needed
                                          height: ScreenConstant
                                              .defaultHeightTwentyThree,
                                          // Set the height as needed
                                          // color: Colors.green,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 3.5,
                                                left: ScreenConstant
                                                    .defaultWidthTen),
                                            child: Text(
                                              "4.5 ⭐",
                                              style: TextStyle(
                                                  fontSize:
                                                      FontSizeStatic.maxMd,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ), // Set the background color to green
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: ScreenConstant
                                            .defaultHeightTwentyThree,
                                      ),
                                      child: Text(
                                        "Delivery by",
                                        style: TextStyle(
                                            fontSize: FontSizeStatic.md),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "Today",
                                      style: TextStyle(
                                        fontSize: FontSizeStatic.md,
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenConstant
                                          .defaultHeightTwentyThree,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 10, color: AppColors.gapColor),
                          SizedBox(
                            height: ScreenConstant.defaultWidthTen,
                          ),
                          Visibility(
                            visible: _productController.productDetailsData.value
                                .relatedProducts!.isNotEmpty,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      ScreenConstant.defaultHeightTwentyThree),
                              child: Text(
                                "Select Other Product",
                                style: TextStyle(
                                    fontSize: FontSizeStatic.maxMd,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenConstant.defaultHeightFive,
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: ScreenConstant.defaultHeightFifteen,
                          ),
                          Visibility(
                            visible: _productController.productDetailsData.value
                                .relatedProducts!.isNotEmpty,
                            child: Container(
                              height: ScreenConstant.defaultHeightTwoHundred,
                              padding: EdgeInsets.only(
                                  left: ScreenConstant.defaultWidthTwenty,
                                  bottom: ScreenConstant.sizeSmall),

                              // ----------------adding_image____________
                              // child: Image.asset('assets/card-item.png',
                              //   height: 170,),
                              child: SizedBox(
                                height: ScreenConstant.defaultHeightOneTwenty,
                                child: AnimationLimiter(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: _productController
                                        .productDetailsData
                                        .value
                                        .relatedProducts!
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 1000),
                                        child: FlipAnimation(
                                          child: FadeInAnimation(
                                            child: ProductListWidget1(
                                              isDeliverable: _productController
                                                  .productDetailsData
                                                  .value
                                                  .product!
                                                  .deliverable,
                                              availability: _productController
                                                  .productDetailsData
                                                  .value
                                                  .relatedProducts![index]
                                                  .availability,
                                              isProductVariant:
                                                  _productController
                                                          .productDetailsData
                                                          .value
                                                          .relatedProducts![
                                                              index]
                                                          .productVariants!
                                                          .isEmpty
                                                      ? true
                                                      : false,
                                              productId: _productController
                                                  .productDetailsData
                                                  .value
                                                  .relatedProducts![index]
                                                  .id
                                                  .toString(),
                                              productName: _productController
                                                  .productDetailsData
                                                  .value
                                                  .relatedProducts![index]
                                                  .details!
                                                  .name,
                                              productImage: _productController
                                                  .productDetailsData
                                                  .value
                                                  .relatedProducts![index]
                                                  .details!
                                                  .imagePath,
                                              purchasePrice: _productController
                                                      .productDetailsData
                                                      .value
                                                      .relatedProducts![index]
                                                      .productVariants!
                                                      .isEmpty
                                                  ? ""
                                                  : _productController
                                                      .productDetailsData
                                                      .value
                                                      .relatedProducts![index]
                                                      .productVariants![0]
                                                      .purchasePrice
                                                      // .listingPrice
                                                      .toString(),
                                              fakePrice: _productController
                                                      .productDetailsData
                                                      .value
                                                      .relatedProducts![index]
                                                      .productVariants!
                                                      .isEmpty
                                                  ? ""
                                                  : _productController
                                                      .productDetailsData
                                                      .value
                                                      .relatedProducts![index]
                                                      .productVariants![0]
                                                      .price
                                                      .toString(),
                                              variant: _productController
                                                  .productDetailsData
                                                  .value
                                                  .relatedProducts![index]
                                                  .variant,
                                              addCart: _productController
                                                      .productDetailsData
                                                      .value
                                                      .relatedProducts![index]
                                                      .productVariants!
                                                      .isEmpty
                                                  ? false
                                                  : _productController
                                                                  .productDetailsData
                                                                  .value
                                                                  .relatedProducts![
                                                                      index]
                                                                  .productVariants![
                                                                      0]
                                                                  .cartQuantity ==
                                                              0 ||
                                                          _productController
                                                                  .productDetailsData
                                                                  .value
                                                                  .relatedProducts![
                                                                      index]
                                                                  .productVariants![
                                                                      0]
                                                                  .cartQuantity ==
                                                              null
                                                      ? false
                                                      : true,
                                              productCartQuantity:
                                                  _productController
                                                          .productDetailsData
                                                          .value
                                                          .relatedProducts![
                                                              index]
                                                          .productVariants!
                                                          .isEmpty
                                                      ? ""
                                                      : _productController
                                                          .productDetailsData
                                                          .value
                                                          .relatedProducts![
                                                              index]
                                                          .productVariants![0]
                                                          .cartQuantity
                                                          .toString(),
                                              shopId: _productController
                                                  .productDetailsData
                                                  .value
                                                  .relatedProducts![index]
                                                  .shopId
                                                  .toString(),
                                              variantId: _productController
                                                      .productDetailsData
                                                      .value
                                                      .relatedProducts![index]
                                                      .productVariants!
                                                      .isEmpty
                                                  ? ""
                                                  : _productController
                                                      .productDetailsData
                                                      .value
                                                      .relatedProducts![index]
                                                      .productVariants![0]
                                                      .id
                                                      .toString(),
                                              productQuantity:
                                                  _productController
                                                          .productDetailsData
                                                          .value
                                                          .relatedProducts![
                                                              index]
                                                          .productVariants!
                                                          .isEmpty
                                                      ? 0
                                                      : _productController
                                                          .productDetailsData
                                                          .value
                                                          .relatedProducts![
                                                              index]
                                                          .productVariants![0]
                                                          .quantity,
                                              isProductDetails: true,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Image.asset(
                                "assets/productdetailsbanner.png",
                                fit: BoxFit.cover),
                          ),
                          SizedBox(
                            height: ScreenConstant.defaultWidthTwenty,
                          )
                        ],
                      ),
                    ]),
          bottomNavigationBar: _productController.isLoading.value
              ? Container()
              : _cartController.cartCount.value == "0"
                  ? Offstage()
                  : Container(
                      color: AppColors.secondary,
                      height: ScreenConstant.defaultHeightOneHundred,
                      child: Column(
                        children: [
                          Divider(
                            thickness: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: ScreenConstant.sizeSmall,
                                right: ScreenConstant.sizeSmall,
                                top: ScreenConstant.sizeSmall,
                                bottom: ScreenConstant.sizeSmall),
                            child: Container(
                              height: ScreenConstant.sizeXXXL,
                              decoration: BoxDecoration(
                                  color: AppColors.buttonColorSecondary,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Container(
                                    width: ScreenConstant.sizeMedium,
                                  ),
                                  Container(
                                    height: ScreenConstant.sizeXL,
                                    width: ScreenConstant.sizeXL,
                                    decoration: BoxDecoration(
                                      color: AppColors.buttonColorSecondary,
                                      // border: Border.all(
                                      //     color: AppColors.secondary, width: 1),
                                    ),
                                    child: Center(
                                        child: Text(
                                      _cartController.cartCount.value,
                                      style: TextStyle(
                                          fontSize: FontSizeStatic.xl,
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.bold,
                                          /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                              'Poppins'),
                                    )),
                                  ),
                                  SizedBox(width: 3,),
                                  Text(
                                    "Items",
                                    style: TextStyle(
                                        fontSize: FontSizeStatic.xll,
                                        color: AppColors.secondary,
                                        fontWeight: FontWeight.bold,
                                        /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                    'Poppins'),
                                  ),
                                  Container(
                                    width: ScreenConstant.sizeMedium,
                                  ),
                                  Text(
                                    "Rs. ${_cartController.cartTotal.value}",
                                    style: TextStyle(
                                        fontSize: FontSizeStatic.xll,
                                        color: AppColors.secondary,
                                        fontWeight: FontWeight.bold,
                                        /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                            'Poppins'),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: ScreenConstant.sizeMedium,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      final MyBucketController
                                          _myBucketController =
                                          Get.put(MyBucketController());
                                      _myBucketController.productDetails.value =
                                          true;
                                      Get.toNamed(myBasket);
                                    },
                                    child: Text(
                                      "View Cart",
                                      style: TextStyle(
                                          fontSize: FontSizeStatic.maxMd,
                                          color: AppColors.secondary,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ),
                                  Container(
                                    width: ScreenConstant.sizeMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
        )));
  }
}
// children: [
//   Visibility(
//     visible: _productController
//                 .productDetailsData
//                 .value
//                 .product
//                 ?.variantOptions !=
//             null &&
//         _productController
//             .productDetailsData
//             .value
//             .product!
//             .variantOptions!
//             .isNotEmpty,
//     child: Container(
//       width: ScreenConstant
//           .defaultHeightFourHundred,
//       height: ScreenConstant
//           .defaultHeightFiftyFive,
//       decoration: BoxDecoration(
//           border: Border.all(
//               color: Colors.grey,
//               width: 2),
//           borderRadius:
//               BorderRadius.circular(
//                   ScreenConstant
//                       .defaultWidthTen)),
//       child: Row(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//                 left: ScreenConstant
//                     .defaultWidthTen),
//             child: Container(
//               width: ScreenConstant
//                   .defaultWidthSixty,
//               child: Text(
//                 "1.8 kg ${_productController.productDetailsData.value.product!.details!.name!}",
//                 style: TextStyle(
//                     fontSize:
//                         FontSizeStatic.sm,
//                     fontWeight:
//                         FontWeight.bold),
//                 overflow:
//                     TextOverflow.ellipsis,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: ScreenConstant
//                 .defaultHeightFour,
//           ),
//           // Text(
//           //   "@₹25/kg",
//           //   style: TextStyle(
//           //       color: Colors.grey,
//           //       fontSize: FontSizeStatic.sm),
//           // ),
//           SizedBox(
//             width: ScreenConstant
//                 .defaultHeightFour,
//           ),
//           Text(
//             "${((double.parse(_productController.fakePrice.value) - double.parse(_productController.purchasePrice.value)) / double.parse(_productController.fakePrice.value) * 100).toStringAsFixed(0)}% off",
//             style: TextStyle(
//                 color: Colors.green,
//                 fontSize:
//                     FontSizeStatic.sm,
//                 fontWeight:
//                     FontWeight.bold),
//           ),
//           SizedBox(
//             width: ScreenConstant
//                 .defaultHeightFifty,
//           ),
//           Center(
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius:
//                       BorderRadius
//                           .circular(3),
//                   color: Colors.green),
//               width: ScreenConstant
//                   .defaultHeightFiftyFive, // Set the width as needed
//               height: ScreenConstant
//                   .defaultHeightFifteen,
//               // Set the height as needed
//               // color: Colors.green,
//               child: Padding(
//                 padding: EdgeInsets.only(
//                     top: 3,
//                     left: ScreenConstant
//                         .defaultHeightFive),
//                 child: Text(
//                   "Save ₹${((double.parse(_productController.fakePrice.value) - double.parse(_productController.purchasePrice.value)) / double.parse(_productController.fakePrice.value) * 100).toStringAsFixed(0)}",
//                   style: TextStyle(
//                       fontSize:
//                           ScreenConstant
//                               .sizeSmall,
//                       color:
//                           Colors.white),
//                 ),
//               ), // Set the background color to green
//             ),
//           ),
//           SizedBox(
//             width: ScreenConstant
//                 .defaultHeightFifty,
//           ),

//           Text(
//             "${_productController.fakePrice}",
//             style: TextStyle(
//                 fontSize:
//                     FontSizeStatic.sm,
//                 fontWeight:
//                     FontWeight.bold,
//                 color: Colors.grey,
//                 decoration: TextDecoration
//                     .lineThrough),
//           ),
//           SizedBox(
//             width: ScreenConstant
//                 .defaultHeightFour,
//           ),
//           Text(
//             "₹${_productController.purchasePrice}",
//             style: TextStyle(
//                 fontSize:
//                     FontSizeStatic.sm,
//                 fontWeight:
//                     FontWeight.bold),
//           ),
//           Radio(
//             fillColor:
//                 MaterialStatePropertyAll(
//                     Colors.green),
//             value: 1,
//             groupValue:
//                 isContainer1Selected
//                     ? 1
//                     : 0,
//             onChanged: (value) {
//               setState(() {});
//             },
//           ),
//           // Align(
//           //   alignment: Alignment.centerRight,
//           // child: Radio(
//           //   value: 1,
//           //   groupValue:
//           //       isContainer1Selected ? 1 : 0,
//           //   onChanged: (value) {
//           //     setState(() {});
//           //   },
//           // ),
//           // ),
//         ],
//       ),
//     ),
//   ),
//   SizedBox(
//       height: ScreenConstant
//           .defaultWidthTwenty),
//   Visibility(
//     visible: _productController
//                 .productDetailsData
//                 .value
//                 .product
//                 ?.variantOptions !=
//             null &&
//         _productController
//             .productDetailsData
//             .value
//             .product!
//             .variantOptions!
//             .isNotEmpty,
//     child: Container(
//       width: ScreenConstant
//           .defaultHeightFourHundred,
//       height: ScreenConstant
//           .defaultHeightFiftyFive,
//       decoration: BoxDecoration(
//           border: Border.all(
//               color: Colors.grey,
//               width: 2),
//           borderRadius:
//               BorderRadius.circular(
//                   ScreenConstant
//                       .defaultWidthTen)),
//       child: Row(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//                 left: ScreenConstant
//                     .defaultWidthTen),
//             child: Container(
//               width: ScreenConstant
//                   .defaultWidthSixty,
//               child: Text(
//                 "500g ${_productController.productDetailsData.value.product!.details!.name!}",
//                 style: TextStyle(
//                     fontSize:
//                         FontSizeStatic.sm,
//                     fontWeight:
//                         FontWeight.bold),
//                 overflow:
//                     TextOverflow.ellipsis,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: ScreenConstant
//                 .defaultHeightFour,
//           ),
//           // Text(
//           //   "@₹25/kg",
//           //   style: TextStyle(
//           //       color: Colors.grey,
//           //       fontSize: FontSizeStatic.sm),
//           // ),
//           SizedBox(
//             width: ScreenConstant
//                 .defaultHeightFour,
//           ),
//           Text(
//             "${((double.parse(_productController.fakePrice.value) - double.parse(_productController.purchasePrice.value)) / double.parse(_productController.fakePrice.value) * 100).toStringAsFixed(0)}% off",
//             style: TextStyle(
//                 color: Colors.green,
//                 fontSize:
//                     FontSizeStatic.sm,
//                 fontWeight:
//                     FontWeight.bold),
//           ),
//           SizedBox(
//             width: ScreenConstant
//                 .defaultHeightFifty,
//           ),
//           Center(
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius:
//                       BorderRadius
//                           .circular(3),
//                   color: Colors.green),
//               width: ScreenConstant
//                   .defaultHeightFiftyFive, // Set the width as needed
//               height: ScreenConstant
//                   .defaultHeightFifteen,
//               // Set the height as needed
//               // color: Colors.green,
//               child: Padding(
//                 padding: EdgeInsets.only(
//                     top: 3,
//                     left: ScreenConstant
//                         .defaultHeightFive),
//                 child: Text(
//                   "Save ₹${((double.parse(_productController.fakePrice.value) - double.parse(_productController.purchasePrice.value)) / double.parse(_productController.fakePrice.value) * 100).toStringAsFixed(0)}",
//                   style: TextStyle(
//                       fontSize:
//                           ScreenConstant
//                               .sizeSmall,
//                       color:
//                           Colors.white),
//                 ),
//               ), // Set the background color to green
//             ),
//           ),
//           SizedBox(
//             width: ScreenConstant
//                 .defaultHeightFifty,
//           ),

//           Text(
//             "${_productController.fakePrice.value}",
//             style: TextStyle(
//                 fontSize:
//                     FontSizeStatic.sm,
//                 fontWeight:
//                     FontWeight.bold,
//                 color: Colors.grey,
//                 decoration: TextDecoration
//                     .lineThrough),
//           ),
//           SizedBox(
//             width: ScreenConstant
//                 .defaultHeightFour,
//           ),
//           Text(
//             "₹${_productController.purchasePrice.value}",
//             style: TextStyle(
//                 fontSize:
//                     FontSizeStatic.sm,
//                 fontWeight:
//                     FontWeight.bold),
//           ),
//           Radio(
//             fillColor:
//                 MaterialStatePropertyAll(
//                     Colors.green),
//             value: 1,
//             groupValue:
//                 isContainer1Selected
//                     ? 1
//                     : 0,
//             onChanged: (value) {
//               setState(() {});
//             },
//           ),
//           // Align(
//           //   alignment: Alignment.centerRight,
//           // child: Radio(
//           //   value: 1,
//           //   groupValue:
//           //       isContainer1Selected ? 1 : 0,
//           //   onChanged: (value) {
//           //     setState(() {});
//           //   },
//           // ),
//           // ),
//         ],
//       ),
//     ),
//   )
// ],

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:get/get.dart';
// import 'package:go_potu_user/Controller/AddToCartController/AddToCartController.dart';
// import 'package:go_potu_user/Controller/MyBucketController/MyBucketController.dart';
// import 'package:go_potu_user/Controller/ProductController/ProductController.dart';
// import 'package:go_potu_user/Controller/StoreController/StoreController.dart';
// import 'package:go_potu_user/Controller/SubCategoryController/SubCategoryController.dart';
// import 'package:go_potu_user/DeviceManager/Colors.dart';
// import 'package:go_potu_user/DeviceManager/HexColor.dart';
// import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
// import 'package:go_potu_user/DeviceManager/TextStyles.dart';
// import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
// import 'package:go_potu_user/Router/RouteConstants.dart';
// import 'package:go_potu_user/Store/HiveStore.dart';
// import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartButtonWidget.dart';
// import 'package:go_potu_user/Widgets/AppButtonWidget/AddToCartNotShowButton.dart';
// import 'package:go_potu_user/Widgets/AppButtonWidget/ItemIncrementDecrementButton.dart';
// import 'package:go_potu_user/Widgets/ProductWidgets/ProductListWidget.dart';
// import 'package:go_potu_user/Widgets/ProductWidgets/ProductListWidget1.dart';
//
// import '../../Controller/DashboardController/DashboardController.dart';
// import 'PhotoViewScreen.dart';
//
// class ProductDetails extends StatefulWidget {
//   @override
//   State<ProductDetails> createState() => _ProductDetailsState();
// }
//
// class _ProductDetailsState extends State<ProductDetails> {
//   int _current = 0;
//   final CarouselController _controller = CarouselController();
//   final ProductController _productController = Get.put(ProductController());
//   final AddToCartController _cartController = Get.put(AddToCartController());
//
//   Future<bool> _onBackPressed() async {
//     Future<bool> isHomeScreenTrue() async {
//       String? isHome = await HiveStore().get(Keys.isHomeScreen);
//       return isHome == "true";
//     }
//
//     if (await isHomeScreenTrue()) {
//       _productController.isLoading.value = true;
//       _productController.purchasePrice.value = "0.00";
//       // _productController.listingPrice.value = "0.00"; //listingPrice
//       _productController.fakePrice.value = "0.00";
//       _productController.discountAmount.value = "0.00";
//       if (_productController.isSearch.value) {
//         _productController.isSearch.value = false;
//       }
//
//       DashboardController dashboardController = Get.put(DashboardController());
//       dashboardController.getHomeDataPress(false, false);
//       HiveStore().put(Keys.isHomeScreen, "false");
//       Get.back();
//     } else {
//       _productController.isLoading.value = true;
//       _productController.purchasePrice.value = "0.00";
//       // _productController.listingPrice.value = "0.00"; //listingPrice
//       _productController.fakePrice.value = "0.00";
//       _productController.discountAmount.value = "0.00";
//       if (_productController.isSearch.value) {
//         _productController.isSearch.value = false;
//         Get.back();
//         // return Future.value(true);
//       } else {
//         StoreController storeController = Get.find();
//         storeController.storeDetailsPress(false);
//         SubCategoryController subCategoryController =
//         Get.put(SubCategoryController());
//
//         if (subCategoryController.allTap.value) {
//           subCategoryController.loadProductListPress(
//               subCategoryController.categoryParentId.toString(), true);
//         } else {
//           subCategoryController.loadProductListPress(
//               subCategoryController.subcategoryId.toString(), true);
//         }
//
//         Get.back();
//       }
//     }
//
//     return Future.value(false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => WillPopScope(
//       onWillPop: _onBackPressed,
//       child: Scaffold(
//         backgroundColor: AppColors.secondary,
//         appBar: AppBar(
//           leading: BackButton(
//             onPressed: _onBackPressed,
//           ),
//           centerTitle: true,
//           backgroundColor: AppColors.primary,
//           elevation: 0,
//           title: Text(
//             AppStrings.ProductDetails,
//             style: TextStyles.appBarTitle,
//           ),
//           actions: [
//             GestureDetector(
//               onTap: () {
//                 Get.toNamed(notifications);
//               },
//               child: Icon(Icons.notifications),
//             ),
//             Container(
//               width: ScreenConstant.sizeMedium,
//             ),
//           ],
//         ),
//         body: _productController.isLoading.value
//             ? Container()
//             : _productController.productDetailsData.value.product == null
//             ? Container()
//             : Stack(
//           alignment: Alignment.topRight,
//           children: [
//             ListView(
//               shrinkWrap: true,
//               physics: ClampingScrollPhysics(),
//               children: [
//                 Padding(
//                   padding:
//                   EdgeInsets.all(ScreenConstant.sizeMedium),
//                   child: Row(
//                     children: [
//                       /*Container(
//                                   height: ScreenConstant.sizeMedium,
//                                   width: ScreenConstant.sizeMedium,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       border: Border.all(color: Colors.green)),
//                                   child: Center(
//                                       child: Icon(
//                                     Icons.circle,
//                                     size: ScreenConstant.sizeSmall,
//                                     color: Colors.green,
//                                   )),
//                                 ),
//                                 Container(
//                                   width: ScreenConstant.sizeSmall,
//                                 ),*/
//                       Flexible(
//                         child: Text(
//                           _productController.productDetailsData
//                               .value.product!.details!.name!,
//                           style: TextStyles
//                               .productDetailsProductName,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   color: Colors.white,
//                   child: CarouselSlider.builder(
//                     itemCount: _productController
//                         .productDetailsData
//                         .value
//                         .product!
//                         .details!
//                         .productImages!
//                         .length,
//                     options: CarouselOptions(
//                         autoPlay: _productController
//                             .productDetailsData
//                             .value
//                             .product!
//                             .details!
//                             .productImages!
//                             .length ==
//                             1
//                             ? false
//                             : true,
//                         enlargeCenterPage: false,
//                         viewportFraction: 1,
//                         onPageChanged: (index, reason) {
//                           setState(() {
//                             _current = index;
//                           });
//                         }),
//                     itemBuilder: (context, index, realIdx) {
//                       return GestureDetector(
//                         onTap: () {
//                           Get.to(PhotoViewScreen(
//                             imageList: _productController
//                                 .productDetailsData
//                                 .value
//                                 .product!
//                                 .details!
//                                 .productImages,
//                           ));
//                         },
//                         child: Container(
//                           child: Center(
//                               child: Image.network(
//                                 _productController
//                                     .productDetailsData
//                                     .value
//                                     .product!
//                                     .details!
//                                     .productImages![index],
//                                 fit: BoxFit.contain,
//                               )),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Container(
//                   color: Colors.white,
//                   height: ScreenConstant.sizeMedium,
//                 ),
//                 _productController
//                     .productDetailsData
//                     .value
//                     .product!
//                     .details!
//                     .productImages!
//                     .length ==
//                     1
//                     ? Offstage()
//                     : Container(
//                   color: Colors.white,
//                   child: Row(
//                     mainAxisAlignment:
//                     MainAxisAlignment.center,
//                     children: _productController
//                         .productDetailsData
//                         .value
//                         .product!
//                         .details!
//                         .productImages!
//                         .asMap()
//                         .entries
//                         .map((entry) {
//                       return GestureDetector(
//                         onTap: () => _controller
//                             .animateToPage(entry.key),
//                         child: Container(
//                           width: ScreenConstant.sizeDefault,
//                           height:
//                           ScreenConstant.sizeDefault,
//                           margin: EdgeInsets.symmetric(
//                               vertical: ScreenConstant
//                                   .sizeExtraSmall,
//                               horizontal: ScreenConstant
//                                   .sizeExtraSmall),
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: (Theme.of(context)
//                                   .brightness ==
//                                   Brightness.dark
//                                   ? Colors.white
//                                   : Colors.black)
//                                   .withOpacity(
//                                   _current == entry.key
//                                       ? 0.9
//                                       : 0.4)),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 Container(
//                   height: ScreenConstant.sizeXL,
//                 ),
//                 _productController.discountAmount.value == "0"
//                     ? Offstage()
//                     : Padding(
//                   padding: EdgeInsets.only(
//                       left: ScreenConstant.sizeMedium,
//                       top: ScreenConstant.sizeMedium),
//                   child: Text(
//                     _productController
//                         .discountAmount.value ==
//                         "1.00"
//                         ? "You Save Re. 1 in this order"
//                         : "You Save Rs. ${_productController.discountAmount.value} in this order",
//                     style: TextStyles
//                         .productDetailsDiscountText,
//                   ),
//                 ),
//                 Container(
//                   height: ScreenConstant.sizeExtraSmall,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       left: ScreenConstant.sizeMedium,
//                       right: ScreenConstant.sizeMedium),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment:
//                             CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     // "Rs. ${double.parse((_productController.listingPrice.value) == "null" ? (_productController.purchasePrice.value) :  (_productController.listingPrice.value)).toStringAsFixed(2).toString()}",
//                                     "Rs. ${double.parse(_productController.purchasePrice.value).toStringAsFixed(2).toString()}",
//                                     style: TextStyles
//                                         .productPriceInProductDetails,
//                                   ),
//                                   Container(
//                                     width:
//                                     ScreenConstant.sizeSmall,
//                                   ),
//                                   (_productController
//                                       .purchasePrice ==
//                                       // .listingPrice ==
//                                       _productController
//                                           .fakePrice)
//                                       ? Offstage()
//                                       : Text(
//                                     "Rs. ${double.parse(_productController.fakePrice.value).toStringAsFixed(2).toString()}",
//                                     style: TextStyles
//                                         .fakePriceInOrderDetails,
//                                   ),
//                                 ],
//                               ),
//                               Container(
//                                 height:
//                                 ScreenConstant.sizeExtraSmall,
//                               ),
//                               Text(
//                                 "(Inclusive of all taxes)",
//                                 style: TextStyles.includingAllTax,
//                               ),
//                             ],
//                           ),
//                           HiveStore().get(Keys.shopType) ==
//                               "restaurant"
//                               ? _productController
//                               .productVariantDetailsData
//                               .value
//                               .variantDetails !=
//                               null
//                               ? Column(
//                             mainAxisAlignment:
//                             MainAxisAlignment.end,
//                             children: [
//                               _productController
//                                   .productVariantDetailsData
//                                   .value
//                                   .variantDetails!
//                                   .cartQuantity ==
//                                   0 ||
//                                   _productController
//                                       .productVariantDetailsData
//                                       .value
//                                       .variantDetails!
//                                       .cartQuantity ==
//                                       null
//                                   ? _productController
//                                   .productDetailsData
//                                   .value
//                                   .product!
//                                   .deliverable!
//                                   ? AddToCartNotShowButtonWidget(
//                                 addToCart:
//                                     () {},
//                                 horizontalPadding:
//                                 ScreenConstant
//                                     .sizeLarge,
//                                 verticalPadding:
//                                 ScreenConstant
//                                     .sizeExtraSmall,
//                               )
//                                   : AddToCartButtonWidget(
//                                 addToCart:
//                                     () {
//                                   _cartController
//                                       .isProductDetailsAdd
//                                       .value = _productController.isFirstCallVariant.value ==
//                                       1
//                                       ? false
//                                       : true;
//                                   _cartController
//                                       .isStore
//                                       .value = false;
//                                   _cartController
//                                       .isProductDetails
//                                       .value = _productController.isFirstCallVariant.value ==
//                                       1
//                                       ? true
//                                       : false;
//                                   _cartController.shopId.value = _productController
//                                       .productDetailsData
//                                       .value
//                                       .product!
//                                       .shopId
//                                       .toString();
//                                   _cartController
//                                       .variantId
//                                       .value =
//                                       _productController
//                                           .productVariantDetailsData
//                                           .value
//                                           .variantDetails!
//                                           .id
//                                           .toString();
//                                   _cartController
//                                       .addToCartPress(
//                                       "1",
//                                       context);
//                                 },
//                                 horizontalPadding:
//                                 ScreenConstant
//                                     .sizeLarge,
//                                 verticalPadding:
//                                 ScreenConstant
//                                     .sizeExtraSmall,
//                               )
//                                   : !_productController
//                                   .productDetailsData
//                                   .value
//                                   .product!
//                                   .deliverable!
//                                   ? AddToCartNotShowButtonWidget(
//                                 addToCart:
//                                     () {},
//                                 horizontalPadding:
//                                 ScreenConstant
//                                     .sizeLarge,
//                                 verticalPadding:
//                                 ScreenConstant
//                                     .sizeExtraSmall,
//                               )
//                                   : ItemIncrementDecrementButton(
//                                 incrementCart:
//                                     () {
//                                   _cartController
//                                       .isStore
//                                       .value = false;
//                                   _cartController
//                                       .isProductDetailsAdd
//                                       .value = _productController.isFirstCallVariant.value ==
//                                       1
//                                       ? false
//                                       : true;
//
//                                   _cartController
//                                       .isCart
//                                       .value = false;
//                                   _cartController
//                                       .isProductDetails
//                                       .value = _productController.isFirstCallVariant.value ==
//                                       1
//                                       ? true
//                                       : false;
//                                   _cartController.shopId.value = _productController
//                                       .productDetailsData
//                                       .value
//                                       .product!
//                                       .shopId
//                                       .toString();
//                                   _cartController
//                                       .variantId
//                                       .value =
//                                       _productController
//                                           .productVariantDetailsData
//                                           .value
//                                           .variantDetails!
//                                           .id
//                                           .toString();
//                                   _cartController
//                                       .addToCartPress(
//                                       "1",
//                                       context);
//                                 },
//                                 decrementCart:
//                                     () {
//                                   _cartController
//                                       .isStore
//                                       .value = false;
//                                   _cartController
//                                       .isProductDetailsAdd
//                                       .value = _productController.isFirstCallVariant.value ==
//                                       1
//                                       ? false
//                                       : true;
//                                   _cartController
//                                       .isCart
//                                       .value = false;
//                                   _cartController
//                                       .isProductDetails
//                                       .value = _productController.isFirstCallVariant.value ==
//                                       1
//                                       ? true
//                                       : false;
//                                   _cartController.shopId.value = _productController
//                                       .productDetailsData
//                                       .value
//                                       .product!
//                                       .shopId
//                                       .toString();
//                                   _cartController
//                                       .variantId
//                                       .value =
//                                       _productController
//                                           .productVariantDetailsData
//                                           .value
//                                           .variantDetails!
//                                           .id
//                                           .toString();
//                                   _cartController
//                                       .addToCartPress(
//                                       "-1",
//                                       context);
//                                 },
//                                 quantity: _productController
//                                     .productVariantDetailsData
//                                     .value
//                                     .variantDetails!
//                                     .cartQuantity
//                                     .toString(),
//                               ),
//                             ],
//                           )
//                               : Offstage()
//                               : _productController
//                               .productVariantDetailsData
//                               .value
//                               .variantDetails !=
//                               null
//                               ? Column(
//                             mainAxisAlignment:
//                             MainAxisAlignment.end,
//                             children: [
//                               _productController
//                                   .productVariantDetailsData
//                                   .value
//                                   .variantDetails!
//                                   .quantity! <
//                                   1
//                                   ? Text(
//                                 "Out Of Stock",
//                                 style: TextStyles
//                                     .outOfStock,
//                               )
//                                   : _productController
//                                   .productVariantDetailsData
//                                   .value
//                                   .variantDetails!
//                                   .cartQuantity ==
//                                   0 ||
//                                   _productController
//                                       .productVariantDetailsData
//                                       .value
//                                       .variantDetails ==
//                                       null
//                                   ? !_productController
//                                   .productDetailsData
//                                   .value
//                                   .product!
//                                   .deliverable!
//                                   ? AddToCartNotShowButtonWidget(
//                                 addToCart:
//                                     () {},
//                                 horizontalPadding:
//                                 ScreenConstant
//                                     .sizeLarge,
//                                 verticalPadding:
//                                 ScreenConstant
//                                     .sizeExtraSmall,
//                               )
//                                   : AddToCartButtonWidget(
//                                 addToCart:
//                                     () {
//                                   _cartController
//                                       .isProductDetailsAdd
//                                       .value = _productController.isFirstCallVariant.value ==
//                                       1
//                                       ? false
//                                       : true;
//                                   _cartController
//                                       .isStore
//                                       .value = false;
//                                   _cartController
//                                       .isProductDetails
//                                       .value = _productController.isFirstCallVariant.value ==
//                                       1
//                                       ? true
//                                       : false;
//                                   _cartController.shopId.value = _productController
//                                       .productDetailsData
//                                       .value
//                                       .product!
//                                       .shopId
//                                       .toString();
//                                   _cartController.variantId.value = _productController
//                                       .productVariantDetailsData
//                                       .value
//                                       .variantDetails!
//                                       .id
//                                       .toString();
//                                   _cartController.addToCartPress(
//                                       "1",
//                                       context);
//                                 },
//                                 horizontalPadding:
//                                 ScreenConstant
//                                     .sizeLarge,
//                                 verticalPadding:
//                                 ScreenConstant
//                                     .sizeExtraSmall,
//                               )
//                                   : !_productController
//                                   .productDetailsData
//                                   .value
//                                   .product!
//                                   .deliverable!
//                                   ? AddToCartNotShowButtonWidget(
//                                 addToCart:
//                                     () {},
//                                 horizontalPadding:
//                                 ScreenConstant
//                                     .sizeLarge,
//                                 verticalPadding:
//                                 ScreenConstant
//                                     .sizeExtraSmall,
//                               )
//                                   : ItemIncrementDecrementButton(
//                                 incrementCart:
//                                     () {
//                                   _cartController
//                                       .isProductDetailsAdd
//                                       .value = _productController.isFirstCallVariant.value ==
//                                       1
//                                       ? false
//                                       : true;
//
//                                   _cartController
//                                       .isCart
//                                       .value = false;
//                                   _cartController
//                                       .isProductDetails
//                                       .value = _productController.isFirstCallVariant.value ==
//                                       1
//                                       ? true
//                                       : false;
//                                   _cartController.shopId.value = _productController
//                                       .productDetailsData
//                                       .value
//                                       .product!
//                                       .shopId
//                                       .toString();
//                                   _cartController.variantId.value = _productController
//                                       .productVariantDetailsData
//                                       .value
//                                       .variantDetails!
//                                       .id
//                                       .toString();
//                                   _cartController.addToCartPress(
//                                       "1",
//                                       context);
//                                 },
//                                 decrementCart:
//                                     () {
//                                   _cartController
//                                       .isProductDetailsAdd
//                                       .value = _productController.isFirstCallVariant.value ==
//                                       1
//                                       ? false
//                                       : true;
//                                   _cartController
//                                       .isCart
//                                       .value = false;
//                                   _cartController
//                                       .isProductDetails
//                                       .value = _productController.isFirstCallVariant.value ==
//                                       1
//                                       ? true
//                                       : false;
//                                   _cartController.shopId.value = _productController
//                                       .productDetailsData
//                                       .value
//                                       .product!
//                                       .shopId
//                                       .toString();
//                                   _cartController.variantId.value = _productController
//                                       .productVariantDetailsData
//                                       .value
//                                       .variantDetails!
//                                       .id
//                                       .toString();
//                                   _cartController.addToCartPress(
//                                       "-1",
//                                       context);
//                                 },
//                                 quantity: _productController
//                                     .productVariantDetailsData
//                                     .value
//                                     .variantDetails!
//                                     .cartQuantity
//                                     .toString(),
//                               ),
//                             ],
//                           )
//                               : Offstage()
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 _productController.productDetailsData.value
//                     .product!.variant ==
//                     null
//                     ? Offstage()
//                     : Padding(
//                   padding: EdgeInsets.only(
//                       left: ScreenConstant.sizeMedium,
//                       top: ScreenConstant.sizeMedium),
//                   child: Text(
//                     _productController.productDetailsData
//                         .value.product!.variant!
//                         .toUpperCase(),
//                     style: TextStyles
//                         .productPriceInProductDetails,
//                   ),
//                 ),
//                 _productController.productDetailsData.value
//                     .product!.variantOptions ==
//                     null ||
//                     _productController
//                         .productDetailsData
//                         .value
//                         .product!
//                         .variantOptions!
//                         .length ==
//                         0
//                     ? Offstage()
//                     : Container(
//                   height: ScreenConstant.sizeXXXL,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: _productController
//                         .productDetailsData
//                         .value
//                         .product!
//                         .variantOptions!
//                         .length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           _productController
//                               .onTapIndexForVariant
//                               .value = index;
//
//                           _cartController
//                               .variantType.value =
//                           _productController
//                               .productDetailsData
//                               .value
//                               .product!
//                               .variant!;
//
//                           _cartController
//                               .variantOption.value =
//                           _productController
//                               .productDetailsData
//                               .value
//                               .product!
//                               .variantOptions![index];
//
//                           _cartController.colorOption
//                               .value = _productController
//                               .productDetailsData
//                               .value
//                               .product!
//                               .colors![
//                           _productController
//                               .onTapIndexForColor
//                               .value];
//                           _productController
//                               .productVariantDetailsPress(
//                             _productController
//                                 .productDetailsData
//                                 .value
//                                 .product!
//                                 .variant!,
//                             _productController
//                                 .productDetailsData
//                                 .value
//                                 .product!
//                                 .variantOptions![index],
//                             _productController
//                                 .productDetailsData
//                                 .value
//                                 .product!
//                                 .colors![
//                             _productController
//                                 .onTapIndexForColor
//                                 .value],
//                             true,
//                           );
//                         },
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                             left: ScreenConstant.sizeMedium,
//                             top: ScreenConstant.sizeMedium,
//                           ),
//                           child: index ==
//                               _productController
//                                   .onTapIndexForVariant
//                                   .value
//                               ? Container(
//                             decoration: BoxDecoration(
//                                 color: AppColors
//                                     .productType,
//                                 borderRadius:
//                                 BorderRadius
//                                     .circular(5)),
//                             child: Padding(
//                               padding:
//                               EdgeInsets.only(
//                                   left: 10.0,
//                                   right: 10.0,
//                                   top: 8.0,
//                                   bottom: 8.0),
//                               child: Text(
//                                 _productController
//                                     .productDetailsData
//                                     .value
//                                     .product!
//                                     .variantOptions![index],
//                                 style: TextStyle(
//                                     fontSize:
//                                     FontSizeStatic
//                                         .md,
//                                     color: AppColors
//                                         .secondary,
//                                     fontFamily:
//                                     'Poppins'),
//                               ),
//                             ),
//                           )
//                               : Container(
//                             decoration: BoxDecoration(
//                                 color: AppColors
//                                     .secondary,
//                                 borderRadius:
//                                 BorderRadius
//                                     .circular(5),
//                                 border: Border.all(
//                                     color: AppColors
//                                         .productType)),
//                             child: Padding(
//                               padding:
//                               EdgeInsets.only(
//                                   left: 10.0,
//                                   right: 10.0,
//                                   top: 8.0,
//                                   bottom: 8.0),
//                               child: Text(
//                                 _productController
//                                     .productDetailsData
//                                     .value
//                                     .product!
//                                     .variantOptions![index],
//                                 style: TextStyle(
//                                     fontSize:
//                                     FontSizeStatic
//                                         .md,
//                                     color: AppColors
//                                         .accentColor,
//                                     fontFamily:
//                                     'Poppins'),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 _productController.productDetailsData.value
//                     .product!.colors ==
//                     null ||
//                     _productController.productDetailsData
//                         .value.product!.colors!.length ==
//                         0
//                     ? Offstage()
//                     : Padding(
//                   padding: EdgeInsets.only(
//                       left: ScreenConstant.sizeMedium,
//                       top: ScreenConstant.sizeMedium),
//                   child: Text(
//                     "color".toUpperCase(),
//                     style: TextStyles
//                         .productPriceInProductDetails,
//                   ),
//                 ),
//                 _productController.productDetailsData.value
//                     .product!.colors ==
//                     null ||
//                     _productController.productDetailsData
//                         .value.product!.colors!.length ==
//                         0
//                     ? Offstage()
//                     : Container(
//                   height: ScreenConstant.sizeXXXL,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: _productController
//                         .productDetailsData
//                         .value
//                         .product!
//                         .colors!
//                         .length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           _productController
//                               .onTapIndexForColor
//                               .value = index;
//
//                           _cartController
//                               .variantType.value =
//                           _productController
//                               .productDetailsData
//                               .value
//                               .product!
//                               .variant!;
//
//                           _productController
//                               .productDetailsData
//                               .value
//                               .product!
//                               .variantOptions![
//                           _productController
//                               .onTapIndexForVariant
//                               .value];
//
//                           _productController
//                               .productDetailsData
//                               .value
//                               .product!
//                               .colors![index];
//                           _productController
//                               .productVariantDetailsPress(
//                               _productController
//                                   .productDetailsData
//                                   .value
//                                   .product!
//                                   .variant!,
//                               _productController
//                                   .productDetailsData
//                                   .value
//                                   .product!
//                                   .variantOptions![
//                               _productController
//                                   .onTapIndexForVariant
//                                   .value],
//                               _productController
//                                   .productDetailsData
//                                   .value
//                                   .product!
//                                   .colors![index],
//                               true);
//                         },
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                             left: ScreenConstant.sizeMedium,
//                             top: ScreenConstant.sizeMedium,
//                           ),
//                           child: index ==
//                               _productController
//                                   .onTapIndexForColor
//                                   .value
//                               ? Container(
//                             decoration: BoxDecoration(
//                                 color: HexColor(
//                                     _productController
//                                         .productDetailsData
//                                         .value
//                                         .product!
//                                         .colors![
//                                     index]),
//                                 border: Border.all(
//                                     color: AppColors
//                                         .accentColor,
//                                     width: 5),
//                                 borderRadius:
//                                 BorderRadius
//                                     .circular(5)),
//                             child: Padding(
//                               padding:
//                               EdgeInsets.only(
//                                   left: 10.0,
//                                   right: 10.0,
//                                   top: 8.0,
//                                   bottom: 8.0),
//                               child: Text(
//                                 'col',
//                                 style: TextStyle(
//                                     fontSize:
//                                     FontSizeStatic
//                                         .md,
//                                     color: Colors
//                                         .transparent,
//                                     fontFamily:
//                                     'Poppins'),
//                               ),
//                             ),
//                           )
//                               : Container(
//                             decoration: BoxDecoration(
//                                 color: HexColor(
//                                     _productController
//                                         .productDetailsData
//                                         .value
//                                         .product!
//                                         .colors![
//                                     index]),
//                                 border: Border.all(
//                                     color: AppColors
//                                         .secondary,
//                                     width: 5),
//                                 borderRadius:
//                                 BorderRadius
//                                     .circular(5)),
//                             child: Padding(
//                               padding:
//                               EdgeInsets.only(
//                                   left: 10.0,
//                                   right: 10.0,
//                                   top: 8.0,
//                                   bottom: 8.0),
//                               child: Text(
//                                 'col',
//                                 style: TextStyle(
//                                     fontSize:
//                                     FontSizeStatic
//                                         .md,
//                                     color: Colors
//                                         .transparent,
//                                     fontFamily:
//                                     'Poppins'),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       left: ScreenConstant.sizeMedium,
//                       top: ScreenConstant.sizeMedium),
//                   child: Text(
//                     "Product Descriptions",
//                     style: TextStyles.productDesTitle,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       left: ScreenConstant.sizeSmall,
//                       right: ScreenConstant.sizeMedium),
//                   child: _productController
//                       .productDetailsData
//                       .value
//                       .product
//                       ?.details
//                       ?.description !=
//                       null
//                       ? Html(
//                     data: _productController
//                         .productDetailsData
//                         .value
//                         .product!
//                         .details!
//                         .description!,
//                     style: {
//                       'p': Style(
//                         fontSize: FontSize.medium,
//                         color: AppColors.productDes,
//                         fontFamily: 'Poppins',
//                         textAlign: TextAlign.justify,
//                       ),
//                     },
//                   )
//                       : Container(),
//                   // child: Html(
//                   //   data: _productController.productDetailsData
//                   //       .value.product!.details!.description,
//                   //   style: {
//                   //     _productController
//                   //         .productDetailsData
//                   //         .value
//                   //         .product!
//                   //         .details!
//                   //         .description!:
//                   //     Style(
//                   //         fontSize: FontSize.medium,
//                   //         color: AppColors.productDes,
//                   //         fontFamily: 'Poppins',
//                   //         textAlign: TextAlign.justify),
//                   //   },
//                   // )
//                   /*Text(
//                               _productController
//                                   .productDetailsData.value.product.description,
//                               style: TextStyles.productDesSubTitle,
//                               textAlign: TextAlign.justify,
//                             ),*/
//                 ),
//                 /*Padding(
//                             padding: EdgeInsets.only(
//                                 left: ScreenConstant.sizeMedium,
//                                 top: ScreenConstant.sizeMedium),
//                             child: Text(
//                               "Country of Origin",
//                               style: TextStyles.productDesTitle,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                               left: ScreenConstant.sizeMedium,
//                             ),
//                             child: Text(
//                               "India",
//                               style: TextStyles.productDesSubTitle,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: ScreenConstant.sizeMedium,
//                                 top: ScreenConstant.sizeMedium),
//                             child: Text(
//                               "Manufacturer Details",
//                               style: TextStyles.productDesTitle,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: ScreenConstant.sizeMedium,
//                                 right: ScreenConstant.defaultHeightTwoHundred,
//                                 top: ScreenConstant.sizeExtraSmall),
//                             child: Text(
//                               "Adani wilmar limited, fortune house, near navrangpura railway crossing, 380009",
//                               style: TextStyles.productDesSubTitle,
//                             ),
//                           ),*/
//                 Container(
//                   height: ScreenConstant.sizeMedium,
//                 ),
//                 _productController.productDetailsData.value
//                     .relatedProducts!.length <
//                     1
//                     ? Offstage()
//                     : Padding(
//                   padding: EdgeInsets.only(
//                       left: ScreenConstant.sizeMedium,
//                       right: ScreenConstant
//                           .defaultHeightTwoHundred,
//                       top: ScreenConstant.sizeExtraSmall),
//                   child: Text(
//                     "Related Products",
//                     style: TextStyles.topOfferText,
//                   ),
//                 ),
//                 Container(
//                   height: ScreenConstant.sizeSmall,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: AnimationLimiter(
//                     child: StaggeredGridView.countBuilder(
//                         shrinkWrap: true,
//                         physics: ClampingScrollPhysics(),
//                         itemCount: _productController
//                             .productDetailsData
//                             .value
//                             .relatedProducts!
//                             .length,
//                         itemBuilder: (BuildContext context,
//                             int index) =>
//                             AnimationConfiguration.staggeredGrid(
//                               position: index,
//                               duration: const Duration(
//                                   milliseconds: 1500),
//                               columnCount: 2,
//                               child: SlideAnimation(
//                                 child: FlipAnimation(
//                                   child: ProductListWidget(
//                                     isDeliverable:
//                                     _productController
//                                         .productDetailsData
//                                         .value
//                                         .product!
//                                         .deliverable,
//                                     availability:
//                                     _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![
//                                     index]
//                                         .availability,
//                                     isProductVariant:
//                                     _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![
//                                     index]
//                                         .productVariants!
//                                         .isEmpty
//                                         ? true
//                                         : false,
//                                     productId: _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![index]
//                                         .id
//                                         .toString(),
//                                     productName:
//                                     _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![
//                                     index]
//                                         .details!
//                                         .name,
//                                     productImage:
//                                     _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![
//                                     index]
//                                         .details!
//                                         .imagePath,
//                                     purchasePrice:
//                                     _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![
//                                     index]
//                                         .productVariants!
//                                         .isEmpty
//                                         ? ""
//                                         : _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![
//                                     index]
//                                         .productVariants![
//                                     0]
//                                         .purchasePrice
//                                     // .listingPrice
//                                         .toString(),
//                                     fakePrice: _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![
//                                     index]
//                                         .productVariants!
//                                         .isEmpty
//                                         ? ""
//                                         : _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![
//                                     index]
//                                         .productVariants![0]
//                                         .price
//                                         .toString(),
//                                     variant: _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![index]
//                                         .variant,
//                                     addCart: _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![
//                                     index]
//                                         .productVariants!
//                                         .isEmpty
//                                         ? false
//                                         : _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![
//                                     index]
//                                         .productVariants![
//                                     0]
//                                         .cartQuantity ==
//                                         0 ||
//                                         _productController
//                                             .productDetailsData
//                                             .value
//                                             .relatedProducts![
//                                         index]
//                                             .productVariants![
//                                         0]
//                                             .cartQuantity ==
//                                             null
//                                         ? false
//                                         : true,
//                                     productCartQuantity:
//                                     _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![
//                                     index]
//                                         .productVariants!
//                                         .isEmpty
//                                         ? ""
//                                         : _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![
//                                     index]
//                                         .productVariants![
//                                     0]
//                                         .cartQuantity
//                                         .toString(),
//                                     shopId: _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![index]
//                                         .shopId
//                                         .toString(),
//                                     variantId: _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![
//                                     index]
//                                         .productVariants!
//                                         .isEmpty
//                                         ? ""
//                                         : _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![
//                                     index]
//                                         .productVariants![0]
//                                         .id
//                                         .toString(),
//                                     productQuantity:
//                                     _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![
//                                     index]
//                                         .productVariants!
//                                         .isEmpty
//                                         ? 0
//                                         : _productController
//                                         .productDetailsData
//                                         .value
//                                         .relatedProducts![
//                                     index]
//                                         .productVariants![
//                                     0]
//                                         .quantity,
//                                     isProductDetails: true,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         staggeredTileBuilder: (int index) =>
//                         new StaggeredTile.count(1, 1.8),
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10.0,
//                         mainAxisSpacing: 10.0),
//                   ),
//                 ),
//               ],
//             ),
//             /*Padding(
//                         padding: EdgeInsets.only(
//                             right: ScreenConstant.sizeXL,
//                             top: ScreenConstant.sizeXXXL),
//                         child: Material(
//                           elevation: 2,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(40.0),
//                             side: BorderSide(
//                                 color: AppColors.productListingScreenColor),
//                           ),
//                           child: Container(
//                             height: ScreenConstant.sizeXL,
//                             width: ScreenConstant.sizeXL,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 border: Border.all(
//                                     color: AppColors.productListingScreenColor),
//                                 shape: BoxShape.circle),
//                             child: Center(
//                                 child: GestureDetector(
//                               onTap: () {},
//                               child: Icon(
//                                 Icons.favorite,
//                                 color: Colors.red,
//                                 size: ScreenConstant.sizeLarge,
//                               ),
//                             )),
//                           ),
//                         ),
//                       ),*/
//           ],
//         ),
//         bottomNavigationBar: _productController.isLoading.value
//             ? Container()
//             : _cartController.cartCount.value == "0"
//             ? Offstage()
//             : Container(
//           color: AppColors.secondary,
//           height: ScreenConstant.defaultHeightOneHundred,
//           child: Column(
//             children: [
//               Divider(
//                 thickness: 1,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                     left: ScreenConstant.sizeSmall,
//                     right: ScreenConstant.sizeSmall,
//                     top: ScreenConstant.sizeSmall,
//                     bottom: ScreenConstant.sizeSmall),
//                 child: Container(
//                   height: ScreenConstant.sizeXXXL,
//                   decoration: BoxDecoration(
//                       color: AppColors.buttonColorSecondary,
//                       borderRadius: BorderRadius.circular(5)),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: ScreenConstant.sizeMedium,
//                       ),
//                       Container(
//                         height: ScreenConstant.sizeXL,
//                         width: ScreenConstant.sizeXL,
//                         decoration: BoxDecoration(
//                           color: AppColors.buttonColorSecondary,
//                           border: Border.all(
//                               color: AppColors.secondary,
//                               width: 1),
//                         ),
//                         child: Center(
//                             child: Text(
//                               _cartController.cartCount.value,
//                               style: TextStyle(
//                                   fontSize: FontSizeStatic.xl,
//                                   color: AppColors.secondary,
//                                   fontWeight: FontWeight.bold,
//                                   /* fontFamily: 'Proxima-Bold' */ fontFamily:
//                               'Poppins'),
//                             )),
//                       ),
//                       Container(
//                         width: ScreenConstant.sizeMedium,
//                       ),
//                       Text(
//                         "Rs. ${_cartController.cartTotal.value}",
//                         style: TextStyle(
//                             fontSize: FontSizeStatic.xll,
//                             color: AppColors.secondary,
//                             fontWeight: FontWeight.bold,
//                             /* fontFamily: 'Proxima-Bold' */ fontFamily:
//                         'Poppins'),
//                       ),
//                       Expanded(
//                         child: Container(
//                           width: ScreenConstant.sizeMedium,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           final MyBucketController
//                           _myBucketController =
//                           Get.put(MyBucketController());
//                           _myBucketController
//                               .productDetails.value = true;
//                           Get.toNamed(myBasket);
//                         },
//                         child: Text(
//                           "View Cart",
//                           style: TextStyle(
//                               fontSize: FontSizeStatic.maxMd,
//                               color: AppColors.secondary,
//                               fontFamily: 'Poppins'),
//                         ),
//                       ),
//                       Container(
//                         width: ScreenConstant.sizeMedium,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
