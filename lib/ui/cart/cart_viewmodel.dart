// ignore_for_file: prefer_final_fields, unused_field

import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/product.dart';

import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';

class CartViewModel extends BaseViewModel {
  BehaviorSubject<List<Product>> _cartProducts = BehaviorSubject();
  Stream<List<Product>> get items => cartService.cartItems;
  List<Product> get originalProducts => cartService.originalProducts;

  Product _currentProduct = Product();

  Product get currentProduct => _currentProduct;
  bool _isLoading = false;
  bool get loading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Product> _products = [];

  List<Product> get products => _products;

  bool _isEmpty = true;
  bool get isEmpty => _isEmpty;

  double _total = 0;

  double get total => _total;

  void fetchCartItems() {
    cartService.fetchCartItems(); // get cartitems and set it to stream

    getTotal(); //get subtotal after fetching all cartitems
  }

  void setIsEmpty(bool value) {
    _isEmpty = value;
    notifyListeners();
  }

  void resetTotal() {
    _total = 0;
    notifyListeners();
  }

  void getSubTotal() async {
    _total = await cartService.getSubTotal();
    notifyListeners();
  }

  void getTotal() {
    cartService.cartItems.listen((products) {
      if (products.isNotEmpty) {
        for (var item in products) {
          _total = 0;
          _total += item.quantity! * item.originalPrice!.toDouble();
        }

        _isEmpty = false;
      }

      notifyListeners();
      print(total);
    });
  }

  void incrementQuantity({required Product product, required int stock}) {
    cartService.incrementQuantity(product, stock);
    _total += product.quantity! * product.originalPrice!.toDouble();
    notifyListeners();
  }

  void decrementQuantity({required Product product}) {
    cartService.decrementQuantity(product);
    _total -= product.quantity! * product.originalPrice!.toDouble();
    notifyListeners();
  }

  void deleteCartItem({required Product product}) {
    cartService.deleteItem(product: product);
    cartService.cartItems.listen((items) {
      if (items.isEmpty) {
        _isEmpty = true;
      }
    });
  }
}
