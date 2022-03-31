// ignore_for_file: prefer_final_fields, unused_field, avoid_print

import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/app/utilites/custom_modals.dart';
import 'package:foodadora/models/product.dart';

import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';

import '../../models/customer.dart';
import '../../models/order.dart';

class CartViewModel extends BaseViewModel {
  bool _isLoading = false;
  bool _isEmpty = true;
  double _total = 0;

  Stream<List<Product>> get items => cartService.cartItems;
  Stream<double> get subtotalController =>
      cartService.totalController; // subtotal controller
  List<Product> get originalProducts => cartService.originalProducts;

  Customer get customerProfile => profileService.currentCustomer;
  bool get isLoggedOn => profileService.isLoggedOn;

  bool get loading => _isLoading;

  bool get isEmpty => _isEmpty;

  double get total => _total;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

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

  void getTotal() {
    cartService.cartItems.listen((products) {
      if (products.isNotEmpty) {
        _total = 0;
        for (var item in products) {
          print(item.quantity);
          _total += (item.quantity!) * item.originalPrice!.toDouble();
        }

        _isEmpty = false;
      }

      notifyListeners();
    });
  }

  void incrementQuantity({required Product product, required int stock}) {
    cartService.incrementQuantity(product, stock);

    notifyListeners();
  }

  void decrementQuantity({required Product product}) {
    cartService.decrementQuantity(product);

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

  void placeOrder(
      {required List<Product> orderProducts, required double total}) async {
    List<Product> orderItems = [];
    String storeId = '';

    try {
      if (!profileService.isLoggedOn) {
        final response = await dialogService.showCustomDialog(
            variant: DialogType.basic,
            title: "You are not Logged on",
            mainButtonTitle: "login/SignUp");

        if (response!.confirmed) {
          navigationService.replaceWith(Routes.loginView);
        }
      } else {
        // add items in cart to order list products
        for (var product in cartService.originalProducts) {
          for (var orderProduct in orderProducts) {
            storeId = product.storeId.toString();
            orderItems.add(orderProduct); // add item
            if (orderProduct.quantity == product.quantity) {
              // set product availability to false
              productService.setProductAvalability(
                  isAvailiable: false, productId: product.productId.toString());
            }
          }
        }

        Order order = Order(
          customerId: profileService.currentCustomer.userId,
          orderDate: DateTime.now(),
          products: orderItems,
          status: 'Pending',
          storeId: storeId,
          totalPrice: total,
        );

        ordersService.createOrder(order: order);

        dialogService.showCustomDialog(
            variant: DialogType.basic,
            title: "Order created successfully",
            mainButtonTitle: "Ok");
      }
    } catch (err) {
      logger.e(err);
    }
  }
}
