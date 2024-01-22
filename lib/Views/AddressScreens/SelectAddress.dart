import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddressController/AddressController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/Views/HomeScreen/HomeScreen.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Router/RouteConstants.dart';

import '../../Widgets/HomeScreenWidgets/SearchWidget.dart';
import 'MapPicker.dart';
import 'package:show_more_text_popup/show_more_text_popup.dart';

import 'MapViewAddressSearchScreen.dart';

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
import 'package:location/location.dart' as loc;

double? lat_new;
double? lng_new;

class SelectAddress extends StatefulWidget {
  static Route route() => MaterialPageRoute(
        builder: (context) => HomeScreen(),
      );
  LatLng value;

  SelectAddress({Key? key, required this.value}) : super(key: key);

  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  Completer<GoogleMapController> _controller = Completer();
  LatLng data = LatLng(43.900250, -91.070580);
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(31.2060916, 29.9187),
    zoom: 18,
  );
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late GoogleMapController mapController;
  bool _mapCreated = false;
  MapPickerController mapPickerController = MapPickerController();
  bool _isLoading = true;
  final AddressController _addressController = Get.find();
  bool isBack = false;
  late String appBerText;
  bool isTap = false;
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  late DetailsResult detailsResult;
  bool isSelectFromSearch = false;
  late bool _serviceEnabled;
  bool _isButtonEnabled = false;
  void startTimer() {}

  @override
  void initState() {
    //_addressController.appBarText.value = _addressController.location.text;
    debugPrint("Onint");
    String apiKey = 'AIzaSyCLBdfxCZAHz73ewTMiueV0V59wT6nxv38';
    googlePlace = GooglePlace(apiKey);
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _isLoading = false;
        cameraPosition = CameraPosition(
          target: widget.value,
          zoom: 18,
        );
      });
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isButtonEnabled = true; // Enable the button after 5 seconds
      });
    });
    // TODO: implement initState
    //   setMap();
    super.initState();
  }

  setInitialAddress({LatLng? latLng, String description = ''}) async {
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(latLng!.latitude, latLng.longitude);
    lat_new = latLng.latitude;
    lng_new = latLng.longitude;
    var place = placeMarks.first;
    print(place);

    var _address = '';
    if (description.isNotEmpty) {
      _address = description + ' - ${place.postalCode}';
    } else {
      _address =
          '${place.street}, ${place.thoroughfare},${place.subLocality}, ${place.locality}, ${place.country} - ${place.postalCode}';
    }
    if (!isSelectFromSearch) {
      setState(isBack
          ? () {
              var fullAddress = _address.replaceAll(RegExp(r'\,{2,200}'), ',');
              _addressController.location.text =
                  fullAddress.replaceAll(RegExp(r'\ \,'), ' ');
              _addressController.city.value = place.locality!;
              _addressController.state.value = place.administrativeArea!;
              _addressController.postalCode.value = place.postalCode!;
              _addressController.country.value = place.country!;
              _addressController.postalCodeController.text = place.postalCode!;
              _addressController.lat.value = latLng.latitude;
              _addressController.lng.value = latLng.longitude;
            }
          : () {
              var fullAddress = _address.replaceAll(RegExp(r'\,{2,200}'), ',');
              _addressController.appBarText.value =
                  fullAddress.replaceAll(RegExp(r'\ \,'), ' ');
              _addressController.location.text =
                  fullAddress.replaceAll(RegExp(r'\ \,'), ' ');
              _addressController.city.value = place.locality!;
              _addressController.state.value = place.administrativeArea!;
              _addressController.postalCode.value = place.postalCode!;
              _addressController.country.value = place.country!;
              _addressController.postalCodeController.text = place.postalCode!;
              _addressController.lat.value = latLng.latitude;
              _addressController.lng.value = latLng.longitude;
              _addressController.lat2.value = latLng.latitude;
              _addressController.lng2.value = latLng.longitude;
            });
    } else {
      setState(() {
        _addressController.city.value = place.locality!;
        _addressController.state.value = place.administrativeArea!;
        _addressController.postalCode.value = place.postalCode!;
        _addressController.country.value = place.country!;
        _addressController.postalCodeController.text = place.postalCode!;
        _addressController.lat.value = latLng.latitude;
        _addressController.lng.value = latLng.longitude;
        _addressController.lat2.value = latLng.latitude;
        _addressController.lng2.value = latLng.longitude;
      });
    }
  }

  getCenter() async {
    LatLngBounds bounds = await mapController.getVisibleRegion();
    LatLng center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );

    return center;
  }

  GlobalKey key = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    // Variable to track button state
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child:  Icon(Icons.chevron_left_rounded,size: 35,color: Colors.white,),
        ),
        elevation: 0,
        backgroundColor: AppColors.primary,
        centerTitle: false,
        title: Text("Set Location", style: TextStyles.appBarTitle),
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
          : isTap
              ? Container(
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
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.primary,
                          ),
                          filled: true,
                          fillColor: AppColors.secondary,
                          contentPadding:
                              EdgeInsets.all(ScreenConstant.sizeMedium),
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
                                setState(() {
                                  _isLoading = true;
                                  isSelectFromSearch = true;
                                  _isButtonEnabled = false;

                                });
                                debugPrint(predictions[index].placeId);
                                getDetils(predictions[index].placeId!);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Stack(
                  children: [
                    MapPicker(
                      iconWidget: Tooltip(
                        message: _addressController.appBarText.value,
                        preferBelow: false,
                        textStyle: TextStyle(
                          height: 1.3,
                          color: AppColors.secondary,
                        ),
                        decoration: BoxDecoration(color: AppColors.accentColor),
                        margin:
                            EdgeInsets.only(left: 100, right: 100, bottom: 5),
                        padding: EdgeInsets.all(5),
                        verticalOffset: 20,
                        waitDuration: const Duration(seconds: 1),
                        triggerMode: TooltipTriggerMode.tap,
                        child: Container(
                          height: ScreenConstant.sizeXXXL,
                          width: ScreenConstant.sizeXXXL,
                          child: Image(
                            fit: BoxFit.contain,
                            color: AppColors.primary,
                            image: AssetImage(
                              Assets.mapPin,
                            ),
                          ),
                        ),
                      ),
                      mapPickerController: mapPickerController,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: cameraPosition,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        //myLocationEnabled: true,
                        onCameraMoveStarted: () {
                          mapPickerController.mapMoving!();
                        },
                        onCameraIdle: () async {
                          // notify map stopped moving
                          mapPickerController.mapFinishedMoving!();
                          print(cameraPosition.target.latitude);
                          print(cameraPosition.target.longitude);
                          setState(() {
                            setInitialAddress(
                                latLng: LatLng(cameraPosition.target.latitude,
                                    cameraPosition.target.longitude));
                          });
                          //get address name from camera s
                          /*  List<Address> addresses = await Geocoder.local
          .findAddressesFromCoordinates(Coordinates(
      cameraPosition.target.latitude,
      cameraPosition.target.longitude));*/
                          // update the ui with the address
                        },
                        onCameraMove: (position) async {
                          setState(() {
                            isSelectFromSearch = false;
                            data = position.target;
                          });
                          final GoogleMapController controller =
                              await _controller.future;

                          /*controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  target: data,
                  zoom: 14,
                )));*/
                          this.cameraPosition = position;

                          print(position.target);
                          final marker = Marker(
                            markerId: MarkerId('place_name'),
                            position: data,
                            draggable: false,
                            // icon: BitmapDescriptor.,
                            infoWindow: InfoWindow(
                              title: 'Mediacal store',
                            ),
                          );

                          setState(() {
                            //  markers[MarkerId('place_name')] = marker;
                          });
                        },
                        onMapCreated: (GoogleMapController controller) {
                          setState(() {
                            mapController = controller;
                          });

                          setState(() {
                            _mapCreated = true;
                          });

                          final marker = Marker(
                            markerId: MarkerId('place_name'),
                            position: LatLng(43.900250, -91.070580),
                            draggable: false,

                            // icon: BitmapDescriptor.,
                            infoWindow: InfoWindow(
                              title: 'Mediacal store',
                            ),
                          );

                          /*  setState(() {
                  markers[MarkerId('place_name')] = marker;
                });*/
                          _controller.complete(controller);
                        },
                      ),
                    ),
                    Positioned(
                      left: 10,
                      right: 10,
                      top: 20,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isTap = true;
                          });
                          // Get.to(MapViewAddressSearchScreen());
                        },
                        child: SearchWidget(
                          searchLevelText: "Search for area, city or more...",
                        ),
                      ),
                    ),
                    Positioned(
                        top: 80,
                        left: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            bool serviceEnabled;
                            LocationPermission permission;
                            loc.Location location = new loc.Location();

                            // Test if location services are enabled.
                            serviceEnabled =
                                await Geolocator.isLocationServiceEnabled();

                            permission = await Geolocator.checkPermission();

                            if (serviceEnabled &&
                                permission != LocationPermission.denied &&
                                permission !=
                                    LocationPermission.deniedForever) {
                              print("LINE NO 297");
                              // await _determinePosition()
                              //     .then((Position value) async {
                              //   setLatLng(
                              //       LatLng(value.latitude, value.longitude));
                              // });
                              // _addressController.isEdit.value = false;
                              // Get.to(MapView(
                              //   value: LatLng(_addressController.lat2.value,
                              //       _addressController.lng2.value),
                              // ));
                              setState(() {
                                isSelectFromSearch = false;

                                _isLoading = true;
                              });
                              useCurrentLocation();
                            } else if (!serviceEnabled) {
                              print("LINE NO 310");

                              _serviceEnabled = await location.requestService();
                            } else if (permission ==
                                LocationPermission.whileInUse) {
                              _serviceEnabled = await location.requestService();
                            } else if (permission ==
                                LocationPermission.unableToDetermine) {
                              _serviceEnabled = await location.requestService();
                            } else if (permission ==
                                LocationPermission.denied) {
                              print("LINE NO 318");
                              Widget cancelButton = TextButton(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: AppColors.accentColor,
                                      fontSize: FontSizeStatic.md,
                                      fontWeight: FontWeight.bold,
                                      /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                          'Poppins'),
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              );
                              Widget continueButton = TextButton(
                                child: Text(
                                  "Settings",
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: FontSizeStatic.md,
                                      fontWeight: FontWeight.bold,
                                      /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                          'Poppins'),
                                ),
                                onPressed: () async {
                                  Get.back();
                                  openAppSettings();
                                },
                              );

                              // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text(
                                  "Sorry!",
                                  style: TextStyles.productPrice,
                                ),
                                content: Text(
                                  "Please update your location permission from the app settings.",
                                  style: TextStyles.chooseCategorySubTitle,
                                ),
                                actions: [
                                  cancelButton,
                                  continueButton,
                                ],
                              );

                              // show the dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            } else if (permission ==
                                LocationPermission.deniedForever) {
                              print("LINE NO 372");
                              Widget cancelButton = TextButton(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: AppColors.accentColor,
                                      fontSize: FontSizeStatic.md,
                                      fontWeight: FontWeight.bold,
                                      /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                          'Poppins'),
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              );
                              Widget continueButton = TextButton(
                                child: Text(
                                  "Settings",
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: FontSizeStatic.md,
                                      fontWeight: FontWeight.bold,
                                      /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                          'Poppins'),
                                ),
                                onPressed: () async {
                                  Get.back();
                                  openAppSettings();
                                },
                              );

                              // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text(
                                  "Sorry!",
                                  style: TextStyles.productPrice,
                                ),
                                content: Text(
                                  "Please update your location permission from the app settings.",
                                  style: TextStyles.chooseCategorySubTitle,
                                ),
                                actions: [
                                  cancelButton,
                                  continueButton,
                                ],
                              );

                              // show the dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            } else {
                              print("LINE NO 427");
                              permission = await Geolocator.requestPermission();
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: AppColors.buttonColorSecondary,
                                    width: 1.5)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.gps_fixed,
                                      size: 20,
                                      color: AppColors.buttonColorSecondary),
                                  Text("Use current location",
                                      style: TextStyle(
                                        color: AppColors.buttonColorSecondary,
                                        fontSize: FontSizeStatic.maxMd,
                                        /* fontFamily: 'Proxima-Regular' */ fontFamily:
                                            'Poppins',
                                      )),
                                ],
                              )),
                            ),
                          ),
                        )),

                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        //height: ScreenConstant.sizeUltraXXXL,
                        decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenConstant.sizeLarge,
                                  left: ScreenConstant.sizeMedium,
                                  right: ScreenConstant.sizeMedium,
                                  bottom: ScreenConstant.sizeSmall),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "MY LOCATION",
                                    style: TextStyle(
                                        fontSize: FontSizeStatic.md,
                                        color: AppColors.storeDistance,
                                        /* fontFamily: 'Proxima-Regular' */ fontFamily:
                                            'Poppins'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenConstant.sizeSmall,
                                  left: ScreenConstant.sizeMedium,
                                  right: ScreenConstant.sizeMedium,
                                  bottom: ScreenConstant.sizeSmall),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.location_on_rounded),
                                  Container(
                                    width: ScreenConstant.sizeSmall,
                                  ),
                                  Obx(() => Expanded(
                                          child: Text(
                                        _addressController.appBarText.value,
                                        style: TextStyle(
                                            fontSize: FontSizeStatic.xl,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.accentColor,
                                            /* fontFamily: 'Proxima-Bold' */ fontFamily:
                                                'Poppins'),
                                      ))),
                                  /*Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.gapColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: ScreenConstant.sizeSmall,
                              bottom: ScreenConstant.sizeExtraSmall,
                              right: ScreenConstant.sizeSmall,
                              top: ScreenConstant.sizeExtraSmall,
                            ),
                            child: Center(
                                child: Text(
                                  "CHANGE",
                                  style: TextStyles.change,
                                )),
                          ),
                        ),*/
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: ScreenConstant.sizeXXXL,
                                width: Get.width,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    elevation: 0,
                                    backgroundColor: _isButtonEnabled
                                        ? AppColors.buttonColorSecondary
                                        : Colors
                                            .grey, // Change color based on button state
                                  ),
                                  onPressed: _isButtonEnabled
                                      ? () async {
                                          setState(() {
                                            _isButtonEnabled =
                                                false; // Disable the button
                                          });

                                          // Perform any necessary actions here
                                          _addressController
                                              .getAddressFromLatLng(
                                                  lat_new!, lng_new!);
                                        }
                                      : null,
                                  child: Text(
                                    "Confirm Location",
                                    style: TextStyle(
                                      fontSize: FontSizeStatic.lg,
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ----------Use current Location Positioned
                  ],
                ),
    );
  }

  void showMoreText(String text) {
    ShowMoreTextPopup popup = ShowMoreTextPopup(
      context,
      text: text,
      textStyle: TextStyle(
        color: Colors.white,
      ),
      height: 70,
      width: 210,
      backgroundColor: AppColors.accentColor,
      padding: EdgeInsets.only(left: 2.0, right: 2, bottom: 1, top: 1),
      borderRadius: BorderRadius.circular(10.0),
    );

    /// show the popup for specific widget
    popup.show(
      widgetKey: key,
    );
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(
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
    var result = await this.googlePlace.details.get(placeId);
    if (result != null && result.result != null && mounted) {
      setState(() {
        detailsResult = result.result!;
        debugPrint("Location=========:- ${detailsResult.formattedAddress}");
        FocusManager.instance.primaryFocus!.unfocus();
        var fullAddress = detailsResult.formattedAddress!
            .replaceAll(RegExp(r'\,{2,200}'), ',');
        _addressController.appBarText.value =
            fullAddress.replaceAll(RegExp(r'\ \,'), ' ');
        _addressController.location.text =
            fullAddress.replaceAll(RegExp(r'\ \,'), ' ');
        double? lat = detailsResult.geometry?.location?.lat;
        double? lng = detailsResult.geometry?.location?.lng;

        if (lat != null && lng != null) {
          setInitialAddress(latLng: LatLng(lat, lng));
        } else {
          // Handle the case when lat or lng is null
          // You might want to add some default behavior or display an error message
        }
        double? lati = detailsResult.geometry?.location?.lat;
        double? lngi = detailsResult.geometry?.location?.lng;

        if (lat != null && lng != null) {
          cameraPosition = CameraPosition(
            target: LatLng(lati!, lngi!),
            zoom: 18,
          );
        } else {
          // Handle the case when lat or lng is null
          // You might want to add some default behavior or display an error message
        }

        isTap = false;
        _isLoading = false;
        _isButtonEnabled = true;
      });
    }
  }

  void useCurrentLocation() async {
    await _determinePosition().then((Position value) async {
      setLatLng(LatLng(value.latitude, value.longitude));
    });
    setState(() {
      cameraPosition = CameraPosition(
        target: LatLng(
            _addressController.lat2.value, _addressController.lng2.value),
        zoom: 18,
      );

      _isLoading = false;
      _isButtonEnabled = true;
    });
  }

  setLatLng(LatLng _position) async {
    _addressController.lat.value = _position.latitude;
    _addressController.lng.value = _position.longitude;
    _addressController.lat2.value = _position.latitude;
    _addressController.lng2.value = _position.longitude;

    print("Lat : ${_addressController.lat.value}");
    print("Lng : ${_addressController.lng.value}");
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
}
