import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/profile/domain/repositories/profile_repository.dart';

class LogoutUseCase implements UseCase<void, NoParams> {
  final ProfileRepository profileRepository;

  LogoutUseCase({required this.profileRepository});
  @override
  Future<Either<Failure, void>> call(NoParams params) =>
      profileRepository.logout();
}
