import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddressController/AddressController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Models/ResponseModels/StateListResponseModel/StateListResponseModel.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';
import 'package:go_potu_user/Widgets/TextFieldWidgets/RequireTextField.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;

import 'MapView.dart';

import 'dart:ui' as ui;

const kGoogleApiKey = "AIzaSyCLBdfxCZAHz73ewTMiueV0V59wT6nxv38";

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class AddNewAddressScreen extends StatefulWidget {
  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final AddressController _addressController = Get.put(AddressController());
  LatLng center = LatLng(0, 0);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  CameraPosition? _initialPosition;
  GoogleMapController? mapController;
  bool loader = false;
  bool _isLoading = true;
  String type = "";
  List<AddressType> typeList = [
    AddressType(id: 0, name: "HOME", isTap: false),
    AddressType(id: 1, name: "WORK", isTap: false),
    AddressType(id: 2, name: "OTHER", isTap: false),
    AddressType(id: 3, name: "CURRENT", isTap: false),
  ];

  Uint8List? markerIcon;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  setIcon() async {
    markerIcon = await getBytesFromAsset('assets/markerPin.png', 150);
  }

  setLatLng(LatLng _position) async {
    setState(() {
      center = LatLng(_position.latitude, _position.longitude);
      _addressController.lat.value = _position.latitude;
      _addressController.lng.value = _position.longitude;

      print("Lat : ${_addressController.lat.value}");
      print("Lng : ${_addressController.lng.value}");

      _initialPosition = CameraPosition(
        target: center,
        zoom: 13,
      );
    });
    debugPrint("center $center");
    // await setInitialAddress(latLng: center);
    print("Set lat Lng");
    setMarker();
  }

  setInitialAddress({LatLng? latLng, String description = ''}) async {
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(latLng!.latitude, latLng.longitude);
    var place = placeMarks.first;
    print(place);
    var _address = '';
    if (description.isNotEmpty) {
      _address = description + ' - ${place.postalCode}';
    } else {
      _address =
          '${place.street}, ${place.thoroughfare},${place.subLocality}, ${place.locality}, ${place.country} - ${place.postalCode}';
    }
    setState(() {
      _addressController.location.text = _address;
      _addressController.city.value = place.locality!;
      _addressController.state.value = place.administrativeArea!;
      _addressController.postalCode.value = place.postalCode!;
      _addressController.country.value = place.country!;
      _addressController.postalCodeController.text = place.postalCode!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(milliseconds: 2000), () {
      setState(() {
        setIcon();
        if (_addressController.isEdit.value) {
          setState(() {
            center = LatLng(
                double.parse(_addressController.addressListData[
                    _addressController.editAddressIndex.value]['latitude']),
                double.parse(_addressController.addressListData[
                    _addressController.editAddressIndex.value]['longitude']));
            print("center.value : $center");
            loader = true;
            _initialPosition = CameraPosition(target: center, zoom: 10);
            loader = false;
            _addressController.location.text = _addressController
                .addressListData[_addressController.editAddressIndex.value]
                    ['location']
                .toString();
            _addressController.mobileController.text =
                HiveStore().get(Keys.userNumber) == null
                    ? _addressController.addressListData[
                        _addressController.editAddressIndex.value]['mobile']
                    : HiveStore().get(Keys.userNumber);
            _addressController.billNameController.text = _addressController
                .addressListData[_addressController.editAddressIndex.value]
                    ['name']
                .toString();
            _addressController.alternativePhController.text =
                _addressController.addressListData[_addressController
                        .editAddressIndex.value]['alternative_mobile'] ??
                    "";
            _addressController.villageNameController.text =
                _addressController.addressListData[_addressController
                        .editAddressIndex
                        .value]['full_address']['address_line1'] ??
                    "";
            _addressController.landMarkController.text =
                _addressController.addressListData[_addressController
                        .editAddressIndex.value]['full_address']['landmark'] ??
                    "";
            _addressController.city.value = _addressController.state.value =
                _addressController.addressListData[_addressController
                        .editAddressIndex.value]['full_address']['state'] ??
                    "";
            _addressController.postalCode.value =
                _addressController.addressListData[_addressController
                        .editAddressIndex
                        .value]['full_address']['postal_code'] ??
                    "";
            _addressController.postalCodeController.text =
                _addressController.addressListData[_addressController
                        .editAddressIndex
                        .value]['full_address']['postal_code'] ??
                    "";
            _addressController.country.value =
                _addressController.addressListData[_addressController
                        .editAddressIndex.value]['full_address']['country'] ??
                    "";
            _addressController.lat.value = double.parse(_addressController
                    .addressListData[_addressController.editAddressIndex.value]
                ['latitude']);
            _addressController.lng.value = double.parse(_addressController
                    .addressListData[_addressController.editAddressIndex.value]
                ['longitude']);
            if (_addressController
                    .addressListData[_addressController.editAddressIndex.value]
                        ['type']
                    .toString() ==
                "home") {
              typeList[0].isTap = true;
              _addressController.addressType.value =
                  typeList[0].name!.toLowerCase();
            } else if (_addressController
                    .addressListData[_addressController.editAddressIndex.value]
                        ['type']
                    .toString() ==
                "work") {
              typeList[1].isTap = true;
              _addressController.addressType.value =
                  typeList[1].name!.toLowerCase();
            } else {
              typeList[2].isTap = true;
              _addressController.addressType.value =
                  typeList[2].name!.toLowerCase();
            }
            setLatLng(LatLng(
                _addressController.lat.value, _addressController.lng.value));
          });
        } else {
          print("Crent value: ${_addressController.lat2.value}");
          center = LatLng(
              _addressController.lat2.value, _addressController.lng2.value);
          _initialPosition = CameraPosition(target: center, zoom: 10);
          setLatLng(LatLng(
              _addressController.lat2.value, _addressController.lng2.value));
        }
        _isLoading = false;
      });
    });

    super.initState();
  }

  setMarker() {
    print("Set Marker");
    final marker = Marker(
      icon: BitmapDescriptor.defaultMarker,
      markerId: MarkerId(
          '${_addressController.location.text.isNotEmpty ? "1" : _addressController.location.text.isNotEmpty}'),
      position: center,
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: _addressController.city.value,
        snippet: _addressController.state.value,
      ),
    );
    setState(() {
      markers[MarkerId(
              '${_addressController.location.text.isNotEmpty ? "1" : _addressController.location.text.isNotEmpty}')] =
          marker;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    //setMarker();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  setCurrentPosition(LatLng center) {
    var newPosition = CameraPosition(
      target: center,
      zoom: 13,
    );
    CameraUpdate update = CameraUpdate.newCameraPosition(newPosition);
    CameraUpdate zoom = CameraUpdate.zoomTo(16);
    mapController!.moveCamera(update);
  }

  Future<Null> displayPrediction(Prediction? p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId!);
      print(p.structuredFormatting?.mainText);

      var placeId = p.placeId;
      double lat = detail.result.geometry!.location.lat;
      double lng = detail.result.geometry!.location.lng;

      setLatLng(LatLng(detail.result.geometry!.location.lat,
          detail.result.geometry!.location.lng));
      setCurrentPosition(center);
      setInitialAddress(latLng: center, description: p.description!);
      setMarker();
    }
  }

  getAddressFromLatLng(double lat, double lng) async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=$kGoogleApiKey&language=en&latlng=$lat,$lng';
    if (lng != null) {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String _formattedAddress = data["results"][0]["formatted_address"];
        print(data["results"][0]);
        print("response ==== $_formattedAddress");
        return _formattedAddress;
      } else
        return null;
    } else
      return null;
  }

  Future<bool> _onBackPressed() async {
    _addressController.isEdit.value = false;
    _addressController.fromAddAddress.value = false;
    _addressController.lat.value = 0.0;
    _addressController.lng.value = 0.0;
    _addressController.billNameController.text = "";
    _addressController.alternativePhController.text = "";
    _addressController.villageNameController.text = "";
    _addressController.landMarkController.text = "";

    bool isEdit = _addressController.isEdit.value;
    Get.back();
    return isEdit;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: Text(
            AppStrings.AddAddress,
            style: TextStyles.appBarTitle,
          ),
        ),
        body: _isLoading
            ? Center(
                child: Container(
                    height: ScreenConstant.sizeXXL,
                    width: ScreenConstant.sizeXXL,
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        border: Border.all(
                          color: AppColors.secondary,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                        strokeWidth: 1.5,
                      ),
                    )))
            : center.latitude != 0 && center.longitude != 0
                ? Stack(
                    children: [
                      ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(ScreenConstant.sizeLarge),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /*Text("Your Location",style: TextStyle(
                         color: Color(0xFF646464),
                         fontSize: FontSize.semiSm,
                         fontWeight: FontWeight.bold,fontFamily: 'Proxima-Bold'
                     ),),
                     Container(
                       height: ScreenConstant.sizeSmall,
                     ),
                     Text("Arambagh park house lane, Arambagh, Hooghly, West Bengal,India, 713611",style: TextStyle(
                         color: AppColors.accentColor,
                         fontSize: FontSize.semiSm,fontFamily: 'Proxima-Regular',
                     ),),*/
                                Text(
                                  "Your Location:",
                                  style: TextStyles.textFieldHints,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("Tap");
                                    _addressController.fromAddAddress.value =
                                        true;
                                    Get.to(MapView(
                                      value: LatLng(
                                          center.latitude, center.longitude),
                                    ))!
                                        .then((value) {
                                      setState(() {
                                        if (value == null) {
                                          center = LatLng(
                                              _addressController.lat.value,
                                              _addressController.lng.value);
                                        } else {
                                          center = value;
                                        }

                                        setMarker();
                                        mapController!.moveCamera(
                                            CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                          target: center,
                                          zoom: 13,
                                        )));
                                      });
                                    });
                                  },
                                  child: TextFormField(
                                    controller: _addressController.location,
                                    maxLines: 5,
                                    minLines: 1,
                                    onTap: () {
                                      print("Tap");
                                      _addressController.fromAddAddress.value =
                                          true;
                                      Get.to(MapView(
                                        value: LatLng(
                                            center.latitude, center.longitude),
                                      ))!
                                          .then((value) {
                                        setState(() {
                                          if (value == null) {
                                            center = LatLng(
                                                _addressController.lat.value,
                                                _addressController.lng.value);
                                          } else {
                                            center = value;
                                          }

                                          setMarker();
                                          mapController!.moveCamera(
                                              CameraUpdate.newCameraPosition(
                                                  CameraPosition(
                                            target: center,
                                            zoom: 13,
                                          )));
                                        });
                                      });
                                    },
                                    enabled: false,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 0, top: 5),
                                        hintText: "Your Location"),
                                    // onTap: () async {
                                    //   FocusScope.of(context)
                                    //       .requestFocus(FocusNode());

                                    //   Prediction p =
                                    //       await PlacesAutocomplete.show(
                                    //               decoration: InputDecoration(
                                    //                 //prefixIcon: Icon(Icons.search),
                                    //                 filled: true,
                                    //                 labelStyle: TextStyle(
                                    //                     color:
                                    //                         AppColors.secondary),
                                    //                 fillColor: AppColors.primary,
                                    //                 contentPadding:
                                    //                     EdgeInsets.all(
                                    //                         ScreenConstant
                                    //                             .sizeSmall),
                                    //                 hintText: "Search",
                                    //                 hintStyle: TextStyle(
                                    //                   color: Colors.white,
                                    //                   fontSize:
                                    //                       FontSizeStatic.semiSm,
                                    //                   fontFamily:
                                    //                       'Proxima-Regular',
                                    //                 ),
                                    //                 focusedBorder:
                                    //                     OutlineInputBorder(
                                    //                   borderSide: BorderSide(
                                    //                       color:
                                    //                           AppColors.primary,
                                    //                       width: 1.0,
                                    //                       style:
                                    //                           BorderStyle.solid),
                                    //                 ),
                                    //                 disabledBorder:
                                    //                     OutlineInputBorder(
                                    //                   borderSide: BorderSide(
                                    //                       color:
                                    //                           AppColors.primary,
                                    //                       width: 1.0,
                                    //                       style:
                                    //                           BorderStyle.solid),
                                    //                 ),
                                    //                 enabledBorder:
                                    //                     OutlineInputBorder(
                                    //                   borderSide: BorderSide(
                                    //                       color:
                                    //                           AppColors.primary,
                                    //                       width: 1.0,
                                    //                       style:
                                    //                           BorderStyle.solid),
                                    //                 ),
                                    //               ),
                                    //               types: [],
                                    //               onError: (_) {},
                                    //               mode: Mode.fullscreen,
                                    //               strictbounds: false,
                                    //               language: "en",
                                    //               components: [
                                    //                 new Component(
                                    //                     Component.country, "in"),
                                    //                 new Component(
                                    //                     Component.country, "us"),
                                    //                 new Component(
                                    //                     Component.country, "uk"),
                                    //                 new Component(
                                    //                     Component.country, "gb")
                                    //               ],
                                    //               context: context,
                                    //               apiKey: kGoogleApiKey)
                                    //           .then((value) async {
                                    //     FocusScope.of(context)
                                    //         .requestFocus(FocusNode());
                                    //     loader = true;

                                    //     await displayPrediction(value);
                                    //     loader = false;

                                    //     print(value);
                                    //   });
                                    // },
                                  ),
                                ),
                                // Container(
                                //   height: ScreenConstant.sizeSmall,
                                // ),
                                // GestureDetector(
                                //   onHorizontalDragStart: (d) {
                                //     _addressController.fromAddAddress.value = true;
                                //     Get.to(MapView(
                                //       value: LatLng(center.latitude, center.longitude),
                                //     )).then((value) {
                                //       setState(() {
                                //         if (value == null) {
                                //           center = LatLng(_addressController.lat.value,
                                //               _addressController.lng.value);
                                //         } else {
                                //           center = value;
                                //         }

                                //         setMarker();
                                //         mapController.moveCamera(
                                //             CameraUpdate.newCameraPosition(CameraPosition(
                                //           target: center,
                                //           zoom: 13,
                                //         )));
                                //       });
                                //     });
                                //   },
                                //   /*onVerticalDragStart: (d) {
                                //    Get.to(MapView(
                                //      value: LatLng(center.latitude,
                                //          center.longitude),
                                //    )).then((value) {
                                //      setState(() {
                                //        center =
                                //            LatLng(value.latitude, value.longitude);
                                //        setMarker();
                                //        mapController.moveCamera(
                                //            CameraUpdate.newCameraPosition(
                                //                CameraPosition(
                                //                  target: center,
                                //                  zoom: 13,
                                //                )));
                                //      });
                                //    });
                                //  },*/
                                //   onTap: () {
                                //     _addressController.fromAddAddress.value = true;
                                //     Get.to(MapView(
                                //       value: LatLng(center.latitude, center.longitude),
                                //     )).then((value) {
                                //       setState(() {
                                //         if (value == null) {
                                //           center = LatLng(_addressController.lat.value,
                                //               _addressController.lng.value);
                                //         } else {
                                //           center = value;
                                //         }
                                //         setMarker();
                                //         mapController.moveCamera(
                                //             CameraUpdate.newCameraPosition(CameraPosition(
                                //           target: center,
                                //           zoom: 13,
                                //         )));
                                //       });
                                //     });
                                //   },
                                //   child: Container(
                                //     height: ScreenConstant.defaultWidthThreeThirtySix,
                                //     width: screenWidth,
                                //     child: center.latitude == 0 && center.longitude == 0
                                //         ? const Offstage()
                                //         : GoogleMap(
                                //             mapType: MapType.normal,
                                //             onMapCreated: _onMapCreated,
                                //             initialCameraPosition: _initialPosition,
                                //             zoomControlsEnabled: false,
                                //             markers: markers.values.toSet(),
                                //             onTap: (d) {
                                //               _addressController.fromAddAddress.value =
                                //                   true;
                                //               Get.to(MapView(
                                //                 value: LatLng(
                                //                     center.latitude, center.longitude),
                                //               )).then((value) {
                                //                 setState(() {
                                //                   if (value == null) {
                                //                     center = LatLng(
                                //                         _addressController.lat.value,
                                //                         _addressController.lng.value);
                                //                   } else {
                                //                     center = value;
                                //                   }
                                //                   setMarker();
                                //                   mapController.moveCamera(
                                //                       CameraUpdate.newCameraPosition(
                                //                           CameraPosition(
                                //                     target: center,
                                //                     zoom: 13,
                                //                   )));
                                //                 });
                                //               });
                                //             },
                                //           ),
                                //   ),
                                // ),

                                Container(
                                  height: ScreenConstant.sizeLarge,
                                ),
                                Text(
                                  "Billing Contact Information:",
                                  style: TextStyles.textFieldHints,
                                ),
                                Container(
                                  height: ScreenConstant.sizeMedium,
                                ),
                                Text(
                                  "Name",
                                  style: TextStyles.textFieldHints,
                                ),
                                Container(
                                  height: ScreenConstant.sizeExtraSmall,
                                ),
                                RequireTextField(
                                  controller:
                                      _addressController.billNameController,
                                  type: Type.fullName,
                                ),
                                Container(
                                  height: ScreenConstant.sizeMedium,
                                ),
                                Text(
                                  "Contact Number",
                                  style: TextStyles.textFieldHints,
                                ),
                                Container(
                                  height: ScreenConstant.sizeExtraSmall,
                                ),
                                HiveStore().get(Keys.guestToken) == null
                                    ? RequireTextField(
                                        //controller: _signUpController.firstNameController,
                                        type: Type.phone,
                                        enable: false,
                                        hintText:
                                            "+91 ${HiveStore().get(Keys.userNumber)}",
                                      )
                                    : RequireTextField(
                                        enable: true,
                                        controller:
                                            _addressController.mobileController,
                                        type: Type.phone,
                                      ),
                                Container(
                                  height: ScreenConstant.sizeMedium,
                                ),
                                Text(
                                  "Alternative Contact Number",
                                  style: TextStyles.textFieldHints,
                                ),
                                Container(
                                  height: ScreenConstant.sizeExtraSmall,
                                ),
                                RequireTextField(
                                  controller: _addressController
                                      .alternativePhController,
                                  type: Type.phone,
                                ),
                                Container(
                                  height: ScreenConstant.sizeMedium,
                                ),
                                Text(
                                  "Village Name",
                                  style: TextStyles.textFieldHints,
                                ),
                                Container(
                                  height: ScreenConstant.sizeExtraSmall,
                                ),
                                TextFormField(
                                  controller:
                                      _addressController.villageNameController,
                                  keyboardType: TextInputType.name,
                                  autofocus: false,
                                  style: TextStyles.textFieldText,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: validateVillageName,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(
                                        ScreenConstant.sizeSmall),
                                    focusedBorder: OutlineInputBorder(
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
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: ScreenConstant.sizeMedium,
                                ),
                                Text(
                                  "Postal Code",
                                  style: TextStyles.textFieldHints,
                                ),
                                Container(
                                  height: ScreenConstant.sizeExtraSmall,
                                ),
                                TextFormField(
                                  controller:
                                      _addressController.postalCodeController,
                                  keyboardType: TextInputType.number,
                                  autofocus: false,
                                  style: TextStyles.textFieldText,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: validatePostalCode,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(
                                        ScreenConstant.sizeSmall),
                                    focusedBorder: OutlineInputBorder(
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
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: ScreenConstant.sizeMedium,
                                ),
                                /*ListTile(
                       title: Text("Select State"),
                       trailing: DropdownButtonHideUnderline(
                         child: DropdownButton<StateList>(
                           items: _addressController.stateData.map((StateList value) {
                             return DropdownMenuItem<StateList>(
                               value: value,
                               child: Text(value.stateName),
                             );
                           }).toList(),
                           onChanged: (_) {},
                         ),
                       ),
                     ),*/
                                /*ListTile(
                       title: Center(
                         child: DropdownButtonHideUnderline(
                           child: DropdownButton<String>(
                             isExpanded: true,
                             value: type,
                             onChanged: (newValue) {
                               setState(() {
                                 type = newValue;
                                 _addressController.selectState.value = newValue;
                                 print("_addressController.selectState.value: ${_addressController.selectState.value}");
                               });
                             },
                             items: _addressController.stateData?.map((type) {
                               return DropdownMenuItem<String>(
                                 child: new Text(
                                   type.stateName,
                                 ),
                                 value: type.stateName,
                               );
                             })?.toList(),
                           ),
                         ),
                       ),
                     ),*/
                                Text(
                                  "Land Mark/ Instruction",
                                  style: TextStyles.textFieldHints,
                                ),
                                Container(
                                  height: ScreenConstant.sizeExtraSmall,
                                ),
                                TextFormField(
                                  controller:
                                      _addressController.landMarkController,
                                  keyboardType: TextInputType.name,
                                  autofocus: false,
                                  maxLines: 5,
                                  style: TextStyles.textFieldText,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: landMarkValidation,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(
                                        ScreenConstant.sizeSmall),
                                    focusedBorder: OutlineInputBorder(
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
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: ScreenConstant.sizeMedium,
                                ),
                                Text(
                                  "Save As",
                                  style: TextStyle(
                                    color: Color(0xFF646464),
                                    fontSize: FontSizeStatic.semiSm,
                                    /* fontFamily: 'Proxima-Regular' */ fontFamily:
                                        'Poppins',
                                  ),
                                ),
                                Container(
                                  height: ScreenConstant.sizeSmall,
                                ),
                                Container(
                                  height: ScreenConstant.sizeXXXL,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: typeList.length,
                                    itemBuilder: (context, index) {
                                      return typeList[index].isTap == true
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors.primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40)),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 3),
                                                  child: Center(
                                                    child: Text(
                                                      typeList[index].name!,
                                                      style: TextStyle(
                                                        fontSize:
                                                            FontSizeStatic.md,
                                                        color:
                                                            AppColors.secondary,
                                                        fontFamily:
                                                            'Proxima-Regular',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  for (int i = 0;
                                                      i < typeList.length;
                                                      i++) {
                                                    if (typeList[i].isTap ==
                                                        true) {
                                                      typeList[i].isTap =
                                                          !typeList[i].isTap!;
                                                    }
                                                  }

                                                  typeList[index].isTap = true;
                                                  _addressController
                                                          .addressType.value =
                                                      typeList[index]
                                                          .name!
                                                          .toLowerCase();
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppColors.secondary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      border: Border.all(
                                                          color: Color(
                                                              0xFFD5DBE1))),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 3),
                                                    child: Center(
                                                      child: Text(
                                                        typeList[index].name!,
                                                        style: TextStyle(
                                                          fontSize:
                                                              FontSizeStatic.md,
                                                          color: AppColors
                                                              .accentColor,
                                                          fontFamily:
                                                              'Proxima-Regular',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                    },
                                  ),
                                ),
                                Container(
                                  height: ScreenConstant.sizeLarge,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenConstant.sizeLarge),
                            child: AppButton(
                              elevation: 0,
                              buttonText: AppStrings.SaveAddress,
                              onPressed: () {
                                _addressController.addAddressPress();
                                //Get.offAllNamed(addressList);
                              },
                              textStyle: TextStyles.bottomTextStyle,
                            ),
                          ),
                          Container(
                            height: ScreenConstant.sizeLarge,
                          ),
                        ],
                      ),
                      // Container(
                      //   color: Colors.black12,
                      //   height: loader ? double.infinity : 0,
                      //   width: loader ? double.infinity : 0,
                      //   child: const Center(
                      //     child: CircularProgressIndicator(
                      //         valueColor:
                      //             AlwaysStoppedAnimation<Color>(Colors.red)),
                      //   ),
                      // )
                    ],
                  )
                : Offstage(),
      ),
    );
  }
}

String? validateVillageName(String? value) {
  if (value!.length == 0) {
    return "Village name required";
  } else {
    return "";
  }
}

String? validatePostalCode(String? value) {
  if (value == null || value.isEmpty) {
    return "Postal code required";
  } else {
    return "";
  }
}

String? landMarkValidation(String? value) {
  if (value!.length == 0) {
    return "Land Mark/Instruction required";
  } else {
    return "";
  }
}

class AddressType {
  int? id;
  String? name;
  bool? isTap;

  AddressType({
    this.id,
    this.name,
    this.isTap,
  });
}
