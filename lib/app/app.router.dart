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

import '../ui/Sign_up/phoneSignup_view.dart';
import '../ui/Sign_up/signup_view.dart';
import '../ui/home/home_view.dart';
import '../ui/login/login_view.dart';

class Routes {
  static const String homeScreen = '/home-screen';
  static const String loginView = '/';
  static const String signUpView = '/sign-up-view';
  static const String phoneSignUpScreen = '/phone-sign-up-screen';
  static const all = <String>{
    homeScreen,
    loginView,
    signUpView,
    phoneSignUpScreen,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeScreen, page: HomeScreen),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.signUpView, page: SignUpView),
    RouteDef(Routes.phoneSignUpScreen, page: PhoneSignUpScreen),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    HomeScreen: (data) {
      var args = data.getArgs<HomeScreenArguments>(
        orElse: () => HomeScreenArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => HomeScreen(key: args.key),
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
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// HomeScreen arguments holder class
class HomeScreenArguments {
  final Key? key;
  HomeScreenArguments({this.key});
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
