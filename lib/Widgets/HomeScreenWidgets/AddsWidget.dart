import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';

class AddsWidget extends StatelessWidget {
  const AddsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Center(
        child: Card(
          margin: EdgeInsets.only(left: 1,right: 1),
          elevation: 0,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.network(
            'https://firebasestorage.googleapis.com/v0/b/gopotu-228fa.appspot.com/o/GoPotuAppImageCollections%2Fsmall-banner.png?alt=media&token=5821df2f-93e3-4cde-aa18-95d7b1e5184a',
            fit: BoxFit.fill,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
      /*Padding(
      padding: EdgeInsets.only(
          left: ScreenConstant.sizeExtraSmall,
          right: ScreenConstant.sizeExtraSmall),
      child: Container(
        height: ScreenConstant.defaultHeightOneHundred,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(
                  "https://ab.gl/WZY6B",
                )),
            borderRadius: BorderRadius.circular(15)),
      ),
    );*/
  }
}
