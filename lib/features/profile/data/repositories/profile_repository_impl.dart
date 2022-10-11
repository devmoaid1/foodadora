import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/core/errors/exceptions.dart';
import 'package:foodadora/features/auth/domain/entities/customer.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:foodadora/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl({required this.profileRemoteDataSource});

  @override
  Future<Either<Failure, Customer>> getCurrentCustomer(
      {required String id}) async {
    try {
      final response = await profileRemoteDataSource.getCurrentCustomer(id: id);
      return Right(response);
    } on ServerException catch (err) {
      logger.e("error in get current customer:${err.message}");
      return Left(ServerFailure(message: err.message!));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final response = await profileRemoteDataSource.logout();
      return Right(response);
    } on FirebaseAuthException catch (err) {
      logger.e("error in get current customer:${err.message}");
      return Left(ServerFailure(message: err.message!));
    }
  }
}
