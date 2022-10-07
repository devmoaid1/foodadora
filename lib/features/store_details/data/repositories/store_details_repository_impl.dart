import 'package:foodadora/features/store_details/data/datasources/store_details_remote_datasource.dart';
import 'package:foodadora/features/store_details/domain/entities/product.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/features/store_details/domain/repositories/store_details_repository.dart';

import '../../../../app/constants/services_instances.dart';
import '../../../../core/errors/exceptions.dart';

class StoreDetailsRepositoryImpl implements StoreDetailsRepository {
  final StoreDetailsRemoteDataSource storeDetailsRemoteDataSource;

  StoreDetailsRepositoryImpl({required this.storeDetailsRemoteDataSource});
  @override
  Future<Either<Failure, List<Product>>> getStoreProducts(
      {required String id}) async {
    try {
      final storeProducts =
          await storeDetailsRemoteDataSource.getStoreProducts(id: id);
      return Right(storeProducts);
    } on ServerException catch (err) {
      logger.e("error fetching store products : ${err.message}");
      return Left(ServerFailure(message: err.message!));
    }
  }
}
