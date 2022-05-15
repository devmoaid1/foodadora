import 'package:flutter/cupertino.dart';
import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:stacked/stacked.dart';

import '../../app/utilites/custom_modals.dart';

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

      setBusy(false);
      setLoading(false);

      homeNavigationViewModel.notifyListeners();
      settingsViewModel.notifyListeners();

      navigationService.back();
    } catch (e) {
      setBusy(false);
      setLoading(false);
      dialogService.showCustomDialog(
          variant: DialogType.basic,
          title: "Invalid Data",
          barrierColor: const Color(0xFF12343E),
          description: e.toString(),
          mainButtonTitle: "ok");
    }
  }

  void googleSignin() async {
    setBusy(true);
    setLoading(true);
    try {
      final result = await authService.signInWithGoogle();

      if (result.additionalUserInfo!.isNewUser) {
        navigationService.navigateTo(Routes.phoneSignUpScreen,
            arguments: PhoneSignUpScreenArguments(user: result));
      } else {
        navigationService.back();
      }
    } catch (e) {
      logger.e(e.toString());
      dialogService.showCustomDialog(
          variant: DialogType.basic,
          title: "Something Went Wrong",
          mainButtonTitle: "Ok");
    }
    setBusy(false);
    setLoading(false);
    settingsViewModel.notifyListeners();
    homeNavigationViewModel.notifyListeners();
  }

  void facebookSignin() async {}
}
