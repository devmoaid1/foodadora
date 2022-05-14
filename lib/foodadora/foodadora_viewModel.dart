// ignore_for_file: file_names, avoid_print

import 'dart:async';

import 'package:stacked/stacked.dart';

import '../app/constants/services_instances.dart';

class FoodadoraViewModel extends BaseViewModel {
  StreamSubscription? _connectivityController;
  StreamSubscription? _authStateSubscription;
  void init() {
    _connectivityController =
        connectivityService.connectivityStream.listen((result) {
      connectivityService.handleStatus(result);
    });

    _authStateSubscription = authService.authState.listen((user) {
      // user logged in
      if (user != null) {
        print("user exist or logged in ");
        profileService.getCurrentCustomer(); // get customer if there is user
      } else {
        profileService.setIsLoggedOn(
            false); // set is logged to false if there isn`t any user
        print("user logged out");
      }
    });
  }

  void onDispose() {
    _connectivityController!.cancel();
    _authStateSubscription!.cancel();
  }
}
