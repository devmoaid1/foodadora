import 'package:foodadora/models/product.dart';
import 'package:rxdart/rxdart.dart';

class CartService {
  BehaviorSubject<List<Product>> _cartItems = BehaviorSubject();
  List<Product> products = [];
  Stream<List<Product>> get cartItems => _cartItems.stream;

  CartService() {
    _cartItems.sink.add(products);
  }

  void addItem(Product product) {
    _cartItems.stream.listen((productList) {
      productList.add(product);
    });
  }

  void deleteItem(Product product) {
    _cartItems.stream.listen((productList) {
      productList.remove(product);
    });
  }

  void incrementQuantity(Product product) {
    _cartItems.stream.listen((productsList) {
      productsList.forEach((element) {
        if (element.productName == product.productName) {
          product.quantity = product.quantity! + 1;
        }
      });
    });
  }

  void decrementQuantity(Product product) {
    _cartItems.stream.listen((productsList) {
      productsList.forEach((element) {
        if (element.productName == product.productName) {
          if (product.quantity! > 1) {
            product.quantity = product.quantity! - 1;
          }
        }
      });
    });
  }

  void getTotalPrice(double price) {
    double total = 0;
    double totalPrice = 0;
    _cartItems.stream.listen((products) {
      for (var item in products) {
        total += item.quantity! * item.originalPrice!.toDouble();
      }

      price = total;
    });
  }
}
