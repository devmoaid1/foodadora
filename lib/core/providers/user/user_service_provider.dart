// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodadora/core/api/endpoints.dart';
import 'package:foodadora/core/api/firebase_api_provider.dart';
import 'package:foodadora/core/providers/user/user_service.dart';

import '../../../features/auth/data/models/customer_model.dart';
import '../../../features/auth/domain/entities/customer.dart';
import '../base_service.dart';

class UserServiceProvider extends BaseService implements UserService {
  final FirebaseApiProvider firebaseApiProvider;

  Customer? _currentCustomer;
  String _customerName = "My Account";
  String _customerAccountType = "email";
  bool _isLoggedOn = false;
  Stream<User?> get authState => auth.authStateChanges();

  UserServiceProvider({required this.firebaseApiProvider});

  Customer? get currentCustomer => _currentCustomer;
  String get customerAccountType => _customerAccountType;

  String get customerName => _customerName;

  bool get isLoggedOn => _isLoggedOn;

  void setIsLoggedOn(bool value) {
    _isLoggedOn = value;
    notifyListeners();
  }

  @override
  Future<void> getCurrentCustomer() async {
    try {
      final isLoggedIn = isUserLoggedIn();
      if (isLoggedIn) {
        final fetchedDocs = await firebaseApiProvider.getDataByID(
            customerCollection, 'userId', auth.currentUser!.uid);

        for (var fetchedDoc in fetchedDocs) {
          _currentCustomer = CustomerModel.fromJson(fetchedDoc.data());
          _customerName = auth.currentUser?.displayName ??
              _currentCustomer!.name ??
              "My Account";
          _customerAccountType =
              auth.currentUser?.providerData[0].providerId ?? "";
        }
        _isLoggedOn = true;
      } else {
        _isLoggedOn = false;
      }
      notifyListeners();
    } catch (err) {
      logger.e(err.toString());
    }
  }

  @override
  bool isUserLoggedIn() {
    final isLoggedIn = auth.currentUser != null;
    return isLoggedIn;
  }
}
