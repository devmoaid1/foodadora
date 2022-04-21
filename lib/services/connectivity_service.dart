import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  ConnectivityResult get connectionStatus => _connectionStatus;
  Stream get connectivityStream => Connectivity().onConnectivityChanged;

  void handleStatus(ConnectivityResult result) {
    _connectionStatus = result;
  }
}
