// Here creating one instance for each service across app

// Services
import 'package:foodadora/app/app.locator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../features/auth/presentation/viewmodels/signup_viewModel.dart';
import '../../features/cart/presentation/viewmodels/cart_viewmodel.dart';
import '../../features/home_navigation/home_navigation_viewmodel.dart';
import '../../features/orders/presentation/viewmodels/orders_viewmodel.dart';
import '../../features/product_details/presentation/viewmodels/product_details_viewmodel.dart';
import '../../features/settings/presentation/viewmodels/settings_viewmodel.dart';
import '../../features/stores/presentation/viewmodels/stores_viewModel.dart';

import '../../core/providers/cart/cart_Service.dart';
import '../../core/providers/connectivity/connectivity_service.dart';
import '../../core/providers/location_service.dart';

import '../../core/providers/user/user_service_provider.dart';

final navigationService = Get.find<NavigationService>();
final dialogService = locator<DialogService>();

final userService = Get.find<UserServiceProvider>();

final cartService = Get.find<CartService>();

final locationService = Get.find<LocationService>();
final connectivityService = Get.find<ConnectivityService>();

// View Models
final signUpViewModel = Get.find<SignUpViewModel>();
final storesViewModel = Get.find<StoresViewModel>();
final ordersViewModel = Get.find<OrdersViewModel>();
final cartViewModel = Get.find<CartViewModel>();
final productDetailsViewModel = Get.find<ProductDetailsViewModel>();
final homeNavigationViewModel = Get.find<HomeNavigationViewModel>();
final settingsViewModel = Get.find<SettingsViewModel>();

//logger
final Logger logger = Logger();
