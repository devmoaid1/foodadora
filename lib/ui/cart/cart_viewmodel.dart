// ignore_for_file: prefer_final_fields, unused_field, avoid_print

import 'package:foodadora/app/app.router.dart';
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

  void navigateToHome() {
    navigationService.replaceWith(Routes.homeNavigationView);
  }

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
    _total = cartService.getSubTotal();
    notifyListeners();
  }

  void getTotal() {
    cartService.cartItems.listen((products) {
      print(products.length);

      if (products.isNotEmpty) {
        _total = 0;
        for (var item in products) {
          print(item.quantity);
          _total += (item.quantity!) * item.originalPrice!.toDouble();
        }

        _isEmpty = false;
      }

      notifyListeners();
      print(total);
    });
  }

  void incrementQuantity({required Product product, required int stock}) {
    cartService.incrementQuantity(product, stock);

    notifyListeners();
  }

  void decrementQuantity({required Product product}) {
    cartService.decrementQuantity(product);
    _total = cartService.getSubTotal();

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
