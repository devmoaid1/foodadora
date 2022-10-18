// ignore_for_file: prefer_final_fields, unused_import

import 'dart:async';

import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/app/utilites/custom_modals.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/cart/domain/usecases/decrement_quantity_usecase.dart';
import 'package:foodadora/features/cart/domain/usecases/delete_item_usecase.dart';
import 'package:foodadora/features/cart/domain/usecases/incrementQuantity_usecase.dart';
import 'package:foodadora/features/cart/presentation/viewmodels/cart_viewmodel.dart';
import 'package:foodadora/features/product_details/domain/usecases/add_item_to_cart_usecase.dart';
import 'package:foodadora/features/product_details/domain/usecases/get_cart_usecase.dart';

import 'package:foodadora/services/local_storage_service.dart';
import 'package:get/get.dart';

import 'package:stacked/stacked.dart';

import '../../../cart/data/models/cartItem.dart';
import '../../../store_details/domain/entities/product.dart';

class ProductDetailsViewModel extends BaseViewModel {
  final GetCartUseCase getCartUseCase;
  final AddItemToCartUseCase addItemToCartUseCase;
  final DeleteCartItemUseCase deleteCartItemUseCase;
  final DecrementQuantityUseCase decrementQuantityUseCase;
  final IncrementQuantityUseCase incrementQuantityUseCase;

  ProductDetailsViewModel(
      {required this.getCartUseCase,
      required this.addItemToCartUseCase,
      required this.deleteCartItemUseCase,
      required this.decrementQuantityUseCase,
      required this.incrementQuantityUseCase});

  Stream<List<Product>> get cart => cartService.cartItems;

  bool _isAddToCart = false;

  int _quantity = 1;

  bool get isAddToCart => _isAddToCart;
  int get quantity => _quantity;

  void init(Product product) async {
    setBusy(true);
    List<CartItem> cartItems = [];

    final response = await getCartUseCase(NoParams());

    response.fold((failure) {
      setBusy(false);
      logger.e(failure.message);
    }, (cart) {
      cartItems = [...cart.cartItems!];
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
    });
    // await cartService
    //     .getCartFromLocalStorage()
    //     .then((cart) => cartItems = [...cart.cartItems!]); //get cart items

    // if (cartItems.isNotEmpty) {
    //   for (CartItem item in cartItems) {
    //     // if exist update to true and quantity with current
    //     if (item.productId == product.productId) {
    //       _isAddToCart = true;
    //       _quantity = item.quantity!;
    //       break;
    //     } else {
    //       _isAddToCart = false;
    //       _quantity = 1;
    //     }

    //     // else set to default

    //   }
    // } else {
    //   _quantity = 1;
    //   _isAddToCart = false;
    // }
    setBusy(false);
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
    final isConfirmed = await cartService.deleteItem(product: product);
    if (isConfirmed) {
      _isAddToCart = false;
    }

    notifyListeners();
  }
}
