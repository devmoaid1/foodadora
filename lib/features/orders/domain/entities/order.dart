import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../store_details/data/models/product_model.dart';

part 'order.g.dart';

@CopyWith()
class Order extends Equatable {
  final String? id;
  final String? customerId;
  final String? storeId;
  final List<ProductModel>? products;

  final double? totalPrice;

  final DateTime? orderDate;

  final String? status;

  const Order(
      {this.id,
      this.customerId,
      this.storeId,
      this.products,
      this.totalPrice,
      this.orderDate,
      this.status});

  @override
  List<Object?> get props => [
        customerId,
        id,
        orderDate,
        products,
        status,
        storeId,
        totalPrice,
      ];
}
