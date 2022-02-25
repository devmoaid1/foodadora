import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  void signUpNewUser(
      {String? email,
      String? password,
      String? name,
      String? phoneNumber}) async {
    setBusy(true);
    try {
      final result = await authService.signUp(
          email: email, name: name, password: password, phone: phoneNumber);

      setBusy(false);
      dialogService.showDialog(title: "SignUp success ${result.user!.uid}");
    } catch (err) {
      logger.e(err.toString());
      dialogService.showDialog(title: "Something went wrong");
    }
  }

  void googleSignUp() async {
    setBusy(true);
    try {
      final result = await authService.signInWithGoogle();

      if (result.additionalUserInfo!.isNewUser) {
        navigationService.navigateTo(Routes.phoneSignUpScreen,
            arguments: PhoneSignUpScreenArguments(user: result));
      } else {
        navigationService.replaceWith(Routes.profileScreen);
      }
    } catch (err) {
      logger.e(err.toString());
      dialogService.showDialog(title: "something went wrong");
    }
  }

  void phoneForm(
      {String? id,
      String? name,
      String? email,
      String? phone,
      String? url}) async {
    setBusy(true);
    try {
      await authService.addCustomerToFirebase(
          email: email, name: name, phone: phone, photoUrl: url);
      setBusy(false);

      dialogService.showDialog(title: "success!");

      navigationService.replaceWith(Routes.homeScreen);
    } catch (err) {
      logger.e(err.toString());
      dialogService.showDialog(title: "something went wrong");
    }
  }
}
