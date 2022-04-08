// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../models/order.dart';
import '../models/product.dart';
import '../models/store.dart';
import '../ui/Sign_up/phoneSignup_view.dart';
import '../ui/Sign_up/signup_view.dart';
import '../ui/cart/cart_view.dart';
import '../ui/home_navigation/home_navigation_view.dart';
import '../ui/login/login_view.dart';
import '../ui/order_details/order_details_view.dart';
import '../ui/orders/orders_view.dart';
import '../ui/product_details/product_details_view.dart';
import '../ui/profile/profile_view.dart';
import '../ui/select_language/select_language_view.dart';
import '../ui/store_details/storeDetails_view.dart';
import '../ui/stores/stores_view.dart';

class Routes {
  static const String homeNavigationView = '/';
  static const String productDetailsView = '/product-details-view';
  static const String ordersScreen = '/orders-screen';
  static const String cartScreen = '/cart-screen';
  static const String loginView = '/login-view';
  static const String signUpView = '/sign-up-view';
  static const String phoneSignUpScreen = '/phone-sign-up-screen';
  static const String profileScreen = '/profile-screen';
  static const String selectLanguageView = '/select-language-view';
  static const String storesScreen = '/stores-screen';
  static const String storeDetailsScreen = '/store-details-screen';
  static const String orderDetailsScreen = '/order-details-screen';
  static const all = <String>{
    homeNavigationView,
    productDetailsView,
    ordersScreen,
    cartScreen,
    loginView,
    signUpView,
    phoneSignUpScreen,
    profileScreen,
    selectLanguageView,
    storesScreen,
    storeDetailsScreen,
    orderDetailsScreen,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeNavigationView, page: HomeNavigationView),
    RouteDef(Routes.productDetailsView, page: ProductDetailsView),
    RouteDef(Routes.ordersScreen, page: OrdersScreen),
    RouteDef(Routes.cartScreen, page: CartScreen),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.signUpView, page: SignUpView),
    RouteDef(Routes.phoneSignUpScreen, page: PhoneSignUpScreen),
    RouteDef(Routes.profileScreen, page: ProfileScreen),
    RouteDef(Routes.selectLanguageView, page: SelectLanguageView),
    RouteDef(Routes.storesScreen, page: StoresScreen),
    RouteDef(Routes.storeDetailsScreen, page: StoreDetailsScreen),
    RouteDef(Routes.orderDetailsScreen, page: OrderDetailsScreen),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    HomeNavigationView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const HomeNavigationView(),
        settings: data,
      );
    },
    ProductDetailsView: (data) {
      var args = data.getArgs<ProductDetailsViewArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => ProductDetailsView(
          key: args.key,
          product: args.product,
          store: args.store,
        ),
        settings: data,
      );
    },
    OrdersScreen: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const OrdersScreen(),
        settings: data,
      );
    },
    CartScreen: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => CartScreen(),
        settings: data,
      );
    },
    LoginView: (data) {
      var args = data.getArgs<LoginViewArguments>(
        orElse: () => LoginViewArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => LoginView(key: args.key),
        settings: data,
      );
    },
    SignUpView: (data) {
      var args = data.getArgs<SignUpViewArguments>(
        orElse: () => SignUpViewArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SignUpView(key: args.key),
        settings: data,
      );
    },
    PhoneSignUpScreen: (data) {
      var args = data.getArgs<PhoneSignUpScreenArguments>(
        orElse: () => PhoneSignUpScreenArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => PhoneSignUpScreen(
          key: args.key,
          user: args.user,
        ),
        settings: data,
      );
    },
    ProfileScreen: (data) {
      var args = data.getArgs<ProfileScreenArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => ProfileScreen(
          color: args.color,
          name: args.name,
          phone: args.phone,
          image: args.image,
        ),
        settings: data,
      );
    },
    SelectLanguageView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SelectLanguageView(),
        settings: data,
      );
    },
    StoresScreen: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const StoresScreen(),
        settings: data,
      );
    },
    StoreDetailsScreen: (data) {
      var args = data.getArgs<StoreDetailsScreenArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => StoreDetailsScreen(
          key: args.key,
          store: args.store,
        ),
        settings: data,
      );
    },
    OrderDetailsScreen: (data) {
      var args = data.getArgs<OrderDetailsScreenArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => OrderDetailsScreen(
          key: args.key,
          order: args.order,
          store: args.store,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ProductDetailsView arguments holder class
class ProductDetailsViewArguments {
  final Key? key;
  final Product product;
  final Store store;
  ProductDetailsViewArguments(
      {this.key, required this.product, required this.store});
}

/// LoginView arguments holder class
class LoginViewArguments {
  final Key? key;
  LoginViewArguments({this.key});
}

/// SignUpView arguments holder class
class SignUpViewArguments {
  final Key? key;
  SignUpViewArguments({this.key});
}

/// PhoneSignUpScreen arguments holder class
class PhoneSignUpScreenArguments {
  final Key? key;
  final UserCredential? user;
  PhoneSignUpScreenArguments({this.key, this.user});
}

/// ProfileScreen arguments holder class
class ProfileScreenArguments {
  final Color? color;
  final String name;
  final String phone;
  final String image;
  ProfileScreenArguments(
      {this.color,
      required this.name,
      required this.phone,
      required this.image});
}

/// StoreDetailsScreen arguments holder class
class StoreDetailsScreenArguments {
  final Key? key;
  final Store store;
  StoreDetailsScreenArguments({this.key, required this.store});
}

/// OrderDetailsScreen arguments holder class
class OrderDetailsScreenArguments {
  final Key? key;
  final Order order;
  final Store store;
  OrderDetailsScreenArguments(
      {this.key, required this.order, required this.store});
}
