import 'package:foodadora/models/product.dart';
import 'package:foodadora/models/store.dart';
import 'package:foodadora/services/base_service.dart';

class StoreService extends BaseService {
  Future<List<Store>> getStores() async {
    try {
      var fetchedStores = await firestore
          .collection('stores')
          .where("isActive", isEqualTo: true)
          .get();

      return fetchedStores.docs
          .map((store) => Store.fromJson(store.data()))
          .toList();
    } catch (err) {
      logger.e(err.toString());
      return [];
    }
  }

  Future<Store?> getStoreById(String id) async {
    Store store = Store();
    try {
      var fetchedStore = await firestore
          .collection('stores')
          .where('storeId', isEqualTo: id)
          .get();

      for (var element in fetchedStore.docs) {
        store = Store.fromJson(element.data());
      }
    } catch (err) {
      logger.e(err.toString());
    }

    return store;
  }

  Future<List<Product>> getStoreProducts(String storeId) async {
    try {
      var fetchedProducts = await firestore
          .collection('products')
          .where("storeId", isEqualTo: storeId)
          .where("isAvailable", isEqualTo: true)
          .get();

      return fetchedProducts.docs
          .map((product) => Product.fromJson(product.data()))
          .toList();
    } catch (err) {
      logger.e(err.toString());
      return [];
    }
  }
}
