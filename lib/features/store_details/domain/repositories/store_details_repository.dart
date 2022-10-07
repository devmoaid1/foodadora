import 'package:dartz/dartz.dart';

import '../../../../core/errors/faliures.dart';
import '../../../../models/product.dart';

abstract class StoreDetailsRepository {
  Future<Either<Failure, List<Product>>> getStoreProducts({required String id});
}
