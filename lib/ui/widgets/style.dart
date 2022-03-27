// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../app/utilites/app_colors.dart';

final ThemeData mainTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xffdda73a),
  primaryColorLight: const Color(0xfff7ecd4),
  primaryColorDark: const Color(0xffc79634),
  accentColorBrightness: Brightness.light,
  canvasColor: scaffoldColor,
  scaffoldBackgroundColor: scaffoldColor,
  bottomAppBarColor: const Color(0xffffffff),
  cardColor: const Color(0xffffffff),
  dividerColor: const Color(0x1FDE9393),
  highlightColor: const Color(0x66bcbcbc),
  splashColor: const Color(0x66c8c8c8),
  selectedRowColor: const Color(0xfff5f5f5),
  unselectedWidgetColor: const Color(0x8a000000),
  disabledColor: const Color(0x61000000),
  toggleableActiveColor: const Color(0xffae7e1e),
  secondaryHeaderColor: const Color(0xfffbf5e9),
  backgroundColor: const Color(0xfff0d8a8),
  dialogBackgroundColor: const Color(0xffffffff),
  indicatorColor: const Color(0xffd99e26),
  hintColor: const Color(0x8a000000),
  errorColor: const Color(0xffd32f2f),
  fontFamily: 'Raleway',
  colorScheme: ColorScheme.fromSwatch(
      primarySwatch: const MaterialColor(4292716346, {
    50: Color(0xfffbf5e9),
    100: Color(0xfff7ecd4),
    200: Color(0xfff0d8a8),
    300: Color(0xffe8c57d),
    400: Color(0xffe1b151),
    500: Color(0xffd99e26),
    600: Color(0xffae7e1e),
    700: Color(0xff825f17),
    800: Color(0xff573f0f),
    900: Color(0xff2b2008)
  })).copyWith(secondary: const Color(0xffF46317)),
  textSelectionTheme:
      const TextSelectionThemeData(selectionColor: Color(0xfff0d8a8)),
);
