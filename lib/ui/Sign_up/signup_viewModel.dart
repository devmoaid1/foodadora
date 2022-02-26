import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void signUpNewUser(
      {String? email,
      String? password,
      String? name,
      String? phoneNumber}) async {
    setBusy(true);
    setLoading(true);
    try {
      final result = await authService.signUp(
          email: email!.trim(),
          name: name,
          password: password!.trim(),
          phone: phoneNumber);

      setBusy(false);
      setLoading(false);
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
    setLoading(true);
    try {
      await authService.addCustomerToFirebase(
          id: id, email: email, name: name, phone: phone, photoUrl: url);
      setBusy(false);
      setLoading(true);
      navigationService.replaceWith(Routes.homeScreen);
      dialogService.showDialog(title: "success!");
    } catch (err) {
      logger.e(err.toString());
      dialogService.showDialog(title: "something went wrong");
    }
  }
}
