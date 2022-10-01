import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/faliures.dart';
import '../../../../core/usecases/use_cases.dart';
import '../repositories/basic_auth_repository.dart';

class SignUp implements UseCase<UserCredential, SignUpParams> {
  final BasicAuthRepo basicAuthRepo;

  SignUp({required this.basicAuthRepo});
  @override
  Future<Either<Failure, UserCredential>> call(params) => basicAuthRepo.signUp(
      email: params.email,
      password: params.password,
      name: params.name,
      phone: params.phone);
}

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String name;
  final String phone;

  const SignUpParams(
      {required this.email,
      required this.password,
      required this.name,
      required this.phone});

  @override
  List<Object?> get props => [email, password];
}
