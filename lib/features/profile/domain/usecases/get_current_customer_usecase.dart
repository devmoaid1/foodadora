import 'package:equatable/equatable.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/profile/domain/repositories/profile_repository.dart';

import '../../../auth/domain/entities/customer.dart';

class GetCurrentCustomerUseCase
    implements UseCase<Customer, GetCurrentCustomerParams> {
  final ProfileRepository profileRepository;

  GetCurrentCustomerUseCase({required this.profileRepository});
  @override
  Future<Either<Failure, Customer>> call(GetCurrentCustomerParams params) =>
      profileRepository.getCurrentCustomer(id: params.id);
}

class GetCurrentCustomerParams extends Equatable {
  final String id;

  const GetCurrentCustomerParams({required this.id});

  @override
  List<Object?> get props => [id];
}
