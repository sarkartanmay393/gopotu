import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';

import '../../Controller/OrderListController/OrderListController.dart';
import '../../DeviceManager/Assets.dart';
import '../../DeviceManager/Colors.dart';
import '../../DeviceManager/DateTimeConverter.dart';
import '../../DeviceManager/TextStyles.dart';
import '../../GlobalConstants/StringConstants/Strings.dart';
import 'OrderDetailsScreen.dart';

class RefundAndReturnDetailsScreen extends StatelessWidget {
  RefundAndReturnDetailsScreen({Key? key}) : super(key: key);

  OrderListController _orderListController = Get.find();
  String getColorText(int index) {
    final variantSelected = _orderListController.returnRefundDetailsData.value
        .returnreplacementItems?[index].orderproduct!.variantSelected;

    final colorNam = variantSelected?.colorName;

    return "COLOR: ${colorNam?.toUpperCase() ?? ''}";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        _orderListController.isDetailsLoading.value = true;
        Get.back();
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.primary,
            elevation: 0,
            title: Text(
              "Return/Replace Details",
              style: TextStyles.appBarTitle,
            ),
          ),
          body: GetX<OrderListController>(initState: (state) {
            Get.find<OrderListController>().getReturnRefundDetailsPress(true);
          }, builder: (_) {
            return _orderListController.isDetailsLoading.value
                ? Container()
                : _orderListController.returnRefundDetailsData.value.id == null
                    ? Container()
                    : ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Text(
                                  "Order ID: ",
                                  style: TextStyle(
                                    color: AppColors.searchLevelText,
                                    fontSize: FontSizeStatic.maxMd,
                                    fontFamily: 'Proxima-Regular',
                                  ),
                                ),
                                Text(
                                  _orderListController
                                          .returnRefundDetailsData.value.code ??
                                      "",
                                  style: TextStyle(
                                    color: AppColors.searchLevelText,
                                    fontSize: FontSizeStatic.maxMd,
                                    fontFamily: 'Proxima-Regular',
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: _orderListController
                                  .returnRefundDetailsData
                                  .value
                                  .returnreplacementItems!
                                  .length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _orderListController
                                                        .returnRefundDetailsData
                                                        .value
                                                        .returnreplacementItems![
                                                            index]
                                                        .orderproduct!
                                                        .product!
                                                        .details!
                                                        .name ??
                                                    "",
                                                style: TextStyle(
                                                  color: AppColors.accentColor,
                                                  fontSize: FontSizeStatic.lg,
                                                  fontFamily: 'Proxima-Regular',
                                                ),
                                              ),
                                              _orderListController
                                                          .returnRefundDetailsData
                                                          .value
                                                          .returnreplacementItems![
                                                              index]
                                                          .orderproduct!
                                                          .variantSelected!
                                                          .variantName ==
                                                      ""
                                                  ? Offstage()
                                                  : Container(
                                                      height: ScreenConstant
                                                          .sizeExtraSmall,
                                                    ),
                                              _orderListController
                                                          .returnRefundDetailsData
                                                          .value
                                                          .returnreplacementItems![
                                                              index]
                                                          .orderproduct!
                                                          .variantSelected!
                                                          .variantName ==
                                                      ""
                                                  ? Offstage()
                                                  : Text(
                                                      _orderListController
                                                              .returnRefundDetailsData
                                                              .value
                                                              .returnreplacementItems![
                                                                  index]
                                                              .orderproduct!
                                                              .variantSelected!
                                                              .variantName ??
                                                          "",
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .searchLevelText,
                                                        fontSize:
                                                            FontSizeStatic.md,
                                                        fontFamily:
                                                            'Proxima-Regular',
                                                      ),
                                                    ),
                                              _orderListController
                                                          .returnRefundDetailsData
                                                          .value
                                                          .returnreplacementItems![
                                                              index]
                                                          .orderproduct!
                                                          .variantSelected!
                                                          .colorName ==
                                                      ""
                                                  ? Offstage()
                                                  : Container(
                                                      height: ScreenConstant
                                                          .sizeExtraSmall,
                                                    ),
                                              _orderListController
                                                          .returnRefundDetailsData
                                                          .value
                                                          .returnreplacementItems![
                                                              index]
                                                          .orderproduct!
                                                          .variantSelected!
                                                          .colorName ==
                                                      ""
                                                  ? Offstage()
                                                  : Text(
                                                      getColorText(index),
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .searchLevelText,
                                                        fontSize:
                                                            FontSizeStatic.md,
                                                        fontFamily:
                                                            'Proxima-Regular',
                                                      ),
                                                    ),
                                              _orderListController
                                                          .returnRefundDetailsData
                                                          .value
                                                          .returnreplacementItems![
                                                              index]
                                                          .orderproduct!
                                                          .variantSelected!
                                                          .colorName ==
                                                      ""
                                                  ? Offstage()
                                                  : Container(
                                                      height: ScreenConstant
                                                          .sizeSmall,
                                                    ),
                                              Text(
                                                "SELLER: ${_orderListController.returnRefundDetailsData.value.returnreplacementItems![index].orderproduct?.product?.details?.brand?.name ?? ""}",
                                                style: TextStyle(
                                                  color:
                                                      AppColors.searchLevelText,
                                                  fontSize: FontSizeStatic.md,
                                                  fontFamily: 'Proxima-Regular',
                                                ),
                                              ),
                                              Container(
                                                height:
                                                    ScreenConstant.sizeLarge,
                                              ),
                                              Text(
                                                "Rs. ${double.parse(_orderListController.returnRefundDetailsData.value.returnreplacementItems![index].orderproduct!.subTotal.toString()).toStringAsFixed(2)}",
                                                style: TextStyle(
                                                  color: AppColors.accentColor,
                                                  fontSize: FontSizeStatic.xl,
                                                  fontWeight: FontWeight.bold,
                                                  /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                                      'Poppins',
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: CachedNetworkImage(
                                                imageUrl: _orderListController
                                                        .returnRefundDetailsData
                                                        .value
                                                        .returnreplacementItems![
                                                            index]
                                                        .orderproduct!
                                                        .product!
                                                        .details!
                                                        .imagePath ??
                                                    "https://corp.sellerscommerce.com//SCAssets/images/noimage.png",
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                        Assets.loadingImageGif),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.network(
                                                        "https://corp.sellerscommerce.com//SCAssets/images/noimage.png"),
                                                height: ScreenConstant
                                                    .defaultHeightOneHundred,
                                                width: ScreenConstant
                                                    .defaultHeightOneHundred,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Container(
                                              height: ScreenConstant.sizeSmall,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColors
                                                          .searchLevelText),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  "Quantity : ${_orderListController.returnRefundDetailsData.value.returnreplacementItems![index].orderproduct!.quantity.toString()}",
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.accentColor,
                                                    fontSize:
                                                        FontSizeStatic.semiSm,
                                                    fontWeight: FontWeight.bold,
                                                    /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                                        'Poppins',
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: ScreenConstant.sizeSmall,
                                    ),
                                    index ==
                                            _orderListController
                                                    .returnRefundDetailsData
                                                    .value
                                                    .returnreplacementItems!
                                                    .length -
                                                1
                                        ? Offstage()
                                        : Divider(
                                            thickness: 2,
                                          )
                                  ],
                                );
                              },
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Container(
                            //height: ScreenConstant.defaultHeightTwoHundredFifty,
                            color: Colors.white,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: _orderListController
                                      .returnRefundDetailsData
                                      .value
                                      .statusLog!
                                      .length,
                                  itemBuilder: (context, ind) {
                                    return DeliveryTrackerSteps(
                                      isFirst: ind == 0 ? true : false,
                                      isLast: ind ==
                                              _orderListController
                                                      .returnRefundDetailsData
                                                      .value
                                                      .statusLog!
                                                      .length -
                                                  1
                                          ? true
                                          : false,
                                      indicatorStyle: _orderListController
                                                  .returnRefundDetailsData
                                                  .value
                                                  .statusLog![ind]
                                                  .timestamp !=
                                              null
                                          ? IndicatorStyles.completedIndicator
                                          : IndicatorStyles.incompleteIndicator,
                                      afterLineStyle: _orderListController
                                                  .returnRefundDetailsData
                                                  .value
                                                  .statusLog![ind]
                                                  .timestamp !=
                                              null
                                          ? IndicatorStyles
                                              .completedAfterLineStyle
                                          : IndicatorStyles
                                              .incompleteAfterLineStyle,
                                      beforeLineStyle: _orderListController
                                                  .returnRefundDetailsData
                                                  .value
                                                  .statusLog![ind]
                                                  .timestamp !=
                                              null
                                          ? IndicatorStyles
                                              .completedAfterLineStyle
                                          : IndicatorStyles
                                              .incompleteAfterLineStyle,
                                      data: ListTile(
                                        minVerticalPadding: 27,
                                        title: Text(
                                          _orderListController
                                              .returnRefundDetailsData
                                              .value
                                              .statusLog![ind]
                                              .label
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: _orderListController
                                                    .returnRefundDetailsData
                                                    .value
                                                    .statusLog![ind]
                                                    .timestamp !=
                                                null
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  "${DateTimeUtility().parse(dateTime: _orderListController.returnRefundDetailsData.value.statusLog?[ind].timestamp.toString(), returnFormat: "EEE, d MMM yyyy")}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          Colors.grey.shade500),
                                                ),
                                              )
                                            : Offstage(),
                                      ),
                                    );
                                  },
                                )),
                          )
                        ],
                      );
          })),
    );
  }
}
