import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:stacked/stacked.dart';

import '../utilites/custom_modals.dart';

class LoginViewModel extends BaseViewModel {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void navigateToSignUpScreen() {
    navigationService.navigateTo(Routes.signUpView);
  }

  void emailLogin({String? email, String? password}) async {
    setBusy(true);
    setLoading(true);
    try {
      await authService.emailLogin(email: email, password: password);
      profileService.getCurrentCustomer();
      setBusy(false);
      setLoading(false);

      navigationService.replaceWith(Routes.homeNavigationView);
      // navigationService.navigateTo(Routes.homeScreen);
    } catch (e) {
      setBusy(false);
      setLoading(false);
      dialogService.showCustomDialog(
          variant: DialogType.basic,
          title: e.toString(),
          mainButtonTitle: "ok");
    }
  }

  void googleSignin() async {
    setBusy(true);
    try {
      final result = await authService.signInWithGoogle();
      profileService.getCurrentCustomer();
      setBusy(false);

      if (result.additionalUserInfo!.isNewUser) {
        navigationService.navigateTo(Routes.phoneSignUpScreen,
            arguments: PhoneSignUpScreenArguments(user: result));
      } else {
        navigationService.replaceWith(Routes.homeNavigationView);
      }
    } catch (e) {
      setBusy(false);
      setLoading(false);
      logger.e(e.toString());
      dialogService.showCustomDialog(
          variant: DialogType.basic,
          title: "something went wrong",
          mainButtonTitle: "ok");
    }
  }
}
