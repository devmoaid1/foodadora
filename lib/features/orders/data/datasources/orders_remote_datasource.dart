import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/core/api/endpoints.dart';
import 'package:foodadora/core/api/firebase_api_provider.dart';
import 'package:foodadora/services/base_service.dart';

import '../../domain/entities/order.dart';
import '../models/order_model.dart';

abstract class OrdersRemoteDataSource {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getCustomerOrders(
      {required String id});

  Future<void> createOrder({required Order order});
}

class OrdersRemoteDataSourceImpl extends BaseService
    implements OrdersRemoteDataSource {
  final FirebaseApiProvider firebaseApiProvider;

  OrdersRemoteDataSourceImpl({required this.firebaseApiProvider});

  @override
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getCustomerOrders(
      {required String id}) async {
    var fetchedDocs = await firebaseApiProvider.getDataByID(
        orderCollection, "customerId", id);
    return fetchedDocs;
  }

  @override
  Future<void> createOrder({required Order order}) async {
    final orderModel = order as OrderModel;
    await firebaseApiProvider.addData(orderCollection, orderModel.toJson());
  }
}
