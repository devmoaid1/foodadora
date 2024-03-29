import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  void navigateToSignUpScreen() {
    navigationService.navigateTo(Routes.signUpView);
  }

  void emailLogin({String? email, String? password}) async {
    try {
      await authService.emailLogin(email: email, password: password);

      setBusy(false);

      navigationService.navigateTo(Routes.homeScreen);
    } catch (e) {
      dialogService.showDialog(title: e.toString());
    }
  }

  void googleSignin() async {
    setBusy(true);
    try {
      final result = await authService.signInWithGoogle();
      print(result.additionalUserInfo!.isNewUser);
      if (result == null) return;
      if (!result.additionalUserInfo!.isNewUser) {
        navigationService.navigateTo(Routes.phoneSignUpScreen,
            arguments: PhoneSignUpScreenArguments(user: result));
      }
      setBusy(false);
    } catch (e) {
      setBusy(false);
      logger.e(e.toString(), e.toString());
      dialogService.showDialog(title: e.toString());
    }
  }
}
