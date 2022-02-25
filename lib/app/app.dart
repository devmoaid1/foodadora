@StackedApp(routes: [
  CupertinoRoute(
    page: HomeScreen,
  ),
  CupertinoRoute(page: LoginView, initial: true),
  CupertinoRoute(
    page: SignUpView,
  ),
  CupertinoRoute(
    page: PhoneSignUpScreen,
  ),
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: AuthService)
], logger: StackedLogger())

// flutter pub run build_runner build --delete-conflicting-outputs   this command for generator
import 'package:foodadora/services/auth_Service.dart';
import 'package:foodadora/ui/Sign_up/phoneSignup_view.dart';
import 'package:foodadora/ui/Sign_up/signup_view.dart';
import 'package:foodadora/ui/home/home_view.dart';
import 'package:foodadora/ui/login/login_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
