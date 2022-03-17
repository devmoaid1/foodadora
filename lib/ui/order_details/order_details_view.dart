import 'package:flutter/material.dart';

import '../../models/order.dart';
import '../../models/store.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;
  final Store store;
  const OrderDetailsScreen({Key? key, required this.order, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [Text("order details")],
        ),
      ),
    );
  }
}
