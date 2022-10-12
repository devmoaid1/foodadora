// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i18;
import 'package:flutter/cupertino.dart' as _i14;
import 'package:flutter/material.dart' as _i15;
import 'package:flutter/material.dart';
import 'package:foodadora/features/auth/presentation/views/login_view.dart'
    as _i6;
import 'package:foodadora/features/auth/presentation/views/phone_signup_view.dart'
    as _i8;
import 'package:foodadora/features/auth/presentation/views/signup_view.dart'
    as _i7;
import 'package:foodadora/features/orders/presentation/views/order_details_view.dart'
    as _i13;
import 'package:foodadora/features/orders/presentation/views/orders_view.dart'
    as _i4;
import 'package:foodadora/features/store_details/domain/entities/product.dart'
    as _i16;
import 'package:foodadora/features/stores/domain/entites/store.dart' as _i17;
import 'package:foodadora/features/stores/presentation/views/stores_view.dart'
    as _i11;
import '/features/cart/presentation/views/cart_view.dart' as _i5;
import 'package:foodadora/ui/home_navigation/home_navigation_view.dart' as _i2;
import 'package:foodadora/ui/product_details/product_details_view.dart' as _i3;
import 'package:foodadora/features/profile/presentation/views/profile_view.dart'
    as _i9;
import 'package:foodadora/ui/select_language/select_language_view.dart' as _i10;
import 'package:foodadora/features/store_details/presentation/views/store_details_view.dart'
    as _i12;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i19;

class Routes {
  static const homeNavigationView = '/';

  static const productDetailsView = '/product-details-view';

  static const ordersScreen = '/orders-screen';

  static const cartScreen = '/cart-screen';

  static const loginView = '/login-view';

  static const signUpView = '/sign-up-view';

  static const phoneSignUpScreen = '/phone-sign-up-screen';

  static const profileScreen = '/profile-screen';

  static const selectLanguageView = '/select-language-view';

  static const storesScreen = '/stores-screen';

  static const storeDetailsScreen = '/store-details-screen';

  static const orderDetailsScreen = '/order-details-screen';

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

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeNavigationView,
      page: _i2.HomeNavigationView,
    ),
    _i1.RouteDef(
      Routes.productDetailsView,
      page: _i3.ProductDetailsView,
    ),
    _i1.RouteDef(
      Routes.ordersScreen,
      page: _i4.OrdersScreen,
    ),
    _i1.RouteDef(
      Routes.cartScreen,
      page: _i5.CartScreen,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i6.LoginView,
    ),
    _i1.RouteDef(
      Routes.signUpView,
      page: _i7.SignUpView,
    ),
    _i1.RouteDef(
      Routes.phoneSignUpScreen,
      page: _i8.PhoneSignUpScreen,
    ),
    _i1.RouteDef(
      Routes.profileScreen,
      page: _i9.ProfileScreen,
    ),
    _i1.RouteDef(
      Routes.selectLanguageView,
      page: _i10.SelectLanguageView,
    ),
    _i1.RouteDef(
      Routes.storesScreen,
      page: _i11.StoresScreen,
    ),
    _i1.RouteDef(
      Routes.storeDetailsScreen,
      page: _i12.StoreDetailsScreen,
    ),
    _i1.RouteDef(
      Routes.orderDetailsScreen,
      page: _i13.OrderDetailsScreen,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeNavigationView: (data) {
      return _i14.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i2.HomeNavigationView(),
        settings: data,
      );
    },
    _i3.ProductDetailsView: (data) {
      final args = data.getArgs<ProductDetailsViewArguments>(nullOk: false);
      return _i14.CupertinoPageRoute<dynamic>(
        builder: (context) => _i3.ProductDetailsView(
            key: args.key, product: args.product, store: args.store),
        settings: data,
      );
    },
    _i4.OrdersScreen: (data) {
      return _i14.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i4.OrdersScreen(),
        settings: data,
      );
    },
    _i5.CartScreen: (data) {
      return _i14.CupertinoPageRoute<dynamic>(
        builder: (context) => _i5.CartScreen(),
        settings: data,
      );
    },
    _i6.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i14.CupertinoPageRoute<dynamic>(
        builder: (context) => _i6.LoginView(key: args.key),
        settings: data,
      );
    },
    _i7.SignUpView: (data) {
      final args = data.getArgs<SignUpViewArguments>(
        orElse: () => const SignUpViewArguments(),
      );
      return _i14.CupertinoPageRoute<dynamic>(
        builder: (context) => _i7.SignUpView(key: args.key),
        settings: data,
      );
    },
    _i8.PhoneSignUpScreen: (data) {
      final args = data.getArgs<PhoneSignUpScreenArguments>(
        orElse: () => const PhoneSignUpScreenArguments(),
      );
      return _i14.CupertinoPageRoute<dynamic>(
        builder: (context) =>
            _i8.PhoneSignUpScreen(key: args.key, user: args.user),
        settings: data,
      );
    },
    _i9.ProfileScreen: (data) {
      final args = data.getArgs<ProfileScreenArguments>(nullOk: false);
      return _i14.CupertinoPageRoute<dynamic>(
        builder: (context) => _i9.ProfileScreen(
            color: args.color,
            name: args.name,
            phone: args.phone,
            image: args.image),
        settings: data,
      );
    },
    _i10.SelectLanguageView: (data) {
      return _i14.CupertinoPageRoute<dynamic>(
        builder: (context) => _i10.SelectLanguageView(),
        settings: data,
      );
    },
    _i11.StoresScreen: (data) {
      return _i14.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i11.StoresScreen(),
        settings: data,
      );
    },
    _i12.StoreDetailsScreen: (data) {
      final args = data.getArgs<StoreDetailsScreenArguments>(nullOk: false);
      return _i14.CupertinoPageRoute<dynamic>(
        builder: (context) => _i12.StoreDetailsScreen(
            key: args.key, store: args.store, distance: args.distance),
        settings: data,
      );
    },
    _i13.OrderDetailsScreen: (data) {
      final args = data.getArgs<OrderDetailsScreenArguments>(nullOk: false);
      return _i14.CupertinoPageRoute<dynamic>(
        builder: (context) => _i13.OrderDetailsScreen(
            key: args.key, order: args.order, store: args.store),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class ProductDetailsViewArguments {
  const ProductDetailsViewArguments({
    this.key,
    required this.product,
    required this.store,
  });

  final _i15.Key? key;

  final _i16.Product product;

  final _i17.Store store;
}

class LoginViewArguments {
  const LoginViewArguments({this.key});

  final _i15.Key? key;
}

class SignUpViewArguments {
  const SignUpViewArguments({this.key});

  final _i15.Key? key;
}

class PhoneSignUpScreenArguments {
  const PhoneSignUpScreenArguments({
    this.key,
    this.user,
  });

  final _i15.Key? key;

  final _i18.UserCredential? user;
}

class ProfileScreenArguments {
  const ProfileScreenArguments({
    this.color,
    required this.name,
    required this.phone,
    required this.image,
  });

  final _i15.Color? color;

  final String name;

  final String phone;

  final String image;
}

class StoreDetailsScreenArguments {
  const StoreDetailsScreenArguments({
    this.key,
    required this.store,
    required this.distance,
  });

  final _i15.Key? key;

  final _i17.Store store;

  final String distance;
}

class OrderDetailsScreenArguments {
  const OrderDetailsScreenArguments({
    this.key,
    required this.order,
    required this.store,
  });

  final _i15.Key? key;

  final dynamic order;

  final _i17.Store store;
}

extension NavigatorStateExtension on _i19.NavigationService {
  Future<dynamic> navigateToHomeNavigationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeNavigationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProductDetailsView({
    _i15.Key? key,
    required _i16.Product product,
    required _i17.Store store,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.productDetailsView,
        arguments: ProductDetailsViewArguments(
            key: key, product: product, store: store),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOrdersScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.ordersScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCartScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.cartScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView({
    _i15.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.loginView,
        arguments: LoginViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignUpView({
    _i15.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.signUpView,
        arguments: SignUpViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPhoneSignUpScreen({
    _i15.Key? key,
    _i18.UserCredential? user,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.phoneSignUpScreen,
        arguments: PhoneSignUpScreenArguments(key: key, user: user),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileScreen({
    _i15.Color? color,
    required String name,
    required String phone,
    required String image,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.profileScreen,
        arguments: ProfileScreenArguments(
            color: color, name: name, phone: phone, image: image),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSelectLanguageView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.selectLanguageView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStoresScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.storesScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStoreDetailsScreen({
    _i15.Key? key,
    required _i17.Store store,
    required String distance,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.storeDetailsScreen,
        arguments: StoreDetailsScreenArguments(
            key: key, store: store, distance: distance),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOrderDetailsScreen({
    _i15.Key? key,
    required dynamic order,
    required _i17.Store store,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.orderDetailsScreen,
        arguments:
            OrderDetailsScreenArguments(key: key, order: order, store: store),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
