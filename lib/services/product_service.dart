import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/services/base_service.dart';

class ProductService extends BaseService {
  void setProductAvalability(
      {required bool isAvailiable, required String productId}) {
    firestore
        .collection('products')
        .doc(productId)
        .set({'isAvailable': isAvailiable}, SetOptions(merge: true));
  }
}
