import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/features/cart/data/models/cart.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/features/product_details/data/datasources/product_details_localdatasource.dart';
import 'package:foodadora/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:foodadora/features/store_details/domain/entities/product.dart';
import 'package:foodadora/services/cart_Service.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailsLocalDataSource productDetailsLocalDataSource;
  final CartService cartService;

  ProductDetailsRepositoryImpl(
      {required this.productDetailsLocalDataSource, required this.cartService});
  @override
  Either<Failure, void> addItemToCart(
      {required Product product, required int quantity}) {
    try {
      final response =
          cartService.addItem(product: product, quantity: quantity);
      return Right(response);
    } catch (err) {
      logger.e("error in adding item to cart : $err");
      return Left(CacheFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, Cart>> getCart() async {
    try {
      final response =
          await productDetailsLocalDataSource.getCartFromLocalStorage();

      return Right(response);
    } catch (err) {
      logger.e("error in getting cart  : $err");
      return Left(CacheFailure(message: err.toString()));
    }
  }
}
