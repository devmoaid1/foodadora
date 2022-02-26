import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:stacked/stacked.dart';

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

      navigationService.replaceWith(Routes.profileScreen);
      // navigationService.navigateTo(Routes.homeScreen);
    } catch (e) {
      setBusy(false);
      dialogService.showDialog(title: e.toString());
    }
  }

  void googleSignin() async {
    setBusy(true);
    try {
      final result = await authService.signInWithGoogle();
      setBusy(false);

      if (result.additionalUserInfo!.isNewUser) {
        navigationService.navigateTo(Routes.phoneSignUpScreen,
            arguments: PhoneSignUpScreenArguments(user: result));
      } else {
        navigationService.replaceWith(Routes.profileScreen);
      }
    } catch (e) {
      setBusy(false);
      logger.e(e.toString(), e.toString());
      dialogService.showDialog(title: "something went wrong");
    }
  }
}
