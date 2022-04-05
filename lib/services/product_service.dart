import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/models/product.dart';
import 'package:foodadora/services/base_service.dart';

import '../models/utilities/dateTime_converters.dart';

class ProductService extends BaseService {
  Future<Product> getProductById({required String productId}) async {
    Product product = Product();
    try {
      var fetchedDocs = await firestore
          .collection('products')
          .where('productId', isEqualTo: productId)
          .get();

      for (var doc in fetchedDocs.docs) {
        product = Product(
          productId: doc.id,
          productName: doc.data()['productName'] as String?,
          description: doc.data()['description'] as String?,
          originalPrice: (doc.data()['originalPrice'] as num?)?.toDouble(),
          expiryDate: DateTimeConverters.dateTimeFromTimestamp(
              doc.data()['expiryDate'] as Timestamp),
          isAvailable: doc.data()['isAvailable'] as bool?,
          productPrice: (doc.data()['productPrice'] as num?)?.toDouble(),
          productImages: (doc.data()['productImages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
          quantity: int.parse(doc.data()['quantity'].toString()),
          storeId: doc.data()['storeId'] as String?,
        );
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
