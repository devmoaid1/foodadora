import 'package:foodadora/features/stores/data/models/location_model.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationRemoteDataSource {
  Future<LocationModel> getUserLocation();
  Future<bool> openLocationSettings();
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  @override
  Future<LocationModel> getUserLocation() async {
    // Test if location services are enabled.
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    final position = await Geolocator.getCurrentPosition();

    return LocationModel(
        permission: permission,
        serviceEnabled: serviceEnabled,
        userLocation: position);
  }

  @override
  Future<bool> openLocationSettings() async {
    final response = await Geolocator.openLocationSettings();
    return response;
  }
}
