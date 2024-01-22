import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/OrderListController/OrderListController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/NoResult.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Views/FilterScreen/FilterScreen.dart';
import 'package:go_potu_user/Widgets/DrawerWidget/DrawerFile.dart';
import 'package:go_potu_user/Widgets/OrdersWidgets/OrdersListingWidget.dart';
import 'package:skeletons/skeletons.dart';

class DrawerOrderListingScreen extends StatefulWidget {
  @override
  State<DrawerOrderListingScreen> createState() =>
      _DrawerOrderListingScreenState();
}

class _DrawerOrderListingScreenState extends State<DrawerOrderListingScreen> {
  final OrderListController _orderListController =
  Get.put(OrderListController());
  bool _isLoading = true;
  Future _refreshData() async {
    //await Future.delayed(Duration(seconds: 1));
    _orderListController.getOrderListPress(false, "");
  }

  @override
  void initState() {
    // TODO: implement initState
    //_simulateLoad();
    super.initState();
  }

  Future _simulateLoad() async {
    Future.delayed(Duration(milliseconds: 5000), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.ordersScreenBackground,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 40,
            ),
            onPressed: () {},
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: Text(
            AppStrings.myOrders,
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
        body: GetX<OrderListController>(initState: (state) {
          Get.find<OrderListController>().getOrderListPress(true, "");
        }, builder: (_) {
          return _orderListController.isLoading.value
              ? Container()
              : _orderListController.orderList.length < 1
              ? Container(
            child: Center(
                child: NoResult(
                  titleText: "Sorry no orders found!",
                  subTitle: "",
                )),
          )
              : RefreshIndicator(
            onRefresh: _refreshData,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: ScreenConstant.sizeXXXL,
                  child: AnimationLimiter(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount:
                      _orderListController.orderList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration:
                          const Duration(milliseconds: 1000),
                          child: FlipAnimation(
                            child: ScaleAnimation(
                              child: OrdersListingWidget(
                                index: index,
                                orderListData:
                                _orderListController.orderList,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  /*ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return OrdersListingWidget(index: index,);
                },
              ),*/
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    color: AppColors.secondary,
                    child: Padding(
                      padding:
                      EdgeInsets.all(ScreenConstant.sizeSmall),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 230,
                            height: 40,
                            child: Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 0),
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        FontSizeStatic.maxMd),
                                    side: BorderSide(
                                        color: Colors.grey),
                                  ),
                                  child: Container(
                                    height: 35,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 10.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText:
                                            'Search your orders',
                                            hintStyle: TextStyle(
                                                fontSize:
                                                FontSizeStatic
                                                    .md),
                                            border: InputBorder.none,
                                            suffixIcon: Padding(
                                              padding:
                                              EdgeInsets.only(
                                                  left: 22),
                                              child: Icon(
                                                Icons.search,
                                                size: ScreenConstant
                                                    .sizeXL,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: Container(
                              width: 150,
                              height: 40,
                              child: Expanded(
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(15.0),
                                    side: BorderSide(
                                        color: Colors.grey),
                                  ),
                                  child: Container(
                                    height: ScreenConstant
                                        .defaultHeightThirtyFive,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 9.0),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: FontSizeStatic.mdSm,
                                            bottom: 4),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Mart',
                                            hintStyle: TextStyle(
                                                fontSize: 14),
                                            border: InputBorder.none,
                                            suffixIcon: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: ScreenConstant
                                                      .screenWidthTwelve),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: ScreenConstant
                                                        .drawerIconSize),
                                                child: Icon(
                                                  Icons
                                                      .arrow_drop_down,
                                                  size: 35,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.red,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 35,
                color: Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                size: 35,
                color: Colors.black,
              ),
              label: 'My Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category_outlined,
                size: 35,
                color: Colors.black,
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.card_travel_outlined,
                color: Colors.black,
                size: 35,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_outlined,
                color: Colors.black,
                size: 35,
              ),
              label: 'Profile',
            ),
          ],
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
                              height: ScreenConstant.defaultHeightTen,
                              borderRadius: BorderRadius.circular(
                                  ScreenConstant.sizeDefault),
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

  showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: AppColors.secondary,
        isDismissible: true,
        context: context,
        builder: (context) {
          return FilterScreen();
        });
  }
}