import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';

class Help_Screen extends StatelessWidget {
  const Help_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 186, 25, 14),
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
              size: ScreenConstant.sizeXL,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "Help",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: ScreenConstant.defaultHeightFiftyFive,
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: ScreenConstant.defaultHeightSeventySix),
                child: Container(
                  height: 67,
                  width: 257,
                  decoration: BoxDecoration(
                    color: Color(0xFFBDFFC8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenConstant.defaultWidthTen,
                            top: ScreenConstant.defaultHeightEight),
                        child: Text(
                          "Gopotu",
                          style: TextStyle(
                              color: Color(0xFF37B24B),
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizeStatic.sm),
                        ),
                      ),
                      SizedBox(
                        height: ScreenConstant.defaultHeightFour,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenConstant.defaultWidthTen,
                            top: ScreenConstant.defaultHeightEight),
                        child: Text(
                          "Hi Jeet, Welcome to Gopotu chat support",
                          style: TextStyle(
                              color: Colors.black, fontSize: FontSizeStatic.sm),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: ScreenConstant.defaultWidthTwenty,
              ),
              Padding(
                // padding: EdgeInsets.only(left: ScreenConstant.defaultWidthTwenty),
                padding: EdgeInsets.only(
                    right: ScreenConstant.defaultHeightSeventySix),
                child: Container(
                  width: 257,
                  height: 75,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: 75,
                        child: Container(
                          color: Color(0xFFBDFFC8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenConstant.defaultWidthTen,
                                    top: ScreenConstant.defaultHeightEight),
                                child: Text(
                                  "Gopotu",
                                  style: TextStyle(
                                      color: Color(0xFF37B24B),
                                      fontWeight: FontWeight.bold,
                                      fontSize: FontSizeStatic.sm),
                                ),
                              ),
                              SizedBox(
                                height: ScreenConstant.defaultHeightFour,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenConstant.defaultWidthTen,
                                    top: ScreenConstant.defaultHeightEight),
                                child: Text(
                                  "Please  select the issue for which you seek support",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: FontSizeStatic.sm),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: ScreenConstant.defaultHeightSeventySix),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 214, 213, 213))),
                  height: 27,
                  width: 257,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: ScreenConstant.defaultWidthTen,
                        top: ScreenConstant.defaultHeightEight),
                    child: Text(
                      "I have a query regarding Slot Booking",
                      style: TextStyle(
                          fontSize: FontSizeStatic.sm,
                          color: Color(0xFF37B24B),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: ScreenConstant.defaultHeightSeventySix),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 214, 213, 213))),
                  height: 27,
                  width: 257,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: ScreenConstant.defaultWidthTen,
                        top: ScreenConstant.defaultHeightEight),
                    child: Text(
                      "I have a query regarding Slot Booking",
                      style: TextStyle(
                          fontSize: FontSizeStatic.sm,
                          color: Color(0xFF37B24B),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: ScreenConstant.defaultHeightSeventySix),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 214, 213, 213))),
                  height: 27,
                  width: 257,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: ScreenConstant.defaultWidthTen,
                        top: ScreenConstant.defaultHeightEight),
                    child: Text(
                      "I have a query regarding Slot Booking",
                      style: TextStyle(
                          fontSize: FontSizeStatic.sm,
                          color: Color(0xFF37B24B),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: ScreenConstant.defaultHeightSeventySix),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 214, 213, 213))),
                  height: 27,
                  width: 257,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: ScreenConstant.defaultWidthTen,
                        top: ScreenConstant.defaultHeightEight),
                    child: Text(
                      "I have a query regarding Slot Booking",
                      style: TextStyle(
                          fontSize: FontSizeStatic.sm,
                          color: Color(0xFF37B24B),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: ScreenConstant.defaultHeightSeventySix),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 214, 213, 213))),
                  height: 27,
                  width: 257,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: ScreenConstant.defaultWidthTen,
                        top: ScreenConstant.defaultHeightEight),
                    child: Text(
                      "I have a query regarding Slot Booking",
                      style: TextStyle(
                          fontSize: FontSizeStatic.sm,
                          color: Color(0xFF37B24B),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenConstant.sizeExtraLarge,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenConstant.defaultHeightOneThirty),
                child: Container(
                  height: 43,
                  width: 257,
                  decoration: BoxDecoration(
                    color: Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenConstant.defaultWidthTen,
                            top: ScreenConstant.defaultHeightTen),
                        child: Text(
                          "I have a query regarding Slot Booking",
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: FontSizeStatic.sm),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: ScreenConstant.defaultHeightThirtyFive,
              ),
              Container(
                height: 35,
                width: 348,
                decoration: BoxDecoration(
                  color: Color(0xFFBDFFC8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: ScreenConstant.defaultHeightTen),
                      child: Center(
                        child: Text(
                          "The conversation has been closed due to inactivity",
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: FontSizeStatic.sm,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenConstant.sizeExtraLarge,
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: ScreenConstant.defaultHeightSeventySix),
                child: Container(
                  height: 67,
                  width: 257,
                  decoration: BoxDecoration(
                    color: Color(0xFFBDFFC8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenConstant.defaultWidthTen,
                            top: ScreenConstant.defaultHeightEight),
                        child: Text(
                          "Gopotu",
                          style: TextStyle(
                              color: Color(0xFF37B24B),
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizeStatic.sm),
                        ),
                      ),
                      SizedBox(
                        height: ScreenConstant.defaultHeightFour,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenConstant.defaultWidthTen,
                            top: ScreenConstant.defaultHeightEight),
                        child: Text(
                          "Hi Jeet, Welcome to Gopotu chat support",
                          style: TextStyle(
                              color: Colors.black, fontSize: FontSizeStatic.sm),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: ScreenConstant.defaultHeightFifteen,
              ),
              Padding(
                // padding: EdgeInsets.only(left: ScreenConstant.defaultWidthTwenty),
                padding: EdgeInsets.only(
                    right: ScreenConstant.defaultHeightSeventySix),
                child: Container(
                  width: 257,
                  height: 75,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: 75,
                        child: Container(
                          color: Color(0xFFBDFFC8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenConstant.defaultWidthTen,
                                    top: ScreenConstant.defaultHeightEight),
                                child: Text(
                                  "Gopotu",
                                  style: TextStyle(
                                      color: Color(0xFF37B24B),
                                      fontWeight: FontWeight.bold,
                                      fontSize: FontSizeStatic.sm),
                                ),
                              ),
                              SizedBox(
                                height: ScreenConstant.defaultHeightFour,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenConstant.defaultWidthTen,
                                    top: ScreenConstant.defaultHeightEight),
                                child: Text(
                                  "Please  select the issue for which you seek support",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: FontSizeStatic.sm),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: ScreenConstant.defaultHeightSeventySix),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 214, 213, 213))),
                  height: 27,
                  width: 257,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: ScreenConstant.defaultWidthTen,
                        top: ScreenConstant.defaultHeightEight),
                    child: Text(
                      "I have a query regarding Slot Booking",
                      style: TextStyle(
                          fontSize: FontSizeStatic.sm,
                          color: Color(0xFF37B24B),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: ScreenConstant.defaultHeightSeventySix),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 214, 213, 213))),
                  height: 27,
                  width: 257,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: ScreenConstant.defaultWidthTen,
                        top: ScreenConstant.defaultHeightEight),
                    child: Text(
                      "I have a query regarding Slot Booking",
                      style: TextStyle(
                          fontSize: FontSizeStatic.sm,
                          color: Color(0xFF37B24B),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: ScreenConstant.defaultHeightSeventySix),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 214, 213, 213))),
                  height: 27,
                  width: 257,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: ScreenConstant.defaultWidthTen,
                        top: ScreenConstant.defaultHeightEight),
                    child: Text(
                      "I have a query regarding Slot Booking",
                      style: TextStyle(
                          fontSize: FontSizeStatic.sm,
                          color: Color(0xFF37B24B),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: ScreenConstant.defaultHeightSeventySix),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 214, 213, 213))),
                  height: 27,
                  width: 257,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: ScreenConstant.defaultWidthTen,
                        top: ScreenConstant.defaultHeightEight),
                    child: Text(
                      "I have a query regarding Slot Booking",
                      style: TextStyle(
                          fontSize: FontSizeStatic.sm,
                          color: Color(0xFF37B24B),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: ScreenConstant.defaultHeightSeventySix),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 214, 213, 213))),
                  height: 27,
                  width: 257,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: ScreenConstant.defaultWidthTen,
                        top: ScreenConstant.defaultHeightEight),
                    child: Text(
                      "I have a query regarding Slot Booking",
                      style: TextStyle(
                          fontSize: FontSizeStatic.sm,
                          color: Color(0xFF37B24B),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenConstant.defaultHeightEightyTwo,
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.red,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                  height: ScreenConstant.defaultHeightForty,
                  width: ScreenConstant.defaultHeightTwentyfive,
                  child: Image.asset(
                    "assets/Vectorhome.png",
                  )),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  height: ScreenConstant.defaultHeightForty,
                  width: ScreenConstant.defaultHeightTwentyfive,
                  child: Image.asset(
                    "assets/orders.png",
                  )),
              label: 'My Orders',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  height: ScreenConstant.defaultHeightForty,
                  width: ScreenConstant.defaultHeightTwentyfive,
                  child: Image.asset("assets/categories.png")),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  height: ScreenConstant.defaultHeightForty,
                  width: ScreenConstant.defaultHeightTwentyfive,
                  child: Image.asset("assets/Group.png")),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  height: ScreenConstant.defaultHeightForty,
                  width: ScreenConstant.defaultHeightTwentyfive,
                  child: Image.asset("assets/profile.png")),
              label: 'Profile',
            ),
          ],
        ));
  }
}
