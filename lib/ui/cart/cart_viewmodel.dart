import 'package:flutter/cupertino.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/product.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';

class CartViewModel extends BaseViewModel {
  BehaviorSubject<List<Product>> _cartProducts = BehaviorSubject();
  Stream<List<Product>> get items => cartService.cartItems;
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

  void fetchCartItems() async {
    setBusy(true);
    setLoading(true);

    cartService.fetchCartItems();
    cartService.cartItems.forEach((element) {
      if (element.isNotEmpty) {
        _isEmpty = false;
        notifyListeners();
      }
    });

    setLoading(false);
    setBusy(false);
  }

  void setIsEmpty(bool value) {
    _isEmpty = value;
    notifyListeners();
  }

  void getTotal() {
    _total = 0;
    cartService.cartItems.listen((products) {
      for (var item in products) {
        _total += item.quantity! * item.originalPrice!.toDouble();
      }

      notifyListeners();
    });
  }

  void incrementQuantity({required Product product}) {
    cartService.incrementQuantity(product);
    notifyListeners();
  }

  void decrementQuantity({required Product product}) {
    cartService.decrementQuantity(product);
    notifyListeners();
  }

  void intit() {
    cartService.cartItems.listen((event) {
      if (event.isEmpty) {
        setIsEmpty(true);
      } else {
        setIsEmpty(false);
      }
    });
  }
}
