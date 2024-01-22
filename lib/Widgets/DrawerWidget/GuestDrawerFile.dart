import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Views/FavouriteScreen/FavouriteScreen.dart';
import 'package:go_potu_user/Views/OrdersScreen/DrawerOrderListingScreen.dart';
import 'package:go_potu_user/Views/ProfileScreen/MyProfileScreen.dart';
import 'package:go_potu_user/Views/SignInScreen/SignIn.dart';

class GuestDrawerFile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.primary, //This will change the drawer background to blue.
        ),
        child: Drawer(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.only(top: ScreenConstant.sizeXXL,bottom: ScreenConstant.sizeMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Container(
                      height: ScreenConstant.defaultHeightSeventy,
                      width: ScreenConstant.defaultHeightSeventy,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondary,
                      ),
                      child: Center(
                          child:
                          Text("G",style: TextStyles.profileNameFirstLetter2,)),
                    ),
                    Container(
                      height: ScreenConstant.sizeSmall,
                    ),
                    Text("GUEST".toUpperCase(),style: TextStyles.drawerMyProfileName,),
                    Container(
                      height: ScreenConstant.sizeSmall,
                    ),
                    GestureDetector(
                        onTap: HiveStore().get(Keys.guestToken) == null ?(){
                          Get.to(MyProfileScreen());
                        }:(){
                          Get.to(SignIn());
                        },
                        child: Text('My Account',style: TextStyles.drawerSubTitle2,)),

                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.secondary,
                  child: Padding(
                    padding:  EdgeInsets.only(left: ScreenConstant.sizeExtraSmall),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        GestureDetector(
                          onTap: (){
                            Get.back();
                            Get.offAllNamed(dashBoard);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: ScreenConstant.sizeLarge,
                                width: ScreenConstant.sizeXXXL,
                                child: Image(
                                  fit: BoxFit.contain,
                                  color: AppColors.primary,
                                  image: AssetImage(
                                    Assets.home,
                                  ),),
                              ),
                              Container(
                                width: ScreenConstant.sizeSmall,
                              ),
                              Text('Home',style: TextStyles.drawerItems,),
                            ],
                          ),
                        ),


                        GestureDetector(
                          onTap: HiveStore().get(Keys.guestToken) == null ?(){
                            Get.back();
                            Get.to(DrawerOrderListingScreen());
                          }:(){
                            Get.to(SignIn());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: ScreenConstant.sizeLarge,
                                width: ScreenConstant.sizeXXXL,
                                child: Image(
                                  fit: BoxFit.contain,
                                  color: AppColors.primary,
                                  image: AssetImage(
                                    Assets.orders,
                                  ),),
                              ),
                              Container(
                                width: ScreenConstant.sizeSmall,
                              ),
                              Text('My Orders',style: TextStyles.drawerItems,),
                            ],
                          ),
                        ),


                        GestureDetector(
                          onTap: HiveStore().get(Keys.guestToken) == null ?(){
                            Get.back();
                            Get.toNamed(notifications);
                          }:(){
                            Get.to(SignIn());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: ScreenConstant.sizeLarge,
                                width: ScreenConstant.sizeXXXL,
                                child: Icon(Icons.notifications,color: AppColors.primary,),
                              ),
                              Container(
                                width: ScreenConstant.sizeSmall,
                              ),
                              Text('Notifications',style: TextStyles.drawerItems,),
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: (){
                            share();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: ScreenConstant.sizeLarge,
                                width: ScreenConstant.sizeXXXL,
                                child: Icon(Icons.share,color: AppColors.primary,),
                              ),
                              Container(
                                width: ScreenConstant.sizeSmall,
                              ),
                              Text('Share App',style: TextStyles.drawerItems,),
                            ],
                          ),
                        ),

                        GestureDetector(
                            onTap: (){
                              Get.back();
                              Get.toNamed(aboutUs);
                            },
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: ScreenConstant.sizeMidLarge,
                                  width: ScreenConstant.sizeXXXL,
                                  child: Image(
                                    fit: BoxFit.contain,
                                    color: AppColors.primary,
                                    image: AssetImage(
                                      Assets.about,
                                    ),),
                                ),
                                Container(
                                  width: ScreenConstant.sizeSmall,
                                ),
                                Text('About Us',style: TextStyles.drawerItems,),
                              ],
                            )),

                        GestureDetector(
                            onTap: HiveStore().get(Keys.guestToken) == null ?(){
                              Get.toNamed(needHelp);
                            }:(){
                              Get.to(SignIn());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: ScreenConstant.sizeMidLarge,
                                  width: ScreenConstant.sizeXXXL,
                                  child: Image(
                                    fit: BoxFit.contain,
                                    color: AppColors.primary,
                                    image: AssetImage(
                                      Assets.customerSupport,
                                    ),),
                                ),
                                Container(
                                  width: ScreenConstant.sizeSmall,
                                ),
                                Text('Help & Support',style: TextStyles.drawerItems,),
                              ],
                            )),
                        GestureDetector(
                          onTap: HiveStore().get(Keys.guestToken) == null ?(){
                            showAlertDialog(context);
                          }:(){
                            Get.to(SignIn());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: ScreenConstant.sizeMidLarge,
                                width: ScreenConstant.sizeXXXL,
                                child: HiveStore().get(Keys.guestToken) == null ?Image(
                                  fit: BoxFit.contain,
                                  color: AppColors.primary,
                                  image: AssetImage(
                                    Assets.logout,
                                  ),):Icon(Icons.login,color: AppColors.primary,),
                              ),
                              Container(
                                width: ScreenConstant.sizeSmall,
                              ),
                              Text(HiveStore().get(Keys.guestToken) == null ?'Sign out':"Sign In",style: TextStyles.drawerItems,),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              //height: ScreenConstant.defaultHeightSeventy,
                              width: ScreenConstant.defaultWidthOneNinety,
                              child: Image(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                  Assets.drawerLogo,
                                ),),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: ScreenConstant.sizeSmall,bottom: ScreenConstant.sizeSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    Text('Version 1.0',style: TextStyles.drawerTitle,),
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    Text('Develop by Syscogen Cognitech Pvt. Ltd',style: TextStyles.drawerSubTitle,),
                    Container(
                      height: ScreenConstant.sizeSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title'
    );
  }

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel",style: TextStyle(
          color: AppColors.accentColor,
          fontSize: FontSizeStatic.md,fontWeight: FontWeight.bold,
          /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins'
      ),),
      onPressed:  () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes",style: TextStyle(
          color: AppColors.primary,
          fontSize: FontSizeStatic.md,fontWeight: FontWeight.bold,
          /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins'
      ),),
      onPressed:  () async{
        //await HiveStore().delete(Keys.deviceID);
        await HiveStore().delete(Keys.accessToken);
        await HiveStore().delete(Keys.guestToken);
        await HiveStore().delete(Keys.profileData);
        await HiveStore().delete(Keys.userNumber);
        await HiveStore().delete(Keys.shopType);
        await HiveStore().delete(Keys.typeSelectIndex);
        await HiveStore().delete(Keys.isDefaultAddressSet);
        await HiveStore().put(Keys.landingShow, "true");
        Get.offAllNamed(signIn);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Log Out!",style: TextStyles.productPrice,),
      content: Text("Are you sure want to log out?",style: TextStyles.chooseCategorySubTitle,),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
