import 'package:foodadora/services/auth_Service.dart';
import 'package:foodadora/services/cart_Service.dart';
import 'package:foodadora/services/connectivity_service.dart';
import 'package:foodadora/services/location_service.dart';
import 'package:foodadora/services/orders_services.dart';
import 'package:foodadora/services/product_service.dart';
import 'package:foodadora/services/profile_service.dart';
import 'package:foodadora/services/store_service.dart';
import 'package:foodadora/ui/cart/cart_viewmodel.dart';
import 'package:foodadora/ui/orders/orders_viewmodel.dart';
import 'package:foodadora/ui/settings/settings_viewmodel.dart';

import 'package:foodadora/ui/sign_up/signup_viewmodel.dart';
import 'package:foodadora/ui/home_navigation/home_navigation_viewmodel.dart';
import 'package:foodadora/ui/product_details/product_details_viewmodel.dart';
import 'package:get/get.dart';

import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../ui/stores/stores_viewmodel.dart';

// Here creating one instance for each service across app

// Services
final navigationService = Get.find<NavigationService>();
final dialogService = Get.find<DialogService>();
final authService = Get.find<AuthService>();
final profileService = Get.find<ProfileService>();
final storeService = Get.find<StoreService>();
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
