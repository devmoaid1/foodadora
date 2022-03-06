import 'package:foodadora/models/order.dart';
import 'package:foodadora/services/base_service.dart';

class OrderService extends BaseService {
  Future<List<Order>> getOrdersForCustomer({required String customerId}) async {
    try {
      var ordersDocs = await firestore
          .collection('orders')
          .where('customerId', isEqualTo: customerId)
          .get();

      return ordersDocs.docs
          .map((orders) => Order.fromJson(orders.data()))
          .toList();
    } catch (err) {
      logger.e(err.toString());
      return [];
    }
  }
}
