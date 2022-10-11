import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../features/auth/presentation/views/login_view.dart';
import '../features/auth/presentation/views/phone_signup_view.dart';
import '../features/auth/presentation/views/signup_view.dart';
import '../features/orders/presentation/views/order_details_view.dart';
import '../features/orders/presentation/views/orders_view.dart';
import '../features/profile/presentation/views/profile_view.dart';
import '../features/store_details/presentation/views/store_details_view.dart';
import '../features/stores/presentation/views/stores_view.dart';
import '../ui/cart/cart_view.dart';
import '../ui/home_navigation/home_navigation_view.dart';

import '../ui/product_details/product_details_view.dart';

import '../ui/select_language/select_language_view.dart';

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
  LazySingleton(classType: DialogService)
], logger: StackedLogger())
// flutter pub run build_runner build --delete-conflicting-outputs   this command for generator
class AppService {}
