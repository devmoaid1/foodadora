// ignore_for_file: file_names

import '/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import '/core/usecases/use_cases.dart';
import '../repositories/cart_repository.dart';

import '../../data/models/cart.dart';

class FetchCartItemsUseCase implements UseCase<Cart, NoParams> {
  final CartRepository cartRepository;

  FetchCartItemsUseCase({required this.cartRepository});
  @override
  Future<Either<Failure, Cart>> call(NoParams params) =>
      cartRepository.getCartItems();
}
