import 'package:get/get.dart';
import '../../Models/ResponseModels/AccountSettingResponseModel/AccountSettingResponseModel.dart';
import '../../Service/CoreService.dart';
import '../../Service/Url.dart';

class SplashController extends GetxController {
  var isMain = false.obs;
  var appVirsion = "0.0.4".obs;
  var accountSettingsData = Data().obs;
  var isUpdate = false.obs;
  var maintenanceMess = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAccountSetting(false);
  }

  getAccountSetting(bool load) async {
    await getAccountSettingApiCall(load).then((result) async {
      if (result is AccountSettingResponseModel) {
        if (result.status == "success") {
          accountSettingsData.value = result.data!;
          if (result.data?.appsettings?.maintenanceMessage != null) {
            isMain.value = true;
            maintenanceMess.value =
                result.data?.appsettings?.maintenanceMessage;
          } else if (appVirsion.value != result.data!.appsettings?.version) {
            isUpdate.value = true;
            isMain.value = true;
          } else {
            isMain.value = false;
          }
        } else {}
      }
    });
    if (isMain.value) {
      return true;
    } else {
      return false;
    }
  }

  getAccountSettingApiCall(bool load) async {
    var result = await CoreService().apiService(
      loader: load,
      baseURL: baseUrl,
      method: METHOD.POST,
      endpoint: getAccountSettingUrl,
    );


    return AccountSettingResponseModel.fromJson(result);
  }
}
