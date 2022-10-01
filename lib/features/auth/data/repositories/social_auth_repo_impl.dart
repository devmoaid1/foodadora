import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/core/errors/exceptions.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:foodadora/features/auth/domain/repositories/social_auth_repository.dart';

class SocialAuthRepoImpl implements SocialAuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  SocialAuthRepoImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UserCredential>> googleSignIn() async {
    try {
      final response = await authRemoteDataSource.googleSignIn();
      return Right(response);
    } on ServerException catch (err) {
      logger.e(err.message);
      return Left(AuthenticationFailure());
    }
  }
}
