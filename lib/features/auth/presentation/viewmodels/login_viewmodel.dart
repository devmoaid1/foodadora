import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/core/app_viewmodel.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/auth/domain/usecases/email_login_usecase.dart';
import 'package:foodadora/features/auth/domain/usecases/google_sign_usecase.dart';

import '../../../../app/utilites/custom_modals.dart';

class LoginViewModel extends AppViewModel {
  final EmailLoginUseCase emailLoginUseCase;
  final GoogleSignInUseCase googleSignInUseCase;

  LoginViewModel({
    required this.emailLoginUseCase,
    required this.googleSignInUseCase,
  });

  void navigateToSignUpScreen() {
    navigationService.navigateTo(Routes.signUpView);
  }

  void emailLogin({String? email, String? password}) async {
    setBusy(true);
    setLoading(true);

    final response = await emailLoginUseCase(EmailLoginParams(
        email: email.toString(), password: password.toString()));

    response.fold((failure) {
      // error handling
      final message = _handleAuthenticationFaliures(failure);
      setError(message);
      setIsErrorState(true);
      setBusy(false);
      setLoading(false);
      dialogService.showCustomDialog(
          variant: DialogType.basic,
          title: "Invalid Data",
          // barrierColor: const Color(0xFF12343E),
          description: message.toString(),
          mainButtonTitle: "ok");
    }, (userCredentials) {
      // success login logic
      logger.i("user logged in success: ${userCredentials.user}");
      setBusy(false);
      setLoading(false);
      homeNavigationViewModel.notifyListeners();
      settingsViewModel.notifyListeners();
      navigationService.back();
    });
  }

  void googleSignin() async {
    setBusy(true);
    setLoading(true);

    final googleResponse = await googleSignInUseCase(NoParams());

    googleResponse.fold((failure) {
      logger.e(failure.message.toString());
      dialogService.showCustomDialog(
          variant: DialogType.basic,
          title: "Something Went Wrong",
          mainButtonTitle: "Ok");
    }, (credential) {
      if (credential.additionalUserInfo!.isNewUser) {
        navigationService.navigateTo(Routes.phoneSignUpScreen,
            arguments: PhoneSignUpScreenArguments(user: credential));
      } else {
        navigationService.back();
      }
    });

    setBusy(false);
    setLoading(false);
    settingsViewModel.notifyListeners();
    homeNavigationViewModel.notifyListeners();
  }

  void facebookSignin() async {}

  String _handleAuthenticationFaliures(Failure failure) {
    switch (failure.runtimeType) {
      case AuthenticationFailure:
        return failure.message;

      default:
        return "Authentication Faliure";
    }
  }
}
