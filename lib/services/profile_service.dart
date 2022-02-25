import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodadora/models/customer.dart';
import 'package:logger/logger.dart';

class ProfileService {
  final Logger logger = Logger();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _instance = FirebaseAuth.instance;

  Future<Customer> getCustomer() async {
    String? id = _instance.currentUser!.uid;

    Customer customer = Customer();
    try {
      await _firestore
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
