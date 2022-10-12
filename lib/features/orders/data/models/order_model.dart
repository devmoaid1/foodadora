// ignore_for_file: override_on_non_overriding_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/features/store_details/data/models/product_model.dart';

import 'package:json_annotation/json_annotation.dart';

import '../../../../models/utilities/dateTime_converters.dart';
import '../../domain/entities/order.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderModel extends OrderEntity {
  const OrderModel({
    String? id,
    String? customerId,
    String? storeId,
    List<ProductModel>? products,
    double? totalPrice,
    DateTime? orderDate,
    String? status,
  }) : super(
            customerId: customerId,
            id: id,
            orderDate: orderDate,
            products: products,
            status: status,
            storeId: storeId,
            totalPrice: totalPrice);

  factory OrderModel.fromJson(Map<String, dynamic> data) =>
      _$OrderModelFromJson(data);
  @override
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
