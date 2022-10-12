// ignore_for_file: prefer_final_fields, unused_field, avoid_print

import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/app/utilites/custom_modals.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/cart/domain/usecases/decrement_quantity_usecase.dart';
import 'package:foodadora/features/cart/domain/usecases/delete_item_usecase.dart';
import 'package:foodadora/features/cart/domain/usecases/fetch_cart_Items_usecase.dart';
import 'package:foodadora/features/cart/domain/usecases/incrementQuantity_usecase.dart';
import 'package:foodadora/features/cart/domain/usecases/set_product_availability_usecase.dart';

import 'package:foodadora/features/orders/domain/usecases/create_order_usecase.dart';
import 'package:foodadora/features/store_details/data/models/product_model.dart';

import 'package:stacked/stacked.dart';

import '../../../orders/data/models/order_model.dart';
import '../../../store_details/domain/entities/product.dart';

class CartViewModel extends BaseViewModel {
  final FetchCartItemsUseCase fetchCartItemsUseCase;
  final DecrementQuantityUseCase decrementQuantityUseCase;
  final IncrementQuantityUseCase incrementQuantityUseCase;
  final SetProductAvailabilityUseCase setProductAvailabilityUseCase;
  final CreateOrderUseCase createOrderUseCase;
  final DeleteCartItemUseCase deleteCartItemUseCase;

  CartViewModel(
      {required this.fetchCartItemsUseCase,
      required this.decrementQuantityUseCase,
      required this.incrementQuantityUseCase,
      required this.setProductAvailabilityUseCase,
      required this.createOrderUseCase,
      required this.deleteCartItemUseCase});

  bool _isEmpty = true;

  String _storeName = "";

  String get storeName => _storeName;
  Stream<List<Product>> get items => cartService.cartItems;

  List<Product> get originalProducts =>
      cartService.originalProducts; // products with stock

  bool get isEmpty => _isEmpty;

  void navigateToHome() {
    navigationService.replaceWith(Routes.homeNavigationView);
  }

  void fetchCartItems() async {
    setBusy(true);

    final response = await fetchCartItemsUseCase(NoParams());

    response.fold((failure) {
      setBusy(false);
      logger.e(failure.message);
      _mapErrorToDialog("something went wrong");
    }, (cart) {
      if (cart.cartItems!.isNotEmpty) {
        _isEmpty = false;
      }
      setBusy(false);
    });

    // final cart = await cartService
    //     .fetchCartItems(); // get cartitems and set it to stream

    // try {
    //   if (cart.storeId!.isNotEmpty) {
    //     // await storeService.getStoreById(cart.storeId!).then((store) =>
    //     //     _storeName = store!.storeName!); // get store name for cart
    //   }

    //   // handle if cart is empty or not
    //   if (cartService.cartProducts.isEmpty) {
    //     _isEmpty = true;
    //   } else {
    //     _isEmpty = false;
    //   }

    //   setBusy(false);
    // } catch (err) {
    //   setBusy(false);

    //   logger.e(err.toString());
    // }

    notifyListeners();
  }

  void incrementQuantity({required Product product, required int stock}) {
    final response = incrementQuantityUseCase(
        IncrementQuantityParams(product: product, stock: stock));

    response.fold((failure) {
      logger.e(failure.message);
      _mapErrorToDialog("something went wrong");
    },
        (r) => logger
            .i("increment quantity for product : ${product.productName}"));

    // cartService.incrementQuantity(product, stock);

    notifyListeners();
  }

  void decrementQuantity({required Product product}) {
    final response =
        decrementQuantityUseCase(DecerementQuantityParams(product: product));

    response.fold((failure) {
      logger.e(failure.message);
      _mapErrorToDialog("something went wrong");
    },
        (r) => logger
            .i("decrement quantity for product : ${product.productName}"));

    // cartService.decrementQuantity(product);

    notifyListeners();
  }

  void deleteCartItem({required Product product}) async {
    final response =
        await deleteCartItemUseCase(DeleteCartItemParams(product: product));

    response.fold((failure) {
      logger.e(failure.message);
      _mapErrorToDialog("something went wrong");
    }, (r) => logger.i("deleted product from cart : ${product.productName}"));

    // cartService.deleteItem(product: product);
  }

  void placeOrder(
      {required List<Product> orderProducts, required double total}) async {
    List<ProductModel> orderItems = [];
    String storeId = '';

    // if user is not logged in
    if (!profileService.isLoggedOn) {
      final response = await dialogService.showCustomDialog(
          variant: DialogType.basic,
          title: "You are not Logged on",
          mainButtonTitle: "login/SignUp");

      if (response!.confirmed) {
        navigationService.navigateTo(Routes.loginView);
      }
    }

    // if logged in normal placing order
    // later should pass data to order confirmation screen
    else {
      // add items and set availability to false if quantity is max
      for (var product in cartService.originalProducts) {
        for (var orderProduct in orderProducts) {
          storeId = product.storeId.toString();

          orderItems.add(ProductModel(
              description: orderProduct.description,
              expiryDate: orderProduct.expiryDate,
              imageUrl: orderProduct.imageUrl,
              isAvailable: orderProduct.isAvailable,
              isVisible: orderProduct.isVisible,
              originalPrice: orderProduct.originalPrice,
              productId: orderProduct.productId,
              productName: orderProduct.productName,
              productPrice: orderProduct.productPrice,
              quantity: orderProduct.quantity,
              storeId: orderProduct.storeId)); // add item
          if (orderProduct.quantity == product.quantity) {
            // set product availability to false
            final response = await setProductAvailabilityUseCase(
                SetProductAvailabilityParams(
                    isAvailable: false, productId: product.productId!));

            response.fold((failure) {
              logger.e(
                  "error in setting product availability:${failure.message}");
              _mapErrorToDialog(
                  "something went wrong... check your connection and try again");
            }, (r) {
              logger.i(
                  "set availability sucseeded for product : ${product.productName}");
            });
          }
        }
      }

      // create order

      OrderModel order = OrderModel(
        customerId: profileService.currentCustomer!.userId,
        orderDate: DateTime.now(),
        products: orderItems,
        status: 'Pending',
        storeId: storeId,
        totalPrice: cartService.subTotal,
      );

      final orderResponse =
          await createOrderUseCase(CreateOrderParams(order: order));

      orderResponse.fold((failure) {
        logger.e(failure.message);
        _mapErrorToDialog(
            "something went wrong on creating order...please try again");
      }, (r) {
        dialogService.showCustomDialog(
            variant: DialogType.basic,
            title: "Order created successfully",
            mainButtonTitle: "Ok");
      });
    }

    // try {
    //   if (!profileService.isLoggedOn) {
    //     final response = await dialogService.showCustomDialog(
    //         variant: DialogType.basic,
    //         title: "You are not Logged on",
    //         mainButtonTitle: "login/SignUp");

    //     if (response!.confirmed) {
    //       navigationService.replaceWith(Routes.loginView);
    //     }
    //   } else {
    //     // add items in cart to order list products
    //     for (var product in cartService.originalProducts) {
    //       for (var orderProduct in orderProducts) {
    //         storeId = product.storeId.toString();
    //         orderItems.add(orderProduct); // add item
    //         if (orderProduct.quantity == product.quantity) {
    //           // set product availability to false
    //           productService.setProductAvalability(
    //               isAvailiable: false, productId: product.productId.toString());
    //         }
    //       }
    //     }

    //     Order order = Order(
    //       customerId: profileService.currentCustomer!.userId,
    //       orderDate: DateTime.now(),
    //       products: orderItems as List<ProductModel>,
    //       status: 'Pending',
    //       storeId: storeId,
    //       totalPrice: total,
    //     );

    //     ordersService.createOrder(order: order);

    //     dialogService.showCustomDialog(
    //         variant: DialogType.basic,
    //         title: "Order created successfully",
    //         mainButtonTitle: "Ok");
    //   }
    // } catch (err) {
    //   logger.e(err);
    // }
  }

  void _mapErrorToDialog(String err) {
    dialogService.showCustomDialog(
        variant: DialogType.basic,
        title: "error",
        description: err,
        mainButtonTitle: "Ok");
  }
}
