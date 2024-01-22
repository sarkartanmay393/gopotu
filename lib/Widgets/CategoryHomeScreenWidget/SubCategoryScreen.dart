import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_potu_user/Controller/SubCategoryController/SubCategoryController.dart';
import 'package:go_potu_user/Service/Url.dart';

import '../../Controller/CategoryController/CategoryController.dart';
import '../../Controller/CategoryController/subcategorycontroller.dart';
import '../../Controller/DashboardController/DashboardController.dart';
import '../../DeviceManager/Colors.dart';
import '../../DeviceManager/NoResult.dart';
import '../../DeviceManager/ScreenConstants.dart';
import '../../DeviceManager/TextStyles.dart';
import '../../Models/ResponseModels/SubCategoryResponseModel/subcategoryresponsemodel.dart';
import '../../Router/RouteConstants.dart';
import '../../Views/CategoryScreen/CategoryShopScreen.dart';
import '../HomeScreenWidgets/SecondBannerListWidget.dart';

class SubCategoryWidgetScreen extends StatelessWidget {
  final DashboardController _dashboardController = Get.put(DashboardController());
  final SubCategoryController _subCategoryController = Get.find();
  final String categoryName;

  SubCategoryWidgetScreen({required this.categoryName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
        child:  Icon(Icons.chevron_left_rounded,size: 35,color: Colors.white,),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(categoryName,style: TextStyle(fontSize: FontSizeStatic.lg,color: Colors.white),)
      ),
      body: GetX<SubCategoryController>(
        initState: (state) {
          Future.delayed(Duration(milliseconds: 500), () {
            Get.find<SubCategoryController>().loadCategoryListPress();
          });
        },
        builder: (_) {
          return _dashboardController.featuredCategories.length < 1
              ? Container(
            child: Center(
              child: NoResult(
                titleText: "Sorry no store found!",
                subTitle: "",
              ),
            ),
          )
              : Column(
            children: [
              _dashboardController.appBannerMiddle.length < 1
                  ? Offstage()
                  : SecondBannerListWidget(
                bannerList: _dashboardController.appBannerFooter,
              ),
              _dashboardController.appBannerMiddle.length < 1
                  ? Offstage()
                  : Divider(
                color: Colors.black,
              ),
              StaggeredGridView.countBuilder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount:
                _subCategoryController.subCategoryList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(ScreenConstant.sizeMedium),
                    child: YourGridItemWidget(
                      index: index,
                      subcategoryList:
                      _subCategoryController.subCategoryList,
                    ),
                  );
                },
                staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(1, 1.4),
                crossAxisCount: 3,
              ),
            ],
          );
        },
      ),
    );
  }
}



class YourGridItemWidget extends StatelessWidget {
  final List<dynamic>? subcategoryList;
  final int? index;

  YourGridItemWidget({
    this.index,
    this.subcategoryList,
  });

  @override
  Widget build(BuildContext context) {
    if (subcategoryList == null || subcategoryList!.isEmpty || index == null || index! >= subcategoryList!.length) {
      // Return a placeholder or an empty container based on your requirements
      return Container();
    }

    final subCategory = subcategoryList![index!];

    return Column(
      children: [
        Container(height: ScreenConstant.defaultWidthTwenty),
        GestureDetector(
          onTap: () {

            final CategoryController categoryController =
            Get.put(CategoryController());
            categoryController.categoryId.value = subcategoryList![index!]['id'].toString();
            Get.to(() => CategoryShopScreen());
          },
          child: Container(
            width: ScreenConstant.defaultHeightNinety,
            height: ScreenConstant.defaultHeightNinety,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey.shade100,
            ),
            child: subCategory != null
                ? CachedNetworkImage(
              imageUrl: subcategoryList![index!]['icon_path'],
            )
                : Image.asset("assets/temporary/onion.png"),
          ),
        ),
        Container(height: 2),
        Expanded(child: Center(child: Text(subcategoryList![index!]['name'])))
      ],
    );
  }
}




// StaggeredGridView.countBuilder(
//   shrinkWrap: true,
//   physics: ClampingScrollPhysics(),
//   itemCount: _dashboardController.featuredCategories.length,
//   itemBuilder: (context, index) {
//     return  Padding(
//       padding: EdgeInsets.all(ScreenConstant.sizeMedium),
//       child: CategoryHomeScreenWidget(
//         index: index,
//         categoryList:
//         _dashboardController
//             .featuredCategories,
//       ),
//     );
//     // return StoreListWidget(
//     //   index: index,
//     //   nearestStore: _dashboardController.featuredCategories,
//     //   onTap: () {
//     //     Get.toNamed(storeDetails,
//     //         arguments: JsonEncoder().convert({
//     //           "id": _dashboardController.featuredCategories[index]
//     //                   ['id']
//     //               .toString(),
//     //           "isFavourite": true
//     //         }));
//     //   },
//     // );
//   },
//   staggeredTileBuilder:
//       (int index) =>
//   new StaggeredTile.count(
//       1,1.5),
//   crossAxisCount: 3,
// ),
