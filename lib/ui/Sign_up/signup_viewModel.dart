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
}
