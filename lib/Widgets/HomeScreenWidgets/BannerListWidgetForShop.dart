// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:go_potu_user/DeviceManager/Assets.dart';
// import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
// import 'package:go_potu_user/Models/ResponseModels/StoreDetailsResponseModel/StoreDetailsResponseModel.dart';

// class BannerListWidgetForShop extends StatefulWidget {
//   final List<dynamic> imageList;
//   final bool isCover;
//   final bool isAutoplay;

//   BannerListWidgetForShop({this.imageList, this.isAutoplay, this.isCover});

//   @override
//   _BannerListWidgetForShopState createState() =>
//       _BannerListWidgetForShopState();
// }

// class _BannerListWidgetForShopState extends State<BannerListWidgetForShop> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container(
//       // height: ScreenConstant.defaultHeightOneThirty,
//       color: Colors.white,
//       child: CarouselSlider.builder(

//         itemCount: widget.imageList.length,
//         options: CarouselOptions(
//           autoPlay: true,
//           enlargeCenterPage: true,
//           viewportFraction: 1,
//           aspectRatio: 4
//         ),
//         itemBuilder: (context, index, realIdx) {
//           return Center(
//               child: CachedNetworkImage(
//                 imageUrl: widget.imageList[index]['image_path'] ??"https://firebasestorage.googleapis.com/v0/b/gopotu-228fa.appspot.com/o/GoPotuAppImageCollections%2Fwlcm.png?alt=media&token=6ecb4771-30f8-4788-9e4a-392b4162b96c",
//                 placeholder: (context, url) =>
//                     Image.asset(Assets.loadingImageGif),
//                 errorWidget: (context, url, error) => Image.network(
//                     "https://firebasestorage.googleapis.com/v0/b/gopotu-228fa.appspot.com/o/GoPotuAppImageCollections%2Fwlcm.png?alt=media&token=6ecb4771-30f8-4788-9e4a-392b4162b96c"),
//                 fit: BoxFit.contain,
//               ));
//         },
//       ),
//     );
//   }

// /*  @override
//   Widget build(BuildContext context) {
//     return Container(
//       //color: Colors.pinkAccent,
//         height: ScreenConstant.defaultHeightOneThirty,
//         child: imageSlider(context)
//     );
//   }

//   Swiper imageSlider(context){
//     return Swiper(itemCount: widget.imageList.length,
//       physics: ClampingScrollPhysics(),
//       key: UniqueKey(),
//       autoplay: widget.isAutoplay,
//       itemBuilder: (BuildContext context, int index){
//         return CachedNetworkImage(
//           imageUrl: widget.imageList[index]['image_path'] ??"https://firebasestorage.googleapis.com/v0/b/gopotu-228fa.appspot.com/o/GoPotuAppImageCollections%2Fwlcm.png?alt=media&token=6ecb4771-30f8-4788-9e4a-392b4162b96c",
//           placeholder: (context, url) =>
//               Image.asset(Assets.loadingImageGif),
//           errorWidget: (context, url, error) => Image.network(
//               "https://firebasestorage.googleapis.com/v0/b/gopotu-228fa.appspot.com/o/GoPotuAppImageCollections%2Fwlcm.png?alt=media&token=6ecb4771-30f8-4788-9e4a-392b4162b96c"),
//           fit: BoxFit.contain,
//         );

//         */ /*Image.network(
//         widget.imageList ??"https://firebasestorage.googleapis.com/v0/b/gopotu-228fa.appspot.com/o/GoPotuAppImageCollections%2Fwlcm.png?alt=media&token=6ecb4771-30f8-4788-9e4a-392b4162b96c",
//         fit: widget.isCover ?BoxFit.cover:BoxFit.contain,
//       );*/ /*
//       },
//     );
//   }*/

// }
