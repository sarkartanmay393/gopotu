import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_potu_user/Controller/ProductController/ProductController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Models/ResponseModels/OrderListResponseModel/OrderListResponseModel.dart';

import '../../DeviceManager/Colors.dart';

class OrderListWidgetProductListWidget extends StatelessWidget {
  final bool? dividerPosition;

  final String? productImage;
  final String? productQuantity;
  final String? productName;
  final int? productPrice;
  final int? index;
  final int? listLength;
  final String? productVarient;
  final String? productColor;

  OrderListWidgetProductListWidget(
      {this.dividerPosition,
      this.productName,
      this.productQuantity,
      this.productImage,
      this.productPrice,
      this.index,
      this.listLength,
      this.productColor,
      this.productVarient});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      dividerPosition!
          ? Divider(
              thickness: 2,
            )
          : Offstage(),
      Padding(
        padding: EdgeInsets.only(left: 5.0, top: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: productImage ??
                      "https://corp.sellerscommerce.com//SCAssets/images/noimage.png",
                  placeholder: (context, url) =>
                      Image.asset(Assets.loadingImageGif),
                  errorWidget: (context, url, error) => Image.network(
                      "https://corp.sellerscommerce.com//SCAssets/images/noimage.png"),
                  height: ScreenConstant.defaultHeightSeventy,
                  width: ScreenConstant.defaultHeightSeventy,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  width: ScreenConstant.sizeSmall,
                ),
                Container(
                  width: 52,
                  child: Text(
                    "$productName",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            // Text(
            //   "50",
            //   style: TextStyle(
            //       fontSize: 14, decoration: TextDecoration.lineThrough),
            // ),
            Text(
              "Rs. ${productPrice!.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ]);
  }
}
