import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/OrderListController/OrderListController.dart';
import 'package:skeletons/skeletons.dart';

import '../../DeviceManager/Assets.dart';
import '../../DeviceManager/Colors.dart';
import '../../DeviceManager/ScreenConstants.dart';
import '../../DeviceManager/TextStyles.dart';
import '../../GlobalConstants/StringConstants/Strings.dart';
import '../../Models/ResponseModels/OrderListResponseModel/OrderListResponseModel.dart';
import '../../Widgets/OrdersWidgets/OrdersListingWidget.dart';
import '../FilterScreen/FilterScreen.dart';
// ... Other imports ...

class OrderListingScreen extends StatefulWidget {
  @override
  State<OrderListingScreen> createState() => _OrderListingScreenState();
}

class _OrderListingScreenState extends State<OrderListingScreen> {
  final OrderListController _orderListController =
  Get.put(OrderListController());
  bool _isLoading = true;
  Future _refreshData() async {
    _orderListController.getOrderListPress(false, "");
  }
  TextEditingController searchController = TextEditingController();
  List<Order> filteredOrders = [];
  String selectedType = "Mart";
  @override
  void initState() {
    _simulateLoad();
    super.initState();
  }

  Future _simulateLoad() async {
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void filterOrders(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredOrders = _orderListController.orderList;
      } else {
        filteredOrders = _orderListController.orderList
            .where((order) => order.orderProducts!
            .any((product) =>
        product.product?.details?.name
            ?.toLowerCase()
            .contains(query.toLowerCase()) ??
            false))
            .toList();
      }
    });
  }
  void filterMartProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredOrders = _orderListController.orderList
            .where((order) => order.type == "Mart")
            .toList();
      } else {
        filteredOrders = _orderListController.orderList
            .where((order) =>
        order.type == "Mart" &&
            order.orderProducts!.any((product) =>
            product.product?.details?.name
                ?.toLowerCase()
                .contains(query.toLowerCase()) ??
                false))
            .toList();
      }
    });
  }

  void onTypeChanged(String newType) {
    setState(() {
      selectedType = newType;
      if (selectedType == 'Mart') {
        filterMartProducts(searchController.text);
      } else {
        // Handle filtering for other types if needed
        // ...
      }
    });
  }
  Widget _buildLeading(BuildContext context) {
    final ModalRoute<Object?>? modalRoute = ModalRoute.of(context);

    // Show back button only when there's a route to pop
    if (modalRoute?.canPop ?? false) {
      return IconButton(
        icon: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: ScreenConstant.sizeXL,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }

    // No route to pop, return an empty container to not show any leading widget
    return Container(width: 0, height: 0);
  }
  @override
  void dispose() {
    super.dispose();
    _orderListController.isLoading.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ordersScreenBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          AppStrings.myOrders,
          style: TextStyles.appBarTitle,
        ),
        actions: [
          Container(
            width: ScreenConstant.sizeMedium,
          ),
        ],
        leading: _buildLeading(context)
      ),
      body: GetX<OrderListController>(
        initState: (state) {
          Get.find<OrderListController>().getOrderListPress(true, "");
        },
        builder: (_) {
          return _orderListController.isLoading.value
              ? Container()
              : _orderListController.orderList.length < 1
              ? Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: ScreenConstant.sizeXXXL,
                child: Container(
                  color: AppColors.secondary,
                  child: Center(
                    child: Container(
                      width: ScreenConstant.screenHeightThird,
                      child: Image.asset(
                        Assets.noOrderFound,
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: filteredOrders.isNotEmpty
                          ? filteredOrders.length
                          : _orderListController.orderList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration:
                          const Duration(milliseconds: 1000),
                          child: FlipAnimation(
                            child: ScaleAnimation(
                              child: OrdersListingWidget(
                                index: index,
                                orderListData: filteredOrders.isNotEmpty
                                    ? filteredOrders
                                    : _orderListController.orderList,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    color: AppColors.secondary,
                    child: Padding(
                      padding: EdgeInsets.all(ScreenConstant.sizeSmall),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: ScreenConstant.defaultHeightThreeHundredFifty,
                            height: 45,
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(FontSizeStatic.maxMd),
                                side: BorderSide(color: Colors.grey),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10, right: 0, top: 10), // Adjusted top padding
                                      child: TextFormField(
                                        controller: searchController,
                                        onChanged: (query) => filterOrders(query),
                                        cursorWidth: 2.0,
                                        cursorHeight: 25, // Adjusted cursor height
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          hintText: 'Search your orders',
                                          hintStyle: TextStyle(fontSize: FontSizeStatic.md),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: () {
                                      // Add search functionality here
                                    },
                                  ),
                                ],
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
        },
      ),
    );
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
