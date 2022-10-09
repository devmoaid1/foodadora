// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, prefer_final_fields

import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/core/app_viewmodel.dart';
import 'package:foodadora/features/orders/domain/usecases/get_customer_orders_usecase.dart';
import 'package:foodadora/features/stores/domain/usecases/get_store_usecase.dart';

import 'package:injectable/injectable.dart';

import '../../../auth/domain/entities/customer.dart';
import '../../../stores/domain/entites/store.dart';
import '../../domain/entities/order.dart';

@singleton
class OrdersViewModel extends AppViewModel {
  final GetCustomerOrdersUsecase getCustomerOrdersUsecase;
  final GetStoreByIdUseCase getStoreByIdUseCase;

  List<Order> _orders = [];

  List<Store> _stores = [];

  OrdersViewModel(
      {required this.getCustomerOrdersUsecase,
      required this.getStoreByIdUseCase});

  Customer? get customerProfile => profileService.currentCustomer;

  List<Store> get stores => _stores;
  List<Order> get orders => _orders;

  void navigateToOrderDetails({required Store store, required Order order}) {
    navigationService.navigateTo(Routes.orderDetailsScreen,
        arguments: OrderDetailsScreenArguments(order: order, store: store));
  }

  void getOrders() async {
    setBusy(true);

    final customerId =
        profileService.currentCustomer?.userId; // get customer id

    if (customerId != null) {
      final response = await getCustomerOrdersUsecase(
          GetCustomerOrdersParams(customerId: customerId));

      response.fold((failre) {
        logger.e(failre.message.toString());
        setBusy(false);
      }, (orders) {
        if (orders.isNotEmpty) {
          _orders = orders;
          orders.forEach(
            (element) async {
              var response = await getStoreByIdUseCase(
                  GetStoreParams(id: element.products![0].storeId.toString()));

              response.fold((failure) {
                logger.e(failure.message);
                setBusy(false);
              }, (store) {
                _stores.add(store);
              });

              notifyListeners();
            },
          );
        } else {
          _orders = [];
        }

        setBusy(false);
      });
    }

    setBusy(false);
    // if (customerId != null) {
    //   print(customerId);

    //   _orders = await ordersService.getOrdersForCustomer(
    //       customerId: customerId.toString());
    //   if (_orders.isNotEmpty) {
    //     _orders.forEach(
    //       (element) async {
    //         var store = await storeService
    //             .getStoreById(element.products![0].storeId.toString());
    //         _stores.add(store as Store);
    //         notifyListeners();
    //       },
    //     );
    //   }
    // }
    // setBusy(false);
    // setLoading(false);
    // } catch (err) {
    //   logger.e(err.toString());
    //   setBusy(false);
    //   setLoading(false);
    // }
  }
}