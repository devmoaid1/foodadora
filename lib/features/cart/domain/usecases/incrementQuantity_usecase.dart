// ignore_for_file: file_names

import 'package:equatable/equatable.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/cart/domain/repositories/cart_repository.dart';
import 'package:foodadora/features/store_details/domain/entities/product.dart';

class IncrementQuantityUseCase
    implements SynchornousUseCase<void, IncrementQuantityParams> {
  final CartRepository cartRepository;

  IncrementQuantityUseCase({required this.cartRepository});
  @override
  Either<Failure, void> call(IncrementQuantityParams params) => cartRepository
      .incrementQuantity(product: params.product, stock: params.stock);
}

class IncrementQuantityParams extends Equatable {
  final Product product;
  final int stock;

  const IncrementQuantityParams({required this.product, required this.stock});

  @override
  List<Object?> get props => [product, stock];
}
