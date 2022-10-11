import 'package:dartz/dartz.dart';
import 'package:foodadora/core/errors/faliures.dart';

import '../../../auth/domain/entities/customer.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Customer>> getCurrentCustomer({required String id});
  Future<Either<Failure, void>> logout();
}
