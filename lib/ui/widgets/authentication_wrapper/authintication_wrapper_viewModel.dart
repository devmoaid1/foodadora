import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:stacked/stacked.dart';

class AuthenticationWrapperViewModel extends BaseViewModel {
  Stream<User?> _currentUser = Stream.empty();
  Stream<User?> get currentUser => _currentUser;

  void getUserStream() {
    setBusy(true);
    _currentUser = authService.getUserStream();
    setBusy(false);
  }
}
