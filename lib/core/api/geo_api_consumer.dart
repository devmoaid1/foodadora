import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/core/api/geo_api_provider.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

class GeoApiConsumer implements GeoApiProvider {
  final GeoFlutterFire geo;

  GeoApiConsumer({required this.geo});
  @override
  Stream<List<DocumentSnapshot>> getDataInRange(
      {required CollectionReference<Object?> collectionReference,
      required GeoFirePoint center,
      required double radius,
      required String field}) {
    return geo
        .collection(collectionRef: collectionReference)
        .within(center: center, radius: radius, field: field);
  }
}
