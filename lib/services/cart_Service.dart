import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/cart.dart';
import 'package:foodadora/models/customer.dart';
import 'package:foodadora/models/product.dart';
import 'package:foodadora/services/base_service.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';

class CartService extends BaseService {
  BehaviorSubject<List<Product>> _cartItems = BehaviorSubject();

  List<Product> _originalProducts = [];

  List<Product> products = [];
  Customer _currentCustomer = Customer();

  Customer get currentCustomer => _currentCustomer;
  List<Product> get originalProducts => _originalProducts;
  Stream<List<Product>> get cartItems => _cartItems.stream;

  CartService() {
    _cartItems.sink.add(products);
  }

  Future<Cart> getCustomerCart() async {
    _currentCustomer = await profileService.getCustomer();
    return _currentCustomer.cart as Cart;
  }

  void fetchCartItems() async {
    List<Product> products = [];

    var cart = await getCustomerCart(); // get current customer cart
    var cartItems = cart.cartItems;
    if (cartItems != null) {
      // for each cartitem get the full product of it
      for (var item in cartItems) {
        var fetchedDocs = await firestore
            .collection('products')
            .where('productId', isEqualTo: item.productId)
            .get();

        for (var doc in fetchedDocs.docs) {
          var product = Product.fromJson(doc.data());

          _originalProducts.add(product);

          products.add(Product(
              productId: product.productId,
              description: product.description,
              expiryDate: product.expiryDate,
              isAvailable: product.isAvailable,
              originalPrice: product.originalPrice,
              productImages: product.productImages,
              productName: product.productName,
              productPrice: product.productPrice,
              quantity: item.quantity,
              storeId: product.storeId));
        }
      }
    }
    logger.i(_originalProducts[0].quantity);
    // add list of full products to the stream to be reactive
    _cartItems.sink.add(products);
  }

  void updateCartItems({required Cart cart}) async {
    await firestore
        .collection('customers')
        .doc('YijGT5zPyNrdGlpat2mZ')
        .set({'cart': cart.toJson()}, SetOptions(merge: true));
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

  void incrementQuantity(Product product, int stock) {
    var cart = _currentCustomer.cart;
    var cartItems = cart!.cartItems;

    _cartItems.stream.listen((productsList) {
      productsList.forEach((element) async {
        if (element.productName == product.productName) {
          if (element.quantity! < stock) {
            // update in ui
            product.quantity = product.quantity! + 1;

            // update in database to be synced
            if (cartItems != null) {
              for (var cartItem in cartItems) {
                if (cartItem.productId == product.productId) {
                  cartItem.quantity = product.quantity;
                  updateCartItems(cart: cart);
                }
              }
            }
          }
        }
      });
    });
  }

  void decrementQuantity(Product product) {
    var cart = _currentCustomer.cart;
    var cartItems = cart!.cartItems;

    _cartItems.stream.listen((productsList) {
      productsList.forEach((element) async {
        if (element.productName == product.productName) {
          if (product.quantity! > 1) {
            // update in ui
            product.quantity = product.quantity! - 1;

            // update in database to be synced
            if (cartItems != null) {
              for (var cartItem in cartItems) {
                if (cartItem.productId == product.productId) {
                  cartItem.quantity = product.quantity;
                  updateCartItems(cart: cart);
                }
              }
            }
          }
        }
      });
    });
  }
}
