import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/models/product.dart';
import 'package:foodadora/models/utilities/dateTime_converters.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  String? id;
  String? customerId;
  String? storeId;
  List<Product>? products;

  double? totalPrice;

  @JsonKey(
      fromJson: DateTimeConverters.dateTimeFromTimestamp,
      toJson: DateTimeConverters.dateTimeAsIs)
  DateTime? orderDate;

  String? status;

  Order(
      {this.id,
      this.customerId,
      this.storeId,
      this.products,
      this.totalPrice,
      this.orderDate,
      this.status});

  factory Order.fromJson(Map<String, dynamic> data) => _$OrderFromJson(data);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
