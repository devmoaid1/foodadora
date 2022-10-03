import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/faliures.dart';
import '../../../../core/usecases/use_cases.dart';
import '../repositories/basic_auth_repository.dart';

class HandlePhoneFormUseCase implements UseCase<void, HandlePhoneFormParams> {
  final BasicAuthRepo basicAuthRepo;

  HandlePhoneFormUseCase({required this.basicAuthRepo});
  @override
  Future<Either<Failure, void>> call(params) =>
      basicAuthRepo.addCustomerToDatabase(
          email: params.email,
          id: params.id,
          name: params.name,
          phone: params.phone,
          photoUrl: params.photoUrl);
}

class HandlePhoneFormParams extends Equatable {
  final String email;

  final String id;

  final String name;
  final String phone;
  final String photoUrl;

  const HandlePhoneFormParams(
      {required this.email,
      required this.id,
      required this.name,
      required this.phone,
      required this.photoUrl});

  @override
  List<Object?> get props => [email, id, name, phone, photoUrl];
}
