import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/core/usecases/use_cases.dart';

import '../repositories/location_repository.dart';

class OpenLocationSettingsUseCase implements UseCase<bool, NoParams> {
  final LocationRepository locationRepository;

  OpenLocationSettingsUseCase({required this.locationRepository});

  @override
  Future<Either<Failure, bool>> call(params) =>
      locationRepository.openLocationSettings();
}
