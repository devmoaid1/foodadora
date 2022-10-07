// ignore_for_file: file_names

import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';

import 'package:stacked/stacked.dart';

import '../../features/store_details/domain/entities/product.dart';
import '../../features/stores/domain/entites/store.dart';

class StoreDetailsViewModel extends BaseViewModel {
  final List<Product> _storeProducts = [];
  bool _isLoading = false;

  bool get loading => _isLoading;
  List<Product> get storeProducts => _storeProducts;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void getStoreProducts({required String storeId}) async {
    setBusy(true);
    setLoading(true);
    try {
      // _storeProducts = await storeService.getStoreProducts(storeId);
      setBusy(false);
      setLoading(false);
    } catch (err) {
      setBusy(false);
      setLoading(false);
      logger.e(err.toString());
    }
  }

  void navigateToProductDetails({Product? product, Store? store}) {
    navigationService.navigateTo(Routes.productDetailsView,
        arguments: ProductDetailsViewArguments(
            product: product as Product, store: store as Store));
  }
}
