// ignore_for_file: file_names

import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:stacked/stacked.dart';

import '../../app/utilites/custom_modals.dart';

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
      await authService.signUp(
          email: email!.trim(),
          name: name,
          password: password!.trim(),
          phone: phoneNumber);

      setBusy(false);
      setLoading(false);
    } catch (err) {
      setLoading(false);
      logger.e(err.toString());
      dialogService.showCustomDialog(
          variant: DialogType.basic,
          title: "something went wrong",
          mainButtonTitle: "ok");
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
      dialogService.showCustomDialog(
          variant: DialogType.basic,
          title: "something went wrong",
          mainButtonTitle: "ok");
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
      navigationService.replaceWith(Routes.homeNavigationView);
      dialogService.showCustomDialog(
          variant: DialogType.basic, title: "success !", mainButtonTitle: "ok");
    } catch (err) {
      setLoading(false);
      logger.e(err.toString());
      dialogService.showCustomDialog(
          variant: DialogType.basic,
          title: "something went wrong",
          mainButtonTitle: "ok");
    }
  }
}
