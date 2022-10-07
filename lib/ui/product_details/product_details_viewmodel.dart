// ignore_for_file: prefer_final_fields, unused_import

import 'dart:async';

import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/app/utilites/custom_modals.dart';
import 'package:foodadora/models/cartItem.dart';

import 'package:foodadora/services/local_storage_service.dart';

import 'package:stacked/stacked.dart';

import '../../features/store_details/data/models/product_model.dart';
import '../../features/store_details/domain/entities/product.dart';

class ProductDetailsViewModel extends BaseViewModel {
  Stream<List<Product>> get cart => cartService.cartItems;
  String _storeImage = "";
  bool _isLoading = false;
  bool _isAddToCart = false;

  int _quantity = 1;

  bool get isAddToCart => _isAddToCart;
  int get quantity => _quantity;

  String get storeImage => _storeImage;

  bool get loading => _isLoading;

  void setIsAddToCart(bool value) {
    _isAddToCart = value;
    notifyListeners();
  }

  void init(Product product) async {
    List<CartItem> cartItems = [];
    await cartService
        .getCartFromLocalStorage()
        .then((cart) => cartItems = [...cart.cartItems!]); //get cart items

    if (cartItems.isNotEmpty) {
      for (CartItem item in cartItems) {
        // if exist update to true and quantity with current
        if (item.productId == product.productId) {
          _isAddToCart = true;
          _quantity = item.quantity!;
          break;
        } else {
          _isAddToCart = false;
          _quantity = 1;
        }

        // else set to default

      }
    } else {
      _quantity = 1;
      _isAddToCart = false;
    }
    // notifyListeners();
    notifyListeners();
  }

  void incrementQunatity({required Product product}) {
    Product? copyProduct;

    if (_quantity < product.quantity!) {
      copyProduct = product.copyWith(quantity: _quantity);
      _quantity++;
    } else {
      dialogService.showCustomDialog(
          variant: DialogType.basic,
          title: "You cant add more",
          mainButtonTitle: "Ok");
    }
    cartViewModel.incrementQuantity(
        product: copyProduct!, stock: product.quantity!);

    notifyListeners();
  }

  void decrementQuantity({required Product product}) {
    Product? copyProduct;
    if (_quantity > 1) {
      copyProduct = product.copyWith(quantity: _quantity);
      cartService.decrementQuantity(copyProduct);
      _quantity--;
      notifyListeners();
    }
  }

  void addToCart({required Product product, required int quantity}) {
    cartService.addItem(product: product, quantity: quantity);
    // notifyListeners();
  }

  void deleteItem({required Product product}) async {
    List<Product> products = [];
    final isConfirmed = await cartService.deleteItem(product: product);
    if (isConfirmed) {
      _isAddToCart = false;
    }

    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
