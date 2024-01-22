import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/NotificationController/NotificationController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/NoResult.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Widgets/NotificationListWidget/NotificationListWidget.dart';

import '../../Controller/OrderListController/OrderListController.dart';
import '../../DeviceManager/ScreenConstants.dart';
import '../../Models/ResponseModels/OrderListResponseModel/OrderListResponseModel.dart';
import '../../Router/RouteConstants.dart';

class NotificationScreen extends StatelessWidget {
   final int? index;
   final List<Order>? orderListData;
  NotificationScreen({this.index, this.orderListData});
  final NotificationController _notificationController =
      Get.put(NotificationController());



  Future _refreshData() async {
    //await Future.delayed(Duration(seconds: 1));
    _notificationController.getNotificationListPress(false);
  }

  @override
  Widget build(BuildContext context) {
    print("dskjjkasdj${orderListData}");
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        _notificationController.isLoading.value = true;
        Get.back();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Color(0xFFf9f9f9),
        appBar: AppBar(
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
          centerTitle: false,
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: Text(
            AppStrings.Notifications,
            style: TextStyles.appBarTitle,
          ),
        ),
        body: GetX<NotificationController>(initState: (state) {
          Get.find<NotificationController>().getNotificationListPress(true);
        }, builder: (_) {
          return _notificationController.isLoading.value
              ? Container()
              : _notificationController.notificationList.length < 1
                  ? Container(
                      child: Center(
                          child: NoResult(
                        titleText: "Sorry no notification found!",
                        subTitle: "",
                      )),
                    )
                  : RefreshIndicator(
                      onRefresh: _refreshData,
                      child: AnimationLimiter(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount:
                              _notificationController.notificationList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 1000),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(

                                  child: GestureDetector(

                                    onTap: () {
                                      final OrderListController _orderListController =
                                      Get.find();
                                      _orderListController.orderId.value =
                                          orderListData![index!].id.toString();

                                      Get.toNamed(orderDetails);
                                    },

                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: NotificationListWidget(
                                        index: index,
                                        notificationListData:
                                            _notificationController
                                                .notificationList,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
        }),
      ),
    );
  }
}
