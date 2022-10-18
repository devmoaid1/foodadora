import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/core/errors/exceptions.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/features/orders/data/datasources/orders_remote_datasource.dart';
import 'package:foodadora/features/orders/data/models/order_model.dart';

import 'package:foodadora/features/orders/domain/repositories/orders_repository.dart';

import '../../../../app/constants/services_instances.dart';
import '../../../../models/utilities/dateTime_converters.dart';
import '../../../store_details/data/models/product_model.dart';

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
      return Right(response
          .map((orders) => OrderModel(
              customerId: orders.data()['customerId'],
              id: orders.id,
              orderDate: DateTimeConverters.dateTimeFromTimestamp(
                  orders.data()['orderDate'] as Timestamp),
              products: (orders.data()['products'] as List<dynamic>?)
                  ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
                  .toList(),
              status: orders.data()['status'],
              storeId: orders.data()['storeId'],
              totalPrice: orders.data()['totalPrice']))
          .toList());
    } on ServerException catch (err) {
      logger.e("error in getting orders for customer: ${err.message}");
      return Left(ServerFailure(message: err.message!));
    }
  }
}
