import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:go_potu_user/Controller/SubCategoryController/SubCategoryController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/NoResult.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Widgets/CategoryWidgets/SubCategoryWidget.dart';
import 'package:skeletons/skeletons.dart';

class SubCategoryScreen extends StatelessWidget {
  final SubCategoryController _subCategoryController =
      Get.put(SubCategoryController());
  Future _refreshData() async {
    // await Future.delayed(Duration(seconds: 1));
    _subCategoryController.subCategoryListPress(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          AppStrings.ShoppingCategory,
          style: TextStyles.appBarTitle,
        ),
      ),
      body: GetX<SubCategoryController>(initState: (state) {
        Get.find<SubCategoryController>().subCategoryListPress(false);
      }, builder: (_) {
        return _subCategoryController.isLoading.isFalse
            ? _skeletonView()
            : _subCategoryController.subCategoryList.length < 1
                ? Container(
                    child: Center(
                        child: NoResult(
                      titleText: "Sorry no category found!",
                      subTitle: "",
                    )),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RefreshIndicator(
                      onRefresh: _refreshData,
                      child: ListView(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          AnimationLimiter(
                            child: StaggeredGridView.countBuilder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: _subCategoryController
                                    .subCategoryList.length,
                                itemBuilder: (BuildContext context,
                                    int index) =>
                                    AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration:
                                      const Duration(milliseconds: 1000),
                                      columnCount: 4,
                                      child: ScaleAnimation(
                                        child: FadeInAnimation(
                                          child: SubCategoryWidget(
                                            categoryId: _subCategoryController
                                                .subCategoryList[index]['id']
                                                .toString(),
                                            categoryImage:
                                            _subCategoryController
                                                .subCategoryList[index]
                                            ['icon_path'],
                                            categoryName: _subCategoryController
                                                .subCategoryList[index]['name'],
                                          ),
                                        ),
                                      ),
                                    ),
                                staggeredTileBuilder: (int index) =>
                                new StaggeredTile.count(1, 1),
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0),
                          ),
                          /* AddsWidget(),
              Container(
                height: ScreenConstant.sizeSmall,
              ),
              AnimationLimiter(
                child: StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) =>
                        AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 1000),
                          columnCount: 4,
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: SubCategoryWidget(),
                            ),
                          ),
                        ),
                    staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(1, 1.2),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0),
              ),*/
                        ],
                      ),
                    ),
                  );
      }),

      /*Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            StaggeredGridView.countBuilder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) =>
                    AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  columnCount: 2,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: SubCategoryWidget(),
                    ),
                  ),
                ),
                staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(1, 1.2),
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0),
            Container(
              height: ScreenConstant.sizeSmall,
            ),
            AddsWidget(),
            Container(
              height: ScreenConstant.sizeSmall,
            ),
            StaggeredGridView.countBuilder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) =>
                    SubCategoryWidget(),
                staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(1, 1.2),
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0),
          ],
        ),
      )*/
    );
  }

  Widget _skeletonView() => ListView.builder(
        // padding: padding,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VerticalDivider(),
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                    height: ScreenConstant.defaultHeightOneForty,
                    width: ScreenConstant.defaultWidthOneEighty),
              ),
              VerticalDivider(),
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                    height: ScreenConstant.defaultHeightOneForty,
                    width: ScreenConstant.defaultWidthOneEighty),
              ),
            ],
          ),
        ),
      );
}
