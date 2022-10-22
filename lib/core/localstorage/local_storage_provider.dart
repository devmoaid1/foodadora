abstract class LocalStorageProvider {
  dynamic getData({required dynamic key, dynamic type});
  void setData({required dynamic key, required dynamic data});
  Future<void> deleteData({required dynamic key, dynamic id});
}
