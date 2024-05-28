import 'package:encrypt_shared_preferences/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefrence {
  static Future<bool> getBoolean(String key) async {
    final EncryptedSharedPreferences prefs = await EncryptedSharedPreferences.getInstance();
    return prefs.getBoolean(key) ?? false;
  }

  static Future<bool> setBoolean(String key, bool value) async {
    final EncryptedSharedPreferences prefs = await EncryptedSharedPreferences.getInstance();
    return await prefs.setBoolean(key, value);
  }

  static Future<int?> getInt(String key) async {
    final EncryptedSharedPreferences prefs = await EncryptedSharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  static Future<bool> setInt(String key, int value) async {
    final EncryptedSharedPreferences prefs = await EncryptedSharedPreferences.getInstance();
    return await prefs.setInt(key, value);
  }

  static Future<String?> getString(String key) async {
    final EncryptedSharedPreferences prefs = await EncryptedSharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    final EncryptedSharedPreferences prefs = await EncryptedSharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  static void clearPrefrence() async {
    final EncryptedSharedPreferences prefs = await EncryptedSharedPreferences.getInstance();
    prefs.clear();
  }

  static void removePrefrence(String key) async {
    final EncryptedSharedPreferences prefs = await EncryptedSharedPreferences.getInstance();
    prefs.remove(key);
  }
}
