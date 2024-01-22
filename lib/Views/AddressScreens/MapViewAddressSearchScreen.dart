import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddressController/AddressController.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Views/AddressScreens/MapView.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

import '../../DeviceManager/Colors.dart';
import '../../DeviceManager/ScreenConstants.dart';
import '../../DeviceManager/TextStyles.dart';

class MapViewAddressSearchScreen extends StatefulWidget {
  const MapViewAddressSearchScreen({Key? key}) : super(key: key);

  @override
  State<MapViewAddressSearchScreen> createState() =>
      _MapViewAddressSearchScreenState();
}

class _MapViewAddressSearchScreenState
    extends State<MapViewAddressSearchScreen> {
  GooglePlace? googlePlace;
  List<AutocompletePrediction> predictions = [];
  DetailsResult? detailsResult;
  AddressController _addressController = Get.find();

  @override
  void initState() {
    String apiKey = 'AIzaSyCLBdfxCZAHz73ewTMiueV0V59wT6nxv38';
    googlePlace = GooglePlace(apiKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Text(
          "Search Address",
          style: TextStyles.appBarTitle,
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.name,
                autofocus: true,
                enabled: true,
                maxLines: 1,
                style: TextStyles.textFieldText,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.length > 0 && mounted) {
                      setState(() {
                        predictions = [];
                      });
                    }
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: AppColors.secondary,
                  contentPadding: EdgeInsets.all(ScreenConstant.sizeMedium),
                  hintText: "Search for area, city or more...",
                  hintStyle: TextStyles.hintTextFieldHints,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.textFieldBorderColor,
                        width: 1.0,
                        style: BorderStyle.solid),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.textFieldBorderColor,
                        width: 1.0,
                        style: BorderStyle.solid),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.textFieldBorderColor,
                        width: 1.0,
                        style: BorderStyle.solid),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: predictions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(
                        Icons.location_on_sharp,
                        color: AppColors.doNotAccount,
                      ),
                      title: Text(
                        predictions[index].description!,
                        style: TextStyle(
                          color: AppColors.doNotAccount,
                          fontSize: FontSizeStatic.md,
                          /* fontFamily: 'Proxima-Regular' */ fontFamily:
                              'Poppins',
                        ),
                      ),
                      onTap: () {
                        debugPrint(predictions[index].placeId);
                        getDetils(predictions[index].placeId!);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace!.autocomplete.get(
      value,
      language: "en",
      components: [
        new Component("country", "in"),
      ],
    );
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  void getDetils(String placeId) async {
    var result = await this.googlePlace!.details.get(placeId);
    if (result != null && result.result != null && mounted) {
      setState(() {
        detailsResult = result.result;
      });
    }
  }
}



  

  // void autoCompleteSearch(String value) async {
  //   var result = await googlePlace.autocomplete.get(value);
  //   if (result != null && result.predictions != null && mounted) {
  //     setState(() {
  //       predictions = result.predictions;
  //     });
  //   }
  // }

