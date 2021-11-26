import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static CacheHelper instance = CacheHelper._();
  late SharedPreferences sharedPreferences;

  CacheHelper._();

  factory CacheHelper() {
    return instance;
  }

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  dynamic getSavedData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);

    return await sharedPreferences.setDouble(key, value);
  }

  Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}
