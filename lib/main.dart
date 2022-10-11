import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:foodadora/app/app.locator.dart';
import 'package:foodadora/app/constants/localization_constants.dart';
import 'package:foodadora/app/dependencies.dart';

import 'app/foodadora/foodadora.dart';
import 'app/utilites/custom_modals.dart';

import 'package:foodadora/translate_preferences.dart';

void main() async {
  LocalizationDelegate delegate = await LocalizationDelegate.create(
    fallbackLocale: fallbackLocale,
    supportedLocales: supportedLocales,
    preferences: TranslatePreferences(),
    basePath: localizationAssetsPath,
  );

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  setupLocator();
  setUpDedpendencies();
  setupDialogUi();

  runApp(
    LocalizedApp(
      delegate,
      DevicePreview(
        builder: (context) => const FoodadoraApp(),
      ),
    ),
  );
}
