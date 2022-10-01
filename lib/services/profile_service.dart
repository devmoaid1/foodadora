// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, unnecessary_null_comparison

import 'package:flutter/cupertino.dart';

import '../features/auth/data/models/customer_model.dart';
import '../features/auth/domain/entities/customer.dart';
import 'base_service.dart';

class ProfileService extends BaseService with ChangeNotifier {
  Customer? _currentCustomer;
  String _customerName = "My Account";
  String _customerAccountType = "email";
  bool _isLoggedOn = false;

  Customer? get currentCustomer => _currentCustomer;
  String get customerAccountType => _customerAccountType;

  String get customerName => _customerName;

  bool get isLoggedOn => _isLoggedOn;

  void setIsLoggedOn(bool value) {
    _isLoggedOn = value;
    notifyListeners();
  }

  Future getCurrentCustomer() async {
    try {
      if (auth.currentUser != null) {
        await firestore
            .collection('customers')
            .where('userId', isEqualTo: auth.currentUser!.uid)
            .get()
            .then((value) => value.docs.forEach((element) {
                  _currentCustomer = CustomerModel.fromJson(element.data());
                  _customerName = auth.currentUser?.displayName ??
                      _currentCustomer!.name ??
                      "My Account";
                  _customerAccountType =
                      auth.currentUser?.providerData[0].providerId ?? "";
                  _isLoggedOn = true;
                }));
      } else {
        _isLoggedOn = false;
      }
      notifyListeners();
    } catch (err) {
      logger.e(err.toString());
    }
  }

  Future<CustomerModel> getCustomer() async {
    String? id = auth.currentUser!.uid;

    CustomerModel? customer;
    try {
      await firestore
          .collection('customers')
          .where('userId', isEqualTo: id)
          .get()
          .then((value) => value.docs.forEach((element) {
                customer = CustomerModel.fromJson(element.data());
              }));
    } catch (err) {
      logger.e(err.toString());
    }

    print(customer!.name);
    return customer!;
  }
}
