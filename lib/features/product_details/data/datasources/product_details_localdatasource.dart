import 'package:foodadora/services/cart_Service.dart';

import '../../../cart/data/models/cart.dart';

abstract class ProductDetailsLocalDataSource {
  Future<Cart> getCartFromLocalStorage();
}

class ProductDetailsLocalDataSourceImpl
    implements ProductDetailsLocalDataSource {
  final CartService cartService;

  ProductDetailsLocalDataSourceImpl({required this.cartService});

  @override
  Future<Cart> getCartFromLocalStorage() async {
    return await cartService.getCartFromLocalStorage();
  }
}
