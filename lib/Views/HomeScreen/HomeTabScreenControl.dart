
import 'package:flutter/material.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Views/CartScreen/CheckOutPage.dart';
import 'package:go_potu_user/Views/HomeScreen/HomeScreen.dart';
import 'package:go_potu_user/Views/OrdersScreen/OrderListingScreen.dart';
import 'package:go_potu_user/Views/ProfileScreen/MyProfileScreen.dart';
import 'package:go_potu_user/Views/SignInScreen/SignIn.dart';

import '../../Widgets/CategoryHomeScreenWidget/CategoryHomeScreenWidget.dart';
import '../StoreScreens/ViewAllCategoryScreen.dart';
import 'ViewAllProductOfferScreen.dart';


// ignore: must_be_immutable
class HomeTabScreenControl extends StatefulWidget {
  var currentIndex;

  HomeTabScreenControl(
      this.currentIndex,
      );

  @override
  _HomeTabScreenControlState createState() => _HomeTabScreenControlState();
}

class _HomeTabScreenControlState extends State<HomeTabScreenControl> {
  Widget? _widget;

  @override
  Widget build(BuildContext context) {
    getMainBody();
    return _widget!;
  }

  getMainBody() {
    switch (widget.currentIndex) {
      case 0:
        {
          _widget = HomeScreen();
        }
        break;
      case 1:
        {
          _widget = HiveStore().get(Keys.guestToken) == null ?OrderListingScreen():SignIn();
        }
        break;
      case 2:
        {
          _widget = HiveStore().get(Keys.guestToken) == null ?ViewAllCategoryScreen():SignIn();
        }
        break;
      case 3:
        {
          _widget = CheckOutPage();
          // _widget = HiveStore().get(Keys.guestToken) == null ?MyProfileScreen():SignIn();
        }
        break;
      case 4:
        {
          _widget = HiveStore().get(Keys.guestToken) == null ?MyProfileScreen():SignIn();
        }
        break;

    }
  }
}
