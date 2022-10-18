import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/cart/data/models/cart.dart';
import 'package:foodadora/features/product_details/domain/repositories/product_details_repository.dart';

class GetCartUseCase implements UseCase<Cart, NoParams> {
  final ProductDetailsRepository productDetailsRepository;

  GetCartUseCase({required this.productDetailsRepository});

  @override
  Future<Either<Failure, Cart>> call(NoParams params) =>
      productDetailsRepository.getCart();
}
