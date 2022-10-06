import 'package:dartz/dartz.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:foodadora/features/stores/data/datasources/location_remote_datasource.dart';
import 'package:foodadora/features/stores/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource locationRemoteDataSource;

  LocationRepositoryImpl({required this.locationRemoteDataSource});

  @override
  Future<Either<Failure, bool>> openLocationSettings() async {
    final permession = await locationRemoteDataSource.openLocationSettings();
    if (permession) {
      return Right(permession);
    }
    return const Left(LocationFailure(
        message: "something went wrong on locations permession "));
  }
}
