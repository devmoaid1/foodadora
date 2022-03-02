import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/product.dart';
import 'package:stacked/stacked.dart';

class StoreDetailsViewModel extends BaseViewModel {
  void navigateToProductDetails({Product? product}) {
    navigationService.navigateTo(Routes.productDetailsView,
        arguments: ProductDetailsViewArguments(product: product as Product));
  }
}
