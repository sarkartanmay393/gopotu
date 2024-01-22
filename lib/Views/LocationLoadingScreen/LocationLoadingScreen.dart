import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_potu_user/Controller/ProfileController/ProfileController.dart';
import '../../Controller/AddressController/AddressController.dart';
import '../../Controller/DashboardController/DashboardController.dart';
import '../../DeviceManager/Assets.dart';
import '../../DeviceManager/Colors.dart';
import '../../DeviceManager/ScreenConstants.dart';
import '../../Store/HiveStore.dart';
import '../../Widgets/SplashWidgets/SplashLogoWidgets.dart';

class LocationLoadingScreen extends StatefulWidget {
  @override
  _LocationLoadingScreenState createState() => _LocationLoadingScreenState();
}

class _LocationLoadingScreenState extends State<LocationLoadingScreen> {
  final AddressController _addressController = Get.put(AddressController());
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _profileController.getAccountPress(false);
    String isDefaultAddress = await HiveStore().get(Keys.isDefaultAddressSet);

    if (isDefaultAddress == "false") {
      await HiveStore().put(Keys.isDefaultAddressSet, "true");
      await _processAddress();
    }
  }

  Future<void> _processAddress() async {
    String? userData;
    print("I am on loading page.");

    while (true) {
      userData = await HiveStore().get(Keys.profileData)?['name'];
      if (userData == null) {
        await Future.delayed(Duration(seconds: 2)); // Wait for 4 seconds
        await ProfileController().getAccountPress(false);
      }

      if (userData != null) {
        break; // Exit the loop when userData is not null
      }

      print(userData);
    }

    Map<String, double>? currentLocation =
        await _addressController.fetchCurrentLocation();

    if (currentLocation != null) {
      double? lat = currentLocation['latitude'];
      double? long = currentLocation['longitude'];
      HiveStore().put(Keys.currLat, lat!);
      HiveStore().put(Keys.currLong, long!);
      await _addressController.getAddressFromLatLng(lat!, long!);
    }

    print("I am called now");
  }

  @override
  Widget build(BuildContext context) {
    ScreenConstant.setScreenAwareConstant(context);
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Container(
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image:
          //       AssetImage('assets/splash.jpg'), // Replace with your image path
          //   fit: BoxFit.cover,
          // ),
        ),
        // child: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Expanded(
        //         child: SplashLogoWidget(
        //           padding: EdgeInsets.all(ScreenConstant.defaultHeightOneHundred),
        //           image: Assets.splashpng,
        //         ),
        //       ),
        //
        //       Container(
        //         height: ScreenConstant.sizeXL,
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
