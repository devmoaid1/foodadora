// ignore_for_file: file_names, prefer_final_fields, avoid_function_literals_in_foreach_calls, avoid_print, unnecessary_null_comparison

import 'dart:convert';

import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/cart.dart';
import 'package:foodadora/models/cartItem.dart';

import 'package:foodadora/models/product.dart';
import 'package:foodadora/services/base_service.dart';
import 'package:foodadora/services/local_storage_service.dart';

import 'package:rxdart/rxdart.dart';

import '../app/utilites/custom_modals.dart';

class CartService extends BaseService {
  LocalStorageService localStorage = LocalStorageService();

  BehaviorSubject<List<Product>> _cartItems =
      BehaviorSubject(); //cartItems stream

  BehaviorSubject<double> _totalController = BehaviorSubject.seeded(0);

  List<Product> _originalProducts = []; // list of original products with stock
  List<Product> _products =
      []; // list of cart items products with cart quantity

  List<Product> get originalProducts => _originalProducts;
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

          products.add(Product(
              productId: doc.id,
              description: product.description,
              expiryDate: product.expiryDate,
              isAvailable: product.isAvailable,
              originalPrice: product.originalPrice,
              imageUrl: product.imageUrl,
              productName: product.productName,
              productPrice: product.productPrice,
              quantity: item.quantity,
              storeId: product.storeId));
        }
      }
    }
    _products = [...products];

    // add list of full products to the stream to be reactive
    _cartItems.sink.add(products);
    getOrderTotal(cartItems: cartItems as List<CartItem>);

    return cart;
  }

  void addItem({required Product product, required int quantity}) async {
    var cart = await getCartFromLocalStorage();
    var items = cart.cartItems;
    List<CartItem> list = items as List<CartItem>;

    bool isAddedQuantity = false;

    // condition for adding to empty cart
    if (items.isEmpty) {
      items.add(CartItem(productId: product.productId, quantity: quantity));
      localStorage.setData(
          key: 'cart',
          data: Cart(storeId: product.storeId, cartItems: items).toJson());

      dialogService
          .showCustomDialog(
            variant: DialogType.basic,
            title: "Your Item has been added to cart",
            mainButtonTitle: "Ok",
          )
          .then(
              (value) => navigationService.popUntil((route) => route.isFirst));
      homeNavigationViewModel.setIndex(1);
    }

    // if cart has items
    else if (items.isNotEmpty) {
      // condition for adding from different store
      if (product.storeId != cart.storeId) {
        var response = await dialogService.showCustomDialog(
            variant: DialogType.addToCart,
            title: "Are you sure you want to remove your current items?",
            description:
                "It seems like you want to add an item from different store",
            mainButtonTitle: "Remove");

        if (response!.confirmed) {
          localStorage.setData(
              key: 'cart', data: Cart(storeId: "", cartItems: []).toJson());

          items.clear();
          items.add(CartItem(productId: product.productId, quantity: quantity));
          localStorage.setData(
              key: 'cart',
              data: Cart(storeId: product.storeId, cartItems: items).toJson());

          print("added from different store");
        }
      }

      //condition for adding product for same store

      else {
        // if item is in cart already update quantity
        items.forEach((item) {
          if (product.productId == item.productId) {
            item.quantity = item.quantity! + quantity;
            localStorage.setData(
                key: 'cart',
                data:
                    Cart(storeId: product.storeId, cartItems: items).toJson());

            isAddedQuantity = true;
            dialogService.showCustomDialog(
                variant: DialogType.basic,
                title: "Updated Quantity ",
                mainButtonTitle: "Ok");
          } else {
            isAddedQuantity = false;
          }
        });

        if (!isAddedQuantity) {
          list.add(CartItem(productId: product.productId, quantity: quantity));
          localStorage.setData(
              key: 'cart',
              data: Cart(storeId: product.storeId, cartItems: list).toJson());

          dialogService.showCustomDialog(
              variant: DialogType.basic,
              title: "item is added to cart",
              mainButtonTitle: "Ok");
        }
      }
    }
  }

  Future<bool> deleteItem({required Product product}) async {
    var cart = await getCartFromLocalStorage();
    var cartItems = cart.cartItems;

    List<CartItem> list = [];
    if (cartItems != null) {
      list = List.from(cartItems);
    }

    var response = await dialogService.showCustomDialog(
        variant: DialogType.addToCart,
        title: "Are you sure you want remove item?",
        mainButtonTitle: "Remove");

    if (response!.confirmed) {
      cartItems!.forEach((element) {
        if (element.productId == product.productId) {
          list.remove(element);
          _products.removeWhere((item) => item.productId == element.productId);
          _cartItems.sink.add(_products);

          localStorage.setData(
              key: 'cart',
              data: Cart(storeId: cart.storeId, cartItems: list).toJson());
        }
      });
    }

    return response.confirmed;
  }

  void incrementQuantity(Product product, int stock) async {
    var cart = await getCartFromLocalStorage();
    var cartItems = cart.cartItems;
    print('called increment');
    for (var item in _products) {
      if (item.productName == product.productName) {
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
        }
      }
    }
    _cartItems.sink.add(_products);

    getOrderTotal(cartItems: cartItems as List<CartItem>);
  }

  void decrementQuantity(Product product) async {
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
