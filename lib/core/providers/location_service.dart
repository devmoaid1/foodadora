import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';

class LocationService extends BaseViewModel {
  Position? _userLocation;
  bool? _serviceEnabled;
  LocationPermission? _permission;

  Position? get userLocation => _userLocation;
  bool? get serviceEnabled => _serviceEnabled;
  LocationPermission? get permission => _permission;

  void setUserLocation(Position? position) {
    _userLocation = position;
    notifyListeners();
  }
}
