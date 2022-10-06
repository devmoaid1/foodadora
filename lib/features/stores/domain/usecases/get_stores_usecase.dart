import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/stores/domain/repositories/stores_repository.dart';

class GetStoresUseCase
    implements UseCase<Stream<List<DocumentSnapshot>>, NoParams> {
  final StoresRepository storesRepository;

  GetStoresUseCase({required this.storesRepository});

  @override
  Future<Either<Failure, Stream<List<DocumentSnapshot>>>> call(params) =>
      storesRepository.getStores();
}
