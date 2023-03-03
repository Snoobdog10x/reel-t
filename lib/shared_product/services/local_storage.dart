import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final String SIGNED_IN_USER_CACHE_KEY = "sign_in_user";
  SharedPreferences? _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> setCache(String key, String value) async {
    if (_preferences == null) return false;

    bool isSet = await _preferences!.setString(key, value);
    return isSet;
  }

  String getCache(String key) {
    if (_preferences != null) return "";

    var data = _preferences!.getString(key);
    if (data == null) return "";

    return data;
  }
}
