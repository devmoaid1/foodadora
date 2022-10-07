import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/core/errors/faliures.dart';

import '../../../store_details/domain/entities/product.dart';
import '../entites/store.dart';

abstract class StoresRepository {
  Future<Either<Failure, Stream<List<DocumentSnapshot>>>> getStores();

  Future<Either<Failure, Store>> getStoreById({required String id});

  Future<Either<Failure, List<Product>>> getStoreProducts({required String id});
}
