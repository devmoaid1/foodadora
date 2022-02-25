import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/customer.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  Customer _customer = Customer();

  Customer get customerProfile => _customer;

  bool _loading = true;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void getCurrentCustomer() async {
    setBusy(true);
    try {
      _customer = await profileService.getCustomer();
      setBusy(false);
      setLoading(false);
      notifyListeners();
      logger.i(_customer.phoneNumber);
    } catch (err) {
      logger.e(err);
    }
  }

  void signOut() async {
    setBusy(true);
    try {
      await authService.logout();
      navigationService.replaceWith(Routes.loginView);
    } catch (err) {
      logger.e(err);
    }
  }
}
