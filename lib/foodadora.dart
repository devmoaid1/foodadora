import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/ui/widgets/style.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:stacked_services/stacked_services.dart';

class FoodadoraApp extends StatelessWidget {
  const FoodadoraApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: StackedService.navigatorKey,
      title: 'Foodadora',
      theme: mainTheme,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
      ],
      builder: DevicePreview.appBuilder,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
