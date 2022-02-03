@StackedApp(routes: [
  CupertinoRoute(page: HomeScreen, initial: true),
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService)
], logger: StackedLogger())

// flutter pub run build_runner build --delete-conflicting-outputs   this command for generator
import 'package:foodadora/ui/home/home_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
