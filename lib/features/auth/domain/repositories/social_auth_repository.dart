import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodadora/core/errors/faliures.dart';

abstract class SocialAuthRepo {
  Future<Either<Failure, UserCredential>> googleSignIn();
}
