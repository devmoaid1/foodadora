import 'package:foodadora/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:foodadora/features/cart/data/models/cart.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/features/cart/domain/repositories/cart_repository.dart';
import 'package:foodadora/features/store_details/domain/entities/product.dart';
import 'package:foodadora/core/providers/cart/cart_Service.dart';

import '../../../../app/constants/services_instances.dart';

class CartRepositoryImpl implements CartRepository {
  final CartService cartService;
  final CartRemoteDataSource cartRemoteDataSource;

  CartRepositoryImpl(
      {required this.cartService, required this.cartRemoteDataSource});

  @override
  Either<Failure, void> decrementQuantity({required Product product}) {
    try {
      final result = cartService.decrementQuantity(product);
      return Right(result);
    } catch (err) {
      logger.e("decrement quantity error:$err");
      return Left(CacheFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteItem({required Product product}) async {
    try {
      final result = await cartService.deleteItem(product: product);
      return Right(result);
    } catch (err) {
      logger.e("delete Item error:$err");
      return Left(CacheFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, Cart>> getCartItems() async {
    try {
      final result = await cartService.fetchCartItems();
      return Right(result);
    } catch (err) {
      logger.e("fetch cartItems  error:$err");
      return Left(CacheFailure(message: err.toString()));
    }
  }

  @override
  Either<Failure, void> incrementQuantity(
      {required Product product, required int stock}) {
    try {
      final result = cartService.incrementQuantity(product, stock);
      return Right(result);
    } catch (err) {
      logger.e("increment quantity  error:$err");
      return Left(CacheFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setProductAvailability(
      {required bool isAvailable, required String productId}) async {
    try {
      final result = await cartRemoteDataSource.setProductAvailability(
          isAvailable: isAvailable, productId: productId);
      return Right(result);
    } catch (err) {
      logger.e("set Product Availablity error:$err");
      return Left(ServerFailure(message: err.toString()));
    }
  }
}
