@StackedApp(routes: <StackedRoute<dynamic>>[
  CupertinoRoute(page: HomeNavigationView, initial: true),
  CupertinoRoute(
    page: ProductDetailsView,
  ),
  CupertinoRoute(
    page: OrdersScreen,
  ),
  CupertinoRoute(
    page: CartScreen,
  ),
  CupertinoRoute(page: LoginView),
  CupertinoRoute(
    page: SignUpView,
  ),
  CupertinoRoute(
    page: PhoneSignUpScreen,
  ),
  CupertinoRoute(
    page: ProfileScreen,
  ),
  CupertinoRoute(
    page: SelectLanguageView,
  ),
  CupertinoRoute(
    page: StoresScreen,
  ),
  CupertinoRoute(page: StoreDetailsScreen),
  CupertinoRoute(page: OrderDetailsScreen),
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: AuthService),
  LazySingleton(classType: ProfileService),
  LazySingleton(classType: StoreService),
  LazySingleton(classType: OrderService),
  LazySingleton(classType: CartService),
  LazySingleton(classType: ProductService),
  LazySingleton(classType: LocationService),
  LazySingleton(classType: ConnectivityService)
], logger: StackedLogger())
// flutter pub run build_runner build --delete-conflicting-outputs   this command for generator
import 'package:foodadora/services/auth_Service.dart';
import 'package:foodadora/services/cart_Service.dart';
import 'package:foodadora/services/location_service.dart';
import 'package:foodadora/services/orders_services.dart';
import 'package:foodadora/services/product_service.dart';
import 'package:foodadora/services/profile_service.dart';
import 'package:foodadora/services/store_service.dart';
import 'package:foodadora/ui/cart/cart_view.dart';
import 'package:foodadora/ui/home_navigation/home_navigation_view.dart';
import 'package:foodadora/ui/login/login_view.dart';
import 'package:foodadora/ui/order_details/order_details_view.dart';
import 'package:foodadora/ui/orders/orders_view.dart';
import 'package:foodadora/ui/product_details/product_details_view.dart';
import 'package:foodadora/ui/profile/profile_view.dart';
import 'package:foodadora/ui/select_language/select_language_view.dart';
import 'package:foodadora/ui/sign_up/phone_signup_view.dart';
import 'package:foodadora/ui/sign_up/signup_view.dart';
import 'package:foodadora/ui/store_details/store_details_view.dart';
import 'package:foodadora/ui/stores/stores_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/connectivity_service.dart';
