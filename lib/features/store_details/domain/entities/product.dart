import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
part "product.g.dart";

@CopyWith()
class Product extends Equatable {
  final String? productId;
  final String? storeId;
  final String? productName;
  final String? description;
  final String? imageUrl;
  final double? productPrice;
  final double? originalPrice;

  final DateTime? expiryDate;

  int? quantity;

  final bool? isAvailable;
  final bool? isVisible;

  Product(
      {this.productId,
      this.storeId,
      this.productName,
      this.description,
      this.imageUrl,
      this.productPrice,
      this.originalPrice,
      this.expiryDate,
      this.isAvailable,
      this.isVisible,
      this.quantity});
  @override
  List<Object?> get props => [
        productId,
        description,
        imageUrl,
        originalPrice,
        productId,
        productName,
        productPrice
      ];
}
