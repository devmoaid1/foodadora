import 'package:foodadora/app/constants/services_instances.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  void logout() {
    authService.logout();
  }
}
