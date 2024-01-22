import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddToCartController/AddToCartController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';

class CustomAnimatedBottomBar extends StatelessWidget {
  CustomAnimatedBottomBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.items,
    this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items!.length >= 2 && items.length <= 5),
        super(key: key);

  final int ?selectedIndex;
  final double? iconSize;
  final Color? backgroundColor;
  final bool? showElevation;
  final Duration? animationDuration;
  final List<BottomNavyBarItem>? items;
  final ValueChanged<int>? onItemSelected;
  final MainAxisAlignment? mainAxisAlignment;
  final double? itemCornerRadius;
  final double? containerHeight;
  final Curve? curve;

  @override
  Widget build(BuildContext context) {

    final bgColor = backgroundColor ?? Theme.of(context).bottomAppBarColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          if (showElevation!)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment!,
            children: items!.map((item) {
              var index = items!.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected!(index),
                child: _ItemWidget(
                  item: item,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: bgColor,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final AddToCartController addToCartController =
      Get.put(AddToCartController());

  final double? iconSize;
  final bool? isSelected;
  final BottomNavyBarItem? item;
  final Color? backgroundColor;
  final double? itemCornerRadius;
  final Duration? animationDuration;
  final Curve? curve;

  _ItemWidget({
    Key? key,
    this.item,
    this.isSelected,
    this.backgroundColor,
    this.animationDuration,
    this.itemCornerRadius,
    this.iconSize,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Before updating cart count: ${addToCartController.cartCount.value}");

    print("After updating cart count: ${addToCartController.cartCount.value}");

    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected! ? 130 : 50,
        height: double.maxFinite,
        duration: animationDuration!,
        curve: curve!,
        decoration: BoxDecoration(
          color: isSelected! ? backgroundColor : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius!),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            width: isSelected! ? 130 : 50,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                item!.isCart!
                    ? Obx(() => Stack(
                          fit: StackFit.passthrough,
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              height: ScreenConstant.sizeMidLarge,
                              width: ScreenConstant.sizeMidLarge,
                              child: Image(
                                fit: BoxFit.contain,
                                color: isSelected!
                                    ? item!.activeColor!.withOpacity(1)
                                    : item!.inactiveColor == null
                                        ? item!.activeColor
                                        : item!.inactiveColor,
                                image: AssetImage(
                                  item!.icon!,
                                ),
                              ),
                            ),
                            addToCartController.cartCount.value == "" ||
                                    addToCartController.cartCount.value == "0"
                                ? Offstage()
                                : Container(
                                    height: ScreenConstant.sizeMedium,
                                    width: ScreenConstant.sizeMedium,
                                    //padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected!
                                            ? AppColors.accentColor
                                            : AppColors.primary),
                                    alignment: Alignment.center,
                                    child: Obx(() => Text(
                                          addToCartController.cartCount.value ==
                                                  "10"
                                              ? "9+"
                                              : addToCartController
                                                  .cartCount.value
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: FontSizeStatic.semiSm,
                                              color: AppColors.secondary),
                                        ))),
                          ],
                        ))
                    : Container(
                        height: ScreenConstant.sizeMidLarge,
                        width: ScreenConstant.sizeMidLarge,
                        child: Image(
                          fit: BoxFit.contain,
                          color: item!.isColor! ?isSelected!
                              ? item!.activeColor!.withOpacity(1)
                              : item!.inactiveColor == null
                                  ? item!.activeColor
                                  : item!.inactiveColor:null,
                          image: AssetImage(
                            item!.icon!,
                          ),
                        ),
                      ),
                /*IconTheme(
                  data: IconThemeData(
                    size: iconSize,
                    color: isSelected
                        ? item.activeColor.withOpacity(1)
                        : item.inactiveColor == null
                        ? item.activeColor
                        : item.inactiveColor,
                  ),
                  child: item.icon,
                ),*/
                if (isSelected!)
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: DefaultTextStyle.merge(
                        style: TextStyle(
                          color: item!.activeColor,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        textAlign: item!.textAlign,
                        child: item!.title!,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    this.icon,
    this.title,
    this.activeColor = Colors.blue,
    this.textAlign,
    this.inactiveColor,
    this.isCart = false,
    this.isColor,
  });

  final String? icon;
  final Widget? title;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextAlign? textAlign;
  final bool? isCart;
  final bool? isColor;
}


class CustomAnimatedBottomBarNew extends StatelessWidget {
  CustomAnimatedBottomBarNew({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.items,
    this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items!.length >= 2 && items.length <= 5),
        super(key: key);

  final int ?selectedIndex;
  final double? iconSize;
  final Color? backgroundColor;
  final bool? showElevation;
  final Duration? animationDuration;
  final List<BottomNavyBarItem>? items;
  final ValueChanged<int>? onItemSelected;
  final MainAxisAlignment? mainAxisAlignment;
  final double? itemCornerRadius;
  final double? containerHeight;
  final Curve? curve;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).bottomAppBarColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          if (showElevation!)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment!,
            children: items!.map((item) {
              var index = items!.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected!(index),
                child: _ItemWidgetNew(
                  item: item,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: bgColor,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidgetNew extends StatelessWidget {
  final AddToCartController addToCartController =
      Get.put(AddToCartController());

  final double? iconSize;
  final bool? isSelected;
  final BottomNavyBarItem? item;
  final Color? backgroundColor;
  final double? itemCornerRadius;
  final Duration? animationDuration;
  final Curve? curve;

  _ItemWidgetNew({
    Key? key,
    this.item,
    this.isSelected,
    this.backgroundColor,
    this.animationDuration,
    this.itemCornerRadius,
    this.iconSize,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: Container(

        height: double.maxFinite,

        decoration: BoxDecoration(
          color: isSelected! ? backgroundColor : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius!),
        ),
        child: Container(
          // width: isSelected! ? 130 : 50,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              item!.isCart!
                  ? Obx(() => Stack(
                        fit: StackFit.passthrough,
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            height: ScreenConstant.sizeMidLarge,
                            width: ScreenConstant.sizeMidLarge,
                            child: Image(
                              fit: BoxFit.contain,
                              color: isSelected!
                                  ? item!.activeColor!.withOpacity(1)
                                  : item!.inactiveColor == null
                                      ? item!.activeColor
                                      : item!.inactiveColor,
                              image: AssetImage(
                                item!.icon!,
                              ),
                            ),
                          ),

                          addToCartController.cartCount.value == "" ||
                                  addToCartController.cartCount.value == "0"
                              ? Offstage()
                              : Container(
                                  height: ScreenConstant.sizeMedium,
                                  width: ScreenConstant.sizeMedium,
                                  //padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected!
                                          ? AppColors.accentColor
                                          : AppColors.primary),
                                  alignment: Alignment.center,

                                  child: Obx(() => Text(
                                        addToCartController.cartCount.value ==
                                                "10"
                                            ? "9+"
                                            : addToCartController
                                                .cartCount.value
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: FontSizeStatic.semiSm,
                                            color: AppColors.secondary),
                                      ))),
                        ],
                      ))
                  : Container(
                      height: ScreenConstant.sizeMidLarge,
                      width: ScreenConstant.sizeMidLarge,
                      child: Image(
                        fit: BoxFit.contain,
                        color: item!.isColor! ?isSelected!
                            ? item!.activeColor!.withOpacity(1)
                            : item!.inactiveColor == null
                                ? item!.activeColor
                                : item!.inactiveColor:null,
                        image: AssetImage(
                          item!.icon!,
                        ),
                      ),
                    ),
              /*IconTheme(
                data: IconThemeData(
                  size: iconSize,
                  color: isSelected
                      ? item.activeColor.withOpacity(1)
                      : item.inactiveColor == null
                      ? item.activeColor
                      : item.inactiveColor,
                ),
                child: item.icon,
              ),*/
              // if (isSelected!)
              //   Expanded(
              //     child: Container(
              //       padding: EdgeInsets.symmetric(horizontal: 40),
              //       child: DefaultTextStyle.merge(
              //         style: TextStyle(
              //           color: item!.activeColor,
              //           fontWeight: FontWeight.bold,
              //         ),
              //         maxLines: 1,
              //         textAlign: item!.textAlign,
              //         child: item!.title!,
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavyBarItemNew {
  BottomNavyBarItemNew({
    this.icon,
    this.title,
    this.activeColor = Colors.blue,
    this.textAlign,
    this.inactiveColor,
    this.isCart = false,
    this.isColor,
  });

  final String? icon;
  final Widget? title;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextAlign? textAlign;
  final bool? isCart;
  final bool? isColor;
}
