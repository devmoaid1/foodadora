// ignore_for_file: avoid_print

import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/order.dart';
import 'package:stacked/stacked.dart';

class OrdersViewModel extends BaseViewModel {
  List<Order> _orders = [];
  bool _isLoading = false;

  bool get loading => _isLoading;

  List<Order> get orders => _orders;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String> getCustomerId() async {
    var customer = await profileService.getCustomer();
    return customer.userId.toString();
  }

  void getOrders() async {
    setBusy(true);
    setLoading(true);
    try {
      var customerId = await getCustomerId();

      _orders =
          await ordersService.getOrdersForCustomer(customerId: customerId);
      setBusy(false);
      setLoading(false);
    } catch (err) {
      logger.e(err.toString());
      setBusy(false);
      setLoading(false);
    }
  }
}
