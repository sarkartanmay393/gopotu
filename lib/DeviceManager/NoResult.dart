import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'Assets.dart';
import 'ScreenConstants.dart';
import 'TextStyles.dart';

class NoResult extends StatefulWidget {
  final String? titleText;
  final String? subTitle;
  final String? img;

  NoResult({this.titleText, this.subTitle, this.img});

  @override
  _NoResultState createState() => _NoResultState();
}

class _NoResultState extends State<NoResult> {
  String? titleText;
  String subtitleText = 'We can\'t find what \n you\'re looking for.';

  //_NoResultState({this.titleText});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      titleText = widget.titleText ?? 'Sad. Nothing is here...';
    });
    print("${widget.titleText}");
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            widget.img?.isNotEmpty ?? false
                ? Container(
                    width: ScreenConstant.sizeUltraXXXL,
                    child: Image.asset(
                      widget.img!,
                    ),
                    //height: ScreenConstant.defaultImageHeight,
                  )
                : Container(
                    width: ScreenConstant.defaultHeightTwoHundred,
                    child: Image.asset(
                      Assets.noData,
                    ),
                    //height: ScreenConstant.defaultImageHeight,
                  ),
            Container(
              height: ScreenConstant.sizeXL,
            ),
            Text(
              widget.titleText! ?? titleText!,
              style: TextStyles.noDataTextTitle,
            ),
            Container(
              height: ScreenConstant.sizeDefault,
            ),
            Text(
              widget.subTitle ?? subtitleText,
              style: TextStyles.noDataTextTitle,
            ),
          ],
        )
      ],
    );
  }
}
