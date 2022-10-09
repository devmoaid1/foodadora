import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/faliures.dart';
import '../../../../core/usecases/use_cases.dart';
import '../repositories/social_auth_repository.dart';

class GoogleSignInUseCase implements UseCase<UserCredential, NoParams> {
  final SocialAuthRepo socialAuthRepo;

  GoogleSignInUseCase({required this.socialAuthRepo});
  @override
  Future<Either<Failure, UserCredential>> call(params) =>
      socialAuthRepo.googleSignIn();
}