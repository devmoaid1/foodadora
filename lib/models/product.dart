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
  final String? imageUrl;
  final double? productPrice;
  final double? originalPrice;

  @JsonKey(
      fromJson: DateTimeConverters.dateTimeFromTimestamp,
      toJson: DateTimeConverters.dateTimeAsIs)
  final DateTime? expiryDate;

  int? quantity;

  final bool? isAvailable;
  final bool? isVisible;

  Product(
      {this.productId,
      this.productName,
      this.description,
      this.originalPrice,
      this.expiryDate,
      this.isAvailable,
      this.isVisible,
      this.productPrice,
      this.imageUrl,
      this.quantity,
      this.storeId});

  factory Product.fromJson(Map<String, dynamic> data) =>
      _$ProductFromJson(data);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
