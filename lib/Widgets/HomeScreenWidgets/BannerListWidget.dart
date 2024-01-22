// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:go_potu_user/DeviceManager/Assets.dart';
// import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';

// class BannerListWidget extends StatefulWidget {
//   final String imageList;
//   final bool isCover;
//   final bool isAutoplay;
//   BannerListWidget({
//     this.imageList,
//     this.isAutoplay,
//     this.isCover
// });
//   @override
//   _BannerListWidgetState createState() => _BannerListWidgetState();
// }

// class _BannerListWidgetState extends State<BannerListWidget> {



//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       //color: Colors.pinkAccent,
//       height: ScreenConstant.defaultWidthOneEighty,
//       child: imageSlider(context)
//     );
//   }

//   Swiper imageSlider(context){
//     return Swiper(itemCount: 1,
//       physics: ClampingScrollPhysics(),
//       key: UniqueKey(),
//       autoplay: widget.isAutoplay,
//       itemBuilder: (BuildContext context, int index){
//       return CachedNetworkImage(
//         imageUrl: widget.imageList ??"https://firebasestorage.googleapis.com/v0/b/gopotu-228fa.appspot.com/o/GoPotuAppImageCollections%2Fwlcm.png?alt=media&token=6ecb4771-30f8-4788-9e4a-392b4162b96c",
//         placeholder: (context, url) =>
//             Image.asset(Assets.loadingImageGif),
//         errorWidget: (context, url, error) => Image.network(
//             "https://firebasestorage.googleapis.com/v0/b/gopotu-228fa.appspot.com/o/GoPotuAppImageCollections%2Fwlcm.png?alt=media&token=6ecb4771-30f8-4788-9e4a-392b4162b96c"),
//         fit: widget.isCover ?BoxFit.cover:BoxFit.contain,
//       );

//         /*Image.network(
//         widget.imageList ??"https://firebasestorage.googleapis.com/v0/b/gopotu-228fa.appspot.com/o/GoPotuAppImageCollections%2Fwlcm.png?alt=media&token=6ecb4771-30f8-4788-9e4a-392b4162b96c",
//         fit: widget.isCover ?BoxFit.cover:BoxFit.contain,
//       );*/
//       },
//     );
//   }

// }
