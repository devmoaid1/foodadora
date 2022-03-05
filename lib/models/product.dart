import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String? storeId;
  final String? productName;
  final String? description;
  final double? productPrice;
  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeAsIs)
  final DateTime? expiryDate;
  final int? quantity;
  final List<String>? productImages;
  final bool? isAvailable;
  final double? originalPrice;

  Product(
      {this.productName,
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

  static DateTime _dateTimeAsIs(DateTime? dateTime) => dateTime
      as DateTime; //<-- pass through no need for generated code to perform any formatting

// https://stackoverflow.com/questions/56627888/how-to-print-firestore-timestamp-as-formatted-date-and-time-in-flutter
  static DateTime _dateTimeFromTimestamp(Timestamp timestamp) {
    return DateTime.parse(timestamp.toDate().toString());
  }
}
