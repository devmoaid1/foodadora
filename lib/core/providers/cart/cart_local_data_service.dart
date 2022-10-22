import 'package:foodadora/core/localstorage/local_storage_provider.dart';
import 'package:foodadora/features/cart/data/models/cart.dart';

abstract class CartLocalDataService {
  Future getCartFromLocal();
  void clearCartFromLocal();
  void updateCartFromLocal({required dynamic data});
}

class CartLocalDataServiceImpl implements CartLocalDataService {
  final LocalStorageProvider localStorageProvider;

  CartLocalDataServiceImpl({required this.localStorageProvider});

  @override
  void clearCartFromLocal() {
    localStorageProvider.setData(
        key: 'cart', data: Cart(cartItems: [], storeId: ""));
  }

  @override
  Future<Cart> getCartFromLocal() async {
    final cartLocalStorage = localStorageProvider.getData(key: 'cart');
    // return if there is data in local storage otherwise empty cart
    if (cartLocalStorage != null) {
      return Cart.fromJson(cartLocalStorage as Map<String, dynamic>);
    }

    return Cart(storeId: "", cartItems: []);
  }

  @override
  void updateCartFromLocal({required data}) {
    localStorageProvider.setData(key: 'cart', data: data);
  }
}
