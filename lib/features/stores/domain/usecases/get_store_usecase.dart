import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/stores/domain/repositories/stores_repository.dart';

import '../entites/store.dart';

class GetStoreUseCase implements UseCase<Store, GetStoreParams> {
  final StoresRepository storesRepository;

  GetStoreUseCase({required this.storesRepository});

  @override
  Future<Either<Failure, Store>> call(GetStoreParams params) =>
      storesRepository.getStoreById(id: params.id);
}

class GetStoreParams extends Equatable {
  final String id;

  const GetStoreParams({required this.id});
  @override
  List<Object?> get props => [id];
}
