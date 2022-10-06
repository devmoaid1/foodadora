import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/stores/domain/repositories/stores_repository.dart';
import 'package:foodadora/models/product.dart';

class GetStoreProductsUseCase
    implements UseCase<List<Product>, GetStoreProductsParams> {
  final StoresRepository storesRepository;

  GetStoreProductsUseCase({required this.storesRepository});

  @override
  Future<Either<Failure, List<Product>>> call(GetStoreProductsParams params) =>
      storesRepository.getStoreProducts(id: params.id);
}

class GetStoreProductsParams extends Equatable {
  final String id;

  const GetStoreProductsParams({required this.id});
  @override
  List<Object?> get props => [id];
}
