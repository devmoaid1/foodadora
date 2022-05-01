// ignore_for_file: avoid_print

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService extends ChangeNotifier {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  bool _isConnected = false;

  bool get isConnected => _isConnected;

  ConnectivityResult get connectionStatus => _connectionStatus;
  Stream get connectivityStream => Connectivity().onConnectivityChanged;

  void handleStatus(ConnectivityResult result) async {
    _connectionStatus = result;

    getConnectionStatus(result);
  }

  Future<bool> checkConnection() async {
    try {
      final res =
          await InternetAddress.lookup('www.google.com'); // lookup a site
      final result = res.isNotEmpty && res[0].rawAddress.isNotEmpty;
      return result; //true if result is not empty
    } catch (err) {
      return false;
    }
  }

  void getConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      _isConnected = false; // no connection
    } else if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      final status =
          await checkConnection(); // check connection while wifi or data

      if (status) {
        _isConnected = true; // connection exits
      }
    }

    notifyListeners();

    // storesViewModel.notifyListeners();
    // cartViewModel.notifyListeners();
    // ordersViewModel.notifyListeners();
    // settingsViewModel.notifyListeners();
    print(_isConnected);
  }
}
