import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/CMSController/CMSController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'PrivacyPolicyScreen.dart';
import 'ReplacementPolicyScreen.dart';
import 'TermsScreen.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class AboutUsScreen extends StatelessWidget {
  final CMSController _cmsController = Get.put(CMSController());

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String currentYear = "${today.year}";
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          AppStrings.AboutUs,
          style: TextStyles.appBarTitle,
        ),
      ),
      // floatingActionButton: Obx(()=>_cmsController.companyDetailsData.value.contactDetails == null ? Offstage(): FloatingActionButton(
      //     elevation: 0.0,
      //     child: new Icon(Icons.call,color: AppColors.secondary,),
      //     backgroundColor: AppColors.primary,
      //     onPressed: (){
      //       UrlLauncher.launch("tel://${_cmsController.companyDetailsData.value.contactDetails.mobile.toString()}");
      //     }
      // )),
      body: GetX<CMSController>(initState: (state) {
        Get.find<CMSController>().cmsAboutUsPress(true, "about-us");
      }, builder: (_) {
        return _cmsController.aboutUsData.value.cmscontent == null
            ? Container()
            : ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: ScreenConstant.defaultWidthOneNinety,
                      left: ScreenConstant.sizeLarge,
                      top: ScreenConstant.sizeLarge,
                      bottom: ScreenConstant.sizeLarge,
                    ),
                    child: Container(
                      child: Image(
                        image: AssetImage(Assets.splashLogo),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ScreenConstant.sizeLarge),
                    child: Text(
                      "Who we are",
                      style: TextStyles.aboutTitle,
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeMedium,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: ScreenConstant.sizeLarge,
                          right: ScreenConstant.sizeLarge),
                      child: Html(
                        data: _cmsController
                            .aboutUsData.value.cmscontent!.content,
                        style: {
                          _cmsController.aboutUsData.value.cmscontent!.content!:
                              Style(
                                  color: AppColors.productDes,
                                  fontSize: FontSize.medium,
                                  /* fontFamily: 'Proxima-Regular' */ fontFamily:
                                      'Poppins',
                                  textAlign: TextAlign.justify),
                        },
                      )),
                  Container(
                    height: ScreenConstant.sizeXL,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ScreenConstant.sizeLarge),
                    child: Text(
                      "Why Us",
                      style: TextStyles.aboutTitle,
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeMedium,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: ScreenConstant.sizeLarge,
                          right: ScreenConstant.sizeLarge),
                      child: Html(
                        data: _cmsController
                            .aboutUsData.value.cmscontent!.content,
                        style: {
                          _cmsController.aboutUsData.value.cmscontent!.content!:
                              Style(
                                  color: AppColors.productDes,
                                  fontSize: FontSize.medium,
                                  /* fontFamily: 'Proxima-Regular' */ fontFamily:
                                      'Poppins',
                                  textAlign: TextAlign.justify),
                        },
                      )
                      /*Text(,
            textAlign: TextAlign.justify,
              style: TextStyles.aboutSubTitle,
            ),*/
                      ),
                  Container(
                    height: ScreenConstant.sizeMedium,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: ScreenConstant.sizeExtraLarge),
                    child: Row(
                      children: [
                        Container(
                          width: ScreenConstant.sizeExtraSmall,
                          height: ScreenConstant.sizeExtraSmall,
                          decoration: new BoxDecoration(
                            color: AppColors.accentColor,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        Container(
                          width: ScreenConstant.sizeSmall,
                        ),
                        Text(
                          "Quality product range.",
                          style: TextStyles.aboutSubTitle,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeExtraSmall,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: ScreenConstant.sizeExtraLarge),
                    child: Row(
                      children: [
                        Container(
                          width: ScreenConstant.sizeExtraSmall,
                          height: ScreenConstant.sizeExtraSmall,
                          decoration: new BoxDecoration(
                            color: AppColors.accentColor,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        Container(
                          width: ScreenConstant.sizeSmall,
                        ),
                        Text(
                          "Standard Packaging.",
                          style: TextStyles.aboutSubTitle,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeExtraSmall,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: ScreenConstant.sizeExtraLarge),
                    child: Row(
                      children: [
                        Container(
                          width: ScreenConstant.sizeExtraSmall,
                          height: ScreenConstant.sizeExtraSmall,
                          decoration: new BoxDecoration(
                            color: AppColors.accentColor,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        Container(
                          width: ScreenConstant.sizeSmall,
                        ),
                        Text(
                          "Low price than market price.",
                          style: TextStyles.aboutSubTitle,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeExtraSmall,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: ScreenConstant.sizeExtraLarge),
                    child: Row(
                      children: [
                        Container(
                          width: ScreenConstant.sizeExtraSmall,
                          height: ScreenConstant.sizeExtraSmall,
                          decoration: new BoxDecoration(
                            color: AppColors.accentColor,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        Container(
                          width: ScreenConstant.sizeSmall,
                        ),
                        Text(
                          "Prompt and safe delivery.",
                          style: TextStyles.aboutSubTitle,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeExtraSmall,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: ScreenConstant.sizeExtraLarge),
                    child: Row(
                      children: [
                        Container(
                          width: ScreenConstant.sizeExtraSmall,
                          height: ScreenConstant.sizeExtraSmall,
                          decoration: new BoxDecoration(
                            color: AppColors.accentColor,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        Container(
                          width: ScreenConstant.sizeSmall,
                        ),
                        Flexible(
                            child: Text(
                          "Ethical business practice and transparent dealings.Ethical business practice and transparent dealings.",
                          style: TextStyles.aboutSubTitle,
                        )),
                      ],
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeXL,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: ScreenConstant.sizeExtraLarge),
                    child: Text(
                      "www.gopotu.com",
                      style: TextStyles.companyWebSite,
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeSmall,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: ScreenConstant.sizeExtraLarge),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            UrlLauncher.launch(_cmsController
                                .socialLinksData.value.socialLinks![0].link
                                .toString());
                          },
                          child: Container(
                            height: ScreenConstant.sizeLarge,
                            width: ScreenConstant.sizeLarge,
                            child: Image(
                              image: AssetImage(Assets.facebook),
                            ),
                          ),
                        ),
                        Container(
                          width: ScreenConstant.sizeSmall,
                        ),
                        GestureDetector(
                          onTap: () {
                            openWhatsapp(context);
                          },
                          child: Container(
                            height: ScreenConstant.sizeLarge,
                            width: ScreenConstant.sizeLarge,
                            child: Image(
                              image: AssetImage(Assets.whatsapp),
                            ),
                          ),
                        ),
                        Container(
                          width: ScreenConstant.sizeSmall,
                        ),
                        GestureDetector(
                          onTap: () {
                            UrlLauncher.launch(_cmsController
                                .socialLinksData.value.socialLinks![1].link
                                .toString());
                          },
                          child: Container(
                            height: ScreenConstant.sizeLarge,
                            width: ScreenConstant.sizeLarge,
                            child: Image(
                              image: AssetImage(Assets.twitter),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: ScreenConstant.sizeXL,
                  ),
                ],
              );
      }),
      bottomNavigationBar: Container(
        color: AppColors.primary,
        height: ScreenConstant.defaultHeightSeventy,
        child: Column(
          children: [
            Container(
              height: ScreenConstant.sizeMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(PrivacyPolicyScreen());
                  },
                  child: Text(
                    "Privacy Policy",
                    style: TextStyles.aboutPrivacy,
                  ),
                ),
                Container(
                  width: ScreenConstant.sizeXL,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(TermsScreen());
                  },
                  child: Text(
                    "Terms",
                    style: TextStyles.aboutPrivacy,
                  ),
                ),
                Container(
                  width: ScreenConstant.sizeXL,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(ReplacementPolicyScreen());
                  },
                  child: Text(
                    "Replacement Policy",
                    style: TextStyles.aboutPrivacy,
                  ),
                ),
              ],
            ),
            Container(
              height: ScreenConstant.sizeSmall,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "© $currentYear Gopotu",
                  style: TextStyles.aboutPrivacy,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  openWhatsapp(BuildContext context) async {
    var whatsapp =
        "+91${_cmsController.companyDetailsData.value.contactDetails!.whatsapp}";
    var whatsAppURlAndroid =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatAppURLIos = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatAppURLIos)) {
        await launch(whatAppURLIos, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsAppURlAndroid)) {
        await launch(whatsAppURlAndroid);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }
}
