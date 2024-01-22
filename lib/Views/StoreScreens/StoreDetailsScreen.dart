import 'dart:convert';
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddToCartController/AddToCartController.dart';
import 'package:go_potu_user/Controller/MyBucketController/MyBucketController.dart';
import 'package:go_potu_user/Controller/ProductController/ProductController.dart';
import 'package:go_potu_user/Controller/StoreController/StoreController.dart';
import 'package:go_potu_user/Controller/SubCategoryController/SubCategoryController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Models/ResponseModels/StoreDetailsResponseModel/StoreDetailsResponseModel.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ScopeStorage.dart';
import 'package:go_potu_user/Store/ShareStore.dart';
import 'package:go_potu_user/Views/HomeScreen/CustomAnimatedBottomBar.dart';
import 'package:go_potu_user/Views/HomeScreen/SearchScreen.dart';
import 'package:go_potu_user/Widgets/CategoryHomeScreenWidget/CategoryShopWidgets.dart';
import 'package:go_potu_user/Widgets/CategoryWidgets/SubCategoryWidget.dart';
import 'package:go_potu_user/Widgets/HomeScreenWidgets/SeacrchWidget1.dart';
// import 'package:go_potu_user/Widgets/HomeScreenWidgets/BannerListWidgetForShop.dart';
import 'package:go_potu_user/Widgets/HomeScreenWidgets/SearchWidget.dart';
import 'package:go_potu_user/Widgets/ProductListWidget/StoreProductWidgets.dart';
import 'package:go_potu_user/Widgets/ProductWidgets/ProductListWidget.dart';
import 'package:skeletons/skeletons.dart';

import '../../DeviceManager/NoResult.dart';
import '../../Models/ResponseModels/GetMyBucketResponseModel/GetMyBucketResponseModel.dart';
import '../../Widgets/CategoryWidgets/StoreCategoryWidget.dart';
import '../../Widgets/ProductListWidget/SubCategoryProductListWidget.dart';
import '../../Widgets/ProductListWidget/TypeOfProductListWidget.dart';
import '../CartScreen/CheckOutPage.dart';
import '../HomeScreen/HomeScreen.dart';
import '../HomeScreen/SeacrhScreen1.dart';
import '../HomeScreen/ViewAllProductOfferScreen.dart';
import '../OrdersScreen/OrderListingScreen.dart';
import '../ProfileScreen/MyProfileScreen.dart';
import '../SignInScreen/SignIn.dart';
import 'StoreProductSearchScreen.dart';
import 'ViewAllCategoryScreen.dart';

// class Product {
//   final String name;
//   final double price;
//
//   Product({required this.name, required this.price});
// }
enum SortOption { lowToHigh, highToLow, All, newestProduct }

class StoreDetailsScreen extends StatefulWidget {
  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  Widget? _widget;
  final StoreController _storeController = Get.put(StoreController());
  final SubCategoryController _subCategoryController =
      Get.put(SubCategoryController());
  final ProductController _productController = Get.put(ProductController());
  final AddToCartController _cartController = Get.put(AddToCartController());

  final AddToCartController addToCartController = Get.find();
  bool _isLoading = true;

  TextEditingController searchController = TextEditingController();

  Future _refreshData() async {
    //await Future.delayed(Duration(seconds: 1));
    _storeController.storeDetailsPress(false);
    // _subCategoryController.subCategoryListPress(false);
  }

  int _currentIndex = 0;
  var currentIndex;
  final _inactiveColor = Colors.black;
  bool isSearch = false;

  void applyFilter(StateSetter setState, String foodType) {
    setState(() {
      if (foodType == 'veg') {
        isVegSelected = true;
        isNonVegSelected = false;
        seletedType = 'veg';
      } else {
        isVegSelected = false;
        isNonVegSelected = true;
        seletedType = 'nonveg';
      }

      // Filter the products based on the selected filter
      filteredProducts = _storeController.storeData!.value!.topofferedProducts!
          .where((product) =>
              product.productVariants != null &&
              product.productVariants!
                  .any((variant) => variant.food_type == foodType))
          .toList();

      itemcount = _storeController.storeData.value.topofferedProducts!.length;
    });

    // print('filteredProducts.first.food_type');
    // print(filteredProducts.first.food_type);
  }

  bool isVegSelected = false;
  bool isNonVegSelected = false;
  String seletedType = '';
  int itemcount = 0;

  // void onTabTapped(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   }
  //   );
  // }
  @override
  void initState() {
    // TODO: implement initState
    //_simulateLoad();
    // _subCategoryController.subCategoryListPress(false);
    super.initState();
  }

  // void onTabTapped(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  //
  //   switch (_currentIndex) {
  //     case 0:
  //       _widget = HomeScreen();
  //       break;
  //     case 1:
  //       _widget = HiveStore().get(Keys.guestToken) == null ? OrderListingScreen() : SignIn();
  //       break;
  //     case 2:
  //       _widget = HiveStore().get(Keys.guestToken) == null ? ViewAllCategoryScreen() : SignIn();
  //       break;
  //     case 3:
  //       _widget = CheckOutPage();
  //       // _widget = HiveStore().get(Keys.guestToken) == null ? MyProfileScreen() : SignIn();
  //       break;
  //     case 4:
  //       _widget = HiveStore().get(Keys.guestToken) == null ? MyProfileScreen() : SignIn();
  //       break;
  //     default:
  //       _widget = Container(); // Handle unknown index gracefully, or replace with appropriate widget.
  //       break;
  //   }
  // }
  List<TopofferedProduct> filteredProducts = [];

  Future _simulateLoad() async {
    Future.delayed(Duration(milliseconds: 3000), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

// Add this enum at the top of your file

// Declare this variable in your widget's state
  SortOption currentSortOption = SortOption.All;

// Your _showSortOptions method can be updated like this
  void _showSortOptions() {
    // Implement the UI for selecting sorting options, for example, using a dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sort by',
              style: TextStyle(
                  fontSize: FontSizeStatic.lg,
                  color: Colors.green,
                  fontWeight: FontWeight.bold)),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<SortOption?>(
                    title: Text('All',
                        style: TextStyle(
                            fontSize: FontSizeStatic.maxMd,
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),
                    value: SortOption.All,
                    groupValue: currentSortOption,
                    onChanged: (SortOption? value) {
                      setState(() {
                        currentSortOption = value!;
                      });
                    },
                  ),
                  RadioListTile<SortOption?>(
                    title: Text('Price - Low to High',
                        style: TextStyle(
                            fontSize: FontSizeStatic.maxMd,
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),
                    value: SortOption.lowToHigh,
                    groupValue: currentSortOption,
                    onChanged: (SortOption? value) {
                      setState(() {
                        currentSortOption = value!;
                      });
                    },
                  ),
                  RadioListTile<SortOption?>(
                    title: Text('Price - High to Low',
                        style: TextStyle(
                            fontSize: FontSizeStatic.maxMd,
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),
                    value: SortOption.highToLow,
                    groupValue: currentSortOption,
                    onChanged: (SortOption? value) {
                      setState(() {
                        currentSortOption = value!;
                      });
                    },
                  ),
                  RadioListTile<SortOption?>(
                    title: Text('Newest Product',
                        style: TextStyle(
                            fontSize: FontSizeStatic.maxMd,
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),
                    value: SortOption.newestProduct,
                    groupValue: currentSortOption,
                    onChanged: (SortOption? value) {
                      setState(() {
                        currentSortOption = value!;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Call a method to apply sorting based on the selected option
                  _sortProducts();
                });
                Navigator.pop(context);
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );
  }

// Method to apply sorting based on the selected option
  void _sortProducts() {
    _storeController.storeData!.value!.topofferedProducts!.sort((a, b) {
      if (currentSortOption == SortOption.newestProduct) {
        DateTime createdAtA =
            _parseCustomDateTime(a.productVariants?[0].createdAt) ??
                DateTime(0);
        DateTime createdAtB =
            _parseCustomDateTime(b.productVariants?[0].createdAt) ??
                DateTime(0);

        // Skip products without a valid creation date
        if (createdAtA == DateTime(0) || createdAtB == DateTime(0)) {
          return 0;
        }

        // Sort by creation date in descending order (newest first)
        return createdAtB.compareTo(createdAtA);
      } else {
        num priceA = a.productVariants?[0].purchasePrice ?? 0.0;
        num priceB = b.productVariants?[0].purchasePrice ?? 0.0;

        DateTime createdAtA =
            _parseCustomDateTime(a.productVariants?[0].createdAt) ??
                DateTime(0);
        DateTime createdAtB =
            _parseCustomDateTime(b.productVariants?[0].createdAt) ??
                DateTime(0);

        int priceComparison = currentSortOption == SortOption.lowToHigh
            ? priceA.compareTo(priceB)
            : priceB.compareTo(priceA);

        if (priceComparison == 0) {
          // If prices are equal, compare based on creation date
          return currentSortOption == SortOption.lowToHigh
              ? createdAtA.compareTo(createdAtB)
              : createdAtB.compareTo(createdAtA);
        } else {
          return priceComparison;
        }
      }
    });
  }

  DateTime? _parseCustomDateTime(String? createdAt) {
    if (createdAt != null) {
      try {
        // Implement your custom date parsing logic based on the provided format
        // Example: "24 Mar 23 - 12:15 PM"

        // Your parsing logic goes here

        // For example, a placeholder implementation (replace with your actual logic):
        return DateTime.now();
      } catch (e) {
        // Handle parsing errors
        print("Error parsing date: $e");
      }
    }
    return null;
  }

  List<int> numbers = [];

  int selectedCategoryIndex =
      0; // Initialize with -1 to indicate no category selected initially

  int selectedIndex = 0;
  late List<TopofferedProduct> products;

  bool isSelected(int index) {
    return selectedIndex == index;
  }

  void toggleSelection(int index) {
    setState(() {
      if (selectedIndex == index) {
        selectedIndex = 0; // Deselect if already selected
      } else {
        selectedIndex = index; // Select if not selected
      }
    });
  }

  String? selectedSortOption;

  String type = ShareStore().getData(store: KeyStore.type) == null
      ? HiveStore().get(Keys.shopType)
      : ShareStore().getData(store: KeyStore.type);

  Future<bool> _onBackPressed() {
    if (_storeController.isFavourite.value) {
      _storeController.isFavourite.value = false;
      Get.back();
    } else {
      Get.offAllNamed(dashBoard);
      Get.back();
    }

    return Future.value(false);
  }

  Color container1Color = Colors.blue;
  Color container2Color = Colors.blue;

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Center(
            child: Text("This is a bottom sheet"),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(
    //   _storeController.storeData.value!.shop!.shopName!.length > 20
    //       ? '${_storeController.storeData.value.shop!.shopName!.substring(0, 20)}...'
    //       : _storeController.storeData.value!.shop!.shopName!,
    // );
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          backgroundColor: AppColors.secondary,
          appBar: new AppBar(
            title: Text(
              "Store Details",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: AppColors.primary,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                size: FontSizeStatic.xxxl,
                color: Colors.white,
              ),
              onPressed: (() {
                Navigator.pop(context);
              }),
            ),
            actions: [
              // Row(
              //   children: [
              //     Image.asset(
              //       "assets/favourit.png",
              //       color: Colors.white,
              //     ),
              //     SizedBox(
              //       width: ScreenConstant.defaultHeightTen,
              //     ),
              //     Image.asset("assets/ss.png")
              //   ],
              // )
            ],
          ),
          body: Obx(
            () => _storeController.isLoading.value
                ? _skeletonView()
                : _storeController.storeData.value.shop == null
                    ? Container()
                    : RefreshIndicator(
                        onRefresh: _refreshData,
                        child: ListView(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: [
                            Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    height: ScreenConstant.sizeSmall,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: ScreenConstant.sizeMedium),
                                          child: Container(
                                            width: ScreenConstant
                                                .defaultHeightTwoHundred,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Welcome To",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          FontSizeStatic.maxMd,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */
                                                      fontFamily: 'Poppins'),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Container(
                                                  height: ScreenConstant
                                                      .sizeExtraSmall,
                                                ),
                                                Text(
                                                  _storeController
                                                              .storeData
                                                              .value!
                                                              .shop!
                                                              .shopName!
                                                              .length >
                                                          20
                                                      ? '${_storeController.storeData.value.shop!.shopName!.substring(0, 20)}...'
                                                      : _storeController
                                                          .storeData
                                                          .value!
                                                          .shop!
                                                          .shopName!,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          FontSizeStatic.xl,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */
                                                      fontFamily: 'Poppins'),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                _storeController
                                                            .storeData
                                                            .value
                                                            .shop!
                                                            .shopTagline ==
                                                        null
                                                    ? Offstage()
                                                    : Container(
                                                        height: ScreenConstant
                                                            .sizeExtraSmall,
                                                      ),
                                                _storeController
                                                            .storeData
                                                            .value
                                                            .shop!
                                                            .shopTagline ==
                                                        null
                                                    ? Offstage()
                                                    : Container(
                                                        width: ScreenConstant
                                                            .defaultWidthOneNinety,
                                                        child: Text(
                                                          _storeController
                                                                  .storeData
                                                                  .value
                                                                  .shop!
                                                                  .shopTagline ??
                                                              "",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  FontSizeStatic
                                                                      .lg),
                                                          overflow:
                                                              TextOverflow.clip,
                                                        ),
                                                      ),
                                                Container(
                                                  height:
                                                      ScreenConstant.sizeSmall,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: ScreenConstant.sizeMedium,
                                            // right: ScreenConstant.sizeMedium,
                                            // bottom: ScreenConstant.sizeMedium
                                          ),
                                          child: Container(
                                            width: ScreenConstant
                                                .defaultHeightOneForty,
                                            child: CachedNetworkImage(
                                              imageUrl: _storeController
                                                      .storeData
                                                      .value
                                                      .shop!
                                                      .shopCoverPath ??
                                                  "https://firebasestorage.googleapis.com/v0/b/gopotu-228fa.appspot.com/o/GoPotuAppImageCollections%2Fwlcm.png?alt=media&token=6ecb4771-30f8-4788-9e4a-392b4162b96c",
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                      Assets.loadingImageGif),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.network(
                                                      "https://firebasestorage.googleapis.com/v0/b/gopotu-228fa.appspot.com/o/GoPotuAppImageCollections%2Fwlcm.png?alt=media&token=6ecb4771-30f8-4788-9e4a-392b4162b96c"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: ScreenConstant.sizeSmall,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ScreenConstant.sizeMedium),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            buildShowModalBottomSheet(context);
                                          },
                                          child: Container(
                                            height: 33,

                                            decoration: BoxDecoration(
                                              color: AppColors.secondary,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              // Adjust the border radius as needed
                                              border: Border.all(
                                                  color: Colors
                                                      .grey), // Border color
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal:
                                                    12), // Padding for inner content
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Image.asset(
                                                          "assets/verified.png"),
                                                    ),
                                                    SizedBox(
                                                        width: ScreenConstant
                                                            .sizeSmall),
                                                    Text(
                                                      'Verified',
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child: Icon(Icons
                                                          .arrow_drop_down),
                                                    ),
                                                  ],
                                                )

                                                // Right icon (down arrow)
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width: ScreenConstant.sizeMedium),
                                        Container(
                                          height: 33,
                                          decoration: BoxDecoration(
                                            color: AppColors.secondary,
                                            borderRadius: BorderRadius.circular(
                                                20), // Adjust the border radius as needed
                                            border: Border.all(
                                                color: Colors
                                                    .grey), // Border color
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5,
                                              horizontal:
                                                  12), // Padding for inner content
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  // Space between icon and text
                                                  Text(
                                                    '40 Mins',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: ScreenConstant.sizeSmall,
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Icon(Icons
                                                    .delivery_dining_outlined),
                                              ),
                                              // Right icon (down arrow)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: ScreenConstant.sizeSmall,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: ScreenConstant.sizeSmall,
                                      right: ScreenConstant.sizeSmall,
                                    ),
                                    child: Container(
                                      height: ScreenConstant.defaultHeightForty,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              ScreenConstant.sizeExtraLarge),
                                          color: AppColors.secondary,
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: ScreenConstant
                                                    .defaultHeightFifteen),
                                            child: Container(
                                              height:
                                                  ScreenConstant.sizeExtraLarge,
                                              width:
                                                  ScreenConstant.sizeExtraLarge,
                                              child: Image(
                                                fit: BoxFit.contain,
                                                // color: Colors.black,
                                                image: AssetImage(
                                                    "assets/offerr.png"),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: ScreenConstant.sizeSmall,
                                          ),
                                          Text(
                                              "Get 40% Discount on Your First Order",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: ScreenConstant.sizeMedium,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenConstant.defaultWidthTwenty),
                                  child: Container(
                                    child: Row(
                                      children: [],
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: ScreenConstant.defaultHeightSixty,
                                // ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _showSortOptions();
                                        });
                                      },
                                      child: Container(
                                        width: ScreenConstant
                                            .defaultHeightSeventySix,
                                        height: ScreenConstant
                                            .defaultHeightTwentyeight,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: ScreenConstant
                                                    .defaultHeightTen),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Sort by',
                                                  style: TextStyle(
                                                    fontSize: FontSizeStatic.sm,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 2),
                                                Container(
                                                  width: ScreenConstant
                                                      .defaultWidthTwenty,
                                                  height: ScreenConstant
                                                      .defaultHeightFifteen,
                                                  child: Image.asset(
                                                      "assets/sor.png"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: ScreenConstant.defaultHeightFifteen,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Show bottom sheet when the container is clicked
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return Column(
                                              children: [
                                                Container(
                                                  height: 200,
                                                  width: 500,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20,
                                                                top: 30),
                                                        child: Text(
                                                          "Filters",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Container(
                                                          height: 100,
                                                          width: 400,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black)),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            20.0,
                                                                        top: 15,
                                                                        bottom:
                                                                            10),
                                                                child: Text(
                                                                  "Veg/Nonveg",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            20),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context); // Close the bottom sheet
                                                                        applyFilter(
                                                                            setState,
                                                                            'veg');
                                                                        print(
                                                                            'Veg button pressed');
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            80,
                                                                        height:
                                                                            30,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: isVegSelected
                                                                              ? Colors.green
                                                                              : Colors.grey,
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            'Veg',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          20),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context); // Close the bottom sheet
                                                                      applyFilter(
                                                                          setState,
                                                                          'nonveg');
                                                                      print(
                                                                          'NonVeg button pressed');
                                                                      print(
                                                                          'After filtering: ${filteredProducts.length} products');
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: 80,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: isNonVegSelected
                                                                            ? Colors.red
                                                                            : Colors.grey,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          'NonVeg',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  // ... Rest of your code
                                                                  SizedBox(
                                                                      width:
                                                                          20),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width:
                                        ScreenConstant.defaultHeightSeventySix,
                                    height:
                                        ScreenConstant.defaultHeightTwentyeight,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(
                                          ScreenConstant.defaultWidthTwenty),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: ScreenConstant
                                                    .defaultHeightFifteen),
                                            child: Text(
                                              'Filter',
                                              style: TextStyle(
                                                fontSize: FontSizeStatic.sm,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: ScreenConstant
                                                .defaultHeightFive,
                                          ),
                                          Container(
                                            width: ScreenConstant
                                                .defaultHeightEight,
                                            height:
                                                ScreenConstant.defaultWidthTen,
                                            child: Image.asset(
                                                "assets/Group 65.png"),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: ScreenConstant.defaultHeightFifteen,
                                ),
                                Container(
                                  height: ScreenConstant.defaultHeightFifty,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: ScreenConstant
                                            .defaultHeightOneHundredNighty,
                                        height: 40,
                                        child: Card(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                FontSizeStatic.maxMd),
                                            side:
                                                BorderSide(color: Colors.black),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller:
                                                        searchController,
                                                    onChanged: (query) {
                                                      if (query.isEmpty ||
                                                          query == null) {
                                                        setState(() {
                                                          isSearch = false;
                                                          _storeController
                                                              .matchingProducts!
                                                              .clear();
                                                        });
                                                      } else {
                                                        setState(() {
                                                          isSearch = true;
                                                        });
                                                        _storeController
                                                                .matchingProducts =
                                                            products
                                                                .where((product) =>
                                                                    product
                                                                        .details
                                                                        ?.name
                                                                        ?.toLowerCase()
                                                                        .contains(
                                                                            query.toLowerCase()) ??
                                                                    false)
                                                                .toList();
                                                      }
                                                    },
                                                    onFieldSubmitted: (query) {
                                                      _storeController
                                                          .storeData
                                                          .value
                                                          .topofferedProducts
                                                          .toString();
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Search your orders',
                                                      hintStyle: TextStyle(
                                                        fontSize:
                                                            FontSizeStatic.mdSm,
                                                        color: Colors.black,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    cursorHeight: 18.0,
                                                    style: TextStyle(
                                                        fontSize:
                                                            FontSizeStatic.sm),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Icon(
                                                    Icons.search,
                                                    color: Colors.black,
                                                    size: ScreenConstant
                                                        .sizeLarge,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // Container(
                            //   color: AppColors.ordersScreenBackground,
                            //   height: ScreenConstant.sizeSmall,
                            // ),
                            // Container(
                            //   color: AppColors.secondary,
                            //   height: ScreenConstant.sizeSmall,
                            // ),
                            _storeController.storeData.value.appbanners!.top!
                                        .length <
                                    1
                                ? Offstage()
                                : Container(),
                            Container(
                              height: 8,
                              color: AppColors.gapColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: ScreenConstant
                                        .defaultHeightFourHundredFifty,
                                    child: AnimationLimiter(
                                      child: ListView.builder(
                                        physics: ClampingScrollPhysics(),
                                        itemCount: _storeController
                                                .storeData
                                                ?.value
                                                ?.featuredCategories
                                                ?.length ??
                                            0,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                AnimationConfiguration
                                                    .staggeredList(
                                          position: index,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedCategoryIndex = index;
                                              });
                                            },
                                            child: ScaleAnimation(
                                              child: FadeInAnimation(
                                                child: Stack(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Container(
                                                        height: ScreenConstant
                                                            .defaultHeightFifty,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: selectedCategoryIndex ==
                                                                  index
                                                              ? Color(
                                                                  0xFF37B24B) // Set your desired selected color
                                                              : Colors
                                                                  .transparent,
                                                          shape: BoxShape
                                                              .rectangle,
                                                        ),
                                                      ),
                                                    ),
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              selectedCategoryIndex ==
                                                                      index
                                                                  ? ScreenConstant
                                                                      .sizeLarge
                                                                  : 2.0),
                                                      child:
                                                          StoreCategoryWidget(
                                                        categoryId: _storeController
                                                                .storeData
                                                                ?.value
                                                                ?.featuredCategories?[
                                                                    index]
                                                                ?.id
                                                                ?.toString() ??
                                                            '',
                                                        categoryName:
                                                            _storeController
                                                                    .storeData
                                                                    ?.value
                                                                    ?.featuredCategories?[
                                                                        index]
                                                                    ?.name ??
                                                                '',
                                                        categoryImage:
                                                            _storeController
                                                                    .storeData
                                                                    ?.value
                                                                    ?.featuredCategories?[
                                                                        index]
                                                                    ?.iconPath ??
                                                                '',
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: ScreenConstant
                                                          .sizeExtraSmall,
                                                      left: ScreenConstant
                                                          .sizeSmall,
                                                      right: ScreenConstant
                                                          .sizeSmall,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          _storeController
                                                                  .storeData
                                                                  ?.value
                                                                  ?.featuredCategories?[
                                                                      index]
                                                                  ?.name ??
                                                              '',
                                                          style: TextStyle(
                                                            fontSize:
                                                                FontSizeStatic
                                                                    .mdSm,
                                                            color: selectedCategoryIndex ==
                                                                    index
                                                                ? Colors
                                                                    .green // Set your desired selected text color
                                                                : Colors
                                                                    .black, // Set your desired default text color
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    height: ScreenConstant
                                        .defaultHeightFourHundredFifty,
                                    decoration: BoxDecoration(
                                      color: AppColors.gapColor,
                                    ),
                                    child: GetX<SubCategoryController>(
                                      initState: (state) {
                                        Get.find<SubCategoryController>()
                                            .loadCategoryListPress();
                                      },
                                      builder: (_) {
                                        if (_storeController.storeData?.value
                                                ?.topofferedProducts !=
                                            null) {
                                          return _storeController
                                                  .isLoading.value
                                              ? Container()
                                              : _storeController
                                                      .storeData!
                                                      .value!
                                                      .topofferedProducts!
                                                      .isEmpty
                                                  ? Container(
                                                      child: Center(
                                                        child: NoResult(
                                                          titleText:
                                                              "Sorry no product found!",
                                                          subTitle: "",
                                                        ),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            ScreenConstant
                                                                .sizeSmall,
                                                      ),
                                                      child: GridView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            ClampingScrollPhysics(),
                                                        itemCount: seletedType
                                                                .isNotEmpty
                                                            ? filteredProducts
                                                                .length
                                                            : _storeController
                                                                .storeData!
                                                                .value!
                                                                .topofferedProducts!
                                                                .where((product) =>
                                                                    product
                                                                        .details
                                                                        ?.categoryId ==
                                                                    _storeController
                                                                        .storeData!
                                                                        .value!
                                                                        .featuredCategories?[
                                                                            selectedCategoryIndex]
                                                                        ?.id)
                                                                .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          // Reset products list based on filters
                                                          products = seletedType
                                                                  .isNotEmpty
                                                              ? filteredProducts
                                                                  .toList()
                                                              : _storeController
                                                                  .storeData!
                                                                  .value!
                                                                  .topofferedProducts!
                                                                  .where((product) =>
                                                                      product
                                                                          .details
                                                                          ?.categoryId ==
                                                                      _storeController
                                                                          .storeData!
                                                                          .value!
                                                                          .featuredCategories?[
                                                                              selectedCategoryIndex]
                                                                          ?.id)
                                                                  .toList();

                                                          if (index >= 0 &&
                                                              index <
                                                                  products
                                                                      .length) {
                                                            final product =
                                                                products[index];

                                                            // if (isVegSelected &&
                                                            //     (product.productVariants?.any((variant) =>
                                                            //             variant
                                                            //                 .food_type ==
                                                            //             "veg") !=
                                                            //         true)) {
                                                            //   return SizedBox
                                                            //       .shrink();
                                                            // }

                                                            // if (isNonVegSelected &&
                                                            //     (product.productVariants?.any((variant) =>
                                                            //             variant
                                                            //                 .food_type ==
                                                            //             "nonveg") !=
                                                            //         true)) {
                                                            //   return SizedBox
                                                            //       .shrink();
                                                            // }

                                                            return StoreProductWidgets(
                                                              seletedType:
                                                                  seletedType,
                                                              isStore: true,
                                                              isDeliverable:
                                                                  _storeController
                                                                      .storeData
                                                                      ?.value
                                                                      ?.shop
                                                                      ?.deliverable,
                                                              availability: product
                                                                  ?.availability,
                                                              isProductVariant: product
                                                                      ?.productVariants
                                                                      ?.isEmpty ??
                                                                  true,
                                                              productId: product
                                                                      ?.id
                                                                      .toString() ??
                                                                  "",
                                                              productName: product
                                                                      ?.details
                                                                      ?.name ??
                                                                  "",
                                                              productImage:
                                                                  product
                                                                      ?.details
                                                                      ?.imagePath,
                                                              purchasePrice: product
                                                                          ?.productVariants
                                                                          ?.isEmpty ??
                                                                      true
                                                                  ? "0"
                                                                  : product
                                                                      ?.productVariants?[
                                                                          0]
                                                                      .purchasePrice
                                                                      .toString(),
                                                              fakePrice: product
                                                                          ?.productVariants
                                                                          ?.isEmpty ??
                                                                      true
                                                                  ? "0"
                                                                  : product
                                                                      ?.productVariants?[
                                                                          0]
                                                                      .price
                                                                      .toString(),
                                                              variant: product
                                                                          ?.productVariants
                                                                          ?.isEmpty ??
                                                                      true
                                                                  ? ""
                                                                  : product
                                                                          ?.productVariants?[
                                                                              0]
                                                                          .variant ??
                                                                      "",
                                                              addCart: product
                                                                          ?.productVariants
                                                                          ?.isEmpty ??
                                                                      true
                                                                  ? false
                                                                  : product!.productVariants![0].cartQuantity ==
                                                                              0 ||
                                                                          product.productVariants![0].cartQuantity ==
                                                                              null
                                                                      ? false
                                                                      : true,
                                                              productCartQuantity: product
                                                                          ?.productVariants
                                                                          ?.isEmpty ??
                                                                      true
                                                                  ? ""
                                                                  : product
                                                                          ?.productVariants?[
                                                                              0]
                                                                          .cartQuantity
                                                                          .toString() ??
                                                                      "",
                                                              shopId: product
                                                                      ?.shopId
                                                                      .toString() ??
                                                                  "",
                                                              variantId: product
                                                                          ?.productVariants
                                                                          ?.isEmpty ??
                                                                      true
                                                                  ? ""
                                                                  : product
                                                                          ?.productVariants?[
                                                                              0]
                                                                          .id
                                                                          .toString() ??
                                                                      "",
                                                              productQuantity: product
                                                                          ?.productVariants
                                                                          ?.isEmpty ??
                                                                      true
                                                                  ? 0
                                                                  : product
                                                                          ?.productVariants?[
                                                                              0]
                                                                          .quantity ??
                                                                      0,
                                                              food_type: product
                                                                          ?.productVariants
                                                                          ?.isEmpty ??
                                                                      true
                                                                  ? "0"
                                                                  : product
                                                                      ?.productVariants?[
                                                                          0]
                                                                      .food_type
                                                                      .toString(),
                                                              // Your existing code for StoreProductWidgets
                                                            );
                                                          }
                                                        },
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                          childAspectRatio:
                                                              ScreenConstant
                                                                      .sizeLarge /
                                                                  ScreenConstant
                                                                      .sizeExtraLarge,
                                                          crossAxisCount: 2,
                                                          crossAxisSpacing:
                                                              ScreenConstant
                                                                  .sizeSmall,
                                                          mainAxisSpacing:
                                                              ScreenConstant
                                                                  .sizeSmall,
                                                        ),
                                                      ),
                                                    );
                                        } else {
                                          return Container(); // Return an empty container if storeData or topofferedProducts is null
                                        }
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(
                            //     horizontal: ScreenConstant.sizeSmall,
                            //     // vertical: ScreenConstant.sizeSmall,
                            //   ),
                            //   child: Obx(() {
                            //     final int? cartCount = int.tryParse(_cartController
                            //         .cartCount.value);
                            //     final double? cartTotal = double.tryParse(_cartController
                            //         .cartTotal.value);
                            //
                            //
                            //     return Visibility(
                            //       visible: cartCount! > 0,
                            //       // Show only if items are added to the cart
                            //       child: Container(
                            //         height: ScreenConstant.sizeXXXL,
                            //         decoration: BoxDecoration(
                            //           color: AppColors.buttonColorSecondary,
                            //           borderRadius: BorderRadius.circular(5),
                            //         ),
                            //         child: Row(
                            //           children: [
                            //             SizedBox(width: ScreenConstant.sizeMedium),
                            //             Container(
                            //               height: ScreenConstant.sizeXL,
                            //               width: ScreenConstant.sizeXL,
                            //               decoration: BoxDecoration(
                            //                 color: AppColors.buttonColorSecondary,
                            //                 border: Border.all(
                            //                   color: AppColors.secondary,
                            //                   width: 1,
                            //                 ),
                            //               ),
                            //               child: Center(
                            //                 child: Text(
                            //                   cartCount.toString(),
                            //                   style: TextStyle(
                            //                     fontSize: FontSizeStatic.xl,
                            //                     color: AppColors.secondary,
                            //                     fontWeight: FontWeight.bold,
                            //                     fontFamily: 'Poppins',
                            //                   ),
                            //                 ),
                            //               ),
                            //             ),
                            //             SizedBox(width: ScreenConstant.sizeMedium),
                            //             Text(
                            //               "Items",
                            //               style: TextStyle(
                            //                 fontSize: FontSizeStatic.xll,
                            //                 color: AppColors.secondary,
                            //                 fontWeight: FontWeight.bold,
                            //                 fontFamily: 'Poppins',
                            //               ),
                            //             ),
                            //             SizedBox(width: ScreenConstant.sizeMedium),
                            //             Text(
                            //               "Rs. $cartTotal",
                            //               style: TextStyle(
                            //                 fontSize: FontSizeStatic.xll,
                            //                 color: AppColors.secondary,
                            //                 fontWeight: FontWeight.bold,
                            //                 fontFamily: 'Poppins',
                            //               ),
                            //             ),
                            //             Spacer(),
                            //             GestureDetector(
                            //               onTap: () {
                            //                 final MyBucketController _myBucketController =
                            //                 Get.put(MyBucketController());
                            //                 _myBucketController.productDetails.value =
                            //                 true;
                            //                 Get.toNamed(myBasket);
                            //               },
                            //               child: Text(
                            //                 "View Cart",
                            //                 style: TextStyle(
                            //                   fontSize: FontSizeStatic.maxMd,
                            //                   color: AppColors.secondary,
                            //                   fontFamily: 'Poppins',
                            //                 ),
                            //               ),
                            //             ),
                            //             SizedBox(width: ScreenConstant.sizeMedium),
                            //           ],
                            //         ),
                            //       ),
                            //     );
                            //   }),
                            // ),
                          ],
                        ),
                      ),
          ),

          // bottomNavigationBar:BottomNavigationBar(
          //   type: BottomNavigationBarType.shifting,
          //   backgroundColor: AppColors.secondary,
          //   currentIndex: _currentIndex,
          //   // elevation: 10,
          //   selectedItemColor: Colors.green,
          //   unselectedItemColor: _inactiveColor,
          //   onTap: onTabTapped,
          //   items: [
          //     BottomNavigationBarItem(
          //       icon: Image(
          //         image: AssetImage(Assets.G),
          //         // You can specify height and width here if needed
          //         height: ScreenConstant.sizeMidLarge,
          //         width: ScreenConstant.sizeMidLarge,
          //       ),
          //       label: 'Home',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Image(
          //         image: AssetImage(Assets.MyOrders),
          //         // You can specify height and width here if needed
          //         height: ScreenConstant.sizeMidLarge,
          //         width: ScreenConstant.sizeMidLarge,
          //         color: _currentIndex == 1 ? Colors.green : Colors.black,
          //       ),
          //       label: 'Orders',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Image(
          //         image: AssetImage(Assets.Categories),
          //         // You can specify height and width here if needed
          //         height: ScreenConstant.sizeMidLarge,
          //         width: ScreenConstant.sizeMidLarge,
          //         color: _currentIndex == 2 ? Colors.green : Colors.black,
          //       ),
          //       label: 'Categories',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Image(
          //         image: AssetImage(Assets.Cart),
          //         // You can specify height and width here if needed
          //         height: ScreenConstant.sizeMidLarge,
          //         width: ScreenConstant.sizeMidLarge,
          //         color: _currentIndex == 3 ? Colors.green : Colors.black,
          //       ),
          //       label: 'Cart',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Image(
          //         image: AssetImage(Assets.profile1),
          //         // You can specify height and width here if needed
          //         height: ScreenConstant.sizeMidLarge,
          //         width: ScreenConstant.sizeMidLarge,
          //         color: _currentIndex == 4 ? Colors.green : Colors.black,
          //       ),
          //       label: 'Profile',
          //     ),
          //   ],
          // )
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenConstant.sizeSmall,
              // vertical: ScreenConstant.sizeSmall,
            ),
            child: Obx(() {
              final int? cartCount =
                  int.tryParse(_cartController.cartCount.value);
              final double? cartTotal =
                  double.tryParse(_cartController.cartTotal.value);

              return Visibility(
                visible: cartCount! > 0,
                // Show only if items are added to the cart
                child: Container(
                  height: ScreenConstant.sizeXXXL,
                  decoration: BoxDecoration(
                    color: AppColors.buttonColorSecondary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: ScreenConstant.sizeMedium),
                      Container(
                        height: ScreenConstant.sizeXL,
                        width: ScreenConstant.sizeXL,
                        decoration: BoxDecoration(
                          color: AppColors.buttonColorSecondary,
                          // border: Border.all(
                          //   color: AppColors.secondary,
                          //   width: 1,
                          // ),
                        ),
                        child: Center(
                          child: Text(
                            cartCount.toString(),
                            style: TextStyle(
                              fontSize: FontSizeStatic.xl,
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: ScreenConstant.sizeMedium),
                      Text(
                        "Items",
                        style: TextStyle(
                          fontSize: FontSizeStatic.xll,
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(width: ScreenConstant.sizeMedium),
                      Text(
                        "Rs. $cartTotal",
                        style: TextStyle(
                          fontSize: FontSizeStatic.xll,
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          final MyBucketController _myBucketController =
                              Get.put(MyBucketController());
                          _myBucketController.productDetails.value = true;
                          Get.toNamed(myBasket);
                        },
                        child: Text(
                          "View Cart",
                          style: TextStyle(
                            fontSize: FontSizeStatic.maxMd,
                            color: AppColors.secondary,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      SizedBox(width: ScreenConstant.sizeMedium),
                    ],
                  ),
                ),
              );
            }),
          ),
        ));
  }

  Widget _skeletonView() => ListView.builder(
        // padding: padding,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(color: Colors.white),
            child: SkeletonItem(
                child: Column(
              children: [
                Row(
                  children: [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        shape: BoxShape.circle,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 3,
                            spacing: 6,
                            lineStyle: SkeletonLineStyle(
                              randomLength: true,
                              height: 10,
                              borderRadius: BorderRadius.circular(8),
                              minLength: MediaQuery.of(context).size.width / 6,
                              maxLength: MediaQuery.of(context).size.width / 3,
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                      lines: 3,
                      spacing: 6,
                      lineStyle: SkeletonLineStyle(
                        randomLength: true,
                        height: 10,
                        borderRadius: BorderRadius.circular(8),
                        minLength: MediaQuery.of(context).size.width / 2,
                      )),
                ),
                SizedBox(
                  height: 12,
                ),
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    width: double.infinity,
                    minHeight: MediaQuery.of(context).size.height / 8,
                    maxHeight: MediaQuery.of(context).size.height / 3,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SkeletonAvatar(
                            style: SkeletonAvatarStyle(width: 20, height: 20)),
                        SizedBox(width: 8),
                        SkeletonAvatar(
                            style: SkeletonAvatarStyle(width: 20, height: 20)),
                        SizedBox(width: 8),
                        SkeletonAvatar(
                            style: SkeletonAvatarStyle(width: 20, height: 20)),
                      ],
                    ),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          height: 16,
                          width: 64,
                          borderRadius: BorderRadius.circular(8)),
                    )
                  ],
                )
              ],
            )),
          ),
        ),
      );

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(ScreenConstant.sizeLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("License"),
            Text("License",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: FontSizeStatic.xxl)),
            SizedBox(
              height: ScreenConstant.sizeSmall,
            ),
            Text("We are Verified",
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: FontSizeStatic.lg)),
            Container(
              height: ScreenConstant.sizeLarge,
            ),
            _storeController.storeData.value.shop!.document!.fssairegNumber ==
                    ""
                ? Offstage()
                : GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade300),
                      child: Row(
                        children: [
                          Icon(
                            Icons.local_police_outlined,
                            size: ScreenConstant.screenHeightFourteen,
                          ),
                          SizedBox(
                            width: ScreenConstant.sizeMedium,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Fassi License",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: ScreenConstant.sizeMedium,
                              ),
                              Text(_storeController.storeData.value.shop!
                                  .document!.fssairegNumber!),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
            _storeController.storeData.value.shop!.document!.fssairegNumber ==
                    ""
                ? Offstage()
                : Container(
                    height: ScreenConstant.sizeLarge,
                  ),
            _storeController
                        .storeData.value.shop!.document!.tradelicenseNumber ==
                    ""
                ? Offstage()
                : GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade300),
                      child: Row(
                        children: [
                          Icon(
                            Icons.app_registration_outlined,
                            size: ScreenConstant.screenHeightFourteen,
                          ),
                          SizedBox(
                            width: ScreenConstant.sizeMedium,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Registraion License",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: ScreenConstant.sizeMedium,
                              ),
                              Text(_storeController.storeData.value.shop!
                                  .document!.tradelicenseNumber!),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
            _storeController
                        .storeData.value.shop!.document!.tradelicenseNumber ==
                    ""
                ? Offstage()
                : Container(
                    height: ScreenConstant.sizeLarge,
                  ),
            _storeController.storeData.value.shop!.document!.gstinNumber == ""
                ? Offstage()
                : GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade300),
                      child: Row(
                        children: [
                          Icon(
                            Icons.insert_drive_file_outlined,
                            size: ScreenConstant.screenHeightFourteen,
                          ),
                          SizedBox(
                            width: ScreenConstant.sizeLarge,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "GST License",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: ScreenConstant.sizeMedium,
                              ),
                              Text(_storeController.storeData.value.shop!
                                  .document!.gstinNumber!),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _showDropDown(BuildContext context) async {
    // Calculate the position of the button
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset buttonPosition = button.localToGlobal(Offset.zero);

    // Define your menu items
    List<PopupMenuEntry<String>> items = [
      PopupMenuItem<String>(
        value: 'Option 1',
        child: Text('Option 1'),
      ),
      PopupMenuItem<String>(
        value: 'Option 2',
        child: Text('Option 2'),
      ),
      // Add more PopupMenuItems as needed
    ];

    // Show the dropdown menu at the button's position
    final String? selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        buttonPosition.dx,
        buttonPosition.dy + button.size.height,
        buttonPosition.dx + button.size.width,
        buttonPosition.dy + button.size.height + 10, // Adjust vertical position
      ),
      items: items,
    );

    // Handle the selected value here
    if (selected != null) {
      print('Selected: $selected');
      // Perform actions based on the selected value
    }
  }

// Row(
//   children: [
//     Container(
//       width: ScreenConstant.defaultHeightSeventy,
//       decoration: BoxDecoration(
//           border: Border.all(color: Colors.black)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Top Offers for you",
//             style: TextStyles.topOfferText,
//           ),
//           Container(
//             height: ScreenConstant.sizeMedium,
//           ),
//           // AnimationLimiter(
//           //   child: StaggeredGridView.countBuilder(
//           //       shrinkWrap: true,
//           //       physics: ClampingScrollPhysics(),
//           //       itemCount: _storeController
//           //           .storeData
//           //           .value
//           //           .topofferedProducts!
//           //           .length,
//           //       // <=
//           //       //     4
// ? _storeController.storeData.value
//     .topofferedProducts.length
//           //       // : 4,
//           //       itemBuilder:
//           //           (BuildContext context,
//           //                   int index) =>
//           //               AnimationConfiguration
//           //                   .staggeredGrid(
//           //                 position: index,
//           //                 duration: const Duration(
//           //                     milliseconds: 1500),
//           //                 columnCount: 2,
//           //                 child: SlideAnimation(
//           //                   child: FlipAnimation(
//           //                     child:
//           //                     //     ProductListWidget(
//           //                     //   isStore: true,
//           //                     //   isDeliverable:
//           //                     //       _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .shop!
//           //                     //           .deliverable,
//           //                     //   availability:
//           //                     //       _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .topofferedProducts![
//           //                     //               index]
//           //                     //           .availability,
//           //                     //   isProductVariant:
//           //                     //       _storeController
//           //                     //               .storeData
//           //                     //               .value
//           //                     //               .topofferedProducts![
//           //                     //                   index]
//           //                     //               .productVariants!
//           //                     //               .isEmpty
//           //                     //           ? true
//           //                     //           : false,
//           //                     //   productId:
//           //                     //       _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .topofferedProducts![
//           //                     //               index]
//           //                     //           .id
//           //                     //           .toString(),
//           //                     //   productName:
//           //                     //       _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .topofferedProducts![
//           //                     //               index]
//           //                     //           .details!
//           //                     //           .name,
//           //                     //   productImage:
//           //                     //       _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .topofferedProducts![
//           //                     //               index]
//           //                     //           .details!
//           //                     //           .imagePath,
//           //                     //   purchasePrice: _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .topofferedProducts![
//           //                     //               index]
//           //                     //           .productVariants!
//           //                     //           .isEmpty
//           //                     //       ? "0"
//           //                     //       : _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .topofferedProducts![
//           //                     //               index]
//           //                     //           .productVariants![
//           //                     //               0]
//           //                     //           // .listingPrice
//           //                     //           .purchasePrice //changes
//           //                     //           .toString(),
//           //                     //   fakePrice: _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .topofferedProducts![
//           //                     //               index]
//           //                     //           .productVariants!
//           //                     //           .isEmpty
//           //                     //       ? "0"
//           //                     //       : _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .topofferedProducts![
//           //                     //               index]
//           //                     //           .productVariants![
//           //                     //               0]
//           //                     //           .price
//           //                     //           .toString(),
//           //                     //   variant: _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .topofferedProducts![
//           //                     //               index]
//           //                     //           .productVariants!
//           //                     //           .isEmpty
//           //                     //       ? ""
//           //                     //       : _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .topofferedProducts![
//           //                     //               index]
//           //                     //           .productVariants![
//           //                     //               0]
//           //                     //           .variant,
//           //                     //   addCart: _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .topofferedProducts![
//           //                     //               index]
//           //                     //           .productVariants!
//           //                     //           .isEmpty
//           //                     //       ? false
//           //                     //       : _storeController.storeData.value.topofferedProducts![index].productVariants![0].cartQuantity ==
//           //                     //                   0 ||
//           //                     //               _storeController.storeData.value.topofferedProducts![index].productVariants![0].cartQuantity ==
//           //                     //                   null
//           //                     //           ? false
//           //                     //           : true,
//           //                     //   productCartQuantity: _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .topofferedProducts![
//           //                     //               index]
//           //                     //           .productVariants!
//           //                     //           .isEmpty
//           //                     //       ? ""
//           //                     //       : _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .topofferedProducts![
//           //                     //               index]
//           //                     //           .productVariants![
//           //                     //               0]
//           //                     //           .cartQuantity
//           //                     //           .toString(),
//           //                     //   shopId: _storeController
//           //                     //       .storeData
//           //                     //       .value
//           //                     //       .topofferedProducts![
//           //                     //           index]
//           //                     //       .shopId
//           //                     //       .toString(),
//           //                     //   variantId: _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .topofferedProducts![
//           //                     //               index]
//           //                     //           .productVariants!
//           //                     //           .isEmpty
//           //                     //       ? ""
//           //                     //       : _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .topofferedProducts![
//           //                     //               index]
//           //                     //           .productVariants![
//           //                     //               0]
//           //                     //           .id
//           //                     //           .toString(),
//           //                     //   productQuantity: _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .topofferedProducts![
//           //                     //               index]
//           //                     //           .productVariants!
//           //                     //           .isEmpty
//           //                     //       ? 0
//           //                     //       : _storeController
//           //                     //           .storeData
//           //                     //           .value
//           //                     //           .topofferedProducts![
//           //                     //               index]
//           //                     //           .productVariants![
//           //                     //               0]
//           //                     //           .quantity,
//           //                     // ),
//           //                     Text("hi")
//           //                   ),
//           //                 ),
//           //               ),
//           //       staggeredTileBuilder: (int index) =>
//           //           new StaggeredTile.count(1, 0.2),
//           //       crossAxisCount: 2,
//           //       crossAxisSpacing: 10.0,
//           //       mainAxisSpacing: 10.0),
//           // ),
//
//           Container(
//             height: ScreenConstant.sizeSmall,
//           ),
//         ],
//       ),
//     ),
//     Column(
//       children: [
//         Text(
//           "Top Offers for you",
//           style: TextStyles.topOfferText,
//         ),
//         Container(
//           height: ScreenConstant.sizeMedium,
//         ),
//         AnimationLimiter(
//           child: StaggeredGridView.countBuilder(
//               shrinkWrap: true,
//               physics: ClampingScrollPhysics(),
//               itemCount: _storeController.storeData
//                   .value.topofferedProducts!.length,
//               // <=
//               //     4
//               // ? _storeController.storeData.value
//               //     .topofferedProducts.length
//               // : 4,
//               itemBuilder: (BuildContext context,
//                       int index) =>
//                   AnimationConfiguration
//                       .staggeredGrid(
//                     position: index,
//                     duration: const Duration(
//                         milliseconds: 1500),
//                     columnCount: 2,
//                     child: SlideAnimation(
//                       child: FlipAnimation(
//                         child: ProductListWidget(
//                           isStore: true,
//                           isDeliverable:
//                               _storeController
//                                   .storeData
//                                   .value
//                                   .shop!
//                                   .deliverable,
//                           availability:
//                               _storeController
//                                   .storeData
//                                   .value
//                                   .topofferedProducts![
//                                       index]
//                                   .availability,
//                           isProductVariant:
//                               _storeController
//                                       .storeData
//                                       .value
//                                       .topofferedProducts![
//                                           index]
//                                       .productVariants!
//                                       .isEmpty
//                                   ? true
//                                   : false,
//                           productId: _storeController
//                               .storeData
//                               .value
//                               .topofferedProducts![
//                                   index]
//                               .id
//                               .toString(),
//                           productName: _storeController
//                               .storeData
//                               .value
//                               .topofferedProducts![
//                                   index]
//                               .details!
//                               .name,
//                           productImage:
//                               _storeController
//                                   .storeData
//                                   .value
//                                   .topofferedProducts![
//                                       index]
//                                   .details!
//                                   .imagePath,
//                           purchasePrice: _storeController
//                                   .storeData
//                                   .value
//                                   .topofferedProducts![
//                                       index]
//                                   .productVariants!
//                                   .isEmpty
//                               ? "0"
//                               : _storeController
//                                   .storeData
//                                   .value
//                                   .topofferedProducts![
//                                       index]
//                                   .productVariants![0]
//                                   // .listingPrice
//                                   .purchasePrice //changes
//                                   .toString(),
//                           fakePrice: _storeController
//                                   .storeData
//                                   .value
//                                   .topofferedProducts![
//                                       index]
//                                   .productVariants!
//                                   .isEmpty
//                               ? "0"
//                               : _storeController
//                                   .storeData
//                                   .value
//                                   .topofferedProducts![
//                                       index]
//                                   .productVariants![0]
//                                   .price
//                                   .toString(),
//                           variant: _storeController
//                                   .storeData
//                                   .value
//                                   .topofferedProducts![
//                                       index]
//                                   .productVariants!
//                                   .isEmpty
//                               ? ""
//                               : _storeController
//                                   .storeData
//                                   .value
//                                   .topofferedProducts![
//                                       index]
//                                   .productVariants![0]
//                                   .variant,
//                           addCart: _storeController
//                                   .storeData
//                                   .value
//                                   .topofferedProducts![
//                                       index]
//                                   .productVariants!
//                                   .isEmpty
//                               ? false
//                               : _storeController
//                                               .storeData
//                                               .value
//                                               .topofferedProducts![
//                                                   index]
//                                               .productVariants![
//                                                   0]
//                                               .cartQuantity ==
//                                           0 ||
//                                       _storeController
//                                               .storeData
//                                               .value
//                                               .topofferedProducts![
//                                                   index]
//                                               .productVariants![
//                                                   0]
//                                               .cartQuantity ==
//                                           null
//                                   ? false
//                                   : true,
//                           productCartQuantity: _storeController
//                                   .storeData
//                                   .value
//                                   .topofferedProducts![
//                                       index]
//                                   .productVariants!
//                                   .isEmpty
//                               ? ""
//                               : _storeController
//                                   .storeData
//                                   .value
//                                   .topofferedProducts![
//                                       index]
//                                   .productVariants![0]
//                                   .cartQuantity
//                                   .toString(),
//                           shopId: _storeController
//                               .storeData
//                               .value
//                               .topofferedProducts![
//                                   index]
//                               .shopId
//                               .toString(),
//                           variantId: _storeController
//                                   .storeData
//                                   .value
//                                   .topofferedProducts![
//                                       index]
//                                   .productVariants!
//                                   .isEmpty
//                               ? ""
//                               : _storeController
//                                   .storeData
//                                   .value
//                                   .topofferedProducts![
//                                       index]
//                                   .productVariants![0]
//                                   .id
//                                   .toString(),
//                           productQuantity: _storeController
//                                   .storeData
//                                   .value
//                                   .topofferedProducts![
//                                       index]
//                                   .productVariants!
//                                   .isEmpty
//                               ? 0
//                               : _storeController
//                                   .storeData
//                                   .value
//                                   .topofferedProducts![
//                                       index]
//                                   .productVariants![0]
//                                   .quantity,
//                         ),
//                       ),
//                     ),
//                   ),
//               staggeredTileBuilder: (int index) =>
//                   new StaggeredTile.count(1, 1.8),
//               crossAxisCount: 2,
//               crossAxisSpacing: 10.0,
//               mainAxisSpacing: 10.0),
//         ),
//         /*StaggeredGridView.countBuilder(
// shrinkWrap: true,
// physics: ClampingScrollPhysics(),
// itemCount: 4,
// itemBuilder: (BuildContext context, int index) =>
//       ProductListWidget(
//         index: index,
//       ),
// staggeredTileBuilder: (int index) =>
//       new StaggeredTile.count(1, 1.9),
// crossAxisCount: 2,
// crossAxisSpacing: 10.0,
// mainAxisSpacing: 10.0),*/
//
//         Container(
//           height: ScreenConstant.sizeSmall,
//         ),
//       ],
//     ),
//   ],
// ),
// Container(
//   width: ScreenConstant.defaultHeightFourHundredFifty,
//   height: ScreenConstant.defaultHeightFifty,
//   decoration: BoxDecoration(
//     color: Colors.green,
//     borderRadius:
//     BorderRadius.circular(ScreenConstant.defaultWidthTwenty),
//   ),
//   child: Padding(
//     padding: EdgeInsets.only(
//         left: ScreenConstant.defaultHeightTwentyThree),
//     child: Row(
//       children: [
//         Text(
//           "View Cart",
//           style: TextStyle(
//               color: Colors.white,
//               fontSize: FontSizeStatic.md,
//               fontWeight: FontWeight.bold),
//         ),
//         SizedBox(
//           width: ScreenConstant.defaultHeightEight,
//         ),
//         Text(
//           "(Add ₹100 items more to get Free Delivery)",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: FontSizeStatic.sm,
//           ),
//         ),
//         SizedBox(
//           width: ScreenConstant.defaultHeightEight,
//         ),
//         Container(
//           width: ScreenConstant.sizeXL,
//           height: ScreenConstant.sizeXL,
//           decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               image: DecorationImage(
//                   image: AssetImage("assets/pause.png"))),
//         )
//       ],
//     ),
//   ),
// )
// void onTabTapped(int index) {
//   print("Tab tapped: $index");
//   setState(() {
//     _currentIndex = index;
//   });
//
//   switch (index) {
//     case 0:
//       Get.offAll(HomeScreen());
//       break;
//     case 1:
//       HiveStore().get(Keys.guestToken) == null
//           ? Get.offAll(OrderListingScreen())
//           : Get.offAll(SignIn());
//       break;
//     case 2:
//       HiveStore().get(Keys.guestToken) == null
//           ? Get.offAll(ViewAllProductOfferScreen())
//           : Get.offAll(SignIn());
//       break;
//     case 3:
//       Get.offAll(CheckOutPage());
//       // _widget = HiveStore().get(Keys.guestToken) == null ?MyProfileScreen():SignIn();
//       break;
//     case 4:
//       HiveStore().get(Keys.guestToken) == null
//           ? Get.offAll(MyProfileScreen())
//           : Get.offAll(SignIn());
//       break;
//     default:
//       break;
//   }
//
// }
// Widget _buildBottomBar(){
//
//   return BottomNavigationBar(
//     type: BottomNavigationBarType.shifting,
//     backgroundColor: AppColors.secondary,
//     currentIndex: _currentIndex,
//     // elevation: 10,
//     selectedItemColor: Colors.red,
//     unselectedItemColor: _inactiveColor,
//     onTap: onTabTapped,
//     items: [
//       BottomNavigationBarItem(
//         icon: Image(
//           image: AssetImage(Assets.G),
//           // You can specify height and width here if needed
//           height: ScreenConstant.sizeMidLarge,
//           width: ScreenConstant.sizeMidLarge,
//         ),
//         label: 'Home',
//       ),
//       BottomNavigationBarItem(
//         icon: Image(
//           image: AssetImage(Assets.MyOrders),
//           // You can specify height and width here if needed
//           height: ScreenConstant.sizeMidLarge,
//           width: ScreenConstant.sizeMidLarge,
//         ),
//         label: 'Orders',
//
//       ),
//       BottomNavigationBarItem(
//         icon: Image(
//           image: AssetImage(Assets.Categories),
//           // You can specify height and width here if needed
//           height: ScreenConstant.sizeMidLarge,
//           width: ScreenConstant.sizeMidLarge,
//         ),
//         label: 'Categories',
//       ),
//       BottomNavigationBarItem(
//         icon: Image(
//           image: AssetImage(Assets.Cart),
//           // You can specify height and width here if needed
//           height: ScreenConstant.sizeMidLarge,
//           width: ScreenConstant.sizeMidLarge,
//         ),
//         label: 'Cart',
//       ),
//       BottomNavigationBarItem(
//         icon: Image(
//           image: AssetImage(Assets.profile1),
//           // You can specify height and width here if needed
//           height: ScreenConstant.sizeMidLarge,
//           width: ScreenConstant.sizeMidLarge,
//         ),
//         label: 'Profile',
//       ),
//     ],
//   );
//
// }  // List<Product> products = [];
//   // String? selectedSortOption;
//   // int selectedCategoryIndex = 0; // Assuming you have this variable
//   //
//   // void _sortList() {
//   //   setState(() {
//   //     if (selectedSortOption == 'low_to_high') {
//   //       products.sort((a, b) => a.price.compareTo(b.price));
//   //     } else if (selectedSortOption == 'high_to_low') {
//   //       products.sort((a, b) => b.price.compareTo(a.price));
//   //     }
//   //   });
//   // }
//   // void _showSortOptions() {
//   //   showModalBottomSheet(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return Container(
//   //         padding: EdgeInsets.all(16.0),
//   //         child: Column(
//   //           mainAxisSize: MainAxisSize.min,
//   //           children: [
//   //             Text(
//   //               'Sort By',
//   //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//   //             ),
//   //             ListTile(
//   //               title: Text('Low to High'),
//   //               leading: Radio(
//   //                 value: 'low_to_high',
//   //                 groupValue: selectedSortOption,
//   //                 onChanged: (value) {
//   //                   setState(() {
//   //                     selectedSortOption = value as String?;
//   //                     // _sortList();
//   //                   });
//   //                   Navigator.pop(context);
//   //                 },
//   //               ),
//   //             ),
//   //             ListTile(
//   //               title: Text('High to Low'),
//   //               leading: Radio(
//   //                 value: 'high_to_low',
//   //                 groupValue: selectedSortOption,
//   //                 onChanged: (value) {
//   //                   setState(() {
//   //                     selectedSortOption = value as String?;
//   //                     // _sortList();
//   //                   });
//   //                   Navigator.pop(context);
//   //                 },
//   //               ),
//   //             ),
//   //             // Add more sorting options as needed
//   //           ],
//   //         ),
//   //       );
//   //     },
//   //   );
//   } // Container(
//                               width: ScreenConstant
//                                   .defaultHeightSeventySix,
//                               height: ScreenConstant
//                                   .defaultHeightTwentyThree,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.rectangle,
//                                 borderRadius: BorderRadius.circular(
//                                     ScreenConstant
//                                         .defaultWidthTwenty),
//                                 border: Border.all(
//                                   color: Colors.grey,
//                                   width: 2,
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Row(
//                                   children: [
//                                     // Padding(
//                                     //   padding: EdgeInsets.only(
//                                     //       left: ScreenConstant
//                                     //           .defaultHeightFifteen),
//                                     //   child: Text(
//                                     //     'Filter',
//                                     //     style: TextStyle(
//                                     //       fontSize: FontSizeStatic.sm,
//                                     //       fontWeight: FontWeight.bold,
//                                     //     ),
//                                     //   ),
//                                     // ),
//                                     // SizedBox(
//                                     //   width: ScreenConstant
//                                     //       .defaultHeightFive,
//                                     // ),
//                                     // Container(
//                                     //     width: ScreenConstant
//                                     //         .defaultHeightEight,
//                                     //     height: ScreenConstant
//                                     //         .defaultWidthTen,
//                                     //     child: Image.asset(
//                                     //         "assets/Group 65.png"))
//                                   ],
//                                 ),
//                               ),
//                             ),
}
