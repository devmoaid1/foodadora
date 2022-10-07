import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:foodadora/core/usecases/use_cases.dart';

import '../../../store_details/domain/entities/product.dart';
import '../repositories/store_details_repository.dart';

class GetStoreProductsUseCase
    implements UseCase<List<Product>, GetStoreProductsParams> {
  final StoreDetailsRepository storeDetailsRepository;

  GetStoreProductsUseCase({required this.storeDetailsRepository});

  @override
  Future<Either<Failure, List<Product>>> call(GetStoreProductsParams params) =>
      storeDetailsRepository.getStoreProducts(id: params.id);
}

class GetStoreProductsParams extends Equatable {
  final String id;

  const GetStoreProductsParams({required this.id});
  @override
  List<Object?> get props => [id];
}
