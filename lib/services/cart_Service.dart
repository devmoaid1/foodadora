import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/customer.dart';
import 'package:foodadora/models/product.dart';
import 'package:foodadora/services/base_service.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';

class CartService extends BaseService {
  BehaviorSubject<List<Product>> _cartItems = BehaviorSubject();

  Stream<List<Product>> get cartItems => _cartItems.stream;
  List<Product> products = [];
  Customer _currentCustomer = Customer();

  CartService() {
    _cartItems.sink.add(products);
  }

  void getCurrentCustomer() async {
    _currentCustomer = await profileService.getCustomer();
  }

  void fetchCartItems() async {
    _currentCustomer = await profileService.getCustomer();
    var cart = _currentCustomer.cart;
    var cartItems = cart!.cartItems;
    List<Product> products = [];
    if (cartItems != null) {
      for (var item in cartItems) {
        var fetchedDocs = await firestore
            .collection('products')
            .where('productId', isEqualTo: item.productId)
            .get();

        for (var doc in fetchedDocs.docs) {
          products.add(Product.fromJson(doc.data()));
        }
      }
    }

    _cartItems.sink.add(products);
  }

  void setStream({required List<Product> product}) {
    _cartItems.stream.listen((products) {
      products.forEach((element) {
        products.add(element);
      });
    });
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
