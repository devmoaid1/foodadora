import 'package:dartz/dartz.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:foodadora/features/store_details/domain/entities/product.dart';

import '../../data/models/cart.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> setProductAvailability(
      {required bool isAvailable, required String productId});

  Future<Either<Failure, Cart>> getCartItems();

  Either<Failure, void> incrementQuantity(
      {required Product product, required int stock});
  Either<Failure, void> decrementQuantity({required Product product});
  Future<Either<Failure, bool>> deleteItem({required Product product});
}
