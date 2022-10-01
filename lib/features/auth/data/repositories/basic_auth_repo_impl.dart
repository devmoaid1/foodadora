import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/core/errors/exceptions.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:foodadora/features/auth/domain/repositories/basic_auth_repository.dart';

class BasicAuthRepoImpl implements BasicAuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  BasicAuthRepoImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UserCredential>> emailLogin(
      {required String email, required String password}) async {
    try {
      final userCredentials =
          await authRemoteDataSource.login(email: email, password: password);
      return Right(userCredentials);
    } on ServerException catch (err) {
      logger.e("error in Login: ${err.message}");
      return Left(AuthenticationFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signUp(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    try {
      final response =
          await authRemoteDataSource.signUp(email: email, password: password);
      return Right(response);
    } on ServerException catch (err) {
      logger.e("error in Sign Up: ${err.message}");
      return Left(AuthenticationFailure());
    }
  }
}
