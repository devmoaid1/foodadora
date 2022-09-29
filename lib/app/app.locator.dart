// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';

import '../core/api/firebase_api_consumer.dart';
import '../core/api/firebase_api_provider.dart';
import '../services/auth_Service.dart';
import '../services/cart_Service.dart';
import '../services/connectivity_service.dart';
import '../services/location_service.dart';
import '../services/orders_services.dart';
import '../services/product_service.dart';
import '../services/profile_service.dart';
import '../services/store_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator
      .registerLazySingleton<FirebaseApiProvider>(() => FirebaseApiConsumer());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => ProfileService());
  locator.registerLazySingleton(() => StoreService());
  locator.registerLazySingleton(() => OrderService());
  locator.registerLazySingleton(() => CartService());
  locator.registerLazySingleton(() => ProductService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => ConnectivityService());
}
