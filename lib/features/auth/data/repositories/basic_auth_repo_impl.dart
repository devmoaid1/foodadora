import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/core/api/endpoints.dart';
import 'package:foodadora/core/api/firebase_api_provider.dart';
import 'package:foodadora/core/errors/exceptions.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:foodadora/features/auth/domain/repositories/basic_auth_repository.dart';

import '../models/customer_model.dart';

class BasicAuthRepoImpl implements BasicAuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final FirebaseApiProvider firebaseApiProvider;

  BasicAuthRepoImpl(
      {required this.authRemoteDataSource, required this.firebaseApiProvider});

  @override
  Future<Either<Failure, UserCredential>> emailLogin(
      {required String email, required String password}) async {
    try {
      final userCredentials =
          await authRemoteDataSource.login(email: email, password: password);
      return Right(userCredentials);
    } on FirebaseAuthException catch (err) {
      logger.e("error in Login: ${err.message}");
      return Left(AuthenticationFailure(message: err.message.toString()));
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

      addCustomerToDatabase(
          email: email,
          id: response.user!.uid,
          name: name,
          phone: phone,
          photoUrl: response.user!.photoURL);

      return Right(response);
    } on FirebaseAuthException catch (err) {
      logger.e("error in Sign Up: ${err.message}");
      return Left(AuthenticationFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addCustomerToDatabase(
      {String? id,
      String? email,
      String? name,
      String? phone,
      String? photoUrl}) async {
    CustomerModel newCustomer = CustomerModel(
        userId: id,
        email: email,
        name: name,
        phoneNumber: phone,
        photoUrl: photoUrl);
    try {
      final response = await firebaseApiProvider.addData(
          customerCollection, newCustomer.toJson());
      return Right(response);
    } on ServerException catch (err) {
      return Left(ServerFailure(message: err.message.toString()));
    }
  }
}
