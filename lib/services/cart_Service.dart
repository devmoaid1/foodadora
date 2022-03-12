import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/cart.dart';
import 'package:foodadora/models/cartItem.dart';
import 'package:foodadora/models/customer.dart';
import 'package:foodadora/models/product.dart';
import 'package:foodadora/services/base_service.dart';
import 'package:foodadora/ui/utilites/custom_modals.dart';
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

    _cartItems.sink.add([]);
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
              productId: doc.id,
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

    // add list of full products to the stream to be reactive
    _cartItems.sink.add(products);
  }

  void updateCartItems({required Cart cart}) async {
    await firestore
        .collection('customers')
        .doc('6kvkrYD5BSqvQ4frXiEN')
        .set({'cart': cart.toJson()}, SetOptions(merge: true));
  }

  void addItem({required Product product, required int quantity}) async {
    var cart = await getCustomerCart();
    var items = cart.cartItems;
    List<CartItem> list = items as List<CartItem>;

    bool isAddedQuantity = false;

    // condition for adding to empty cart
    if (items.isEmpty) {
      items.add(CartItem(productId: product.productId, quantity: quantity));
      updateCartItems(cart: Cart(storeId: product.storeId, cartItems: items));
      dialogService.showDialog(title: "item is added to cart");
    }

    // if cart has items
    if (items.isNotEmpty) {
      // condition for adding from different store
      if (product.storeId != cart.storeId) {
        var response = await dialogService.showCustomDialog(
            variant: DialogType.addToCart,
            title: "Are you sure you want to remove cart?",
            description:
                "it seems like you want to add an item from different store",
            mainButtonTitle: "Remove");

        if (response!.confirmed) {
          updateCartItems(cart: Cart(storeId: "", cartItems: []));

          items.add(CartItem(productId: product.productId, quantity: quantity));

          updateCartItems(
              cart: Cart(storeId: product.storeId, cartItems: items));
        }
      }

      //condition for adding product for same store

      else {
        // if item is in cart already update quantity
        items.forEach((item) {
          if (product.productId == item.productId) {
            item.quantity = item.quantity! + quantity;

            updateCartItems(
                cart: Cart(storeId: product.storeId, cartItems: items));
            isAddedQuantity = true;
          } else {
            isAddedQuantity = false;
          }
        });

        if (!isAddedQuantity) {
          list.add(CartItem(productId: product.productId, quantity: quantity));

          updateCartItems(
              cart: Cart(storeId: product.storeId, cartItems: list));

          dialogService.showDialog(title: "item is added to cart");
        }
      }
    }
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
