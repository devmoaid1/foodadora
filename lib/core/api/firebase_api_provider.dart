abstract class FirebaseApiProvider {
  Future getDataByID(String collection, String attribute, dynamic id);
  Future getData(String collection);
  Future<void> addData(String collection, Map<String, dynamic> data);
  Future setData(String collection, Map<String, dynamic> data, String docId,
      {dynamic options});
  Future deleteData(String collection, dynamic docId);
}
