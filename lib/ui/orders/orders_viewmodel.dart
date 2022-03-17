// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/order.dart';
import 'package:stacked/stacked.dart';

import '../../models/store.dart';

class OrdersViewModel extends BaseViewModel {
  List<Order> _orders = [];
  bool _isLoading = false;

  List<Store> _stores = [];

  bool get loading => _isLoading;
  List<Store> get stores => _stores;
  List<Order> get orders => _orders;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String> getCustomerId() async {
    var customer = await profileService.getCustomer();
    return customer.userId.toString();
  }

  void navigateToOrderDetails({required Store store, required Order order}) {
    navigationService.navigateTo(Routes.orderDetailsScreen,
        arguments: OrderDetailsScreenArguments(order: order, store: store));
  }

  void getOrders() async {
    setBusy(true);
    setLoading(true);
    try {
      var customerId = await getCustomerId();
      print(customerId);

      _orders =
          await ordersService.getOrdersForCustomer(customerId: customerId);

      _orders.forEach(
        (element) async {
          var store = await storeService
              .getStoreById(element.products![0].storeId.toString());
          _stores.add(store as Store);
          notifyListeners();
        },
      );
      setBusy(false);
      setLoading(false);
    } catch (err) {
      logger.e(err.toString());
      setBusy(false);
      setLoading(false);
    }
  }
}
