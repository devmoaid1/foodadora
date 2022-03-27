// ignore_for_file: prefer_final_fields, unused_import

import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/product.dart';

import 'package:stacked/stacked.dart';

class ProductDetailsViewModel extends BaseViewModel {
  Stream<List<Product>> get cart => cartService.cartItems;
  String _storeImage = "";
  bool _isLoading = false;
  bool _isAddToCart = false;

  int _quantity = 1;

  bool get isAddToCart => _isAddToCart;
  int get quantity => _quantity;

  String get storeImage => _storeImage;

  bool get loading => _isLoading;

  void setIsAddToCart(bool value) {
    _isAddToCart = value;
    notifyListeners();
  }

  void init() {
    _quantity = 1;
    _isAddToCart = false;
    notifyListeners();
  }

  void incrementQunatity({required int productQuantity}) {
    if (_quantity < productQuantity) {
      _quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  void addToCart({required Product product, required int quatity}) {
    cartService.addItem(product: product, quantity: quatity);
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
