import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewScreen extends StatefulWidget {

  final List<String>? imageList;

  PhotoViewScreen({
    this.imageList
});


  @override
  _PhotoViewScreenState createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  /*final imageList = [
    'assets/images/villa_img2.jpg',
    'assets/images/resort_1.jpg',
    'assets/images/resort_3.jpg',
    'assets/images/getRadyForSummer.jpg',
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.close,color: AppColors.accentColor,), // Put icon of your preference.
              onPressed: () {
                Get.back();
                // your method (function),
              },
            );
          },
        ),
      ),
      // add this body tag with container and photoview widget
      body: Container(

        height: screenHeight,
        margin: EdgeInsets.only(left: 15, right: 15),
        width: screenWidth,
        child: PhotoViewGallery.builder(
          itemCount: widget.imageList!.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(
                widget.imageList![index],
              ),
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2,
            );
          },
          scrollPhysics: BouncingScrollPhysics(),
          backgroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: AppColors.secondary,
          ),
          enableRotation: true,
          loadingBuilder: (context, event) => Center(
            child: Container(
              color: AppColors.secondary,
              width: 30.0,
              height: 30.0,
              child: CircularProgressIndicator(
                backgroundColor: Colors.orange,
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
              ),
            ),
          ),
        ),
      ),
    );
  }
}