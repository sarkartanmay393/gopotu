import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Store/ScopeStorage.dart';
import 'package:go_potu_user/Store/ShareStore.dart';

class FavouriteFilterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String type = ShareStore().getData(store:KeyStore.type) == null ?HiveStore().get(Keys.shopType) :ShareStore().getData(store:KeyStore.type);
    return Container(
      height: ScreenConstant.defaultWidthOneEighty,
      child: Padding(
        padding:  EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            Container(
              height: ScreenConstant.sizeMedium,
            ),
            Text("Filter Your Favourite List",style: TextStyles.filterTitle,),
            Container(
              height: ScreenConstant.sizeExtraLarge,
            ),
            GestureDetector(
              onTap: type == "mart"?(){
                Get.back();
              }:(){
                Get.back();
                Get.snackbar("Sorry!", "Your are in restaurant category",
                    backgroundColor: AppColors.secondary,
                    snackPosition: SnackPosition.BOTTOM,
                    icon: Icon(
                      Icons.error_outline_sharp,
                      color: Colors.red,
                    ),titleText: Text(
                    "Sorry!",
                    style: TextStyle(
                      fontFamily: 'Poppins',  // Replace with the desired font family for the title
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  messageText: Text(
                    "You are in restaurant category",
                    style: TextStyle(
                      fontFamily: 'Poppins',  // Replace with the desired font family for the message

                    ),
                  ),);
              },
              child: Row(
                children: [
                  Container(
                    height: ScreenConstant.sizeMedium,
                    width: ScreenConstant.sizeMedium,
                    child: Image(
                      color: type == "mart"?AppColors.filterBox:AppColors.addressListWidgetBorderColor,
                      fit: BoxFit.fitHeight,
                      image: AssetImage(
                        Assets.filterIcon,
                      ),),
                  ),
                  Container(
                    width: ScreenConstant.sizeMedium,
                  ),
                  Text("Mart",style: type == "mart"?TextStyles.filterContain:TextStyle(
                    color: AppColors.addressListWidgetBorderColor,
                    fontSize: FontSizeStatic.md,/* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
                  ),),
                ],
              ),
            ),
            Container(
              height: ScreenConstant.sizeExtraLarge,
            ),
            GestureDetector(
              onTap: type == "restaurant"?(){
                Get.back();
              }:(){
                Get.back();
                Get.snackbar("Sorry!", "Your are in mart category",
                    backgroundColor: AppColors.secondary,
                    snackPosition: SnackPosition.BOTTOM,
                    icon: Icon(
                      Icons.error_outline_sharp,
                      color: Colors.red,
                    ),
                  titleText: Text(
                    "Sorry!",
                    style: TextStyle(
                      fontFamily: 'Poppins',  // Replace with the desired font family for the title
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  messageText: Text(
                    "You are in mart category",
                    style: TextStyle(
                      fontFamily: 'Poppins',  // Replace with the desired font family for the message

                    ),
                  ),);
              },
              child: Row(
                children: [
                  Container(
                    height: ScreenConstant.sizeMedium,
                    width: ScreenConstant.sizeMedium,
                    child: Image(
                      color: type == "restaurant"?AppColors.filterBox:AppColors.addressListWidgetBorderColor,
                      fit: BoxFit.fitHeight,
                      image: AssetImage(
                        Assets.filterIcon,
                      ),),
                  ),
                  Container(
                    width: ScreenConstant.sizeMedium,
                  ),
                  Text("Restaurants",style: type == "restaurant"?TextStyles.filterContain:TextStyle(
                    color: AppColors.addressListWidgetBorderColor,
                    fontSize: FontSizeStatic.md,/* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
                  ),),
                ],
              ),
            ),
            Container(
              height: ScreenConstant.sizeExtraLarge,
            ),
          ],
        ),
      ),
    );
  }
}
