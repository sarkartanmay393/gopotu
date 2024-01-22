import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/CMSController/CMSController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';


class ReplacementPolicyScreen extends StatelessWidget {
  final CMSController _cmsController = Get.put(CMSController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: Text(
            "Replacement Policy",
            style: TextStyles.appBarTitle,
          ),
        ),
        body: GetX<CMSController>(initState: (state) {
          Get.find<CMSController>().cmsReplacementPress(true, "refund-return-policy");
        }, builder: (_) {
          return _cmsController.replacementData.value.cmscontent == null ? Container():ListView(
            padding: EdgeInsets.all(10),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Html(
                data: _cmsController.replacementData.value.cmscontent!.content,
                style: {
                  _cmsController.replacementData.value.cmscontent!.content!: Style(
                      color: AppColors.productDes,
                      fontSize: FontSize.medium,
                      /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
                      textAlign: TextAlign.justify),
                },
              ),
            ],
          );
        }));
  }
}
