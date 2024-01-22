import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';

import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';

class My_Favourite extends StatefulWidget {
  const My_Favourite({Key? key}) : super(key: key);

  @override
  State<My_Favourite> createState() => _My_FavouriteState();
}

class _My_FavouriteState extends State<My_Favourite> {
  List<String> listItem = ["Relevance (Default)", "Delivery Time", "Rating"];

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
            "My Favourite",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: ScreenConstant.defaultHeightTwoHundredTen,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/Rectangle 1345.png"),
                        fit: BoxFit.cover)),
                child: Container(
                  width: ScreenConstant.defaultHeightOneHundred,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: ScreenConstant.defaultHeightNinetyEight,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: ScreenConstant.defaultWidthOneEighty),
                          child: Container(
                            width: ScreenConstant.defaultHeightOneHundredNighty,
                            height: ScreenConstant.defaultHeightSeventySix,
                            child: Text(
                              "We are aware that you love it!",
                              style: TextStyle(
                                  fontSize: FontSizeStatic.xxl,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: ScreenConstant.defaultHeightSixtyEight),
                          child: Container(
                            width: ScreenConstant.defaultHeightTwoHundredTen,
                            child: Text(
                              "like never before as you search your preferred grocers, restaurants, and meat.",
                              style: TextStyle(
                                  fontSize: FontSizeStatic.sm,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: ScreenConstant.defaultWidthTen),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenConstant.defaultHeightFifteen),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                context: context,
                                builder: (context) => buildSheet1());
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  width: ScreenConstant.defaultHeightSeventy,
                                  height:
                                      ScreenConstant.defaultHeightTwentyThree,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(
                                        ScreenConstant.defaultWidthTwenty),
                                    border: Border.all(
                                      color: Colors.black,
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
                                          height: ScreenConstant
                                              .defaultHeightTwentyThree,
                                          child: Image.asset(
                                            "assets/Group 65.png",
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ScreenConstant.defaultWidthTen,
                      ),
                      Column(
                        children: [
                          Container(
                            width: ScreenConstant.defaultHeightSeventy,
                            height: ScreenConstant.defaultHeightTwentyThree,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: DropdownButton(
                                underline: Container(),
                                icon: Container(
                                    height: ScreenConstant.screenWidthFifteen,
                                    child: Container(
                                        width:
                                            ScreenConstant.defaultWidthTwenty,
                                        height:
                                            ScreenConstant.screenWidthFifteen,
                                        child:
                                            Image.asset("assets/sort by.png"))),
                                hint: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenConstant.defaultWidthTen),
                                      child: Text(
                                        "Sort By",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: FontSizeStatic.sm,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                isExpanded: true,
                                items: listItem.map((valueItem) {
                                  return DropdownMenuItem(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            valueItem.toString(),
                                            style: TextStyle(
                                              fontSize: FontSizeStatic.sm,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Radio(
                                            value: "",
                                            groupValue: "",
                                            onChanged: (value) {},
                                          )
                                        ],
                                      ),
                                    ),
                                    value: valueItem,
                                  );
                                }).toList(),
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        ],
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
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenConstant
                                              .defaultHeightEight),
                                      child: Text(
                                        'Ratings 4.0+',
                                        style: TextStyle(
                                          fontSize: FontSizeStatic.sm,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenConstant.defaultHeightFive,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: ScreenConstant.defaultHeightTen,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: ScreenConstant.defaultHeightOneHundred,
                              height: ScreenConstant.defaultHeightTwentyThree,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        height: 7,
                                        width: 7,
                                        child: Radio(
                                          value: "",
                                          groupValue: "",
                                          onChanged: (value) {},
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenConstant.defaultHeightTen,
                                    ),
                                    Text(
                                      'Pure Veg',
                                      style: TextStyle(
                                        fontSize: FontSizeStatic.sm,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {},
                                        child:
                                            Icon(Icons.arrow_drop_down_sharp))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: ScreenConstant.defaultWidthTen,
              ),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenConstant.defaultHeightTwentyThree),
                child: Row(
                  children: [
                    Container(
                      height: ScreenConstant.defaultHeightOneHundredTen,
                      width: ScreenConstant.defaultHeightNinety,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTg7lNCopQ15sXBm0iUrilZm9xe0DUHDTn6fA&usqp=CAU")),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: ScreenConstant.defaultHeightFifty,
                            bottom: ScreenConstant.defaultHeightThirtyFive),
                        child: Icon(
                          Icons.favorite_outline,
                          size: FontSizeStatic.xxxl,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //  padding: EdgeInsets.only(left: 20, bottom: 55),
                    Padding(
                      padding: EdgeInsets.only(
                          left: ScreenConstant.defaultWidthTwenty,
                          top: ScreenConstant.defaultHeightFour),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kwality Walls Frozen ...",
                            style: TextStyle(
                                fontSize: FontSizeStatic.maxMd,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: ScreenConstant.defaultHeightTen,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: ScreenConstant.sizeExtraLarge),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("⭐",
                                    style: TextStyle(
                                        fontSize: FontSizeStatic.maxMd,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: ScreenConstant.defaultHeightEight,
                                ),
                                Text(
                                  "4.5",
                                  style: TextStyle(
                                      fontSize: FontSizeStatic.maxMd,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: ScreenConstant.defaultHeightEight,
                                ),
                                Text(
                                  "(500+)",
                                  style: TextStyle(
                                      fontSize: FontSizeStatic.maxMd,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: ScreenConstant.defaultHeightThirtyFive,
                                ),
                                Container(
                                  height: 16,
                                  width: 17,
                                  child: Image.network(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShbZdF9uX6CKJUCn_LIVmh8-j8jZ79lgdUAatkKgwN9EENzw8IqDtn0PWAEu04g4KHqkE&usqp=CAU"),
                                ),
                                SizedBox(
                                  width: ScreenConstant.defaultHeightFifteen,
                                ),
                                Text(
                                  "52 mins",
                                  style: TextStyle(
                                      fontSize: FontSizeStatic.maxMd,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ScreenConstant.defaultHeightEight,
                          ),
                          Container(
                            width: ScreenConstant
                                .defaultHeightTwoHundredThirtyFive,
                            child: Text(
                              "Desserts  Ice Cream, Ice Cream...",
                              style: TextStyle(
                                fontSize: FontSizeStatic.maxMd,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenConstant.defaultHeightFour,
                          ),
                          Text("Saltlake 0.4km")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
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
                    "assets/Vector.png",
                  )),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  height: ScreenConstant.defaultHeightForty,
                  width: ScreenConstant.defaultHeightTwentyfive,
                  child: Image.asset(
                    "assets/file-text.png",
                  )),
              label: 'My Orders',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  height: ScreenConstant.defaultHeightForty,
                  width: ScreenConstant.defaultHeightTwentyfive,
                  child: Image.asset("assets/category 1.png")),
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

buildSheet1() {
  return Container(
    height: ScreenConstant.defaultHeightSevenHundred,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: ScreenConstant.defaultHeightTwentyfive,
        ),
        Padding(
          padding:
              EdgeInsets.only(left: ScreenConstant.defaultHeightTwentyThree),
          child: Row(
            children: [
              Text(
                "Filter",
                style: TextStyle(
                    fontSize: FontSizeStatic.xl, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: ScreenConstant.defaultSizeTwoFifty,
              ),
              TextButton(
                child: Text(
                  "X",
                  style: TextStyle(
                      fontSize: FontSizeStatic.lg,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: (() {}),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 2,
        ),
        SizedBox(height: ScreenConstant.defaultWidthTwenty),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenConstant.defaultHeightFifteen),
                  child: Row(
                    children: [
                      Text(
                        "Sort",
                        style: TextStyle(
                            fontSize: FontSizeStatic.lg,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenConstant.defaultHeightThirtyFive,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenConstant.defaultHeightFifteen),
                  child: Text(
                    "Veg/Non-Veg",
                    style: TextStyle(
                      fontSize: FontSizeStatic.lg,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenConstant.defaultHeightThirtyFive,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenConstant.defaultHeightFifteen),
                  child: Text(
                    "Rating",
                    style: TextStyle(
                      fontSize: FontSizeStatic.lg,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            VerticalDivider(
              thickness: 4,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: ScreenConstant.defaultHeightSeventy),
                  child: Text(
                    "SORT BY",
                    style: TextStyle(
                        fontSize: FontSizeStatic.sm,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: ScreenConstant.defaultWidthTen,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(right: ScreenConstant.defaultWidthTen),
                  child: Row(
                    children: [
                      Container(
                        height: ScreenConstant.defaultWidthTwenty,
                        width: ScreenConstant.defaultWidthTwenty,
                        child: Radio(
                          value: "",
                          groupValue: "",
                          onChanged: (value) {},
                        ),
                      ),
                      Text(
                        "Relavence",
                        style: TextStyle(
                            fontSize: FontSizeStatic.lg,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenConstant.defaultWidthTwenty,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: ScreenConstant.defaultWidthTen),
                  child: Row(
                    children: [
                      Container(
                        height: ScreenConstant.defaultWidthTwenty,
                        width: ScreenConstant.defaultWidthTwenty,
                        child: Radio(
                          value: "",
                          groupValue: "",
                          onChanged: (value) {},
                        ),
                      ),
                      Text(
                        "Delivery Time",
                        style: TextStyle(
                            fontSize: FontSizeStatic.lg,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenConstant.defaultWidthTwenty,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 48),
                  child: Row(
                    children: [
                      Container(
                        height: ScreenConstant.defaultWidthTwenty,
                        width: ScreenConstant.defaultWidthTwenty,
                        child: Radio(
                          value: "",
                          groupValue: "",
                          onChanged: (value) {},
                        ),
                      ),
                      Text(
                        "Rating",
                        style: TextStyle(
                            fontSize: FontSizeStatic.lg,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: ScreenConstant.defaultHeightThreeHundredFortyEight,
        ),
        Container(
          color: AppColors.secondary,
          height: ScreenConstant.defaultHeightNinety,
          child: Column(
            children: [
              Container(
                height: ScreenConstant.sizeSmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: ScreenConstant.sizeExtraSmall,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenConstant.defaultWidthTwenty),
                        child: Text(
                          "Clear Filter",
                          style: TextStyle(
                              fontSize: FontSizeStatic.xxl,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: ScreenConstant.screenWidthFifteen),
                      child: Container(
                          height: ScreenConstant.defaultHeightForty,
                          width: ScreenConstant.defaultHeightOneForty,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey),
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Apply",
                                style: TextStyle(
                                    fontSize: FontSizeStatic.xl,
                                    color: Colors.black),
                              ))))
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
