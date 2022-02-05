import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodadora/app/app.locator.dart';
import 'package:foodadora/foodadora.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(DevicePreview(builder: (context) => const FoodadoraApp()));
}
