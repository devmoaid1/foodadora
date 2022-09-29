import 'package:foodadora/core/api/firebase_api_provider.dart';
import 'package:foodadora/services/base_service.dart';

class FirebaseApiConsumer extends BaseService implements FirebaseApiProvider {
  @override
  Future<void> addData(String collection, Map<String, dynamic> data) async {
    await firestore.collection(collection).add(data);
  }

  @override
  Future deleteData(String collection, docId) async {
    return await firestore.collection(collection).doc(docId).delete();
  }

  @override
  Future getData(String collection) async {
    return await firestore.collection(collection).get();
  }

  @override
  Future getDataByID(String collection, String attribute, id) async {
    return await firestore
        .collection(collection)
        .where(attribute, isEqualTo: id)
        .get();
  }

  @override
  Future setData(String collection, Map<String, dynamic> data, String docId,
      {options}) async {
    return await firestore
        .collection(collection)
        .doc(docId)
        .set(data, options ?? []);
  }
}
