// ignore_for_file: file_names

import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/core/app_viewmodel.dart';
import 'package:foodadora/features/auth/domain/usecases/handle_phone_form_usecase.dart';
import 'package:foodadora/features/auth/domain/usecases/sign_up_usecase.dart';

import '../../../../app/utilites/custom_modals.dart';

class SignUpViewModel extends AppViewModel {
  final SignUpUseCase signUpUseCase;
  final HandlePhoneFormUseCase handlePhoneFormUseCase;

  SignUpViewModel(
      {required this.signUpUseCase, required this.handlePhoneFormUseCase});
  void signUpNewUser(
      {String? email,
      String? password,
      String? name,
      String? phoneNumber}) async {
    setBusy(true);
    setLoading(true);

    final response = await signUpUseCase(SignUpParams(
        email: email!, password: password!, name: name!, phone: phoneNumber!));

    response.fold((failure) {
      setLoading(false);
      logger.e(failure.message.toString());
      dialogService.showCustomDialog(
          variant: DialogType.basic,
          title: failure.message,
          mainButtonTitle: "ok");
    }, (credential) {
      logger.i("sign up success for user : ${credential.user}");
      setBusy(false);
      setLoading(false);
    });

    // try {
    //   await authService.signUp(
    //       email: email!.trim(),
    //       name: name,
    //       password: password!.trim(),
    //       phone: phoneNumber);

    //   setBusy(false);
    //   setLoading(false);
    // } catch (err) {
    //   setLoading(false);
    //   logger.e(err.toString());
    //   dialogService.showCustomDialog(
    //       variant: DialogType.basic,
    //       title: "something went wrong",
    //       mainButtonTitle: "ok");
    // }
  }

  void phoneForm(
      {String? id,
      String? name,
      String? email,
      String? phone,
      String? url}) async {
    setBusy(true);
    setLoading(true);

    final response = await handlePhoneFormUseCase(HandlePhoneFormParams(
        email: email!, id: id!, name: name!, phone: phone!, photoUrl: url!));

    response.fold((failure) {
      setLoading(false);
      logger.e(failure.message.toString());
      dialogService.showCustomDialog(
          variant: DialogType.basic,
          title: "something went wrong",
          mainButtonTitle: "ok");
    }, (result) {
      setBusy(false);
      setLoading(true);
      userService.setIsLoggedOn(true);
      homeNavigationViewModel.notifyListeners();
      settingsViewModel.notifyListeners();

      navigationService.popUntil((route) => route.isFirst);
      dialogService.showCustomDialog(
          variant: DialogType.basic, title: "success !", mainButtonTitle: "ok");
    });
  }
}
