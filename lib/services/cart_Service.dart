// ignore_for_file: file_names, prefer_final_fields, avoid_function_literals_in_foreach_calls, avoid_print, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/cart.dart';
import 'package:foodadora/models/cartItem.dart';

import 'package:foodadora/models/product.dart';
import 'package:foodadora/services/base_service.dart';
import 'package:foodadora/services/local_storage_service.dart';

import 'package:rxdart/rxdart.dart';

import '../app/utilites/custom_modals.dart';

class CartService extends BaseService with ChangeNotifier {
  LocalStorageService localStorage = LocalStorageService();

  BehaviorSubject<List<Product>> _cartItems =
      BehaviorSubject(); //cartItems stream

  BehaviorSubject<double> _totalController = BehaviorSubject.seeded(0);

  List<Product> _originalProducts = []; // list of original products with stock
  List<Product> _products =
      []; // list of cart items products with cart quantity

  List<CartItem> _cartProducts = [];
  int get cartLength => _cartProducts.length;

  List<Product> get originalProducts => _originalProducts;
  List<Product> get cartProducts => _products;
  Stream<List<Product>> get cartItems => _cartItems.stream;
  Stream<double> get totalController => _totalController.stream;

  CartService() {
    _cartItems.sink.add(_products);
  }

  Future<Cart> getCartFromLocalStorage() async {
    final cartLocalStorage = await localStorage.getData(key: 'cart');
    // return if there is data in local storage otherwise empty cart
    if (cartLocalStorage != null) {
      return Cart.fromJson(jsonDecode(cartLocalStorage.toString()));
    }

    return Cart(storeId: "", cartItems: []);
  }

  Future<Cart> fetchCartItems() async {
    var cart = await getCartFromLocalStorage(); // get cart from local storage
    var cartItems = cart.cartItems;

    List<Product> products = [];
    _originalProducts.clear(); //clear each time fetching

    if (cartItems != null) {
      _cartProducts = cartItems;
      // for each cartitem get the full product of it
      for (var item in cartItems) {
        var fetchedDocs = await firestore
            .collection('products')
            .where('productId', isEqualTo: item.productId)
            .where('isAvailable', isEqualTo: true)
            .get();

        for (var doc in fetchedDocs.docs) {
          var product = Product.fromJson(doc.data());

          _originalProducts.add(Product.fromJson(doc.data()));

          products.add(
              product.copyWith(productId: doc.id, quantity: item.quantity));
        }
      }
    }
    _products = [...products];

    // add list of full products to the stream to be reactive
    _cartItems.sink.add(products);
    getOrderTotal(cartItems: cartItems as List<CartItem>);
    notifyListeners();
    return cart;
  }

  void addItem({required Product product, required int quantity}) async {
    var cart = await getCartFromLocalStorage();
    var items = cart.cartItems!;

    List<CartItem> list = items;

    // condition for adding to empty cart
    if (items.isEmpty) {
      _addToEmptyCart(items, product, quantity);
    }

    // if cart has items
    else {
      // condition for adding from different store
      if (product.storeId != cart.storeId) {
        _addFromDifferentStore(items, product, quantity);
      }

      //condition for adding product for same store

      else {
        // add item directly
        _addToSameStore(list, product, quantity);
      }
    }

    _cartProducts = items;
    notifyListeners();
  }

  void _addToSameStore(List<CartItem> list, Product product, int quantity) {
    list.add(CartItem(
        productId: product.productId, quantity: quantity)); // add to cart list
    localStorage.setData(
        key: 'cart',
        data: Cart(storeId: product.storeId, cartItems: list)
            .toJson()); // update to local storage

    productDetailsViewModel.setIsAddToCart(true);
    navigationService.popUntil((route) => route.isFirst);
    homeNavigationViewModel.setIndex(1);
  }

  void _addFromDifferentStore(
      List<CartItem> items, Product product, int quantity) async {
    var response = await dialogService.showCustomDialog(
        variant: DialogType.addToCart,
        title: "Are you sure you want to remove your current items?",
        description:
            "It seems like you want to add an item from different store",
        mainButtonTitle: "Remove");

    if (response!.confirmed) {
      localStorage.setData(
          key: 'cart',
          data:
              Cart(storeId: "", cartItems: []).toJson()); // clear local storage

      items.clear();
      items.add(CartItem(
          productId: product.productId, quantity: quantity)); // add product
      localStorage.setData(
          key: 'cart',
          data: Cart(storeId: product.storeId, cartItems: items)
              .toJson()); // add product in local storage
      productDetailsViewModel.setIsAddToCart(true);
      navigationService.popUntil((route) => route.isFirst);
      homeNavigationViewModel.setIndex(1);

      print("added from different store");
    } else {
      productDetailsViewModel.setIsAddToCart(false);
    }
  }

  void _addToEmptyCart(
      List<CartItem> items, Product product, int quantity) async {
    items.add(CartItem(productId: product.productId, quantity: quantity));
    localStorage.setData(
        key: 'cart',
        data: Cart(storeId: product.storeId, cartItems: items).toJson());

    productDetailsViewModel.setIsAddToCart(true);
    navigationService.popUntil((route) => route.isFirst);
    homeNavigationViewModel.setIndex(1);
  }

  Future<bool> deleteItem({required Product product}) async {
    var cart = await getCartFromLocalStorage();
    var cartItems = cart.cartItems!;

    List<CartItem> list = List.from(cartItems);

    var response = await dialogService.showCustomDialog(
        variant: DialogType.addToCart,
        title: "Are you sure you want remove item?",
        mainButtonTitle: "Remove");

    if (response!.confirmed) {
      list.removeWhere(
        (element) => element.productId == product.productId,
      ); // remove from cart list
      _products.removeWhere((item) =>
          item.productId == product.productId); // remove from cart screen list

      _cartItems.sink.add(_products); // sync new list to ui

      localStorage.setData(
          key: 'cart',
          data: Cart(storeId: cart.storeId, cartItems: list)
              .toJson()); // update local storage with updated cart items
    }

    _cartProducts = list; // cartproducts sync with new list
    getOrderTotal(cartItems: list); // get total after each item deletion
    cartViewModel.notifyListeners();
    notifyListeners();
    return response.confirmed;
  }

  void incrementQuantity(Product product, int stock) async {
    var cart = await getCartFromLocalStorage();
    var cartItems = cart.cartItems!;

    for (var item in _products) {
      if (item.productId == product.productId) {
        if (item.quantity! < stock) {
          // update in ui
          product.quantity = product.quantity! + 1;

          // update in local storage to be synced
          if (cartItems != null) {
            for (var cartItem in cartItems) {
              if (cartItem.productId == product.productId) {
                cartItem.quantity = product.quantity;
                localStorage.setData(key: 'cart', data: cart.toJson());
              }
            }
          }

          print('called increment and quantity is ${product.quantity}');
        }
      }
    }
    _cartItems.sink.add(_products);

    getOrderTotal(cartItems: cartItems);
  }

  void decrementQuantity(Product product) async {
    // get latest local storage value
    var cart = await getCartFromLocalStorage();
    var cartItems = cart.cartItems;

    for (var item in _products) {
      if (item.productName == product.productName) {
        if (product.quantity! > 1) {
          // update in ui
          product.quantity = product.quantity! - 1;

          // update in local storage to be synced
          if (cartItems != null) {
            for (var cartItem in cartItems) {
              if (cartItem.productId == product.productId) {
                cartItem.quantity = product.quantity;
                localStorage.setData(key: 'cart', data: cart.toJson());
              }
            }
          }
        }
      }
    }

    _cartItems.sink.add(_products);
    getOrderTotal(cartItems: cartItems as List<CartItem>);
  }

  void getOrderTotal({required List<CartItem> cartItems}) async {
    double total = 0;

    if (cartItems != null) {
      for (var cartItem in cartItems) {
        for (var product in _originalProducts) {
          if (cartItem.productId == product.productId) {
            total += cartItem.quantity! * product.productPrice!.toDouble();
          }
        }
      }
    }

    _totalController.sink.add(total);

    logger.i(total);
  }
}
