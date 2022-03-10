import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'utilities/dateTime_converters.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String? productId;
  final String? storeId;
  final String? productName;
  final String? description;
  final double? productPrice;

  @JsonKey(
      fromJson: DateTimeConverters.dateTimeFromTimestamp,
      toJson: DateTimeConverters.dateTimeAsIs)
  final DateTime? expiryDate;

  int? quantity;

  final List<String>? productImages;
  final bool? isAvailable;
  final double? originalPrice;

  Product(
      {this.productId,
      this.productName,
      this.description,
      this.originalPrice,
      this.expiryDate,
      this.isAvailable,
      this.productPrice,
      this.productImages,
      this.quantity,
      this.storeId});

  factory Product.fromJson(Map<String, dynamic> data) =>
      _$ProductFromJson(data);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
