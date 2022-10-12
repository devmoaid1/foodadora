import 'package:equatable/equatable.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/cart/domain/repositories/cart_repository.dart';
import 'package:foodadora/features/store_details/domain/entities/product.dart';

class DeleteCartItemUseCase implements UseCase<bool, DeleteCartItemParams> {
  final CartRepository cartRepository;

  DeleteCartItemUseCase({required this.cartRepository});
  @override
  Future<Either<Failure, bool>> call(DeleteCartItemParams params) =>
      cartRepository.deleteItem(product: params.product);
}

class DeleteCartItemParams extends Equatable {
  final Product product;

  const DeleteCartItemParams({required this.product});

  @override
  List<Object?> get props => [product];
}
