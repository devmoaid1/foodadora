// ignore_for_file: file_names

import 'dart:async';

import 'package:stacked/stacked.dart';

import '../app/constants/services_instances.dart';

class FoodadoraViewModel extends BaseViewModel {
  StreamSubscription? _connectivityController;

  void init() {
    profileService.getCurrentCustomer();
    _connectivityController =
        connectivityService.connectivityStream.listen((result) {
      print("connection is $result");
      connectivityService.handleStatus(result);
      storesViewModel.notifyListeners();
    });
  }

  void onDispose() {
    _connectivityController!.cancel();
  }
}
