import 'package:foodadora/app/app.locator.dart';
import 'package:foodadora/services/auth_Service.dart';
import 'package:foodadora/services/cart_Service.dart';
import 'package:foodadora/services/orders_services.dart';
import 'package:foodadora/services/profile_service.dart';
import 'package:foodadora/services/store_service.dart';
import 'package:foodadora/ui/Sign_up/signup_viewModel.dart';
import 'package:foodadora/ui/stores/stores_viewModel.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

// here creating one instance for each service across app

//services
final navigationService = locator<NavigationService>();
final dialogService = locator<DialogService>();
final authService = locator<AuthService>();
final profileService = locator<ProfileService>();
final storeService = locator<StoreService>();
final ordersService = locator<OrderService>();
final cartService = locator<CartService>();

//viewModels

final SignUpViewModel signUpViewModel = SignUpViewModel();
final StoresViewModel storesViewModel = StoresViewModel();

//logger

final Logger logger = Logger();
