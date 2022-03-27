// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, unnecessary_null_comparison

import 'package:foodadora/models/customer.dart';

import 'base_service.dart';

class ProfileService extends BaseService {
  Customer _currentCustomer = Customer();
  bool _isLoggedOn = false;

  Customer get currentCustomer => _currentCustomer;
  bool get isLoggedOn => _isLoggedOn;

  void setIsLoggedOn(bool value) {
    _isLoggedOn = value;
  }

  void getCurrentCustomer() async {
    try {
      if (auth.currentUser != null) {
        await firestore
            .collection('customers')
            .where('userId', isEqualTo: auth.currentUser!.uid)
            .get()
            .then((value) => value.docs.forEach((element) {
                  _currentCustomer = Customer.fromJson(element.data());
                  _isLoggedOn = true;
                }));
      } else {
        _isLoggedOn = false;
      }
    } catch (err) {
      logger.e(err.toString());
    }
  }

  Future<Customer> getCustomer() async {
    String? id = auth.currentUser!.uid;

    Customer customer = Customer();
    try {
      await firestore
          .collection('customers')
          .where('userId', isEqualTo: id)
          .get()
          .then((value) => value.docs.forEach((element) {
                customer = Customer.fromJson(element.data());
              }));
    } catch (err) {
      logger.e(err.toString());
    }

    print(customer.name);
    return customer;
  }
}
