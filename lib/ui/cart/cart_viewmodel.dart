import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/product.dart';
import 'package:stacked/stacked.dart';

class CartViewModel extends BaseViewModel {
  Stream<List<Product>> get items => cartService.cartItems;

  bool _isEmpty = true;
  bool get isEmpty => _isEmpty;

  double _total = 0;

  double get total => _total;

  void fetchCartItems() async {
    var fetchedItems = await cartService.fetchCartItems();

    cartService.setStream(product: fetchedItems);
    print(await cartService.cartItems.first);

    notifyListeners();
    // notifyListeners();
    // for (var item in fetchedItems) {
    // }
  }

  void setIsEmpty(bool value) {
    _isEmpty = value;
    notifyListeners();
  }

  void getTotal() {
    _total = 0;
    cartService.cartItems.listen((products) {
      for (var item in products) {
        _total += item.quantity! * item.originalPrice!.toDouble();
      }

      notifyListeners();
    });
  }

  void incrementQuantity({required Product product}) {
    cartService.incrementQuantity(product);
    notifyListeners();
  }

  void decrementQuantity({required Product product}) {
    cartService.decrementQuantity(product);
    notifyListeners();
  }

  void intit() {
    cartService.cartItems.listen((event) {
      if (event.isEmpty) {
        setIsEmpty(true);
      } else {
        setIsEmpty(false);
      }
    });
  }
}
