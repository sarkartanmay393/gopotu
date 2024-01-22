import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'vm.dart';

class Keys {
  static const String deviceID = "deviceID";
  static const String accessToken = "accessToken";
  static const String guestToken = "guestToken";
  static const dynamic profileData = "profileData";
  static const String userNumber = "userNumber";
  static const String landingShow = "landingShow";
  static const String shopType = "shopType";
  static const String typeSelectIndex = "typeSelectIndex";
  static const String isDefaultAddressSet = "isDefaultAddressSet";
  static const String isHomeScreen = "isHomeScreen";
  static const String isStoreScreen = "isStoreScreen";

  static const String playerID = "pairId";
  static const String loginUserId = "loginUserId";
  static const String currLat = "currLatitude";
  static const String currLong = "currLongitude";
}

class HiveStore {
  //Singleton Class
  static final HiveStore _default = new HiveStore._internal();
  static Box? defBox;

  factory HiveStore() {
    return _default;
  }

  HiveStore._internal();

  static getInstance() {
    return _default;
  }

  initBox() async {
    defBox = await openBox();
  }

  //Object Storage
  put(String key, Object value) async {
    defBox!.put(key, value);
    print("HiveStored : Key:$key, Value:$value");
  }

  get(String key) {
    print("Box is Open? ${defBox!.isOpen}");
    print("HiveRetrive : Key:$key, Value:${defBox!.get(key)}");
    return defBox!.get(key);
  }

  clear() {
    defBox!.clear();
  }

  delete(String key) async {
    defBox!.delete(key);
  }

  Future openBox() async {
    if (!isBrowser) {
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }
    return await Hive.openBox('Store');
  }
}
