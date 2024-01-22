import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';

class OnBoardingModel {
  String? title;
  String? description;
  Color? titleColor;
  Color? descripColor;
  String? imagePath;

  OnBoardingModel({
    @required this.title,
    @required this.description,
    @required this.imagePath,
    @required this.titleColor,
    @required this.descripColor,
  });
}

class OnBoardingWidget extends StatefulWidget {
  final List<OnBoardingModel>? pages;
  final Color? bgColor;
  final Color? themeColor;
  final ValueChanged<String>? skipClicked;
  final ValueChanged<String>? getStartedClicked;

  OnBoardingWidget({
    Key? key,
    @required this.pages,
    @required this.bgColor,
    @required this.themeColor,
    @required this.skipClicked,
    @required this.getStartedClicked,
  }) : super(key: key);

  @override
  OnBoardingWidgetState createState() => OnBoardingWidgetState();
}

class OnBoardingWidgetState extends State<OnBoardingWidget> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < widget.pages!.length; i++) {
      list.add(i == _currentPage ? _indicator(true, i) : _indicator(false, i));
    }
    return list;
  }

  List<Widget> buildOnboardingPages() {
    final children = <Widget>[];

    for (int i = 0; i < widget.pages!.length; i++) {
      children.add(_showPageData(widget.pages![i]));
    }
    return children;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget _indicator(bool isActive, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: ScreenConstant.sizeDefault),
      height: ScreenConstant.sizeDefault,
      width:
          isActive ? ScreenConstant.sizeExtraLarge : ScreenConstant.sizeLarge,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        color: isActive ? AppColors.primary : AppColors.secondary,
        borderRadius:
            BorderRadius.all(Radius.circular(ScreenConstant.sizeMedium)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        actions: [
          _currentPage != widget.pages!.length - 1
              ? Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      widget.skipClicked!("Skip Tapped");
                    },
                    child: Text(
                      'Skip'.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.landingTitle,
                        fontSize: FontSizeStatic.md,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                )
              : Offstage(),
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenConstant.sizeLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: ScreenConstant.screenHeightOneSeventh,
                    color: Colors.transparent,
                    child: PageView(
                        physics: ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: buildOnboardingPages()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Spacer(),
                  _currentPage != widget.pages!.length - 1
                      ? Align(
                          alignment: FractionalOffset.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: ScreenConstant.sizeLarge,
                                left: ScreenConstant.sizeLarge),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: _buildPageIndicator(),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _pageController.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  },
                                  child: Text(
                                    AppStrings.next,
                                    style: TextStyles.landingNext,
                                  ),
                                ),
                                /*SizedBox(
                                height: ScreenConstant.sizeXXXL,
                                width:ScreenConstant.defaultSizeOneTen ,
                                child: FloatingActionButton.extended(
                                  elevation: 0,
                                  backgroundColor: widget.themeColor,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(ScreenConstant.sizeExtraSmall))),
                                  label: Text("Next"),
                                  onPressed: () {
                                    _pageController.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  },
                                ),
                              ),*/
                              ],
                            ),
                          ),
                        )
                      : Align(
                          alignment: FractionalOffset.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: ScreenConstant.sizeLarge,
                                bottom: ScreenConstant.sizeSmall),
                            child: SizedBox(
                              height: ScreenConstant.sizeXXXL,
                              width: ScreenConstant.defaultHeightTwoHundred,
                              child: FloatingActionButton.extended(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenConstant.sizeExtraSmall))),
                                backgroundColor: widget.themeColor,
                                // icon: Icon(Icons.save),
                                label: Row(
                                  children: [
                                    Text(
                                      AppStrings.getStarted,
                                      style: TextStyles.getStarted,
                                    ),
                                    Container(
                                      width: ScreenConstant.sizeSmall,
                                    ),
                                    Icon(Icons.arrow_forward)
                                  ],
                                ),
                                onPressed: () {
                                  widget.getStartedClicked!("Start Tapped");
                                  /* _pageController.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,*/
                                  //);
                                },
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
      /*  bottomSheet: _currentPage == widget.pages.length - 1
          ? _showGetStartedButton()
          : Text(''),*/
    );
  }

  Widget _showPageData(OnBoardingModel page) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: ScreenConstant.sizeLarge,
          horizontal: ScreenConstant.sizeLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(child: SizedBox(height: ScreenConstant.sizeSmall)),
          Center(
            child: Image(
              image: AssetImage(page.imagePath!),
              height: ScreenConstant.screenHeightHalf,
              width: ScreenConstant.screenHeightHalf,
            ),
          ),
          SizedBox(height: ScreenConstant.sizeXXXL),
          // Text(
          //   page.title,
          //   style: TextStyle(
          //     fontWeight: FontWeight.w700,
          //     color: page.titleColor,
          //     fontSize: ScreenConstant.sizeLarge,
          //   ),
          // ),
          // SizedBox(height:ScreenConstant.sizeLarge  ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: ScreenConstant.sizeExtraLarge),
          //   child: Text(
          //     page.description,
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       fontWeight: FontWeight.w400,
          //       color: page.descripColor,
          //       fontSize:FontSizeStatic.lg,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
