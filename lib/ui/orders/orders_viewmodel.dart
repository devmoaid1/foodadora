// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, prefer_final_fields

import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/order.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../models/customer.dart';
import '../../models/store.dart';

@singleton
class OrdersViewModel extends BaseViewModel {
  List<Order> _orders = [];
  bool _isLoading = false;

  List<Store> _stores = [];

  Customer get customerProfile => profileService.currentCustomer;
  bool get isLoggedOn => profileService.isLoggedOn;
  bool get isConnected => connectivityService.isConnected;

  bool get loading => _isLoading;
  List<Store> get stores => _stores;
  List<Order> get orders => _orders;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void navigateToOrderDetails({required Store store, required Order order}) {
    navigationService.navigateTo(Routes.orderDetailsScreen,
        arguments: OrderDetailsScreenArguments(order: order, store: store));
  }

  void getOrders() async {
    setBusy(true);
    setLoading(true);

    try {
      final customerId =
          profileService.currentCustomer.userId; // get customer id

      if (customerId != null) {
        print(customerId);

        _orders = await ordersService.getOrdersForCustomer(
            customerId: customerId.toString());
        if (_orders.isNotEmpty) {
          _orders.forEach(
            (element) async {
              var store = await storeService
                  .getStoreById(element.products![0].storeId.toString());
              _stores.add(store as Store);
              notifyListeners();
            },
          );
        }
      }
      setBusy(false);
      setLoading(false);
    } catch (err) {
      logger.e(err.toString());
      setBusy(false);
      setLoading(false);
    }
  }
}
