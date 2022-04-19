import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:geolocator/geolocator.dart';

final geo = GeoFlutterFire();

String getDistance(GeoPoint point, [Position? position]) {
  Position currPosition = position ?? locationService.userLocation!;
  GeoFirePoint currPoint = geo.point(
      latitude: currPosition.latitude, longitude: currPosition.longitude);
  double distance =
      currPoint.distance(lat: point.latitude, lng: point.longitude);

  if (distance < 1) {
    return '${(distance * 1000).toStringAsFixed(0)} m';
  } else {
    return '${distance.toStringAsFixed(2)} km';
  }
}
