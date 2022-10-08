import 'package:dartz/dartz.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:foodadora/features/orders/data/models/order_model.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<OrderModel>>> getOrdersForCustomer(
      {required String customerId});

  Future<Either<Failure, void>> createOrder({required OrderModel order});
}
