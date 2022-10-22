import 'dart:convert';

import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/core/localstorage/local_storage_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrencesConsumer implements LocalStorageProvider {
  final SharedPreferences sharedPreferences;

  SharedPrefrencesConsumer({required this.sharedPreferences});
  @override
  Future<void> deleteData({required key, id}) async {
    final deltedData = await sharedPreferences.remove(key);
    if (deltedData) {
      logger.i("data is deleted from local storage");
    }

    logger.i("data is not deleted from local storage");
  }

  @override
  dynamic getData({required key, dynamic type}) {
    Map<String, dynamic>? result;
    try {
      final data = sharedPreferences.get(key) as String;
      result = jsonDecode(data) as Map<String, dynamic>;
      return result;
    } catch (err) {
      return result;
    }
  }

  @override
  Future<void> setData({required key, required dynamic data}) async {
    final isDataSet = await sharedPreferences.setString(key, jsonEncode(data));
    if (isDataSet) {
      logger.i("data is set successfully to local storage");
    } else {
      logger.i("data is not set  to local storage");
    }
  }
}
