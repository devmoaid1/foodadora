// ignore_for_file: file_names

import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/core/app_viewmodel.dart';
import 'package:foodadora/features/store_details/domain/usecases/get_store_products_usecase.dart';

import '../../../stores/domain/entites/store.dart';
import '../../domain/entities/product.dart';

class StoreDetailsViewModel extends AppViewModel {
  final GetStoreProductsUseCase getStoreProductsUseCase;

  StoreDetailsViewModel({required this.getStoreProductsUseCase});

  List<Product> _storeProducts = [];
  List<Product> get storeProducts => _storeProducts;

  void getStoreProducts({required String storeId}) async {
    setBusy(true);

    final response =
        await getStoreProductsUseCase(GetStoreProductsParams(id: storeId));

    response.fold((failure) {
      setBusy(false);
      logger.e(failure.message.toString());
    }, (products) {
      _storeProducts = products;
      setBusy(false);
    });

    notifyListeners();
  }

  void navigateToProductDetails({Product? product, Store? store}) {
    navigationService.navigateTo(Routes.productDetailsView,
        arguments: ProductDetailsViewArguments(
            product: product as Product, store: store as Store));
  }
}
