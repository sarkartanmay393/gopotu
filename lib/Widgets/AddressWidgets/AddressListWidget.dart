import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddressController/AddressController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';

class AddressListWidget extends StatelessWidget {
  final int index;
  final List<dynamic>? addressListData;
  final AddressController _addressController = Get.put(AddressController());

  AddressListWidget({
    required this.index,
    this.addressListData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenConstant.sizeMedium,
          bottom: ScreenConstant.sizeMedium,
          right: ScreenConstant.sizeMedium),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenConstant.sizeMedium),
        ),
        elevation: 10,
        child: Obx(() => Container(
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(ScreenConstant.sizeMedium),
                  color: (addressListData![index]['is_default'] ?? 0) == 1
                      ? AppColors.addressListWidgetColor
                      : _addressController.addressListData[index]['deliverable']
                          ? AppColors.secondary
                          : AppColors.otpBoxFillColor,
                  border: Border.all(
                      color: AppColors.addressListWidgetBorderColor)),
              child: Padding(
                padding: EdgeInsets.all(ScreenConstant.sizeMedium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: _addressController.addressListData[index]
                              ['deliverable']
                          ? () {
                              _addressController.isAddressCardSelect.value =
                                  true;
                              _addressController.onAddressSelect.value = index;
                              _addressController.addressId.value =
                                  _addressController.addressListData[index]
                                          ['id']
                                      .toString();
                              // _addressController.setDefaultAddressPress();
                            }
                          : () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _addressController.isAddressCardSelect.value
                              ? index !=
                                      _addressController.onAddressSelect.value
                                  ? Icon(Icons.radio_button_off)
                                  : Icon(Icons.radio_button_checked_sharp)
                              : addressListData?[index]['is_default'] == 1
                                  ? Icon(Icons.radio_button_checked_sharp)
                                  : Icon(Icons.radio_button_off)
                        ],
                      ),
                    ),
                    Container(
                      width: ScreenConstant.sizeLarge,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _addressController.addressListData[index]
                                  ['deliverable']
                              ? Offstage()
                              : Text(
                                  "Does not Deliver to".toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: FontSizeStatic.maxMd,
                                      /* fontFamily: 'Proxima-Regular' */ fontFamily:
                                          'Poppins'),
                                ),
                          _addressController.addressListData[index]
                                  ['deliverable']
                              ? Offstage()
                              : Container(
                                  height: ScreenConstant.sizeExtraSmall,
                                ),
                          Text(
                            addressListData?[index]['name'] ?? "",
                            style: TextStyles.addressListWidgetContainTitle,
                          ),
                          Container(
                            height: ScreenConstant.sizeExtraSmall,
                          ),
                          Text(
                            addressListData?[index]['full_address']
                                    ['landmark'] ??
                                "",
                            style: TextStyles.addressListWidgetContainSubTitle,
                          ),
                          Container(
                            height: ScreenConstant.sizeExtraSmall,
                          ),
                          Text(
                            addressListData?[index]['location'] ?? "",
                            style: TextStyles.addressListWidgetContainSubTitle,
                          ),
                          Container(
                            height: ScreenConstant.sizeExtraSmall,
                          ),
                          Text(
                            addressListData?[index]['mobile'] ?? "",
                            style: TextStyles.addressListWidgetContainSubTitle,
                          ),
                          Container(
                            height: ScreenConstant.sizeSmall,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ScreenConstant.sizeSmall),
                                border: Border.all(
                                    color: _addressController
                                                .addressListData[index]
                                            ['deliverable']
                                        ? AppColors.buttonColorSecondary
                                        : AppColors.otpBoxFillColor),
                                color:
                                    addressListData?[index]['is_default'] == 1
                                        ? AppColors.buttonColorSecondary
                                        : AppColors.secondary),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: ScreenConstant.sizeLarge,
                                bottom: ScreenConstant.sizeExtraSmall,
                                right: ScreenConstant.sizeLarge,
                                top: ScreenConstant.sizeExtraSmall,
                              ),
                              child: Text(
                                addressListData?[index]['type']
                                        .toString()
                                        .toUpperCase() ??
                                    "",
                                textAlign: TextAlign.center,
                                style:
                                    addressListData?[index]['is_default'] == 1
                                        ? TextStyles.addressType1
                                        : TextStyles.addressType2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PopupMenuButton(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: Icon(Icons.more_vert_rounded),
                            ),
                            onSelected: (result) {
                              if (result == 0) {
                                _addressController.editAddressIndex.value =
                                    index;
                                _addressController.isEdit.value = true;
                                Get.toNamed(addAddress);
                              } else {
                                _addressController.deleteAddressId.value =
                                    addressListData![index]['id'].toString();
                                _addressController.deleteAddressPress();
                              }
                            },
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: Text(
                                      "Edit",
                                      style: TextStyles
                                          .addressListWidgetContainTitle,
                                    ),
                                    value: 0,
                                  ),
                                  PopupMenuItem(
                                    child: Text(
                                      "Delete",
                                      style: TextStyles
                                          .addressListWidgetContainTitle,
                                    ),
                                    value: 1,
                                  ),
                                ])
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
