import 'package:equatable/equatable.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/cart/domain/repositories/cart_repository.dart';
import 'package:foodadora/features/store_details/domain/entities/product.dart';

class DecrementQuantityUseCase
    implements SynchornousUseCase<void, DecerementQuantityParams> {
  final CartRepository cartRepository;

  DecrementQuantityUseCase({required this.cartRepository});
  @override
  Either<Failure, void> call(DecerementQuantityParams params) =>
      cartRepository.decrementQuantity(product: params.product);
}

class DecerementQuantityParams extends Equatable {
  final Product product;

  const DecerementQuantityParams({required this.product});

  @override
  List<Object?> get props => [product];
}
