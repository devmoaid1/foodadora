// Here creating one instance for each service across app

// Services
import 'package:foodadora/app/app.locator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../features/auth/presentation/viewmodels/signup_viewModel.dart';
import '../../features/orders/presentation/viewmodels/orders_viewmodel.dart';
import '../../features/stores/presentation/viewmodels/stores_viewModel.dart';
import '../../services/auth_Service.dart';
import '../../services/cart_Service.dart';
import '../../services/connectivity_service.dart';
import '../../services/location_service.dart';
import '../../services/orders_services.dart';
import '../../services/product_service.dart';
import '../../services/profile_service.dart';
import '../../ui/cart/cart_viewmodel.dart';
import '../../ui/home_navigation/home_navigation_viewmodel.dart';

import '../../ui/product_details/product_details_viewmodel.dart';
import '../../ui/settings/settings_viewmodel.dart';

final navigationService = Get.find<NavigationService>();
final dialogService = locator<DialogService>();
final authService = Get.find<AuthService>();
final profileService = Get.find<ProfileService>();
// final storeService = Get.find<StoreService>();
final ordersService = Get.find<OrderService>();
final cartService = Get.find<CartService>();
final productService = Get.find<ProductService>();
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
