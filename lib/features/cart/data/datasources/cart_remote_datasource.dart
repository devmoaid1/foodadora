import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/core/api/firebase_api_provider.dart';

abstract class CartRemoteDataSource {
  Future<void> setProductAvailability(
      {required bool isAvailable, required String productId});
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final FirebaseApiProvider firebaseApiProvider;

  CartRemoteDataSourceImpl({required this.firebaseApiProvider});
  @override
  Future<void> setProductAvailability(
      {required bool isAvailable, required String productId}) async {
    await firebaseApiProvider.setData(
        productId, {"isAvailable": isAvailable}, productId,
        options: SetOptions(merge: true));
  }
}
