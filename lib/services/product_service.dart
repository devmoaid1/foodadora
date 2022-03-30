import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/models/product.dart';
import 'package:foodadora/services/base_service.dart';

class ProductService extends BaseService {
  Future<Product> getProductById({required String productId}) async {
    Product product = Product();
    try {
      var fetchedDocs = await firestore
          .collection('products')
          .where('productId', isEqualTo: productId)
          .get();

      for (var doc in fetchedDocs.docs) {
        product = Product.fromJson(doc.data());
      }
    } catch (err) {
      logger.e(err.toString());
    }

    return product;
  }

  void setProductAvalability(
      {required bool isAvailiable, required String productId}) {
    firestore
        .collection('products')
        .doc(productId)
        .set({'isAvailable': isAvailiable}, SetOptions(merge: true));
  }
}
