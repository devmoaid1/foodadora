import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodadora/core/errors/faliures.dart';

abstract class BasicAuthRepo {
  Future<Either<Failure, UserCredential>> emailLogin(
      {required String email, required String password});

  Future<Either<Failure, UserCredential>> signUp(
      {required String email,
      required String password,
      required String name,
      required String phone});

  Future<Either<Failure, void>> addCustomerToDatabase(
      {String? id,
      String? email,
      String? name,
      String? phone,
      String? photoUrl});
}
