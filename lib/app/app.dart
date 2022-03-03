@StackedApp(routes: [
  CupertinoRoute(
    page: HomeScreen,
  ),
  CupertinoRoute(
    page: ProductDetailsView,
  ),
  CupertinoRoute(
    page: OrdersScreen,
  ),
  CupertinoRoute(
    page: CartScreen,
  ),
  CupertinoRoute(page: AuthenticationWrapper, initial: true),
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
  CupertinoRoute(page: StoreDetailsScreen),
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: AuthService),
  LazySingleton(classType: ProfileService),
], logger: StackedLogger())

// flutter pub run build_runner build --delete-conflicting-outputs   this command for generator
import 'package:foodadora/services/auth_Service.dart';
import 'package:foodadora/services/profile_service.dart';
import 'package:foodadora/ui/Sign_up/phoneSignup_view.dart';
import 'package:foodadora/ui/Sign_up/signup_view.dart';
import 'package:foodadora/ui/cart/cart_view.dart';
import 'package:foodadora/ui/home/home_view.dart';
import 'package:foodadora/ui/login/login_view.dart';
import 'package:foodadora/ui/orders/orders_view.dart';
import 'package:foodadora/ui/product_details/product_details_view.dart';
import 'package:foodadora/ui/profile/profile_view.dart';
import 'package:foodadora/ui/store_details/storeDetails_view.dart';
import 'package:foodadora/ui/widgets/authentication_wrapper/authentication_wrapper.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
