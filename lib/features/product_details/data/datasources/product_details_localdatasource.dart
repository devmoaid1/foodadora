import 'package:foodadora/core/providers/cart/cart_local_data_service.dart';

import '../../../cart/data/models/cart.dart';

abstract class ProductDetailsLocalDataSource {
  Future<Cart> getCartFromLocalStorage();
}

class ProductDetailsLocalDataSourceImpl
    implements ProductDetailsLocalDataSource {
  final CartLocalDataService cartService;

  ProductDetailsLocalDataSourceImpl({required this.cartService});

  @override
  Future<Cart> getCartFromLocalStorage() async {
    return await cartService.getCartFromLocal();
  }
}
