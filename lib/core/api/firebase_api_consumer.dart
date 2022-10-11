import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/core/api/firebase_api_provider.dart';
import 'package:foodadora/services/base_service.dart';

class FirebaseApiConsumer extends BaseService implements FirebaseApiProvider {
  @override
  Future<void> addData(String collection, Map<String, dynamic> data) async {
    try {
      await firestore.collection(collection).add(data);
    } on FirebaseException catch (err) {
      _handleFirebaseException(err);
    }
  }

  @override
  Future deleteData(String collection, docId) async {
    try {
      return await firestore.collection(collection).doc(docId).delete();
    } on FirebaseException catch (err) {
      _handleFirebaseException(err);
    }
  }

  @override
  Future getData(String collection) async {
    List data = [];
    try {
      await firestore
          .collection(collection)
          .get()
          .then((value) => data = value.docs);
      return data;
    } on FirebaseException catch (err) {
      _handleFirebaseException(err);
      return [];
    }
  }

  @override
  Future getDataByID(String collection, String attribute, id) async {
    List data = [];
    try {
      await firestore
          .collection(collection)
          .where(attribute, isEqualTo: id)
          .get()
          .then((value) => data = value.docs);
      return data;
    } on FirebaseException catch (err) {
      _handleFirebaseException(err);
    }
  }

  @override
  Future setData(String collection, Map<String, dynamic> data, String docId,
      {options}) async {
    try {
      await firestore
          .collection(collection)
          .doc(docId)
          .set(data, options ?? []);
    } on FirebaseException catch (err) {
      _handleFirebaseException(err);
    }
  }

  void _handleFirebaseException(FirebaseException err) {
    logger.e("error code : ${err.code}");
    logger.e("error code : ${err.message}");
  }
}
