import 'package:foodadora/core/errors/exceptions.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/features/orders/data/datasources/orders_remote_datasource.dart';
import 'package:foodadora/features/orders/data/models/order_model.dart';

import 'package:foodadora/features/orders/domain/repositories/orders_repository.dart';

import '../../../../app/constants/services_instances.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource ordersRemoteDataSource;

  OrdersRepositoryImpl({required this.ordersRemoteDataSource});

  @override
  Future<Either<Failure, void>> createOrder({required OrderModel order}) async {
    try {
      final response = await ordersRemoteDataSource.createOrder(order: order);
      return Right(response);
    } on ServerException catch (err) {
      logger.e("error in creating order:$err");
      return Left(ServerFailure(message: err.message!));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getOrdersForCustomer(
      {required String customerId}) async {
    try {
      final response =
          await ordersRemoteDataSource.getCustomerOrders(id: customerId);
      return Right(
          response.map((order) => OrderModel.fromJson(order.data())).toList());
    } on ServerException catch (err) {
      logger.e("error in getting orders for customer: ${err.message}");
      return Left(ServerFailure(message: err.message!));
    }
  }
}
