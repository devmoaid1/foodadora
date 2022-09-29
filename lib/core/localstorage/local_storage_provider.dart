abstract class LocalStorageProvider {
  Type getData({required dynamic key, Type? type});
  void setData({required dynamic key, required Type data});
  void deleteData({required dynamic key, required dynamic id});
}
