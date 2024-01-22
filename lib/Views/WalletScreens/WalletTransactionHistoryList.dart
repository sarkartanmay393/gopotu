import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/MyWalletController/MyWalletController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/DateTimeConverter.dart';
import 'package:go_potu_user/DeviceManager/NoResult.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WalletTransactionHistoryList extends StatefulWidget {
  @override
  State<WalletTransactionHistoryList> createState() =>
      _WalletTransactionHistoryListState();
}

class _WalletTransactionHistoryListState
    extends State<WalletTransactionHistoryList> {
  final MyWalletController _myWalletController = Get.put(MyWalletController());
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _myWalletController.selectedFirstDate.value = DateTime.now();
    _myWalletController.selectedSecondDate.value = DateTime.now();
    _myWalletController.getWalletTransactionListPress(false);
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myWalletController.selectedFirstDate.value =
        DateTime(DateTime.now().year, DateTime.now().month, 1);
    _myWalletController.selectedSecondDate.value = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        _myWalletController.isWalletHistoryLoading.value = true;
        Get.back();
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: AppColors.secondary,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.primary,
            elevation: 0,
            title: Text(
              "Wallet Transactions",
              style: TextStyles.appBarTitle,
            ),
          ),
          body: GetX<MyWalletController>(initState: (state) {
            Get.find<MyWalletController>().getWalletTransactionListPress(true);
          }, builder: (_) {
            return SmartRefresher(
              enablePullDown: true,
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  Container(
                    height: ScreenConstant.sizeLarge,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Transaction History",
                          style: TextStyle(
                            fontSize: FontSizeStatic.lg,
                            color: Color(0xFF1D1D1D),
                            /* fontFamily: 'Proxima-Regular' */ fontFamily:
                                'Poppins',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            openBottomSheet();
                          },
                          child: Container(
                            height: ScreenConstant.sizeXL,
                            width: ScreenConstant.sizeXL,
                            child: Image.asset(
                              Assets.sort,
                              color: AppColors.buttonColorSecondary,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _myWalletController.walletTransactionList.length < 1
                      ? Container(
                          height: ScreenConstant.sizeXXL,
                        )
                      : Container(
                          height: ScreenConstant.sizeLarge,
                        ),
                  _myWalletController.isWalletHistoryLoading.value
                      ? Container()
                      : _myWalletController.walletTransactionList.length < 1
                          ? Container(
                              child: Center(
                                  child: NoResult(
                                titleText: "Sorry no history found!",
                                subTitle: "",
                              )),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: _myWalletController
                                  .walletTransactionList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenConstant.sizeMedium,
                                      vertical: ScreenConstant.sizeSmall),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.secondary,
                                        border: Border.all(
                                            color: Color(0xFFD5DBE1),
                                            width: 1)),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(5),
                                                    topLeft:
                                                        Radius.circular(5)),
                                                color: _myWalletController
                                                                .walletTransactionList[
                                                            index]['trans_type'] ==
                                                        "credit"
                                                    ? Color(0xFFD8FCDD)
                                                    : Color(0xFFFFCFD4),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  _myWalletController
                                                      .walletTransactionList[
                                                          index]['trans_type']
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: _myWalletController
                                                                      .walletTransactionList[
                                                                  index]
                                                              ['trans_type'] ==
                                                          "credit"
                                                      ? TextStyle(
                                                          fontSize:
                                                              FontSizeStatic
                                                                  .semiSm,
                                                          color:
                                                              Color(0xFF007D04),
                                                          fontFamily:
                                                              'Proxima-Regular',
                                                        )
                                                      : TextStyle(
                                                          fontSize:
                                                              FontSizeStatic
                                                                  .semiSm,
                                                          color:
                                                              Color(0xFFCF2031),
                                                          fontFamily:
                                                              'Proxima-Regular',
                                                        ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                              child: Text(
                                                "Rs. ${_myWalletController.walletTransactionList[index]["amount"].toString()}",
                                                style: TextStyle(
                                                  fontSize:
                                                      FontSizeStatic.semiSm,
                                                  color: Color(0xFF1D1D1D),
                                                  /* fontFamily: 'Proxima-Regular' */ fontFamily:
                                                      'Poppins',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        /*Container(
                                      height: ScreenConstant.sizeSmall,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: ScreenConstant.sizeExtraSmall,
                                        ),
                                        Text(
                                          "${_myWalletController.payoutRequestListData[index].code.toString().toUpperCase()}",
                                          style: TextStyle(
                                            fontSize: FontSize.semiSm,
                                            color: Color(0xFF1D1D1D),
                                            /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),*/
                                        Container(
                                          height: ScreenConstant.sizeSmall,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width:
                                                  ScreenConstant.sizeExtraSmall,
                                            ),
                                            Flexible(
                                              child: Text(
                                                "${_myWalletController.walletTransactionList[index]["remarks"].toString()}",
                                                style: TextStyle(
                                                  fontSize:
                                                      FontSizeStatic.semiSm,
                                                  color: Color(0xFF1D1D1D),
                                                  /* fontFamily: 'Proxima-Regular' */ fontFamily:
                                                      'Poppins',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: ScreenConstant.sizeMedium,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width:
                                                  ScreenConstant.sizeExtraSmall,
                                            ),
                                            Text(
                                              "${_myWalletController.walletTransactionList[index]['created_at']}",
                                              style: TextStyle(
                                                fontSize: FontSizeStatic.semiSm,
                                                color: Color(0xFF747474),
                                                /* fontFamily: 'Proxima-Regular' */ fontFamily:
                                                    'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: ScreenConstant.sizeSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                ],
              ),
            );
          })),
    );
  }

  openBottomSheet() {
    Get.bottomSheet(Container(
      padding: EdgeInsets.all(20),
      color: AppColors.secondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Filter your report",
            style: TextStyle(
              fontSize: FontSizeStatic.xl,
              /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
              color: Color(0xFF1D1D1D),
            ),
          ),
          Container(
            height: ScreenConstant.sizeExtraSmall,
          ),
          Text(
            "Select dates and get your result",
            style: TextStyle(
              fontSize: FontSizeStatic.maxMd,
              /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
              color: Color(0xFF747474),
            ),
          ),
          Container(
            height: ScreenConstant.sizeMedium,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _selectFirstDate(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.secondary,
                      border: Border.all(color: Color(0xFF707070), width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Obx(() => Text(
                              DateFormat('yyyy-MM-dd').format(
                                  _myWalletController.selectedFirstDate.value),
                              style: TextStyle(
                                fontSize: FontSizeStatic.md,
                                /* fontFamily: 'Proxima-Regular' */ fontFamily:
                                    'Poppins',
                                color: Color(0xFF747474),
                              ),
                            )),
                        Container(
                          width: ScreenConstant.sizeMedium,
                        ),
                        Icon(
                          Icons.date_range_sharp,
                          color: Color(0xFF056EAB),
                          size: ScreenConstant.sizeXL,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: ScreenConstant.sizeMedium,
              ),
              GestureDetector(
                onTap: () {
                  _selectSecondDate(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.secondary,
                      border: Border.all(color: Color(0xFF707070), width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Obx(() => Text(
                              DateFormat('yyyy-MM-dd').format(
                                  _myWalletController.selectedSecondDate.value),
                              style: TextStyle(
                                fontSize: FontSizeStatic.md,
                                /* fontFamily: 'Proxima-Regular' */ fontFamily:
                                    'Poppins',
                                color: Color(0xFF747474),
                              ),
                            )),
                        Container(
                          width: ScreenConstant.sizeMedium,
                        ),
                        Icon(
                          Icons.date_range_sharp,
                          color: Color(0xFF056EAB),
                          size: ScreenConstant.sizeXL,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: ScreenConstant.sizeExtraLarge,
          ),
          AppButton(
            width: screenWidth,
            color: AppColors.buttonColorSecondary,
            buttonText: "Search Now",
            onPressed: () {
              Get.back();
              _myWalletController.isWalletHistoryLoading.value = true;
              _myWalletController.getWalletTransactionListPress(true);
            },
          ),
        ],
      ),
    ));
  }

  Future<void> _selectFirstDate(BuildContext? context) async {
    final DateTime? picked = await showDatePicker(
        context: context!,
        initialDate: _myWalletController.selectedFirstDate.value,
        firstDate: DateTime(2021, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != _myWalletController.selectedFirstDate.value)
      setState(() {
        _myWalletController.selectedFirstDate.value = picked;
      });
  }

  Future<void> _selectSecondDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTimeUtility()
            .convertDateFromString(
                _myWalletController.selectedFirstDate.value.toString())
            .add(Duration(days: 1)),
        firstDate: DateTimeUtility()
            .convertDateFromString(
                _myWalletController.selectedFirstDate.value.toString())
            .add(Duration(days: 1)),
        lastDate: DateTime.now());
    if (picked != null &&
        picked != _myWalletController.selectedSecondDate.value)
      setState(() {
        _myWalletController.selectedSecondDate.value = picked;
      });
  }
}
