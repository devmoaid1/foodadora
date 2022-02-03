import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:foodadora/app/app.router.dart';

import 'package:stacked_services/stacked_services.dart';

class FoodadoraApp extends StatelessWidget {
  const FoodadoraApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: StackedService.navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: DevicePreview.appBuilder,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
