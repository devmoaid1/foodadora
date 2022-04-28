import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:foodadora/foodadora/foodadora.dart';
import 'app/utilites/custom_modals.dart';
import 'package:foodadora/app/app.locator.dart';
import 'package:foodadora/translate_preferences.dart';

void main() async {
  LocalizationDelegate delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: ['en', 'tr'],
    preferences: TranslatePreferences(),
    basePath: 'assets/i18n/',
  );

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  setupLocator();
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
