import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int? storeId;
  final String? productName;
  final double? productPrice;
  final DateTime? expiryDate;
  final int? quantity;
  final List<String>? productImages;
  final bool? isAvailable;
  final double? originalPrice;

  Product(
      {this.productName,
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
