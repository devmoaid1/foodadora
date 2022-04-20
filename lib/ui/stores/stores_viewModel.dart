// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/store.dart';
import 'package:foodadora/services/store_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@singleton
class StoresViewModel extends BaseViewModel {
  final StoreService _storeService = StoreService();
  late List<Store?> _stores;

  List<Store?> get stores => _stores;
  LocationPermission? _locationPermission;
  bool? _serviceEnabled;

  LocationPermission? get locationPermission => _locationPermission;
  bool? get serviceEnabled => _serviceEnabled;

  bool _isLoading = false;

  bool get loading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> openLocationSettings() async {
    await locationService.openLocationSettings();
    _locationPermission = locationService.permission;
    _serviceEnabled = locationService.serviceEnabled;
    notifyListeners();
  }

  void navigateToStoreDetails(
      {required Store store, required String distance}) {
    navigationService.navigateTo(Routes.storeDetailsScreen,
        arguments:
            StoreDetailsScreenArguments(store: store, distance: distance));
  }

  void getStoresList() async {
    setBusy(true);
    Stream<List<DocumentSnapshot>>? storesStream =
        await _storeService.getStores();

    if (storesStream != null) {
      _locationPermission = locationService.permission;
      _serviceEnabled = locationService.serviceEnabled;
      storesStream.listen((snapshots) {
        _stores = snapshots.map((snapshot) {
          if (snapshot.data() != null) {
            return Store.fromJson(snapshot.data() as Map<String, dynamic>);
          }
        }).toList();
        setBusy(false);
        notifyListeners();
      });
    } else {
      _stores = [];
      setBusy(false);
      notifyListeners();
    }
  }
}
