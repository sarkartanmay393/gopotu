import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddressController/AddressController.dart';
import 'package:go_potu_user/Controller/ChooseCategoryController/ChooseCategoryController.dart';
import 'package:go_potu_user/Controller/DashboardController/DashboardController.dart';
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
import 'package:go_potu_user/Views/AddressScreens/SelectAddress.dart';
import 'package:go_potu_user/Views/CategoryScreen/ChangeCategoryScreen.dart';
import 'package:go_potu_user/Views/SignInScreen/SignIn.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';
import 'package:go_potu_user/Widgets/DrawerWidget/DrawerFile.dart';
import 'package:go_potu_user/Widgets/DrawerWidget/GuestDrawerFile.dart';
import 'package:go_potu_user/Widgets/HomeScreenWidgets/SecondBannerListWidget.dart';
import 'package:go_potu_user/Widgets/HomeScreenWidgets/TopOfferWidgets.dart';
import 'package:go_potu_user/Widgets/HomeScreenWidgets/newProductsHomeScreenWidget.dart';
import 'package:go_potu_user/Widgets/ProductsHomeScreenWidget/ProductHomeScreenWidget.dart';
import 'package:go_potu_user/Widgets/StoreWidgets/StoreListWidget.dart';
import 'package:go_potu_user/Widgets/HomeScreenWidgets/SearchWidget.dart';
import 'package:go_potu_user/Widgets/HomeScreenWidgets/TopStoreWidgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../Controller/SplashController/SplashController.dart';
import '../../Widgets/CategoryHomeScreenWidget/CategoryHomeScreenWidget.dart';
import '../../Widgets/HomeScreenWidgets/BottomOfferWidgets.dart';
import '../../Widgets/ProductListWidget/SubCategoryProductListWidget.dart';
import '../AddressScreens/AddNewAddressScreen.dart';
import '../AddressScreens/MapView.dart';
import 'SearchScreen.dart';
import 'package:http/http.dart' as http;

int selectedIndex = 0;
String? currentAddress;
double? lat, long;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DashboardController _dashboardController =
      Get.put(DashboardController());

  final SplashController _splashController = Get.put(SplashController());
  final ChooseCategoryController chooseCategoryController =
      Get.put(ChooseCategoryController());
  final AddressController _addressController = Get.put(AddressController());

  @override
  Future _refreshData() async {
    // getLocation();
    await Future.delayed(Duration(seconds: 10));
    _dashboardController.getHomeDataPress(false, false);
  }

  Future _refreshDataa() async {
    // getLocation();
    await Future.delayed(Duration(seconds: 10));
  }

  ////location fetching end
  @override
  SnackBar _getExitSnackBar(
    BuildContext context,
  ) {
    return SnackBar(
      content: Text(
        'Press BACK again to exit!',
      ),
      backgroundColor: Colors.black,
      duration: const Duration(
        seconds: 2,
      ),
      behavior: SnackBarBehavior.floating,
    );
  }

  late DateTime currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press Back button again to Exit");
      return Future.value(false);
    }
    return Future.value(true);
  }
  //DateTime pre_backpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var index;

    //---new before removal of shop category page
    String shopType = HiveStore().get(Keys.shopType);
    if (shopType == "mart") {
      // If the shop type is "mart", set selectedIndex to 0
      selectedIndex = 0;
    } else {
      // Otherwise, set selectedIndex to 1
      selectedIndex = 1;
    }
    // ----new
    String type = ShareStore().getData(store: KeyStore.type) == null
        ? HiveStore().get(Keys.shopType)
        : ShareStore().getData(store: KeyStore.type);
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: GestureDetector(
            onTap: () {
              _addressController.isHomeScreen.value = true;
              Get.to(SelectAddress(
                value: LatLng(HiveStore().get(Keys.currLat),HiveStore().get(Keys.currLong)),
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: ScreenConstant.sizeLarge,
                  color: Colors.white,
                ),
                Container(
                  width: ScreenConstant.sizeExtraSmall,
                ),
                Obx(() => Expanded(
                  child: Text(
                    _dashboardController.location.value.split(',')[0] ?? "Fetching",
                    style: TextStyles.homeScreenAppBarTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
              ],
            ),
          ),

// Function to handle location tap



          actions: [
            GestureDetector(
              onTap: HiveStore().get(Keys.guestToken) == null
                  ? () {
                      Get.back();
                      Get.toNamed(notifications);
                    }
                  : () {
                      Get.to(SignIn());
                    },
              child: Icon(Icons.notifications,color: Colors.white,),
            ),
            Container(
              width: ScreenConstant.sizeMedium,
            ),
          ],
        ),
        // drawer: HiveStore().get(Keys.guestToken) == null
        //     ? DrawerFile()
        //     : GuestDrawerFile(),
        body: GetX<DashboardController>(initState: (state) {
          Get.find<DashboardController>().getHomeDataPress(true, true);
        }, builder: (_) {
          return Stack(
            children: [
              _dashboardController.isLoading.isFalse
                  ? Container()
                  : _dashboardController.nearestStore.length == 0
                      ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                height: ScreenConstant.screenHeightHalf,
                                image: AssetImage(
                                  Assets.storeNotFound,
                                ),
                              ),
                              Text(
                                "Store Not Found",
                                style: TextStyles.storeNotFoundMessage,
                                textAlign: TextAlign.center,
                              ),
                              Container(
                                height: ScreenConstant.sizeSmall,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Text(
                                  "We are currently not delivering at this location at the moment. Please \ntry again later.",
                                  style: TextStyles.notDeliveryMessage,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                height: ScreenConstant.sizeLarge,
                              ),
                              AppButton(
                                width: ScreenConstant.defaultWidthOneEighty,
                                color: AppColors.primary,
                                buttonText: AppStrings.ChangeLocation,
                                onPressed: () async {
                                  _addressController.isHomeScreen.value = true;
                                  Get.to(SelectAddress(
                                    value: LatLng(HiveStore().get(Keys.currLat),HiveStore().get(Keys.currLong)),
                                  ));
                                },
                              ),
                              Container(
                                height: ScreenConstant.sizeSmall,
                              ),
                            ],
                          ),
                        )
                      : Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          top: ScreenConstant.defaultSizeOneTen,
                          child: RefreshIndicator(
                            onRefresh: _refreshData,
                            child: ListView(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              children: [
                                // Container(
                                //   height: ScreenConstant.defaultWidthOneEighty,
                                //   child: CachedNetworkImage(
                                //     imageUrl:
                                //         "https://firebasestorage.googleapis.com/v0/b/gopotu-228fa.appspot.com/o/GoPotuAppImageCollections%2FHomePageMainBanner.jpeg?alt=media&token=d9a417b6-46b4-4981-bdac-20342357435e",
                                //     placeholder: (context, url) =>
                                //         Image.asset(Assets.loadingImageGif),
                                //     errorWidget: (context, url, error) =>
                                //         Image.network(
                                //             "https://firebasestorage.googleapis.com/v0/b/gopotu-228fa.appspot.com/o/GoPotuAppImageCollections%2Fwlcm.png?alt=media&token=6ecb4771-30f8-4788-9e4a-392b4162b96c"),
                                //     fit: BoxFit.contain,
                                //   ),
                                // ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 4, //newchanges from 3 to 77
                                    )
                                  ],
                                ),

                                Container(
                                    height:
                                        ScreenConstant.defaultWidthOneEighty,
                                    child: Image(
                                        image: AssetImage(
                                            "assets/HomePageMainBanner.jpeg"))),
                                // BannerListWidget(
                                //   isAutoplay: false,
                                //   isCover: false,
                                // ),
                                Center(
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "Get Full Cashback On First Order",
                                            style: TextStyle(
                                              fontSize: 15,
                                              /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                                  'Poppins',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      Container(

                                          child: Text(
                                            "Grab Exciting Deal",
                                            style: TextStyle(
                                              fontSize: 25,
                                              /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                                  'Poppins',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                // Container(
                                //   height: ScreenConstant.sizeLarge,
                                // ),
                                Container(
                                  color: AppColors.secondary,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: ScreenConstant.sizeSmall,
                                          right: ScreenConstant.sizeSmall,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            // Text(
                                            //   AppStrings.topStoreForYou,
                                            //   style: TextStyles.topStoreText,
                                            // ),
                                            _dashboardController
                                                        .offers_shop.length >
                                                    1
                                                ? GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(allShopOffer);
                                                    },
                                                    child: Text(
                                                      AppStrings.viewAll,
                                                      style: TextStyles.viewAll,
                                                    ),
                                                  )
                                                : Offstage(),
                                          ],
                                        ),
                                      ),
                                      _dashboardController.offers_shop.length <
                                              1
                                          ? Offstage()
                                          : Container(
                                              height: ScreenConstant.sizeMedium,
                                            ),
                                      _dashboardController.offers_shop.length <
                                              1
                                          ? Offstage()
                                          : Container(
                                              padding: EdgeInsets.only(
                                                left: ScreenConstant.sizeSmall,
                                              ),
                                              height: ScreenConstant
                                                  .defaultHeightOneForty,
                                              // ----------------adding_image____________
                                              // child: Image.asset('assets/card-item.png',
                                              //   height: 170,),
                                              child: AnimationLimiter(
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  physics:
                                                      ClampingScrollPhysics(),
                                                  itemCount:
                                                      _dashboardController
                                                          .offers_shop.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return AnimationConfiguration
                                                        .staggeredList(
                                                      position: index,
                                                      duration: const Duration(
                                                          milliseconds: 1000),
                                                      child: FlipAnimation(
                                                        child: FadeInAnimation(
                                                          child:
                                                              TopStoreWidgets(
                                                            index: index,
                                                            topStore:
                                                                _dashboardController
                                                                    .offers_shop,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                      /*Container(
                              padding: EdgeInsets.only(
                                  left: ScreenConstant.sizeSmall,
                                  bottom: ScreenConstant.sizeExtraSmall),
                              height: ScreenConstant.defaultHeightNinety,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return TopStoreWidgets();
                                },
                              ),
                            ),*/
                                      Container(
                                        height: ScreenConstant.sizeMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: ScreenConstant.sizeLarge,
                                ),
                                _dashboardController.featuredCategories.length <
                                        1
                                    ? Offstage()
                                    : Container(
                                        color: AppColors.secondary,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: ScreenConstant.sizeSmall,
                                                right: ScreenConstant.sizeSmall,
                                                top: ScreenConstant
                                                    .sizeExtraSmall,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: ScreenConstant
                                                            .defaultWidthTen),
                                                    child: Text(
                                                      AppStrings
                                                          .whatAreYouLookingFor,
                                                      style: TextStyles
                                                          .topStoreText,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: ScreenConstant
                                                          .defaultHeightForty),

//View all what do you want
                                                  _dashboardController
                                                              .featuredCategories
                                                              .length >
                                                          1
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            Get.toNamed(
                                                                allCategory);
                                                          },
                                                          child: Text(
                                                            AppStrings.viewAll,
                                                            style: TextStyles
                                                                .viewAll,
                                                          ),
                                                        )
                                                      : Offstage(),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: ScreenConstant.sizeMedium,
                                            ),
                                            Container(

                                              padding: EdgeInsets.only(
                                                left: ScreenConstant.sizeSmall,
                                                bottom: ScreenConstant.sizeSmall,
                                              ),
                                              child: SizedBox(
                                                height: _dashboardController.featuredCategories.length > 4
                                                    ? ScreenConstant.defaultHeightTwoHundredTen
                                                    : ScreenConstant.defaultHeightOneHundredTen,
                                                child: AnimationLimiter(
                                                  child: GridView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: _dashboardController.featuredCategories.length > 4 ? 2 : 1,
                                                      crossAxisSpacing: 2.0,
                                                      mainAxisSpacing: 0.0,
                                                    ),
                                                    physics: ClampingScrollPhysics(),
                                                    itemCount: min(_dashboardController.featuredCategories.length, 8),
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return AnimationConfiguration.staggeredList(
                                                        position: index,
                                                        duration: const Duration(milliseconds: 1000),
                                                        child: FlipAnimation(
                                                          child: FadeInAnimation(
                                                            child: CategoryHomeScreenWidget(
                                                              index: index,
                                                              categoryList: _dashboardController.featuredCategories,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),

                                            ),





                                            SizedBox(
                                              height: _dashboardController.offers_products != null && _dashboardController.offers_products.isNotEmpty
                                                  ? ScreenConstant.sizeExtraLarge
                                                  : 0.0,
                                            ),
                                            _dashboardController.offers_products != null && _dashboardController.offers_products.isNotEmpty
                                                ? TopOfferWidgets(bannerList: _dashboardController.offers_products)
                                                : Container(height: 0.0,),


                                          ],
                                        ),
                                      ),
                                _dashboardController.featuredCategories.length <
                                        1
                                    ? Offstage()
                                    : Container(
                                        height: ScreenConstant.sizeXXL,
                                      ),
                                _dashboardController.featuredProducts.length < 1
                                    ? Offstage()
                                    : Container(
                                        color: AppColors.secondary,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: ScreenConstant.sizeSmall,
                                                right: ScreenConstant.sizeSmall,
                                                top: ScreenConstant
                                                    .sizeExtraSmall,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: ScreenConstant
                                                            .defaultWidthTen),
                                                    child: Text(
                                                      AppStrings.whatdoyouwant,
                                                      style: TextStyles
                                                          .topStoreText,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: ScreenConstant
                                                          .defaultHeightForty),
                                                  // View all what you want
                                                  _dashboardController
                                                              .featuredProducts
                                                              .length >
                                                          1
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            Get.toNamed(
                                                                allProductOffer);
                                                          },
                                                          child: Text(
                                                            AppStrings.viewAll,
                                                            style: TextStyles
                                                                .viewAll,
                                                          ),
                                                        )
                                                      : Offstage(),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: ScreenConstant.sizeSmall,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: ScreenConstant.sizeMedium,
                                                bottom: ScreenConstant.sizeSmall,
                                              ),
                                              child: SizedBox(
                                                height: _dashboardController.featuredProducts.length > 8
                                                    ? ScreenConstant.defaultHeightTwoHundred
                                                    : ScreenConstant.defaultHeightOneHundredTen,
                                                child: AnimationLimiter(
                                                  child: GridView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: _dashboardController.featuredProducts.length > 8 ? 2 : 1,
                                                      crossAxisSpacing: 3.0,
                                                      mainAxisSpacing: 3.0,
                                                    ),
                                                    physics: ClampingScrollPhysics(),
                                                    itemCount: min(_dashboardController.featuredProducts.length, 8),
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return AnimationConfiguration.staggeredList(
                                                        position: index,
                                                        duration: const Duration(milliseconds: 1000),
                                                        child: FlipAnimation(
                                                          child: FadeInAnimation(
                                                            child: ProductHomeScreenWidget(
                                                              index: index,
                                                              productList: _dashboardController.featuredProducts,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
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
                                    left: ScreenConstant.sizeSmall,
                                    right: ScreenConstant.sizeSmall,
                                    top: ScreenConstant.sizeExtraSmall,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                ScreenConstant.defaultWidthTen),
                                        child: Text(
                                          AppStrings.specialofferZone,
                                          style: TextStyles.topStoreText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                _dashboardController.appBannerMiddle.length < 1
                                    ? Offstage()
                                    : Padding(
                                        padding: EdgeInsets.only(
                                          top: ScreenConstant.sizeExtraSmall,
                                        ),
                                        child: SecondBannerListWidget(
                                          bannerList: _dashboardController
                                              .appBannerMiddle,
                                        ),
                                      ),

                                Container(
                                  color: AppColors.secondary,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: ScreenConstant.sizeSmall,
                                          right: ScreenConstant.sizeSmall,
                                          top: ScreenConstant.sizeMedium,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: ScreenConstant
                                                      .defaultWidthTen),
                                              child: Text(
                                                AppStrings.exploreOurStore,
                                                style: TextStyles.topStoreText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            // left: ScreenConstant.sizeSmall,
                                            right:
                                                ScreenConstant.sizeExtraLarge,
                                            bottom:
                                                ScreenConstant.defaultWidthTen
                                            // top: ScreenConstant.sizeMedium,
                                            ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            _dashboardController
                                                        .nearestStore.length >
                                                    1
                                                ? GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(allStores);
                                                    },
                                                    child: Text(
                                                      AppStrings.viewAll,
                                                      style: TextStyles.viewAll,
                                                    ),
                                                  )
                                                : Offstage(),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: ScreenConstant.defaultWidthTwenty,
                                          right: ScreenConstant.sizeLarge,
                                        ),
                                        child: AnimationLimiter(
                                          child: StaggeredGridView.countBuilder(
                                            shrinkWrap: true,
                                            physics: ClampingScrollPhysics(),
                                            itemCount: _dashboardController.nearestStore.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              bool isOnline = _dashboardController.nearestStore[index]['online'] == '1';

                                              return AnimationConfiguration.staggeredGrid(
                                                position: index,
                                                duration: const Duration(milliseconds: 1500),
                                                columnCount: 2,
                                                child: SlideAnimation(
                                                  child: FlipAnimation(
                                                    child: isOnline
                                                        ? StoreListWidget(
                                                      index: index,
                                                      nearestStore: _dashboardController.nearestStore,
                                                      onTap: () {
                                                        Get.toNamed(
                                                          storeDetails,
                                                          arguments: JsonEncoder().convert({
                                                            "id": _dashboardController.nearestStore[index]['id'].toString(),
                                                            "isFavourite": false,
                                                          }),
                                                        );
                                                      },
                                                    )
                                                        : BackdropFilter(
                                                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                                      child: StoreListWidget(
                                                        index: index,
                                                        nearestStore: _dashboardController.nearestStore,
                                                        onTap: () {
                                                          // Handle onTap for blurred items (if needed)
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            staggeredTileBuilder: (int index) => StaggeredTile.count(1, 1.65),
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10.0,
                                            mainAxisSpacing: 8.0,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Container(
                                  height: ScreenConstant.sizeSmall,
                                ),
                                Container(
                                  color: AppColors.secondary,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: ScreenConstant.sizeSmall,
                                          right: ScreenConstant.sizeSmall,
                                          top: ScreenConstant.sizeMedium,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: ScreenConstant
                                                      .defaultWidthTen),
                                              child: Text(
                                                AppStrings.newProducts,
                                                style: TextStyles.topStoreText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: ScreenConstant.sizeMedium,
                                          right: ScreenConstant.sizeSmall,
                                          // top: ScreenConstant.sizeMedium,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            _dashboardController
                                                        .newProducts.length >
                                                    1
                                                ? GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(
                                                          allNewProduct);
                                                    },
                                                    child: Text(
                                                      AppStrings.viewAll,
                                                      style: TextStyles.viewAll,
                                                    ),
                                                  )
                                                : Offstage(),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: ScreenConstant.defaultWidthTwenty,
                                            bottom: ScreenConstant.sizeSmall),

                                        // ----------------adding_image____________
                                        // child: Image.asset('assets/card-item.png',
                                        //   height: 170,),
                                        child: SizedBox(
                                          height: ScreenConstant
                                              .defaultHeightOneTwenty,
                                          child: AnimationLimiter(
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              physics: ClampingScrollPhysics(),
                                              itemCount: _dashboardController
                                                  .newProducts.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return AnimationConfiguration
                                                    .staggeredList(
                                                  position: index,
                                                  duration: const Duration(
                                                      milliseconds: 1000),
                                                  child: FlipAnimation(
                                                    child: FadeInAnimation(
                                                      child:
                                                          newProductsHomeScreenWidget(
                                                        index: index,
                                                        productList:
                                                            _dashboardController
                                                                .newProducts,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: ScreenConstant.sizeSmall,
                                      ),
                                      // _dashboardController
                                      //             .appBannerFooter.length <
                                      //         1
                                      //     ? Offstage()
                                      //     : SecondBannerListWidget(
                                      //         bannerList: _dashboardController
                                      //             .appBannerFooter,
                                      //       ),
                                    ],
                                  ),
                                ),
                                Image(
                                  image: AssetImage(Assets.footerBanner),
                                ),
                                _dashboardController.offers_delivery.length == 0
                                    ? Offstage()
                                    : SizedBox(
                                        height: ScreenConstant.sizeLarge,
                                      )
                                // Container(
                                //   height: 210,
                                //   child: Stack(
                                //     children: [
                                //       Positioned(
                                //         top: 20,
                                //         bottom: 0,
                                //         left: 0,
                                //         right: 0,
                                //         child: Column(children: <Widget>[
                                //           Container(
                                //             height: ScreenConstant
                                //                 .defaultHeightSeventy,
                                //             color: AppColors.secondary,
                                //           ),
                                //           Expanded(
                                //               child: Container(
                                //             decoration: BoxDecoration(
                                //                 color: AppColors.guaranteeBox,
                                //                 borderRadius: BorderRadius.only(
                                //                   topLeft: Radius.circular(20),
                                //                   topRight: Radius.circular(20),
                                //                 )),
                                //           )),
                                //         ]),
                                //       ),
                                //       //   Positioned(
                                //       //     left: 0,
                                //       //     top: 50,
                                //       //     right: 0,
                                //       //     bottom: 0,
                                //       //     child: Column(
                                //       //       children: [
                                //       //         Container(
                                //       //           //height: ScreenConstant.defaultHeightOneForty,
                                //       //           width: ScreenConstant
                                //       //               .defaultHeightOneForty,
                                //       //           child: Image(
                                //       //             fit: BoxFit.contain,
                                //       //             image: AssetImage(
                                //       //                 Assets.companyTrust),
                                //       //           ),
                                //       //         ),
                                //       //         Container(
                                //       //           height:
                                //       //               ScreenConstant.sizeExtraSmall,
                                //       //         ),
                                //       //         Text(
                                //       //           "GO POTU".toUpperCase(),
                                //       //           style:
                                //       //               TextStyles.companyTrustTitle,
                                //       //         ),
                                //       //         Container(
                                //       //           height:
                                //       //               ScreenConstant.sizeExtraSmall,
                                //       //         ),
                                //       //         Text(
                                //       //           "GHAR MEIN HO KOI BAAT,\n GOPOTU\n HAI AAPKE SATH",
                                //       //           style: TextStyles
                                //       //               .companyTrustSubTitle,
                                //       //           textAlign: TextAlign.center,
                                //       //         ),
                                //       //       ],
                                //       //     ),
                                //       //   )
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Column(
                  children: [
                    _dashboardController.nearestStore.length == 0
                        ? Offstage()
                        : Container(
                            color: AppColors.primary,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenConstant.sizeMedium,
                                  left: ScreenConstant.sizeLarge,
                                  right: ScreenConstant.sizeLarge,
                                  bottom: ScreenConstant.sizeMedium),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(SearchScreen());
                                },
                                child: SearchWidget(
                                  onTap: () {},
                                  searchLevelText: type == "restaurant"
                                      ? "Search for restaurants, items or more..."
                                      : "Search for stores, items or more...",
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              //--------------------Newchanges------------
              // Center(
              //   child: Container(
              //     padding: EdgeInsets.only(
              //         left: 10, right: 10, top: 5, bottom: 5),
              //     child: ToggleSwitch(
              //       minWidth: 200.0,
              //       cornerRadius: 40.0,
              //       borderWidth: 0.5,
              //       fontSize: 16.0,
              //       borderColor: [Colors.grey],
              //       activeBgColors: [
              //         [AppColors.ToggleBar],
              //         [AppColors.ToggleBar],
              //         [AppColors.ToggleBar]
              //       ],
              //       activeFgColor: Colors.white,
              //       inactiveBgColor: AppColors.secondary,
              //       inactiveFgColor: Colors.black,
              //       initialLabelIndex: selectedIndex,
              //       totalSwitches: 3,
              //       labels: ['Mart', 'Restaurant', 'Meat'],
              //       radiusStyle: true,
              //       onToggle: (index_tb) {
              //         print('switched to: $index_tb');
              //
              //         selectedIndex = index_tb!;
              //
              //         if (index_tb == 0) {
              //           if (chooseCategoryController
              //               .isBeforeDashboard.value) {
              //             Get.offAllNamed(dashBoard);
              //           } else {
              //             Get.back();
              //             Get.offAllNamed(dashBoard);
              //           }
              //           ShareStore().saveData(
              //               store: KeyStore.typeIndex, object: "0");
              //           HiveStore().put(Keys.typeSelectIndex, "0");
              //           ShareStore().saveData(
              //               store: KeyStore.type, object: "mart");
              //           HiveStore().put(Keys.shopType, "mart");
              //         } else if (index_tb == 1) {
              //           if (chooseCategoryController
              //               .isBeforeDashboard.value) {
              //             Get.offAllNamed(dashBoard);
              //           } else {
              //             Get.back();
              //             Get.offAllNamed(dashBoard);
              //           }
              //           ShareStore().saveData(
              //               store: KeyStore.typeIndex, object: "1");
              //           HiveStore().put(Keys.typeSelectIndex, "1");
              //           ShareStore().saveData(
              //               store: KeyStore.type, object: "restaurant");
              //           HiveStore().put(Keys.shopType, "restaurant");
              //         } else {
              //           Get.back();
              //           Get.snackbar(
              //             "Sorry!",
              //             "This Service is not available at this moment.",
              //             backgroundColor: AppColors.secondary,
              //             icon: Icon(
              //               Icons.error_outline_sharp,
              //               color: Colors.red,
              //             ),
              //           );
              //         }
              //       },
              //     ),
              //   ),
              // ),
              // //--------------------Newchanges------------
              // Container(
              //   height: 2,
              // ),

              //---change cart button selection
              /*
                    Container(
                      color: AppColors.dashBoardChangeCategory,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: ScreenConstant.sizeLarge,
                          bottom: ScreenConstant.sizeSmall,
                          right: ScreenConstant.sizeLarge,
                          top: ScreenConstant.sizeSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [


                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.selectedShoppingCategory,
                                  style: TextStyles.categoryChangeText1,
                                ),

                                Container(
                                  height: ScreenConstant.sizeExtraSmall,
                                ),
                                Text(
                                  HiveStore().get(Keys.shopType) == "mart"
                                      ? "GOPOTU MART".toUpperCase()
                                      : "Restaurants Foods".toUpperCase(),
                                  style: TextStyles.categoryChangeText2,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showBottomSheet(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color:
                                          AppColors.dashBoardChangeCategoryText,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: ScreenConstant.sizeLarge,
                                        bottom: ScreenConstant.sizeExtraSmall,
                                        right: ScreenConstant.sizeLarge,
                                        top: ScreenConstant.sizeExtraSmall,
                                      ),
                                      child: Center(
                                          child: Text(
                                        AppStrings.change,
                                        style:
                                            TextStyles.categoryChangeBottomText,
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    */
              //--change cart button selection
              Positioned(
                left: 0,
                right: 0,
                top: _dashboardController.nearestStore.isNotEmpty ? 84 : 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    child: ToggleSwitch(
                      minWidth: 200.0,
                      cornerRadius: 40.0,
                      borderWidth: 0.5,
                      fontSize: 16.0,
                      borderColor: [Colors.grey],
                      activeBgColors: [
                        [AppColors.ToggleBar],
                        [AppColors.ToggleBar],
                        [AppColors.ToggleBar],
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: AppColors.secondary,
                      inactiveFgColor: Colors.black,
                      initialLabelIndex: selectedIndex,
                      totalSwitches: 2,
                      labels: ['Mart', 'Restaurant'],
                      radiusStyle: true,
                      onToggle: (index_tb) {
                        print('switched to: $index_tb');
                        selectedIndex = index_tb!;

                        if (index_tb == 0) {
                          if (chooseCategoryController.isBeforeDashboard.value) {
                            Get.offAllNamed(dashBoard);
                          } else {
                            Get.back();
                            Get.offAllNamed(dashBoard);
                          }
                          ShareStore().saveData(store: KeyStore.typeIndex, object: "0");
                          HiveStore().put(Keys.typeSelectIndex, "0");
                          ShareStore().saveData(store: KeyStore.type, object: "mart");
                          HiveStore().put(Keys.shopType, "mart");
                        } else if (index_tb == 1) {
                          if (chooseCategoryController.isBeforeDashboard.value) {
                            Get.offAllNamed(dashBoard);
                          } else {
                            Get.back();
                            Get.offAllNamed(dashBoard);
                          }
                          ShareStore().saveData(store: KeyStore.typeIndex, object: "1");
                          HiveStore().put(Keys.typeSelectIndex, "1");
                          ShareStore().saveData(store: KeyStore.type, object: "restaurant");
                          HiveStore().put(Keys.shopType, "restaurant");
                        } else {
                          Get.back();
                          Get.snackbar(
                            "Sorry!",
                            "This Service is not available at this moment.",
                            backgroundColor: AppColors.secondary,
                            icon: Icon(
                              Icons.error_outline_sharp,
                              color: Colors.red,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  children: [
                    _dashboardController.offers_delivery.length == 0 ||
                            _dashboardController.nearestStore.length == 0
                        ? Offstage()
                        : BottomOfferWidgets(
                            bannerList: _dashboardController.offers_delivery,
                          ),
                    //--------------------Newchanges------------
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  showBottomSheet(BuildContext context) {
    ChooseCategoryController chooseCategoryController =
        Get.put(ChooseCategoryController());
    chooseCategoryController.isBeforeDashboard.value = false;
    showBarModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        backgroundColor: AppColors.secondary,
        isDismissible: false,
        expand: false,
        topControl: Container(
          decoration: BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.circular(40)),
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.cancel,
                color: AppColors.secondary,
                size: ScreenConstant.sizeXXL,
              )),
        ),
        context: context,
        builder: (context) {
          return ChangeCategoryScreen();
        });
  }
}

void showLoadingBottomSheet(BuildContext context) {
  showBarModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    backgroundColor: AppColors.secondary,
    isDismissible: false,
    expand: false,
    context: context,
    builder: (context) {
      return Container(
        height: 100, // Adjust the height as needed
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
          ),
        ),
      );
    },
  );
}
