// ignore_for_file: file_names, prefer_final_fields, avoid_function_literals_in_foreach_calls, avoid_print, unnecessary_null_comparison

import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/core/api/endpoints.dart';
import 'package:foodadora/core/providers/cart/cart_local_data_service.dart';
import 'package:foodadora/features/store_details/data/models/product_model.dart';

import 'package:foodadora/core/providers/base_service.dart';

import 'package:rxdart/rxdart.dart';

import '../../../app/utilites/custom_modals.dart';
import '../../../features/cart/data/models/cart.dart';
import '../../../features/cart/data/models/cartItem.dart';
import '../../../features/store_details/domain/entities/product.dart';

class CartService extends BaseService {
  final CartLocalDataService cartLocalDataService;

  BehaviorSubject<List<Product>> _cartItems =
      BehaviorSubject(); //cartItems stream

  double _subTotal = 0;

  List<Product> _originalProducts = []; // list of original products with stock
  List<Product> _products =
      []; // list of cart items products with cart quantity

  List<CartItem> _cartProducts = [];
  int get cartLength => _cartProducts.length;

  List<Product> get originalProducts => _originalProducts;
  List<Product> get cartProducts => _products;
  double get subTotal => _subTotal;
  Stream<List<Product>> get cartItems => _cartItems.stream;
  // Stream<double> get totalController => _totalController.stream;

  CartService({required this.cartLocalDataService});

  Future<Cart> fetchCartItems() async {
    var cart = await cartLocalDataService
        .getCartFromLocal(); // get cart from local storage
    var cartItems = cart.cartItems;

    List<Product> products = [];
    _originalProducts.clear(); //clear each time fetching

    if (cartItems != null) {
      _cartProducts = cartItems;
      // for each cartitem get the full product of it
      for (var item in cartItems) {
        var fetchedDocs = await firestore
            .collection(productCollection)
            .where('productId', isEqualTo: item.productId)
            .where('isAvailable', isEqualTo: true)
            .get();

        for (var doc in fetchedDocs.docs) {
          var product = ProductModel.fromJson(doc.data());

          _originalProducts.add(ProductModel.fromJson(doc.data()));

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
    var cart = await cartLocalDataService.getCartFromLocal();
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

    cartLocalDataService.updateCartFromLocal(
        data: Cart(storeId: product.storeId, cartItems: list).toJson());
    // update to local storage

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
      cartLocalDataService.clearCartFromLocal();
      // clear local storage

      items.clear();
      items.add(CartItem(
          productId: product.productId, quantity: quantity)); // add product
      cartLocalDataService.updateCartFromLocal(
          data: Cart(storeId: product.storeId, cartItems: items).toJson());
      // add product in local storage
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
    cartLocalDataService.updateCartFromLocal(
        data: Cart(storeId: product.storeId, cartItems: items).toJson());

    productDetailsViewModel.setIsAddToCart(true);
    navigationService.popUntil((route) => route.isFirst);
    homeNavigationViewModel.setIndex(1);
  }

  Future<bool> deleteItem({required Product product}) async {
    var cart = await cartLocalDataService.getCartFromLocal();
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

      cartLocalDataService.updateCartFromLocal(
          data: Cart(storeId: product.storeId, cartItems: list)
              .toJson()); // update local storage with updated cart items
    }

    _cartProducts = list; // cartproducts sync with new list
    getOrderTotal(cartItems: list); // get total after each item deletion
    cartViewModel.notifyListeners();
    notifyListeners();
    return response.confirmed;
  }

  void incrementQuantity(Product product, int stock) async {
    var cart = await cartLocalDataService.getCartFromLocal();
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
                cartLocalDataService.updateCartFromLocal(data: cart.toJson());
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
    var cart = await cartLocalDataService.getCartFromLocal();
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
                cartLocalDataService.updateCartFromLocal(data: cart.toJson());
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
    _subTotal = 0;

    if (cartItems != null) {
      for (var cartItem in cartItems) {
        for (var product in _originalProducts) {
          if (cartItem.productId == product.productId) {
            _subTotal += cartItem.quantity! * product.productPrice!.toDouble();
          }
        }
      }
    }

    // _totalController.sink.add(total);

    logger.i("total cart is :$_subTotal");
    notifyListeners();
  }
}
