import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class LocationModel extends Equatable {
  final Position? userLocation;
  final bool? serviceEnabled;
  final LocationPermission? permission;

  const LocationModel(
      {this.userLocation, this.serviceEnabled, this.permission});

  @override
  List<Object?> get props => [userLocation, serviceEnabled, permission];
}
