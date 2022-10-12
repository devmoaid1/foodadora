import 'package:equatable/equatable.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/cart/domain/repositories/cart_repository.dart';

class SetProductAvailabilityUseCase
    implements UseCase<void, SetProductAvailabilityParams> {
  final CartRepository cartRepository;

  SetProductAvailabilityUseCase({required this.cartRepository});
  @override
  Future<Either<Failure, void>> call(SetProductAvailabilityParams params) =>
      cartRepository.setProductAvailability(
          isAvailable: params.isAvailable, productId: params.productId);
}

class SetProductAvailabilityParams extends Equatable {
  final bool isAvailable;
  final String productId;

  const SetProductAvailabilityParams(
      {required this.isAvailable, required this.productId});

  @override
  List<Object?> get props => [isAvailable, productId];
}
