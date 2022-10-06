import 'package:foodadora/core/errors/exceptions.dart';
import 'package:foodadora/features/stores/data/datasources/location_remote_datasource.dart';
import 'package:foodadora/features/stores/data/datasources/stores_remote_datasource.dart';
import 'package:foodadora/features/stores/domain/entites/store.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/features/stores/domain/repositories/stores_repository.dart';
import 'package:foodadora/models/product.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../app/constants/services_instances.dart';

class StoresRepositoryImpl implements StoresRepository {
  final StoreRemoteDataSource storesRemoteDataSource;
  final LocationRemoteDataSource locationRemoteDataSource;

  StoresRepositoryImpl(
      {required this.storesRemoteDataSource,
      required this.locationRemoteDataSource});

  @override
  Future<Either<Failure, Store>> getStoreById({required String id}) async {
    try {
      final store = await storesRemoteDataSource.getStoreById(id: id);
      return Right(store);
    } on ServerException catch (err) {
      logger.e("error in getting store :${err.message}");
      return Left(ServerFailure(message: err.message!));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getStoreProducts(
      {required String id}) async {
    try {
      final storeProducts =
          await storesRemoteDataSource.getStoreProducts(id: id);
      return Right(storeProducts);
    } on ServerException catch (err) {
      logger.e("error fetching store products : ${err.message}");
      return Left(ServerFailure(message: err.message!));
    }
  }

  @override
  Future<Either<Failure, Stream<List<DocumentSnapshot>>>> getStores() async {
    try {
      final response = await locationRemoteDataSource.getUserLocation();
      final userLocation = response.userLocation;
      if (response.serviceEnabled == true &&
              userLocation != null &&
              response.permission == LocationPermission.always ||
          response.permission == LocationPermission.whileInUse) {
        final stores =
            storesRemoteDataSource.getStoresInPosition(position: userLocation!);
        return Right(stores);
      }
      return const Right(Stream.empty());
    } on ServerException catch (err) {
      logger.e("error in fetching stores : ${err.message}");
      return Left(ServerFailure(message: err.message!));
    }
  }
}
