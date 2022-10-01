import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/auth/domain/repositories/basic_auth_repository.dart';

class EmailLogin implements UseCase<UserCredential, EmailLoginParams> {
  final BasicAuthRepo basicAuthRepo;

  EmailLogin({required this.basicAuthRepo});
  @override
  Future<Either<Failure, UserCredential>> call(params) =>
      basicAuthRepo.emailLogin(email: params.email, password: params.password);
}

class EmailLoginParams extends Equatable {
  final String email;
  final String password;

  const EmailLoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
