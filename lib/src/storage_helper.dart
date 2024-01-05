import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static late SharedPreferences _preferences;

  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  static String? getString(String key) {
    return _preferences.getString(key);
  }

  static Future<bool> saveBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  static Future<bool> saveInt(String key, int value) async {
    return await _preferences.setInt(key, value);
  }

  static int? getInt(String key) {
    return _preferences.getInt(key);
  }

  static Future<bool> saveDouble(String key, double value) async {
    return await _preferences.setDouble(key, value);
  }

  static double? getDouble(String key) {
    return _preferences.getDouble(key);
  }

  static Future<bool> remove(String key) async {
    return await _preferences.remove(key);
  }

  static Future<bool> clear() async {
    return await _preferences.clear();
  }
}
