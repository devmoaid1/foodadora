import 'package:foodadora/core/api/firebase_api_consumer.dart';
import 'package:foodadora/core/api/firebase_api_provider.dart';
import 'package:foodadora/core/api/geo_api_consumer.dart';
import 'package:foodadora/core/api/geo_api_provider.dart';
import 'package:foodadora/core/localstorage/local_storage_provider.dart';
import 'package:foodadora/core/localstorage/shared_prefrences_consumer.dart';
import 'package:foodadora/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:foodadora/features/auth/data/repositories/basic_auth_repo_impl.dart';
import 'package:foodadora/features/auth/data/repositories/social_auth_repo_impl.dart';
import 'package:foodadora/features/auth/domain/repositories/basic_auth_repository.dart';
import 'package:foodadora/features/auth/domain/repositories/social_auth_repository.dart';
import 'package:foodadora/features/auth/domain/usecases/email_login_usecase.dart';
import 'package:foodadora/features/auth/domain/usecases/google_sign_usecase.dart';
import 'package:foodadora/features/auth/domain/usecases/handle_phone_form_usecase.dart';
import 'package:foodadora/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:foodadora/features/store_details/domain/repositories/store_details_repository.dart';
import 'package:foodadora/features/stores/data/datasources/location_remote_datasource.dart';
import 'package:foodadora/features/stores/data/datasources/stores_remote_datasource.dart';
import 'package:foodadora/features/stores/data/repositories/location_repository_impl.dart';
import 'package:foodadora/features/stores/data/repositories/stores_repository_impl.dart';
import 'package:foodadora/features/stores/domain/repositories/location_repository.dart';
import 'package:foodadora/features/stores/domain/repositories/stores_repository.dart';

import 'package:foodadora/features/stores/domain/usecases/get_stores_usecase.dart';
import 'package:foodadora/features/stores/domain/usecases/open_location_settings_usecase.dart';
import 'package:foodadora/foodadora/foodadora_viewModel.dart';
import 'package:foodadora/services/base_service.dart';
import 'package:foodadora/services/cart_Service.dart';
import 'package:foodadora/services/connectivity_service.dart';
import 'package:foodadora/services/profile_service.dart';
import 'package:foodadora/ui/cart/cart_viewmodel.dart';
import 'package:foodadora/ui/home_navigation/home_navigation_viewmodel.dart';

import 'package:foodadora/ui/order_details/order_details_viewModel.dart';
import 'package:foodadora/ui/orders/orders_viewmodel.dart';
import 'package:foodadora/ui/product_details/product_details_viewmodel.dart';
import 'package:foodadora/ui/profile/profile_viewModel.dart';
import 'package:foodadora/ui/select_language/select_language_viewmodel.dart';
import 'package:foodadora/ui/settings/settings_viewmodel.dart';
import 'package:foodadora/ui/store_details/store_details_viewmodel.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

import '../features/auth/presentation/viewmodels/login_viewmodel.dart';
import '../features/auth/presentation/viewmodels/signup_viewModel.dart';
import '../features/store_details/data/datasources/store_details_remote_datasource.dart';
import '../features/store_details/data/repositories/store_details_repository_impl.dart';
import '../features/store_details/domain/usecases/get_store_products_usecase.dart';
import '../features/stores/domain/usecases/get_store_usecase.dart';
import '../features/stores/presentation/viewmodels/stores_viewModel.dart';
import '../services/auth_Service.dart';
import '../services/location_service.dart';
import '../services/orders_services.dart';
import '../services/product_service.dart';

Future<void> setUpDedpendencies() async {
  final sharedPrefrences = await SharedPreferences.getInstance();

  //core
  Get.lazyPut(() => sharedPrefrences);
  Get.lazyPut(() => GeoFlutterFire());
  Get.lazyPut<LocalStorageProvider>(
      () => SharedPrefrencesConsumer(sharedPreferences: Get.find()));
  Get.lazyPut(() => BaseService());
  Get.lazyPut<FirebaseApiProvider>(() => FirebaseApiConsumer());
  Get.lazyPut<GeoApiProvider>(() => GeoApiConsumer(geo: Get.find()));

  // remote data sources

  //Auth
  Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSourceimpl());

  // stores
  Get.lazyPut<LocationRemoteDataSource>(() => LocationRemoteDataSourceImpl());
  Get.lazyPut<StoreRemoteDataSource>(() => StoreRemoteDataSourceImpl(
      fireStore: Get.find(), geo: Get.find(), locationService: Get.find()));

  Get.lazyPut<StoreDetailsRemoteDataSource>(
      () => StoreDetailsRemoteDataSourceImpl(
            fireStore: Get.find(),
          ));

  // repositories

  // auth
  Get.lazyPut<BasicAuthRepo>(() => BasicAuthRepoImpl(
      authRemoteDataSource: Get.find(), firebaseApiProvider: Get.find()));
  Get.lazyPut<SocialAuthRepo>(
      () => SocialAuthRepoImpl(authRemoteDataSource: Get.find()));

  // stores
  Get.lazyPut<StoresRepository>(() => StoresRepositoryImpl(
      storesRemoteDataSource: Get.find(),
      locationRemoteDataSource: Get.find()));
  Get.lazyPut<LocationRepository>(
      () => LocationRepositoryImpl(locationRemoteDataSource: Get.find()));

  Get.lazyPut<StoreDetailsRepository>(() =>
      StoreDetailsRepositoryImpl(storeDetailsRemoteDataSource: Get.find()));

  // use cases
  //Auth
  Get.lazyPut(() => EmailLoginUseCase(basicAuthRepo: Get.find()));
  Get.lazyPut(() => GoogleSignInUseCase(socialAuthRepo: Get.find()));
  Get.lazyPut(() => SignUpUseCase(basicAuthRepo: Get.find()));
  Get.lazyPut(() => HandlePhoneFormUseCase(basicAuthRepo: Get.find()));

  // stores
  Get.lazyPut(() => GetStoresUseCase(storesRepository: Get.find()));
  Get.lazyPut(() => GetStoreByIdUseCase(storesRepository: Get.find()));
  Get.lazyPut(
      () => GetStoreProductsUseCase(storeDetailsRepository: Get.find()));
  Get.lazyPut(
      () => OpenLocationSettingsUseCase(locationRepository: Get.find()));

  // viewModels

  Get.lazyPut(() => HomeNavigationViewModel(), fenix: true);
  Get.lazyPut(() => FoodadoraViewModel(), fenix: true);
  Get.lazyPut(
      () => LoginViewModel(
            emailLoginUseCase: Get.find(),
            googleSignInUseCase: Get.find(),
          ),
      fenix: true);
  Get.lazyPut(
      () => SignUpViewModel(
          handlePhoneFormUseCase: Get.find(), signUpUseCase: Get.find()),
      fenix: true);
  Get.lazyPut(() => CartViewModel(), fenix: true);
  Get.lazyPut(() => OrdersViewModel(), fenix: true);
  Get.lazyPut(() => OrdersViewModel(), fenix: true);
  Get.lazyPut(() => OrderDetailsViewModel(), fenix: true);
  Get.lazyPut(() => SettingsViewModel(), fenix: true);
  Get.lazyPut(() => ProfileViewModel(), fenix: true);
  Get.lazyPut(() => ProductDetailsViewModel(), fenix: true);
  Get.lazyPut(() => SelectLanguageViewModel(), fenix: true);
  Get.lazyPut(() => StoreDetailsViewModel(), fenix: true);
  Get.lazyPut(
      () => StoresViewModel(
          getStoresUseCase: Get.find(),
          openLocationSettingsUseCase: Get.find()),
      fenix: true);

  // services

  Get.lazyPut(() => NavigationService());
  // Get.put(DialogService());
  Get.lazyPut(() => AuthService());

  // Get.lazyPut(() => StoreService());
  Get.lazyPut(() => OrderService());

  Get.lazyPut(() => ProductService());
  Get.lazyPut(() => LocationService());
  Get.lazyPut(() => ConnectivityService());

  // providers
  Get.lazyPut(() => ProfileService());
  Get.lazyPut(() => ConnectivityService());
  Get.lazyPut(() => CartService());
}
