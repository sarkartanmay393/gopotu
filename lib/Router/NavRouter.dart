import 'package:get/get.dart';
import 'package:go_potu_user/Views/AddressScreens/AddNewAddressScreen.dart';
import 'package:go_potu_user/Views/AddressScreens/AddressListScreen.dart';
import 'package:go_potu_user/Views/AddressScreens/MapView.dart';
import 'package:go_potu_user/Views/CartScreen/CheckOutPage.dart';
import 'package:go_potu_user/Views/CartScreen/OrderPlacedScreen.dart';
import 'package:go_potu_user/Views/CartScreen/PromoApplyScreen.dart';
import 'package:go_potu_user/Views/CategoryScreen/CategoryShopScreen.dart';
import 'package:go_potu_user/Views/CompanyScreens/AboutUsScreen.dart';
import 'package:go_potu_user/Views/CompanyScreens/CustomerCareService.dart';
import 'package:go_potu_user/Views/CompanyScreens/RateUSScreen.dart';
import 'package:go_potu_user/Views/HomeScreen/HomeScreen.dart';
import 'package:go_potu_user/Views/HomeScreen/NewHomeScreenTab.dart';
import 'package:go_potu_user/Views/HomeScreen/ViewAllNewProductScreen.dart';
import 'package:go_potu_user/Views/HomeScreen/ViewAllProductOfferScreen.dart';
import 'package:go_potu_user/Views/HomeScreen/ViewAllShopOfferScreen.dart';
import 'package:go_potu_user/Views/LocationLoadingScreen/LocationLoadingScreen.dart';
import 'package:go_potu_user/Views/NotificationScreen/NotificationScreen.dart';
import 'package:go_potu_user/Views/OrdersScreen/OrderListingScreen.dart';
import 'package:go_potu_user/Views/ProductListScreen/SubCategoryProductListScreen.dart';
import 'package:go_potu_user/Views/CategoryScreen/SubCategoryScreen.dart';
import 'package:go_potu_user/Views/ProductDetailsScreen/ProductDetails.dart';
import 'package:go_potu_user/Views/ProfileScreen/ChangePasswordScreen.dart';
import 'package:go_potu_user/Views/ProfileScreen/EditProfileDetails.dart';
import 'package:go_potu_user/Views/StoreScreens/StoreDetailsScreen.dart';
import 'package:go_potu_user/Views/StoreScreens/ViewAllCategoryScreen.dart';
import 'package:go_potu_user/Views/StoreScreens/ViewAllStoreScreen.dart';
import 'package:go_potu_user/Views/LandingScreen/Landing.dart';
import 'package:go_potu_user/Views/OTPScreen/OTPScreen.dart';
import 'package:go_potu_user/Views/OrdersScreen/OrderDetailsScreen.dart';
import 'package:go_potu_user/Views/SignInScreen/SignIn.dart';
import 'package:go_potu_user/Views/SignUpScreen/SignUpScreen.dart';
import '../Views/SplashScreen/SplashScreen.dart';
import 'RouteConstants.dart';

class NavRouter {
  static final generateRoute = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: landing,
      page: () => Landing(),
    ),
    GetPage(
      name: signIn,
      page: () => SignIn(),
    ),
    GetPage(
      name: signUp,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: otp,
      page: () => OTPScreen(),
    ),
    GetPage(
      name: addressList,
      page: () => AddressListScreen(),
    ),
    GetPage(
      name: orderDetails,
      page: () => OrderDetailsScreen(),
    ),
    GetPage(
      name: allStores,
      page: () => ViewAllStoreScreen(),
    ),
    GetPage(
      name: allCategory,
      page: () => ViewAllCategoryScreen(),
    ),
    GetPage(
      name: allShopOffer,
      page: () => ViewAllShopOfferScreen(),
    ),
    GetPage(
      name: allProductOffer,
      page: () => ViewAllProductOfferScreen(),
    ),
    GetPage(
      name: allNewProduct,
      page: () => ViewAllNewProductScreen(),
    ),
    GetPage(
      name: storeDetails,
      page: () => StoreDetailsScreen(),
    ),
    GetPage(
      name: subCategory,
      page: () => SubCategoryScreen(),
    ),
    GetPage(
      name: editProfile,
      page: () => EditProfileDetails(),
    ),
    GetPage(
      name: myBasket,
      page: () => CheckOutPage(),
    ),
    GetPage(
      name: promoApply,
      page: () => PromoApplyScreen(),
    ),
    GetPage(
      name: orderPlaced,
      page: () => OrderPlacedScreen(),
    ),
    GetPage(
      name: dashBoard,
      page: () => NewHomeScreenTab(),
    ),
    GetPage(
      name: productDetails,
      page: () => ProductDetails(),
    ),
    GetPage(
      name: productList,
      page: () => SubCategoryProductListScreen(),
    ),
    GetPage(
      name: aboutUs,
      page: () => AboutUsScreen(),
    ),
    GetPage(
      name: needHelp,
      page: () => CustomerCareService(),
    ),
    GetPage(
      name: rateUs,
      page: () => RateUSScreen(),
    ),
    GetPage(
      name: notifications,
      page: () => NotificationScreen(),
    ),
    GetPage(
      name: addAddress,
      page: () => AddNewAddressScreen(),
    ),
    GetPage(
      name: orderListing,
      page: () => OrderListingScreen(),
    ),
    GetPage(
      name: home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: changePassword,
      page: () => ChangePasswordScreen(),
    ),
    GetPage(
      name: mapView,
      page: () => MapView(),
    ),
    // GetPage(
    //   name: selectAddress,
    //   page: () => SelectAddress(),
    // ),
    GetPage(
      name: loading,
      page: () => LocationLoadingScreen(),
    ),
    GetPage(
      name: shop,
      page: () => CategoryShopScreen(),
    ),
  ];
}
