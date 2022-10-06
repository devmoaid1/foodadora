import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

abstract class GeoApiProvider {
  // getDataInRange

  Stream<List<DocumentSnapshot>> getDataInRange(
      {required CollectionReference collectionReference,
      required GeoFirePoint center,
      required double radius,
      required String field});
}
