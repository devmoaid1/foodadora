import 'package:foodadora/core/api/endpoints.dart';

import '../../../../core/api/firebase_api_provider.dart';
import '../../../../services/base_service.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class StoreDetailsRemoteDataSource {
  Future<List<Product>> getStoreProducts({required String id});
}

class StoreDetailsRemoteDataSourceImpl extends BaseService
    implements StoreDetailsRemoteDataSource {
  final FirebaseApiProvider fireStore;

  StoreDetailsRemoteDataSourceImpl({required this.fireStore});

  @override
  Future<List<Product>> getStoreProducts({required String id}) async {
    var fetchedProducts = await firestore
        .collection(productCollection)
        .where("storeId", isEqualTo: id)
        .where("isVisible", isEqualTo: true)
        .get();

    return fetchedProducts.docs
        .map((product) => ProductModel.fromJson(product.data()))
        .toList();
  }
}
