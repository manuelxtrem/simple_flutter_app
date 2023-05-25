import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_flutter_app/res/shared_settings.dart';
import 'package:simple_flutter_app/res/utils.dart';

class UserCache extends SharedSettings {
  static const String userSettings = "user_settings";
  static const String isLoggedInKey = 'is_logged_in';
  static const String userIdKey = 'user_id';

  UserCache(SharedPreferences prefs) : super(prefs);

  void reset() {}

  Future setLoggedIn(bool status, String userId) async {
    await setAndSaveBool(isLoggedInKey, status);
    await setUserId(userId);
  }

  bool isLoggedIn() {
    return getBoolFromPrefsDefaultFalse(isLoggedInKey) && !Utils.isEmptyOrNull(getUserId());
  }

  Future setUserId(String userId) async {
    setAndSaveString(userIdKey, userId);
  }

  String getUserId() {
    return getStringFromPrefs(userIdKey);
  }
}
