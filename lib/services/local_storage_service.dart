import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  SharedPreferences? _sharedPreferences;
  LocalStorageService() {
    getInstance();
  }

  void getInstance() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<String?> getData({required String key}) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    try {
      final data = _sharedPreferences!.get(key) as String?;
      return data;
    } catch (e) {
      return null;
    }
  }

  void setData({required String key, required Map<String, dynamic> data}) {
    _sharedPreferences!.setString(key, jsonEncode(data));
  }
}
