import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/product.dart';
import 'package:stacked/stacked.dart';

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

  void incrementQunatity({required int productQuantity}) {
    if (_quantity < productQuantity) {
      _quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  void addToCart({required Product product}) {
    cartService.cartItems.listen((products) {
      if (products.contains(product)) {
        dialogService.showDialog(title: "item is already on cart");
      } else {
        cartService.addItem(product);
        dialogService.showDialog(title: "item is added to cart ");
        notifyListeners();
      }
    }).onError((err) => logger.e(err));

    navigationService.navigateTo(Routes.cartScreen);
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void getStoreImage({required String id}) async {
    setLoading(true);
    setBusy(true);
    try {
      var store = await storeService.getStoreById(id);

      _storeImage = store!.logoUrl.toString();
      setBusy(false);
      setLoading(false);
    } catch (err) {
      setBusy(false);
      setLoading(false);
      logger.e(err.toString());
    }
  }
}
