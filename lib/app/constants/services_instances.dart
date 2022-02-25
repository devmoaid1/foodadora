import 'package:foodadora/app/app.locator.dart';
import 'package:foodadora/services/auth_Service.dart';
import 'package:foodadora/services/profile_service.dart';
import 'package:foodadora/ui/Sign_up/signup_viewModel.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

// here creating one instance for each service across app

//services
final navigationService = locator<NavigationService>();
final dialogService = locator<DialogService>();
final authService = locator<AuthService>();
final profileService = locator<ProfileService>();

//viewModels

final SignUpViewModel signUpViewModel = SignUpViewModel();

//logger

final Logger logger = Logger();
