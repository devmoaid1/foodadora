import 'package:dartz/dartz.dart';

import '../../../../core/errors/faliures.dart';

abstract class LocationRepository {
  Future<Either<Failure, bool>> openLocationSettings();
}
