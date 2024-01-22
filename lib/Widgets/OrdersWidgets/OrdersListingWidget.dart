import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/OrderListController/OrderListController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/DateTimeConverter.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Models/ResponseModels/GetMyBucketResponseModel/GetMyBucketResponseModel.dart';
import 'package:go_potu_user/Models/ResponseModels/OrderListResponseModel/OrderListResponseModel.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';

import '../../Views/TrackingScreen/Tracking.dart';
import 'OrderListWidgetProductListWidget.dart';

class OrdersListingWidget extends StatelessWidget {
  final int? index;
  final List<Order>? orderListData;

  OrdersListingWidget({this.index, this.orderListData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenConstant.sizeXL),
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(
            left: ScreenConstant.sizeMedium,
            right: ScreenConstant.sizeMedium,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius:
                  BorderRadius.circular(ScreenConstant.defaultHeightTen),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: ScreenConstant.sizeMedium),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Item: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizeStatic.md,
                            ),
                          ),
                          Container(
                            width: 150,
                            child: Text(
                              orderListData![index!]
                                  .orderProducts!
                                  .map((product) =>
                              product.product?.details?.name ?? "")
                                  .join(', ') ??
                                  "",
                              style: TextStyle(fontSize: FontSizeStatic.mdSm),
                              overflow: TextOverflow.ellipsis,
                            ),

                          ),
                        ],
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenConstant
                                .sizeMedium, // Adjust this value as needed
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              final OrderListController _orderListController =
                                  Get.find();
                              _orderListController.orderId.value =
                                  orderListData![index!].id.toString();
                              Get.to(TrcakingScreen1());
                              // print(orderListData![index!].orderProducts);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.primary,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      ScreenConstant.sizeSmall)),
                            ),
                            child: Text(
                              "Track Order",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: FontSizeStatic.mdSm,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenConstant.sizeMedium,
                ),
                Padding(
                  padding: EdgeInsets.only(left: ScreenConstant.sizeMedium),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.orderId + ": ",
                        // style: TextStyles.orderIdTitle,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: FontSizeStatic.md),
                      ),
                      Text(
                        orderListData![index!].code.toString() ?? "",
                        style: TextStyle(fontSize: FontSizeStatic.mdSm),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenConstant.sizeMedium,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenConstant.sizeMedium),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Order Status - ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: FontSizeStatic.md),
                          ),
                          Text(
                            orderListData![index!].status == "outfordelivery"
                                ? "OUT FOR DELIVERY"
                                : orderListData![index!].status!.toUpperCase(),
                            style: TextStyle(
                                fontSize: FontSizeStatic.mdSm,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Order Total: ",
                            style: TextStyle(
                                fontSize: FontSizeStatic.md,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "₹${orderListData![index!].payableAmount!}",
                            // style: TextStyles.orderId,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: FontSizeStatic.mdSm,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenConstant.sizeMedium,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final OrderListController _orderListController =
                              Get.find();
                          _orderListController.orderId.value =
                              orderListData![index!].id.toString();
                          Get.toNamed(orderDetails);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            side: BorderSide
                                .none, // Add this line to remove the top border
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(ScreenConstant.sizeMedium),
                          child: Text("View Details"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
