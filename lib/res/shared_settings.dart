import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_flutter_app/res/utils.dart';

class SharedSettings {
  late SharedPreferences _prefs;

  SharedSettings(SharedPreferences prefs) {
    _prefs = prefs;
  }

  Future setAndSaveObject(String key, Map value) async {
    await _prefs.setString(key, json.encode(value));
  }

  Future setAndSaveList(String key, List value) async {
    await _prefs.setString(key, json.encode(value));
  }

  Future setAndSaveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  Future setAndSaveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  Future setAndSaveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  Map<String, dynamic>? getObjectFromPrefs(String key) {
    try {
      String? jsonString = _prefs.getString(key);

      if (jsonString == null) {
        return null;
      }

      return json.decode(jsonString);
    } catch (e) {
      return null;
    }
  }

  List<dynamic>? getListFromPrefs(String key) {
    try {
      String? jsonString = _prefs.getString(key);

      if (jsonString == null) {
        return null;
      }

      return json.decode(jsonString);
    } catch (e) {
      Utils.log(e);
      return null;
    }
  }

  String getStringFromPrefs(String key) {
    try {
      return _prefs.getString(key) ?? "";
    } catch (e) {
      return "";
    }
  }

  int getIntFromPrefs(String key) {
    try {
      return _prefs.getInt(key) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  bool getBoolFromPrefsDefaultTrue(String key) {
    try {
      return _prefs.getBool(key) ?? true;
    } catch (e) {
      return true;
    }
  }

  bool getBoolFromPrefsDefaultFalse(String key) {
    try {
      return _prefs.getBool(key) ?? false;
    } catch (e) {
      return false;
    }
  }
}
