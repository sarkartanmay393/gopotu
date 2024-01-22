import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddToCartController/AddToCartController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import '../../DeviceManager/ScreenConstants.dart';
import 'CustomAnimatedBottomBar.dart';
import 'HomeTabScreenControl.dart';

class NewHomeScreenTab extends StatefulWidget {

  @override
  _NewHomeScreenTabState createState() => _NewHomeScreenTabState();
}

class _NewHomeScreenTabState extends State<NewHomeScreenTab> {
  int _currentIndex = 0;

  final _inactiveColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        HomeTabScreenControl(
          _currentIndex,
        ),
        bottomNavigationBar: _buildBottomBar()
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    }
    );
  }
  Widget _buildBottomBar(){
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: AppColors.secondary,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: onTabTapped,
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Assets.G,
          title: Text("Home"),// Use label instead of title
          activeColor: Colors.red,
          inactiveColor: _inactiveColor,
          isColor: false,
          textAlign: TextAlign.center,
        ),
    BottomNavyBarItem(
    icon: Assets.MyOrders,
    title: Text("Orders"),  // Use label instead of title
    activeColor: Colors.red,
    inactiveColor: _inactiveColor,
    isColor: true,
    textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
    icon: Assets.Categories,
    title: Text("Categories"),  // Use label instead of title
    activeColor: Colors.red,
    inactiveColor: _inactiveColor,
    isColor: true,
    textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
    isCart: true,
    icon: Assets.Cart,
    title: Text("Cart"),  // Use label instead of title
    activeColor: Colors.red,
    inactiveColor: _inactiveColor,
    isColor: true,
    textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
    icon: Assets.profile1,
    title: Text("Profile"),  // Use label instead of title
    activeColor: Colors.red,
    inactiveColor: _inactiveColor,
    isColor: true,
    textAlign: TextAlign.center,
    ),
      ],
    );
  // Widget _buildBottomBar(){
  //   return CustomAnimatedBottomBarNew(
  //     containerHeight: 70,
  //     backgroundColor: AppColors.secondary,
  //     selectedIndex: _currentIndex,
  //     showElevation: true,
  //     itemCornerRadius: 24,
  //     curve: Curves.easeIn,
  //     onItemSelected: onTabTapped,
  //     items: <BottomNavyBarItem>[
  //       BottomNavyBarItem(
  //         icon: Assets.G,
  //         title: Text("Home"),// Use label instead of title
  //         activeColor: Colors.red,
  //         inactiveColor: _inactiveColor,
  //         isColor: false,
  //         textAlign: TextAlign.center,
  //       ),
  //       BottomNavyBarItem(
  //         icon: Assets.MyOrders,
  //         title: Text("Orders"),  // Use label instead of title
  //         activeColor: Colors.red,
  //         inactiveColor: _inactiveColor,
  //         isColor: true,
  //         textAlign: TextAlign.center,
  //       ),
  //       BottomNavyBarItem(
  //         icon: Assets.Categories,
  //         title: Text("Categories"),  // Use label instead of title
  //         activeColor: Colors.red,
  //         inactiveColor: _inactiveColor,
  //         isColor: true,
  //         textAlign: TextAlign.center,
  //       ),
  //       BottomNavyBarItem(
  //         isCart: true,
  //         icon: Assets.Cart,
  //         title: Text("Cart"),  // Use label instead of title
  //         activeColor: Colors.red,
  //         inactiveColor: _inactiveColor,
  //         isColor: true,
  //         textAlign: TextAlign.center,
  //       ),
  //       BottomNavyBarItem(
  //         icon: Assets.profile1,
  //         title: Text("Profile"),  // Use label instead of title
  //         activeColor: Colors.red,
  //         inactiveColor: _inactiveColor,
  //         isColor: true,
  //         textAlign: TextAlign.center,
  //       ),
  //     ],
  //   );

    // return BottomNavigationBar(
    //
    //   type: BottomNavigationBarType.shifting,
    //   backgroundColor: AppColors.secondary,
    //   currentIndex: _currentIndex,
    //   selectedItemColor: Colors.green, // Set the desired color for both selected and unselected icons
    //   onTap: onTabTapped,
    //   items: [
    //     BottomNavigationBarItem(
    //       icon: Image(
    //         image: AssetImage(Assets.G),
    //         height: ScreenConstant.sizeMidLarge,
    //         width: ScreenConstant.sizeMidLarge,
    //       ),
    //       label: 'Home',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Image(
    //         image: AssetImage(Assets.MyOrders),
    //         height: ScreenConstant.sizeMidLarge,
    //         width: ScreenConstant.sizeMidLarge,
    //         color: _currentIndex == 1 ? Colors.green : Colors.black, // Set appropriate colors based on the index
    //       ),
    //       label: 'Orders',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Image(
    //         image: AssetImage(Assets.Categories),
    //         height: ScreenConstant.sizeMidLarge,
    //         width: ScreenConstant.sizeMidLarge,
    //         color: _currentIndex == 2 ? Colors.green : Colors.black,
    //       ),
    //       label: 'Categories',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Image(
    //         image: AssetImage(Assets.Cart),
    //         height: ScreenConstant.sizeMidLarge,
    //         width: ScreenConstant.sizeMidLarge,
    //         color: _currentIndex == 3 ? Colors.green : Colors.black,
    //       ),
    //       label: 'Cart',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Image(
    //         image: AssetImage(Assets.profile1),
    //         height: ScreenConstant.sizeMidLarge,
    //         width: ScreenConstant.sizeMidLarge,
    //         color: _currentIndex == 4 ? Colors.green : Colors.black,
    //       ),
    //       label: 'Profile',
    //     ),
    //   ],
    // );



  }


  /*Widget getBody() {
    List<Widget> pages = [
      Container(
        alignment: Alignment.center,
        child: Text("Home",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
      Container(
        alignment: Alignment.center,
        child: Text("Users",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
      Container(
        alignment: Alignment.center,
        child: Text("Messages",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
      Container(
        alignment: Alignment.center,
        child: Text("Settings",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }*/


}