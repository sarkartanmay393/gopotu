import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';

class Store_Details extends StatefulWidget {
  const Store_Details({Key? key}) : super(key: key);

  @override
  State<Store_Details> createState() => _Store_DetailsState();
}

class _Store_DetailsState extends State<Store_Details> {
  @override
  String selectedValue = 'Option 1';
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0F0F0),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primary,
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
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenConstant.defaultHeightEight,
                  right: ScreenConstant.defaultHeightThirtyFive),
              child: Row(
                children: [
                  Icon(Icons.favorite_border_outlined),
                  SizedBox(
                    width: ScreenConstant.defaultWidthTen,
                  ),
                  Image.asset("assets/uil_share.png")
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: ScreenConstant.defaultHeightTwoHundred,
                      width: double.infinity,
                      child: Container(
                        color: AppColors.primary,
                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //         image: AssetImage("assets/Group 61.png"),
                        //         fit: BoxFit.fill)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenConstant.defaultWidthTwenty),
                                  child: Text("Welcome to",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFDCDCDC),
                                          fontSize: FontSizeStatic.lg)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ScreenConstant.defaultWidthTen,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenConstant.defaultWidthTwenty),
                              child: Text(
                                "DEAR  MART",
                                style: TextStyle(
                                    fontSize: FontSizeStatic.xxl,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              height: ScreenConstant.defaultWidthTen,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenConstant.defaultWidthTwenty),
                              child: Row(
                                children: [
                                  Text(
                                    "Fresh Grocery Shopping",
                                    style: TextStyle(
                                        fontSize: FontSizeStatic.xl,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenConstant.sizeLarge,
                                  top: ScreenConstant.defaultWidthTwenty),
                              child: Row(
                                children: [
                                  Container(
                                    width: ScreenConstant.defaultHeightNinety,
                                    height:
                                        ScreenConstant.defaultHeightTwentyThree,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        // image: DecorationImage(
                                        //     image:
                                        //         AssetImage("assets/verified.png")),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: ScreenConstant
                                                  .defaultHeightEight),
                                          child: Image.asset(
                                              "assets/verified.png"),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text("Verified",
                                            style: TextStyle(
                                                fontSize: FontSizeStatic.sm,
                                                color: Colors.green)),
                                        PopupMenuButton<String>(
                                          itemBuilder: (BuildContext context) =>
                                              <PopupMenuEntry<String>>[
                                            PopupMenuItem<String>(
                                              value: 'Option 1',
                                              child: Text('Option 1'),
                                            ),
                                            PopupMenuItem<String>(
                                              value: 'Option 2',
                                              child: Text('Option 2'),
                                            ),
                                            PopupMenuItem<String>(
                                              value: 'Option 3',
                                              child: Text('Option 3'),
                                            ),
                                            PopupMenuItem<String>(
                                              value: 'Option 4',
                                              child: Text('Option 4'),
                                            ),
                                          ],
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(Icons.arrow_drop_down),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        ScreenConstant.defaultHeightTwentyThree,
                                  ),
                                  Container(
                                    height: 22,
                                    width: 85,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only()),
                                    child: Text("40 Mins"),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: ScreenConstant.defaultHeightTwentyeight,
                            ),
                            Center(
                              child: Container(
                                width: ScreenConstant.defaultSizeThreeTwenty,
                                height: ScreenConstant.defaultHeightFortyFive,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenConstant.defaultWidthTwenty,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: ScreenConstant.defaultWidthTwenty),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  width: ScreenConstant.defaultHeightSeventySix,
                                  height:
                                      ScreenConstant.defaultHeightTwentyThree,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(
                                        ScreenConstant.defaultWidthTwenty),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 2,
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
                                          width:
                                              ScreenConstant.defaultHeightFive,
                                        ),
                                        Container(
                                            width: ScreenConstant
                                                .defaultHeightEight,
                                            height:
                                                ScreenConstant.defaultWidthTen,
                                            child: Icon(
                                              Icons.filter,
                                              size: 10,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ScreenConstant.defaultWidthTen,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                width: ScreenConstant.defaultHeightSeventySix,
                                height: ScreenConstant.defaultHeightTwentyThree,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: ScreenConstant
                                                .defaultHeightTen),
                                        child: Text(
                                          'Sort by',
                                          style: TextStyle(
                                            fontSize: FontSizeStatic.sm,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenConstant.defaultHeightFive,
                                      ),
                                      Container(
                                        width:
                                            ScreenConstant.defaultWidthTwenty,
                                        height:
                                            ScreenConstant.defaultHeightFifteen,
                                        child: Icon(Icons.sort),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: ScreenConstant.defaultWidthTwenty,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                width: ScreenConstant.defaultWidthOneSeventy,
                                height: ScreenConstant.defaultHeightTwentyThree,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: ScreenConstant
                                                  .defaultWidthTen),
                                          child: TextField(
                                            decoration: InputDecoration(
                                                hintText: "Search Store",
                                                hintStyle: TextStyle(
                                                    fontSize:
                                                        FontSizeStatic.semiSm),
                                                border: InputBorder.none),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenConstant.defaultHeightFour,
                                      ),
                                      Icon(Icons.search),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenConstant.defaultWidthTen,
                    ),
                    Container(
                      height: 2,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: ScreenConstant.defaultHeightFiftyFive),
                    child: Container(
                      color: Color(0xFFFFFFFF),
                      height: ScreenConstant.defaultHeightFiveHundred,
                      width: ScreenConstant.defaultHeightOneHundred,
                      child: Column(
                        children: [
                          SizedBox(
                            height: ScreenConstant.defaultWidthTwenty,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: ScreenConstant.screenWidthFifteen),
                                child: Container(
                                    width:
                                        ScreenConstant.defaultHeightEightyTwo,
                                    height: ScreenConstant.defaultHeightForty,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 163, 238, 166),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              ScreenConstant
                                                  .defaultWidthTwenty),
                                          bottomRight: Radius.circular(
                                              ScreenConstant
                                                  .defaultWidthTwenty)),
                                    )),
                              ),
                              SizedBox(
                                height: ScreenConstant.defaultHeightEight,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: ScreenConstant.sizeLarge),
                                child: Text(
                                  "Best Picks",
                                  style: TextStyle(
                                      fontSize: FontSizeStatic.sm,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ),
                              SizedBox(
                                height: ScreenConstant.defaultHeightTwentyThree,
                              ),
                              Container(
                                width: ScreenConstant.defaultWidthSixty,
                                height: ScreenConstant.defaultWidthSixty,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 163, 238, 166),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  height:
                                      ScreenConstant.defaultHeightTwentyThree,
                                  width: ScreenConstant.defaultHeightThirtyFive,
                                  child: Center(
                                    child: Image.network(
                                      "https://www.starhealth.in/blog/wp-content/uploads/2022/03/Organic-food.jpg",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenConstant.defaultHeightEight,
                              ),
                              Container(
                                height: ScreenConstant.screenWidthTwelve,
                                width: ScreenConstant.defaultHeightFiftyFive,
                                child: Center(
                                  child: Text(
                                    "Organic & Healthy",
                                    style: TextStyle(
                                        fontSize: FontSizeStatic.sm,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenConstant.sizeXL),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: ScreenConstant.defaultSizeThreeTwenty),
                    child: Container(
                      height: ScreenConstant.defaultWidthOneSeventy,
                      width: ScreenConstant.defaultHeightOneThirty,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(
                            ScreenConstant.defaultHeightTen),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenConstant.defaultHeightTen),
                                child: Container(
                                  height: ScreenConstant.sizeMidLarge,
                                  width: ScreenConstant.sizeMidLarge,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.green, width: 2),
                                  ),
                                  child: Radio(
                                    activeColor: Colors.green,
                                    value: "",
                                    groupValue: "",
                                    onChanged: (value) => "",
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ScreenConstant.defaultHeightFortyFive,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    5, 0, 0, ScreenConstant.defaultHeightFour),
                                child: Container(
                                  height: ScreenConstant.sizeExtraLarge,
                                  width: ScreenConstant.defaultHeightFiftyFive,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(
                                            ScreenConstant.defaultWidthTen,
                                          ),
                                          topRight: Radius.circular(
                                              ScreenConstant.defaultWidthTen))
                                      // borderRadius: BorderRadius.circular(
                                      //     ScreenConstant.defaultHeightEight),
                                      ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              ScreenConstant.defaultHeightFive),
                                      child: Text(
                                        "20% off",
                                        style: TextStyle(
                                            fontSize: FontSizeStatic.sm,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: ScreenConstant.defaultHeightOneHundred,
                            width: ScreenConstant.defaultHeightOneHundred,
                            child: Image.network(
                                "https://images.unsplash.com/photo-1533450718592-29d45635f0a9?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8anBnfGVufDB8fDB8fHww"),
                          ),
                          Container(
                            height: ScreenConstant.sizeXL,
                            width: ScreenConstant.defaultIconSize,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 80, 207, 84)),
                              ),
                              child: Text(
                                "ADD +",
                                style: TextStyle(
                                    fontSize: FontSizeStatic.sm,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: ScreenConstant.defaultHeightFourHundred,
                height: ScreenConstant.defaultHeightFifty,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius:
                      BorderRadius.circular(ScreenConstant.defaultWidthTwenty),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: ScreenConstant.defaultHeightTwentyThree),
                  child: Row(
                    children: [
                      Text(
                        "View Cart",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSizeStatic.md,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: ScreenConstant.defaultHeightEight,
                      ),
                      Text(
                        "(Add ₹100 items more to get Free Delivery)",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSizeStatic.sm,
                        ),
                      ),
                      SizedBox(
                        width: ScreenConstant.defaultHeightEight,
                      ),
                      Container(
                        width: ScreenConstant.sizeXL,
                        height: ScreenConstant.sizeXL,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/pause.png"))),
                      )
                    ],
                  ),
                ),
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
                  width: ScreenConstant.defaultHeightTwentyThree,
                  child: Image.asset(
                    "assets/Vectorhome.png",
                  )),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  height: ScreenConstant.defaultHeightForty,
                  width: ScreenConstant.defaultHeightTwentyThree,
                  child: Image.asset(
                    "assets/myorders.png",
                  )),
              label: 'My Orders',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  height: ScreenConstant.defaultHeightForty,
                  width: ScreenConstant.defaultHeightTwentyThree,
                  child: Image.asset("assets/categories.png")),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  height: ScreenConstant.defaultHeightForty,
                  width: ScreenConstant.defaultHeightTwentyThree,
                  child: Image.asset("assets/cart.png")),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  height: ScreenConstant.defaultHeightForty,
                  width: ScreenConstant.defaultHeightTwentyThree,
                  child: Image.asset("assets/profile.png")),
              label: 'Profile',
            ),
          ],
        ));
  }
}
