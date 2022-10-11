// ignore_for_file: file_names

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  StoresViewModel(
      {required this.openLocationSettingsUseCase,
      required this.getStoresUseCase});

  List<Store?> _stores = [];
  List<Store?> get stores => _stores;
  LocationPermission? _locationPermission;
  bool? _serviceEnabled;

  StreamSubscription<List<DocumentSnapshot>>? _storesSubscribtion;

  LocationPermission? get locationPermission => _locationPermission;
  bool? get serviceEnabled => _serviceEnabled;

  Future<void> openLocationSettings() async {
    final response = await openLocationSettingsUseCase(NoParams());
    response.fold((failure) {
      _stores = [];
      _locationPermission = LocationPermission.denied;
      _serviceEnabled = false;
      dialogService.showCustomDialog(
          variant: DialogType.basic,
          title: "Invalid Data",
          // barrierColor: const Color(0xFF12343E),
          description: failure.message.toString(),
          mainButtonTitle: "ok");
      setBusy(false);
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
      setBusy(false);
      setIsErrorState(true);
      setError(failure.message);
      dialogService.showCustomDialog(
        variant: DialogType.basic,
        title: "error",
        description: failure.message,
      );
    }, (storesStream) async {
      _locationPermission = LocationPermission.always;
      _serviceEnabled = true;

      _storesSubscribtion = storesStream.listen((snapshots) {});

      _storesSubscribtion!.onData((snapshots) {
        if (snapshots.isNotEmpty) {
          _stores = snapshots.map((snapshot) {
            if (snapshot.data() != null) {
              return StoreModel.fromJson(
                  snapshot.data() as Map<String, dynamic>);
            }
          }).toList();
        } else {
          _stores = [];
        }

        setBusy(false);

        notifyListeners();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _storesSubscribtion!.cancel();
  }
}
