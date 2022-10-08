import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/features/store_details/data/models/product_model.dart';

import 'package:foodadora/services/base_service.dart';

import '../features/orders/data/models/order_model.dart';
import '../features/orders/domain/entities/order.dart';
import '../models/utilities/dateTime_converters.dart';

class OrderService extends BaseService {
  Future<List<Order>> getOrdersForCustomer({required String customerId}) async {
    try {
      var ordersDocs = await firestore
          .collection('orders')
          .where('customerId', isEqualTo: customerId)
          .get();

      return ordersDocs.docs
          .map((orders) => Order(
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
          .toList();
    } catch (err) {
      logger.e(err.toString());
      return [];
    }
  }

  void createOrder({required Order order}) {
    final orderModel = order as OrderModel;
    firestore.collection('orders').add(orderModel.toJson());
  }
}
