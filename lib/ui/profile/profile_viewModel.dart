// ignore_for_file: file_names

import 'package:foodadora/app/constants/services_instances.dart';

import 'package:stacked/stacked.dart';

import '../../features/auth/domain/entities/customer.dart';

class ProfileViewModel extends BaseViewModel {
  Customer? get customerProfile => profileService.currentCustomer;

  bool get isLoggedOn => profileService.isLoggedOn;

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void getCurrentCustomer() {
    setBusy(true);
    try {
      profileService.getCurrentCustomer();
      setBusy(false);
      setLoading(false);
      notifyListeners();
      logger.i(profileService.currentCustomer!.phoneNumber);
    } catch (err) {
      logger.e(err);
    }
  }

  void signOut() async {
    setBusy(true);
    try {
      await authService.logout();
      // profileService.setIsLoggedOn(false);
      homeNavigationViewModel.notifyListeners();
      navigationService.back();
    } catch (err) {
      logger.e(err);
    }
    notifyListeners();
  }
}
