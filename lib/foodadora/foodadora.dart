import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/foodadora/foodadora_viewModel.dart';
import 'package:foodadora/ui/widgets/style.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:stacked/stacked.dart';

import 'package:stacked_services/stacked_services.dart';

class FoodadoraApp extends StatelessWidget {
  const FoodadoraApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FoodadoraViewModel>.nonReactive(
      viewModelBuilder: () => FoodadoraViewModel(),
      onModelReady: (model) => model.getCurrentCustomer(),
      builder: (context, model, _) {
        LocalizationDelegate localizationDelegate =
            LocalizedApp.of(context).delegate;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: StackedService.navigatorKey,
          title: 'Foodadora',
          theme: mainTheme,
          localizationsDelegates: [
            localizationDelegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            FormBuilderLocalizations.delegate,
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: localizationDelegate.currentLocale,
          builder: DevicePreview.appBuilder,
          onGenerateRoute: StackedRouter().onGenerateRoute,
        );
      },
    );
  }
}
