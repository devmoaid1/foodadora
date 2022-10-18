import 'package:equatable/equatable.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/product_details/domain/repositories/product_details_repository.dart';

import '../../../store_details/domain/entities/product.dart';

class AddItemToCartUseCase
    implements SynchornousUseCase<void, AddToCartParams> {
  final ProductDetailsRepository productDetailsRepository;

  AddItemToCartUseCase({required this.productDetailsRepository});

  @override
  Either<Failure, void> call(AddToCartParams params) => productDetailsRepository
      .addItemToCart(product: params.product, quantity: params.quantity);
}

class AddToCartParams extends Equatable {
  final Product product;
  final int quantity;

  const AddToCartParams({required this.product, required this.quantity});

  @override
  List<Object?> get props => [product, quantity];
}
