// ignore_for_file: file_names

import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/app/utilites/custom_modals.dart';
import 'package:foodadora/core/app_viewmodel.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/stores/domain/usecases/get_stores_usecase.dart';
import 'package:foodadora/features/stores/domain/usecases/open_location_settings_usecase.dart';

import 'package:geolocator/geolocator.dart';

import '../../data/models/storemodel.dart';
import '../../domain/entites/store.dart';

class StoresViewModel extends AppViewModel {
  // final StoreService _storeService = StoreService();

  final OpenLocationSettingsUseCase openLocationSettingsUseCase;
  final GetStoresUseCase getStoresUseCase;

  late List<Store?> _stores;

  StoresViewModel(
      {required this.openLocationSettingsUseCase,
      required this.getStoresUseCase});

  List<Store?> get stores => _stores;
  LocationPermission? _locationPermission;
  bool? _serviceEnabled;

  LocationPermission? get locationPermission => _locationPermission;
  bool? get serviceEnabled => _serviceEnabled;

  Future<void> openLocationSettings() async {
    final response = await openLocationSettingsUseCase(NoParams());
    response.fold((failure) {
      _locationPermission = LocationPermission.denied;
      _serviceEnabled = false;
      dialogService.showCustomDialog(
        variant: DialogType.basic,
        title: "error",
        description: failure.message,
      );
    }, (permession) {
      _locationPermission = LocationPermission.always;
      _serviceEnabled = true;
    });

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

    final response = await getStoresUseCase(NoParams());

    response.fold((failure) {
      setIsErrorState(true);
      setError(failure.message);
      dialogService.showCustomDialog(
        variant: DialogType.basic,
        title: "error",
        description: failure.message,
      );
    }, (storesStream) async {
      if (await storesStream.isEmpty != true) {
        _locationPermission = LocationPermission.always;
        _serviceEnabled = true;

        storesStream.listen((snapshots) {
          _stores = snapshots.map((snapshot) {
            if (snapshot.data() != null) {
              return StoreModel.fromJson(
                  snapshot.data() as Map<String, dynamic>);
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
    });

    // Stream<List<DocumentSnapshot>>? storesStream =
    //     await _storeService.getStores();

    // if (storesStream != null) {
    //   _locationPermission = locationService.permission;
    //   _serviceEnabled = locationService.serviceEnabled;
    //   storesStream.listen((snapshots) {
    //     _stores = snapshots.map((snapshot) {
    //       if (snapshot.data() != null) {
    //         return StoreModel.fromJson(snapshot.data() as Map<String, dynamic>);
    //       }
    //     }).toList();
    //     setBusy(false);
    //     notifyListeners();
    //   });
    // } else {
    //   _stores = [];
    //   setBusy(false);
    //   notifyListeners();
    // }
  }
}
