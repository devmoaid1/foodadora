import 'package:dartz/dartz.dart';
import 'package:foodadora/core/errors/faliures.dart';

import '../../../cart/data/models/cart.dart';
import '../../../store_details/domain/entities/product.dart';

abstract class ProductDetailsRepository {
  Future<Either<Failure, Cart>> getCart();
  Either<Failure, void> addItemToCart(
      {required Product product, required int quantity});
}
