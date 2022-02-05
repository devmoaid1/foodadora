import 'package:foodadora/app/app.locator.dart';
import 'package:foodadora/services/auth_Service.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

// here creating one instance for each service across app

final navigationService = locator<NavigationService>();
final dialogService = locator<DialogService>();
final authService = locator<AuthService>();

//logger

final Logger logger = Logger();
