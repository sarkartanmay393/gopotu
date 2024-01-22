import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';

class SecondBannerListWidget extends StatefulWidget {
  final List<dynamic> bannerList;

  SecondBannerListWidget({required this.bannerList});

  @override
  State<SecondBannerListWidget> createState() => _SecondBannerListWidgetState();
}

class _SecondBannerListWidgetState extends State<SecondBannerListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(),
      child: Container(
          //color: Colors.pinkAccent,
          // height: ScreenConstant.defaultWidthOneEighty,
          height: ScreenConstant.defaultHeightOneHundredFifty,
          child: imageSlider(context)),
    );
  }

  Swiper imageSlider(BuildContext context) {
    return Swiper(
      itemHeight: ScreenConstant.defaultWidthOneEighty,
      itemCount: widget.bannerList.length,
      physics: ClampingScrollPhysics(),
      key: UniqueKey(),
      autoplay: true,
      // pagination: SwiperPagination(
      //     builder: DotSwiperPaginationBuilder(
      //       color: Colors.grey,
      //       activeColor: Colors.blue,
      //       size: 8.0,
      //     ),
      //     margin: EdgeInsets.only(top: ScreenConstant.defaultHeightEightyTwo)),
      // Add this line for dot indicator
      itemBuilder: (BuildContext context, int index) {
        return CachedNetworkImage(
          imageUrl: widget.bannerList[index]['image_path'] ??
              "https://firebasestorage.googleapis.com/v0/b/gopotu-228fa.appspot.com/o/GoPotuAppImageCollections%2Fwlcm.png?alt=media&token=6ecb4771-30f8-4788-9e4a-392b4162b96c",
          placeholder: (context, url) => Image.asset(Assets.loadingImageGif),
          errorWidget: (context, url, error) => Image.network(
              "https://firebasestorage.googleapis.com/v0/b/gopotu-228fa.appspot.com/o/GoPotuAppImageCollections%2Fwlcm.png?alt=media&token=6ecb4771-30f8-4788-9e4a-392b4162b96c"),
          fit: BoxFit.contain,
        );
      },
    );
  }
}
