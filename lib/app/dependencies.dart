import 'package:foodadora/core/api/firebase_api_consumer.dart';
import 'package:foodadora/core/api/firebase_api_provider.dart';
import 'package:foodadora/core/api/geo_api_consumer.dart';
import 'package:foodadora/core/api/geo_api_provider.dart';
import 'package:foodadora/core/localstorage/local_storage_provider.dart';
import 'package:foodadora/core/localstorage/shared_prefrences_consumer.dart';
import 'package:foodadora/core/providers/cart/cart_local_data_service.dart';
import 'package:foodadora/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:foodadora/features/auth/data/repositories/basic_auth_repo_impl.dart';
import 'package:foodadora/features/auth/data/repositories/social_auth_repo_impl.dart';
import 'package:foodadora/features/auth/domain/repositories/basic_auth_repository.dart';
import 'package:foodadora/features/auth/domain/repositories/social_auth_repository.dart';
import 'package:foodadora/features/auth/domain/usecases/email_login_usecase.dart';
import 'package:foodadora/features/auth/domain/usecases/google_sign_usecase.dart';
import 'package:foodadora/features/auth/domain/usecases/handle_phone_form_usecase.dart';
import 'package:foodadora/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:foodadora/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:foodadora/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:foodadora/features/cart/domain/repositories/cart_repository.dart';
import 'package:foodadora/features/cart/domain/usecases/delete_item_usecase.dart';
import 'package:foodadora/features/orders/data/datasources/orders_remote_datasource.dart';
import 'package:foodadora/features/orders/data/repositories/orders_repository_impl.dart';
import 'package:foodadora/features/orders/domain/repositories/orders_repository.dart';
import 'package:foodadora/features/orders/domain/usecases/create_order_usecase.dart';
import 'package:foodadora/features/orders/domain/usecases/get_customer_orders_usecase.dart';
import 'package:foodadora/features/product_details/data/datasources/product_details_localdatasource.dart';
import 'package:foodadora/features/product_details/data/repositories/product_details_repository_impl.dart';
import 'package:foodadora/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:foodadora/features/product_details/domain/usecases/add_item_to_cart_usecase.dart';
import 'package:foodadora/features/product_details/domain/usecases/get_cart_usecase.dart';
import 'package:foodadora/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:foodadora/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:foodadora/features/profile/domain/repositories/profile_repository.dart';
import 'package:foodadora/features/profile/domain/usecases/get_current_customer_usecase.dart';
import 'package:foodadora/features/profile/domain/usecases/logout_usecase.dart';
import 'package:foodadora/features/store_details/domain/repositories/store_details_repository.dart';
import 'package:foodadora/features/stores/data/datasources/location_remote_datasource.dart';
import 'package:foodadora/features/stores/data/datasources/stores_remote_datasource.dart';
import 'package:foodadora/features/stores/data/repositories/location_repository_impl.dart';
import 'package:foodadora/features/stores/data/repositories/stores_repository_impl.dart';
import 'package:foodadora/features/stores/domain/repositories/location_repository.dart';
import 'package:foodadora/features/stores/domain/repositories/stores_repository.dart';

import 'package:foodadora/features/stores/domain/usecases/get_stores_usecase.dart';
import 'package:foodadora/features/stores/domain/usecases/open_location_settings_usecase.dart';
import 'package:foodadora/core/providers/base_service.dart';
import 'package:foodadora/core/providers/cart/cart_Service.dart';
import 'package:foodadora/core/providers/connectivity/connectivity_service.dart';
import 'package:foodadora/core/providers/user/user_service_provider.dart';

import 'package:geoflutterfire2/geoflutterfire2.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

import '../features/auth/presentation/viewmodels/login_viewmodel.dart';
import '../features/auth/presentation/viewmodels/signup_viewModel.dart';
import '../features/cart/domain/usecases/decrement_quantity_usecase.dart';
import '../features/cart/domain/usecases/fetch_cart_Items_usecase.dart';
import '../features/cart/domain/usecases/incrementQuantity_usecase.dart';
import '../features/cart/domain/usecases/set_product_availability_usecase.dart';
import '../features/cart/presentation/viewmodels/cart_viewmodel.dart';
import '../features/home_navigation/home_navigation_viewmodel.dart';
import '../features/orders/presentation/viewmodels/orders_viewmodel.dart';
import '../features/product_details/presentation/viewmodels/product_details_viewmodel.dart';
import '../features/profile/presentation/viewmodels/profile_viewModel.dart';
import '../features/select_language/select_language_viewmodel.dart';
import '../features/settings/presentation/viewmodels/settings_viewmodel.dart';
import '../features/store_details/data/datasources/store_details_remote_datasource.dart';
import '../features/store_details/data/repositories/store_details_repository_impl.dart';
import '../features/store_details/domain/usecases/get_store_products_usecase.dart';
import '../features/store_details/presentation/viewmodels/store_details_viewmodel.dart';
import '../features/stores/domain/usecases/get_store_usecase.dart';
import '../features/stores/presentation/viewmodels/stores_viewModel.dart';

import '../core/providers/location_service.dart';

import 'foodadora/foodadora_viewModel.dart';

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

  // orders
  Get.lazyPut<OrdersRemoteDataSource>(() => OrdersRemoteDataSourceImpl(
        firebaseApiProvider: Get.find(),
      ));

  //profile

  Get.lazyPut<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl(
        firebaseApiProvider: Get.find(),
      ));

  // cart
  Get.lazyPut<CartRemoteDataSource>(() => CartRemoteDataSourceImpl(
        firebaseApiProvider: Get.find(),
      ));

  // product details

  Get.lazyPut<ProductDetailsLocalDataSource>(
      () => ProductDetailsLocalDataSourceImpl(cartService: Get.find()));

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

  // orders

  Get.lazyPut<OrdersRepository>(
      () => OrdersRepositoryImpl(ordersRemoteDataSource: Get.find()));

  // profile

  Get.lazyPut<ProfileRepository>(
      () => ProfileRepositoryImpl(profileRemoteDataSource: Get.find()));

  // cart

  Get.lazyPut<CartRepository>(() => CartRepositoryImpl(
      cartService: Get.find(), cartRemoteDataSource: Get.find()));

  // product details

  Get.lazyPut<ProductDetailsRepository>(() => ProductDetailsRepositoryImpl(
      productDetailsLocalDataSource: Get.find(), cartService: Get.find()));

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

  // orders

  Get.lazyPut(() => CreateOrderUseCase(ordersRepository: Get.find()));
  Get.lazyPut(() => GetCustomerOrdersUsecase(ordersRepository: Get.find()));

  // profile

  Get.lazyPut(() => GetCurrentCustomerUseCase(profileRepository: Get.find()));
  Get.lazyPut(() => LogoutUseCase(profileRepository: Get.find()));

  // cart

  Get.lazyPut(() => DeleteCartItemUseCase(cartRepository: Get.find()));
  Get.lazyPut(() => DecrementQuantityUseCase(cartRepository: Get.find()));
  Get.lazyPut(() => IncrementQuantityUseCase(cartRepository: Get.find()));
  Get.lazyPut(() => FetchCartItemsUseCase(cartRepository: Get.find()));
  Get.lazyPut(() => SetProductAvailabilityUseCase(cartRepository: Get.find()));

  // product details

  Get.lazyPut(() => GetCartUseCase(productDetailsRepository: Get.find()));
  Get.lazyPut(() => AddItemToCartUseCase(productDetailsRepository: Get.find()));

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
  Get.lazyPut(
      () => CartViewModel(
          createOrderUseCase: Get.find(),
          decrementQuantityUseCase: Get.find(),
          deleteCartItemUseCase: Get.find(),
          fetchCartItemsUseCase: Get.find(),
          incrementQuantityUseCase: Get.find(),
          setProductAvailabilityUseCase: Get.find()),
      fenix: true);
  Get.lazyPut(
      () => OrdersViewModel(
          getCustomerOrdersUsecase: Get.find(),
          getStoreByIdUseCase: Get.find()),
      fenix: true);

  Get.lazyPut(() => SettingsViewModel(), fenix: true);
  Get.lazyPut(() => ProfileViewModel(logoutUseCase: Get.find()), fenix: true);
  Get.lazyPut(
      () => ProductDetailsViewModel(
          addItemToCartUseCase: Get.find(),
          decrementQuantityUseCase: Get.find(),
          deleteCartItemUseCase: Get.find(),
          getCartUseCase: Get.find(),
          cartViewModel: Get.find()),
      fenix: true);
  Get.lazyPut(() => SelectLanguageViewModel(), fenix: true);
  Get.lazyPut(() => StoreDetailsViewModel(getStoreProductsUseCase: Get.find()),
      fenix: true);
  Get.lazyPut(
      () => StoresViewModel(
          getStoresUseCase: Get.find(),
          openLocationSettingsUseCase: Get.find()),
      fenix: true);

  // services

  Get.lazyPut<CartLocalDataService>(
      () => CartLocalDataServiceImpl(localStorageProvider: Get.find()));
  Get.lazyPut(() => NavigationService());

  Get.lazyPut(() => LocationService());
  Get.lazyPut(() => ConnectivityService());

  // providers
  Get.lazyPut(() => UserServiceProvider(firebaseApiProvider: Get.find()));
  Get.lazyPut(() => ConnectivityService());
  Get.lazyPut(() => CartService(cartLocalDataService: Get.find()));
}
