import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/AddToCartController/AddToCartController.dart';
import 'package:go_potu_user/Controller/ChooseCategoryController/ChooseCategoryController.dart';
import 'package:go_potu_user/Controller/MyBucketController/MyBucketController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultResponseModel/DefaultResponseModel.dart';
import 'package:go_potu_user/Models/DefaultModels/DefaultSendModel/DefaultHeaderSendModel.dart';
import 'package:go_potu_user/Models/ResponseModels/StateListResponseModel/StateListResponseModel.dart';
import 'package:go_potu_user/Models/SendModels/AddAddressSendModel/AddAddressSendModel.dart';
import 'package:go_potu_user/Models/SendModels/ChangeAddressFromCheckoutPageSendModel/ChangeAddressFromCheckoutPageSendModel.dart';
import 'package:go_potu_user/Models/SendModels/SetDefaultAddressSendModel/SetDefaultAddressSendModel.dart';
import 'package:go_potu_user/Router/RouteConstants.dart';
import 'package:go_potu_user/Service/CoreService.dart';
import 'package:go_potu_user/Service/Url.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Views/CategoryScreen/ChooseCategoryScreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../Store/ScopeStorage.dart';
import '../../Store/ShareStore.dart';
import '../../Views/AddressScreens/AddNewAddressScreen.dart';
import 'package:http/http.dart' as http;

class AddressController extends GetxController {
  var defaultAddressId = 0;
  var addressListData = <dynamic>[].obs;
  var addressId = "".obs;
  var deleteAddressId = "".obs;
  var editAddressId = "".obs;
  var editAddressIndex = 0.obs;
  late TextEditingController billNameController;
  late TextEditingController alternativePhController;
  late TextEditingController villageNameController;
  late TextEditingController landMarkController;
  late TextEditingController location;
  late TextEditingController mobileController;
  late TextEditingController postalCodeController;
  var city = "".obs;
  var state = "".obs;
  var country = "".obs;
  var postalCode = "".obs;
  var lat2 = 0.0.obs;
  var lng2 = 0.0.obs;
  var lat = 0.0.obs;
  var lng = 0.0.obs;
  var currLatitude = 0.0.obs;
  var currLongitude = 0.0.obs;
  var addressType = "".obs;
  var isCheckOutPage = false.obs;
  var isEdit = false.obs;
  var isHomeScreen = false.obs;
  var appBarText = "".obs;
  var isLoading = false.obs;
  var shopId = "".obs;
  var center = LatLng(0, 0).obs;
  var stateData = <StateList>[].obs;
  var selectState = "Andaman and Nicobar Islands".obs;
  var fromAddAddress = false.obs;
  var isAddressCardSelect = false.obs;
  var onAddressSelect = 150.obs;
  var isChaeckOutAddAddress = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    billNameController = TextEditingController();
    alternativePhController = TextEditingController();
    villageNameController = TextEditingController();
    landMarkController = TextEditingController();
    location = TextEditingController();
    mobileController = TextEditingController();
    postalCodeController = TextEditingController();
    super.onInit();
  }

  fetchAddressListPress(bool isLoader) {
    fetchAddressListApiCall(isLoader).then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          isLoading.value = true;
          addressListData.assignAll(result.data['addresses']);
          print("addressListData.length :${addressListData.length}");
        } else {
          isLoading.value = true;
          Get.snackbar(
            "Sorry!",
            result.message!,
            backgroundColor: AppColors.secondary,
            duration: Duration(seconds: 1),
            icon: Icon(
              Icons.error_outline_sharp,
              color: Colors.red,
            ),
            titleText: Text(
              "Sorry!",
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the title
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              result.message!,
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the message
              ),
            ),
          );
        }
      }
    });
  }

  fetchAddressListApiCall(bool loader) async {
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      guestToken: HiveStore().get(Keys.guestToken),
    );

    ChangeAddressFromCheckoutPageSendModel model =
        ChangeAddressFromCheckoutPageSendModel(
      shopId: isCheckOutPage.value ? shopId.value : "",
    );

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      baseURL: baseUrl,
      body: model.toJson(),
      method: METHOD.POST,
      loader: loader,
      endpoint: fetchAddressListUrl,
    );
    return DefaultResponseModel.fromJson(result);
  }

  setDefaultAddressPress() {
    setDefaultAddressApiCall().then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          await HiveStore().put(Keys.isDefaultAddressSet, "true");
          if (isCheckOutPage.value == true) {
            await HiveStore().put(Keys.isDefaultAddressSet, "true");
            Get.back();
            print("I reached here PArt 1");
            final MyBucketController myBucketController = Get.find();
            myBucketController.getBucketPress(true, "", );
            AddToCartController addToCartController =
                Get.put(AddToCartController());
            addToCartController.fetchCartCountPress(false);
            isCheckOutPage.value = false;
            print("I reached here PArt 2");
          } else {
            if (HiveStore().get(Keys.shopType) == null) {
              Get.offAllNamed(dashBoard);
              ShareStore().saveData(store: KeyStore.typeIndex, object: "0");
              HiveStore().put(Keys.typeSelectIndex, "0");
              ShareStore().saveData(store: KeyStore.type, object: "mart");
              HiveStore().put(Keys.shopType, "mart");
              // ----------------------------
              // ChooseCategoryController chooseCategoryController =
              //     Get.put(ChooseCategoryController());
              // chooseCategoryController.isBeforeDashboard.value = true;
              // Get.to(ChooseCategoryScreen());
            } else {
              Get.offAllNamed(dashBoard);
            }
          }
        } else {
          Get.snackbar(
            "Sorry!",
            result.message!,
            backgroundColor: AppColors.secondary,
            duration: Duration(seconds: 1),
            icon: Icon(
              Icons.error_outline_sharp,
              color: Colors.red,
            ),
            titleText: Text(
              "Sorry!",
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the title
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              result.message!,
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the message
              ),
            ),
          );
        }
      }
    });
  }

  setDefaultAddressApiCall() async {
    SetDefaultAddressSendModel model = SetDefaultAddressSendModel(
      id: addressId.value,
    );
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      guestToken: HiveStore().get(Keys.guestToken),
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: setDefaultAddress,
    );

    return DefaultResponseModel.fromJson(result);
  }

  deleteAddressPress() {
    deleteAddressApiCall().then((result) async {
      if (result is DefaultResponseModel) {
        if (result.status == "success") {
          fetchAddressListPress(false);
          Get.snackbar(
            "Success",
            result.message!,
            backgroundColor: AppColors.secondary,
            duration: Duration(seconds: 1),
            icon: Icon(
              Icons.done,
              color: Colors.greenAccent,
            ),
            titleText: Text(
              "Success",
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the title
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              result.message!,
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the message
              ),
            ),
          );
        } else {
          Get.snackbar(
            "Sorry!",
            result.message!,
            backgroundColor: AppColors.secondary,
            duration: Duration(seconds: 1),
            icon: Icon(
              Icons.error_outline_sharp,
              color: Colors.red,
            ),
            titleText: Text(
              "Sorry!",
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the title
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              result.message!,
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the message
              ),
            ),
          );
        }
      }
    });
  }

  deleteAddressApiCall() async {
    SetDefaultAddressSendModel model = SetDefaultAddressSendModel(
      id: deleteAddressId.value,
    );
    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken),
      guestToken: HiveStore().get(Keys.guestToken),
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: deleteAddress,
    );
    return DefaultResponseModel.fromJson(result);
  }

  addAddressPress() {
    if (billNameController.text == null || billNameController.text.isEmpty) {
      Get.snackbar(
        "Sorry!",
        "Please enter your name",
        backgroundColor: AppColors.secondary,
        duration: Duration(seconds: 1),
        icon: Icon(
          Icons.error_outline_sharp,
          color: Colors.red,
        ),
        titleText: Text(
          "Sorry!",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the title
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: Text(
          "Please enter your name",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the message
          ),
        ),
      );
    } else if (villageNameController.text == null ||
        villageNameController.text.isEmpty) {
      Get.snackbar(
        "Sorry!",
        "Please enter your Village/City name",
        backgroundColor: AppColors.secondary,
        duration: Duration(seconds: 1),
        icon: Icon(
          Icons.error_outline_sharp,
          color: Colors.red,
        ),
        titleText: Text(
          "Sorry!",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the title
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: Text(
          "Please enter your Village/City name",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the message
          ),
        ),
      );
    } else if (landMarkController.text == null ||
        landMarkController.text.isEmpty) {
      Get.snackbar(
        "Sorry!",
        "Please enter at least one landmark",
        backgroundColor: AppColors.secondary,
        duration: Duration(seconds: 1),
        icon: Icon(
          Icons.error_outline_sharp,
          color: Colors.red,
        ),
        titleText: Text(
          "Sorry!",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the title
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: Text(
          "Please enter at least one landmark",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the message
          ),
        ),
      );
    } else if (addressType.value == "" || addressType.value.isEmpty) {
      Get.snackbar(
        "Sorry!",
        "Please select your address type",
        backgroundColor: AppColors.secondary,
        duration: Duration(seconds: 1),
        icon: Icon(
          Icons.error_outline_sharp,
          color: Colors.red,
        ),
        titleText: Text(
          "Sorry!",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the title
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: Text(
          "Please select your address type",
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the message
          ),
        ),
      );
    } else {
      addAddressApiCall().then((result) async {
        if (result is DefaultResponseModel) {
          if (result.status == "success") {
            Get.back();
            fetchAddressListPress(true);
            isCheckOutPage.value
                ? isChaeckOutAddAddress.value
                    ? Get.back()
                    : Get.toNamed(addressList)
                : isHomeScreen.value
                    ? Get.toNamed(addressList)
                    : Get.offAllNamed(addressList);
            billNameController.text = "";
            alternativePhController.text = "";
            villageNameController.text = "";
            landMarkController.text = "";
            addressType.value = "";
            // lat.value = 0.0;
            // lng.value = 0.0;
            // lat2.value = 0.0;
            // lng2.value = 0.0;
            fromAddAddress.value = false;
            isChaeckOutAddAddress.value = false;
          } else {
            Get.snackbar(
              "Sorry!",
              result.message!,
              backgroundColor: AppColors.secondary,
              duration: Duration(seconds: 1),
              icon: Icon(
                Icons.error_outline_sharp,
                color: Colors.red,
              ),
              titleText: Text(
                "Sorry!",
                style: TextStyle(
                  fontFamily:
                      'Poppins', // Replace with the desired font family for the title
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              messageText: Text(
                result.message!,
                style: TextStyle(
                  fontFamily:
                      'Poppins', // Replace with the desired font family for the message
                ),
              ),
            );
          }
        }
      });
    }
  }

  addAddressApiCall() async {
    AddAddressSendModel model = AddAddressSendModel(
      name: billNameController.text,
      mobile: HiveStore().get(Keys.userNumber) == null
          ? mobileController.text
          : HiveStore().get(Keys.userNumber),
      addressLine1: villageNameController.text,
      alternativePhoneNumber: alternativePhController.text ?? "",
      location: location.text,
      city: city.value,
      country: country.value,
      state: "WB",
      postalCode: postalCodeController.text,
      latitude: lat.value.toString(),
      longitude: lng.value.toString(),
      landmark: landMarkController.text,
      type: addressType.value,
    );

    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken) ?? "",
      guestToken: HiveStore().get(Keys.guestToken) ?? "",
    );

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: addOrdersUrl,
    );
    return DefaultResponseModel.fromJson(result);
  }

  Future<String?> getAddressFromLatLng(
      double lat_fetch, double lng_fetch) async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url =
        '$_host?key=$kGoogleApiKey&language=en&latlng=$lat_fetch,$lng_fetch';

    if (lat_fetch != null && lng_fetch != null) {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String formattedAddress = data["results"][0]["formatted_address"];
        print(data["results"][0]);
        Map<String, dynamic> geometry = data["results"][0]['geometry'];
        lat.value = geometry['location']['lat'];
        lng.value = geometry['location']['lng'];

        List<dynamic> addressComponents =
            data["results"][0]['address_components'];
        for (var component in addressComponents) {
          List<String> types = List<String>.from(component["types"]);
          print(component);
          if (types.contains("locality")) {
            city.value = component["long_name"];
          }
          if (types.contains("postal_code")) {
            postalCodeController.text = component["long_name"];
          }
        }
        // city.value= data["results"][0]['address_components'][2]['long_name'];
        // postalCodeController.text = data["results"][0]['address_components'][7]['long_name'];
        landMarkController.text =
            data["results"][0]['address_components'][1]['long_name'];
        location.text =
            data["results"][0]['address_components'][1]['long_name'];

        print('City Name: ' + city.value);
        print('Postal Code:' + postalCodeController.text);
        print('Land Mark:' + landMarkController.text);
        print('Latitude: ' + lat.value.toString());
        print('Longitude: ' + lng.value.toString());
        print('Formatted Address: $formattedAddress');
        lng.value=

        addCurrentAddressApiCall();
        return formattedAddress;
      }
    }
  }

  Future<Map<String, double>?> fetchCurrentLocation() async {
    try {
      Location location = Location();
      bool serviceEnabled;
      PermissionStatus permission;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled.');
        return null;
      }

      permission = await location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await location.requestPermission();
        if (permission == PermissionStatus.denied) {
          print('Location permissions are denied.');
          return null;
        }
      }

      if (permission == PermissionStatus.deniedForever) {
        print('Location permissions are permanently denied.');
        return null;
      }

      Position position = await _determinePosition();
      print('Current Location: ${position.latitude}, ${position.longitude}');

      return {
        "latitude": position.latitude,
        "longitude": position.longitude,
      };
    } catch (error) {
      print('Error: $error');
      return null;
    }
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

  addCurrentAddressApiCall() async {
    AddAddressSendModel model = AddAddressSendModel(
      name: HiveStore().get(Keys.profileData)['name'],
      mobile: HiveStore().get(Keys.profileData)['mobile'],
      // mobile: HiveStore().get(Keys.userNumber) == null
      // ? mobileController.text
      // : HiveStore().get(Keys.userNumber),
      addressLine1: villageNameController.text,
      alternativePhoneNumber: alternativePhController.text ?? "",
      location: location.text,
      city: city.value,
      country: 'India',
      state: "WB",
      postalCode: postalCodeController.text,
      latitude: lat.value.toString(),
      longitude: lng.value.toString(),
      landmark: landMarkController.text,
      type: "current",
    );

    DefaultHeaderSendModel headerModel = DefaultHeaderSendModel(
      authorization: HiveStore().get(Keys.accessToken) ?? "",
      guestToken: HiveStore().get(Keys.guestToken) ?? "",
    );

    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      body: model.toJson(),
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: addOrdersUrl,
    );
    addressId.value = result['data']['id'].toString();
    await setDefaultAddressPress();
    return DefaultResponseModel.fromJson(result);
  }

  fetchStateListPress(bool isLoader) {
    fetchStateListApiCall(isLoader).then((result) async {
      if (result is StateListResponseModel) {
        if (result.status == "success") {
          stateData.assignAll(result.data!.states as Iterable<StateList>);
        } else {
          isLoading.value = true;
          Get.snackbar(
            "Sorry!",
            result.message!,
            backgroundColor: AppColors.secondary,
            duration: Duration(seconds: 1),
            icon: Icon(
              Icons.error_outline_sharp,
              color: Colors.red,
            ),
            titleText: Text(
              "Sorry!",
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the title
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              result.message!,
              style: TextStyle(
                fontFamily:
                    'Poppins', // Replace with the desired font family for the message
              ),
            ),
          );
        }
      }
    });
  }

  fetchStateListApiCall(bool loader) async {
    var result = await CoreService().apiService(
      baseURL: baseUrl,
      method: METHOD.POST,
      loader: loader,
      endpoint: fetchStateListUrl,
    );
    return StateListResponseModel.fromJson(result);
  }
}
