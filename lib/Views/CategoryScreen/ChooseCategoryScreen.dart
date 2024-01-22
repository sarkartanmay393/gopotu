import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Views/CategoryScreen/ChangeCategoryScreen.dart';

class ChooseCategoryScreen extends StatelessWidget {
  Future<bool> _onBackPressed() {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          title: Text(
            "Choose Category",
            style: TextStyles.appBarTitle,
          ),
          automaticallyImplyLeading: false,
        ),
        body: ChangeCategoryScreen(),
      ),
    );
  }
}
