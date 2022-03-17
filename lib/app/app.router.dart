// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../models/product.dart';
import '../models/store.dart';
import '../ui/Sign_up/phoneSignup_view.dart';
import '../ui/Sign_up/signup_view.dart';
import '../ui/cart/cart_view.dart';
import '../ui/home_navigation/home_navigation_view.dart';
import '../ui/login/login_view.dart';
import '../ui/orders/orders_view.dart';
import '../ui/product_details/product_details_view.dart';
import '../ui/profile/profile_view.dart';
import '../ui/store_details/storeDetails_view.dart';
import '../ui/stores/stores_view.dart';
import '../ui/widgets/authentication_wrapper/authentication_wrapper.dart';

class Routes {
  static const String homeNavigationView = '/';
  static const String productDetailsView = '/product-details-view';
  static const String ordersScreen = '/orders-screen';
  static const String cartScreen = '/cart-screen';
  static const String authenticationWrapper = '/authentication-wrapper';
  static const String loginView = '/login-view';
  static const String signUpView = '/sign-up-view';
  static const String phoneSignUpScreen = '/phone-sign-up-screen';
  static const String profileScreen = '/profile-screen';
  static const String storesScreen = '/stores-screen';
  static const String storeDetailsScreen = '/store-details-screen';
  static const all = <String>{
    homeNavigationView,
    productDetailsView,
    ordersScreen,
    cartScreen,
    authenticationWrapper,
    loginView,
    signUpView,
    phoneSignUpScreen,
    profileScreen,
    storesScreen,
    storeDetailsScreen,
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
    RouteDef(Routes.authenticationWrapper, page: AuthenticationWrapper),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.signUpView, page: SignUpView),
    RouteDef(Routes.phoneSignUpScreen, page: PhoneSignUpScreen),
    RouteDef(Routes.profileScreen, page: ProfileScreen),
    RouteDef(Routes.storesScreen, page: StoresScreen),
    RouteDef(Routes.storeDetailsScreen, page: StoreDetailsScreen),
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
    AuthenticationWrapper: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const AuthenticationWrapper(),
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
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const ProfileScreen(),
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

/// StoreDetailsScreen arguments holder class
class StoreDetailsScreenArguments {
  final Key? key;
  final Store store;
  StoreDetailsScreenArguments({this.key, required this.store});
}
