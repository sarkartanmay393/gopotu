import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';

class SearchWidget1 extends StatelessWidget {
  final String? searchLevelText;
  final Function? onTap;
  final TextEditingController? searchEditingController;

  SearchWidget1(
      {this.searchLevelText, this.onTap, this.searchEditingController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchEditingController,
      keyboardType: TextInputType.name,
      autofocus: false,
      enabled: false,
      maxLines: 1,
      style: TextStyles.textFieldText,
      decoration: InputDecoration(
        // prefixIcon: Icon(Icons.abc),
        // filled: true,
        // contentPadding: EdgeInsets.all(ScreenConstant.sizeMedium),
        // hintText: searchLevelText,
        labelText: "Search Product",
        labelStyle: TextStyle(fontSize:12),
        border: InputBorder.none
        // hintStyle: TextStyles.hintTextFieldHints,
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //       color: AppColors.textFieldBorderColor,
        //       width: 1.0,
        //       style: BorderStyle.solid),
        // ),
        // disabledBorder: OutlineInputBorder(
        //   //The border radius is used to change the border of search widget.
        //   borderRadius: BorderRadius.circular(30),
        //   borderSide: BorderSide(
        //       color: AppColors.textFieldBorderColor,
        //       width: 1.0,
        //       style: BorderStyle.solid),
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //       color: AppColors.textFieldBorderColor,
        //       width: 1.0,
        //       style: BorderStyle.solid),
        // ),
      ),
    );
  }
}
