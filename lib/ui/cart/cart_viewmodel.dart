import 'package:flutter/cupertino.dart';
import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/product.dart';
import 'package:foodadora/services/cart_Service.dart';
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
    // setBusy(true);
    // setLoading(true);
    cartService.fetchCartItems(); // get cartitems and set it to stream

    // cartService.cartItems.listen((element) {
    //   if (element.isNotEmpty) {
    //     _isEmpty = false;
    //     notifyListeners();
    //   }
    // });

    getTotal(); //get subtotal after fetching all cartitems
  }

  void getProduct({required String productId}) async {
    setBusy(true);
    _currentProduct = await productService.getProductById(productId: productId);
    setBusy(false);
  }

  void setIsEmpty(bool value) {
    _isEmpty = value;
    notifyListeners();
  }

  void getTotal() {
    setLoading(true);
    _total = 0;
    cartService.cartItems.listen((products) {
      if (products.isNotEmpty) {
        for (var item in products) {
          _total += item.quantity! * item.originalPrice!.toDouble();
        }

        _isEmpty = false;
      }

      notifyListeners();
    });

    setLoading(false);
  }

  void incrementQuantity({required Product product, required int stock}) {
    cartService.incrementQuantity(product, stock);
    notifyListeners();
  }

  void decrementQuantity({required Product product}) {
    cartService.decrementQuantity(product);
    notifyListeners();
  }
}
