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

class SubCategoryWidget extends StatelessWidget {
  final String? categoryImage;
  final String? categoryName;
  final String? categoryId;

  SubCategoryWidget({this.categoryName, this.categoryImage, this.categoryId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        await HiveStore().put(Keys.isStoreScreen, "true");
        final StoreController storeController = Get.find();
        final SubCategoryController subCategoryController =
            Get.put(SubCategoryController());
        subCategoryController.shopId.value = storeController.storeId.value;
        subCategoryController.categoryParentId.value = categoryId!;
        subCategoryController.isTapId.value = -1;
        subCategoryController.allTap.value = true;
        subCategoryController.subCategoryProductList.clear();
        Get.toNamed(productList);
      },
      child: /*Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: AppColors.topStoreWidgetsBorder
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Image.network("https://firebasestorage.googleapis.com/v0/b/gopotu-228fa.appspot.com/o/GoPotuAppImageCollections%2Fbath.png?alt=media&token=fb33c7fe-bb2e-40c4-94f1-027105739bf1"),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Kid's Fashion",style: TextStyles.subCategoryName,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),*/
      Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.topStoreWidgetsBorder)),

          height: ScreenConstant.defaultWidthOneHundredSeven,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: CachedNetworkImage(
                imageUrl: categoryImage ??
                    "https://corp.sellerscommerce.com//SCAssets/images/noimage.png",
                placeholder: (context, url) =>
                    Image.asset(Assets.loadingImageGif),
                errorWidget: (context, url, error) => Image.network(
                    "https://corp.sellerscommerce.com//SCAssets/images/noimage.png"),
                height: ScreenConstant.defaultHeightOneThirty,
                //width: ScreenConstant.defaultHeightOneThirty,
                fit: BoxFit.contain,
              )),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenConstant.sizeSmall,
                    //vertical: ScreenConstant.sizeSmall
                  ),
                  child: Text(
                    categoryName!,
                    style: TextStyles.subCategoryName,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
