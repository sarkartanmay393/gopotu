import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/StoreController/StoreController.dart';
import 'package:go_potu_user/Controller/SubCategoryController/SubCategoryController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Models/ResponseModels/StoreDetailsResponseModel/StoreDetailsResponseModel.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';

import '../../Store/HiveStore.dart';

class StoreCategoryWidget extends StatelessWidget {
  final String? categoryImage;
  final String? categoryName;
  final String? categoryId;

  StoreCategoryWidget({this.categoryName, this.categoryImage, this.categoryId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () async {
      //   final StoreController storeController = Get.find();
      //   final SubCategoryController subCategoryController =
      //       Get.put(SubCategoryController());
      //   subCategoryController.shopId.value = storeController.storeId.value;
      //   subCategoryController.categoryParentId.value = categoryId!;
      //   subCategoryController.isTapId.value = -1;
      //   subCategoryController.allTap.value = true;
      //   subCategoryController.loadCategoryListApiCall();
      //   print(
      //       "${subCategoryController.categoryParentId} --> ${subCategoryController.subCategoryProductList.length}");
      // },
      child: Padding(
        padding: EdgeInsets.all(ScreenConstant.sizeSmall),
        child: Container(
          height: ScreenConstant.defaultHeightSixty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(

                    // color: Color(0xFF37B24B),
                    borderRadius: BorderRadius.circular(6),
                    // border: Border.all(color: AppColors.topStoreWidgetsBorder)
                  ),
                  child: CachedNetworkImage(
                    imageUrl: categoryImage ??
                        "https://corp.sellerscommerce.com//SCAssets/images/noimage.png",
                    placeholder: (context, url) =>
                        Image.asset(Assets.loadingImageGif),
                    errorWidget: (context, url, error) => Image.network(
                        "https://corp.sellerscommerce.com//SCAssets/images/noimage.png"),
                    height: ScreenConstant.defaultHeightForty,
                    width: ScreenConstant.defaultHeightFifty,

                    //width: ScreenConstant.defaultHeightOneThirty,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 4,),
              // Expanded(
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(
              //       horizontal: ScreenConstant.sizeSmall,
              //     ),
              //     child: Container(
              //
              //       child: Text(
              //         categoryName != null
              //             ? categoryName!.length <= 15
              //             ? categoryName!
              //             : categoryName!.substring(0, 15) + '...'
              //             : "",
              //         style: TextStyle(
              //           fontSize: FontSizeStatic.sm,
              //         ),
              //         overflow: TextOverflow.ellipsis,
              //         maxLines: 2,
              //       ),
              //     ),
              //   ),
              // ),


            ],
          ),
        ),
      ),
    );
  }
}
