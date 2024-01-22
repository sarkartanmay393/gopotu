import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/OrderListController/OrderListController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';

class FilterScreen extends StatelessWidget {
  final OrderListController _orderListController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            Container(
              height: ScreenConstant.sizeMedium,
            ),
            Text(
              "Filter Your Order List",
              style: TextStyles.filterTitle,
            ),
            Container(
              height: ScreenConstant.sizeExtraLarge,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                _orderListController.getOrderListPress(true, "");
              },
              child: Row(
                children: [
                  Container(
                    height: ScreenConstant.sizeMedium,
                    width: ScreenConstant.sizeMedium,
                    child: Image(
                      color: AppColors.filterBox,
                      fit: BoxFit.fitHeight,
                      image: AssetImage(
                        Assets.filterIcon,
                      ),
                    ),
                  ),
                  Container(
                    width: ScreenConstant.sizeMedium,
                  ),
                  Text(
                    "Show All Orders",
                    style: TextStyles.filterContain,
                  ),
                ],
              ),
            ),
            /*Container(
              height: ScreenConstant.sizeExtraLarge,
            ),
            Row(
              children: [
                Container(
                  height: ScreenConstant.sizeMedium,
                  width: ScreenConstant.sizeMedium,
                  child: Image(
                    color: AppColors.filterBox,
                    fit: BoxFit.fitHeight,
                    image: AssetImage(
                      Assets.filterIcon,
                    ),),
                ),
                Container(
                  width: ScreenConstant.sizeMedium,
                ),
                Text("Under process Orders",style: TextStyles.filterContain,),
              ],
            ),
            Container(
              height: ScreenConstant.sizeExtraLarge,
            ),
            Row(
              children: [
                Container(
                  height: ScreenConstant.sizeMedium,
                  width: ScreenConstant.sizeMedium,
                  child: Image(
                    color: AppColors.filterBox,
                    fit: BoxFit.fitHeight,
                    image: AssetImage(
                      Assets.filterIcon,
                    ),),
                ),
                Container(
                  width: ScreenConstant.sizeMedium,
                ),
                Text("Out of delivery orders",style: TextStyles.filterContain,),
              ],
            ),*/
            Container(
              height: ScreenConstant.sizeExtraLarge,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                _orderListController.getOrderListPress(true, "delivered");
              },
              child: Row(
                children: [
                  // Container(
                  //   height: ScreenConstant.sizeMedium,
                  //   width: ScreenConstant.sizeMedium,
                  //   child: Image(
                  //     color: AppColors.filterBox,
                  //     fit: BoxFit.fitHeight,
                  //     image: AssetImage(
                  //       Assets.filterIcon,
                  //     ),
                  //   ),
                  // ),
                  Container(
                    width: ScreenConstant.sizeMedium,
                  ),
                  Text(
                    "Delivered orders",
                    style: TextStyles.filterContain,
                  ),
                ],
              ),
            ),
            Container(
              height: ScreenConstant.sizeExtraLarge,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                _orderListController.getOrderListPress(true, "cancelled");
              },
              child: Row(
                children: [
                  Container(
                    height: ScreenConstant.sizeMedium,
                    width: ScreenConstant.sizeMedium,
                    child: Image(
                      color: AppColors.filterBox,
                      fit: BoxFit.fitHeight,
                      image: AssetImage(
                        Assets.filterIcon,
                      ),
                    ),
                  ),
                  Container(
                    width: ScreenConstant.sizeMedium,
                  ),
                  Text(
                    "Cancelled Orders",
                    style: TextStyles.filterContain,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
