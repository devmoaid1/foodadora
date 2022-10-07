import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:foodadora/features/store_details/domain/entities/product.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../models/utilities/dateTime_converters.dart';

part 'product_model.g.dart';

@JsonSerializable()
@CopyWith()
class ProductModel extends Product {
  const ProductModel(
      {String? productId,
      String? productName,
      String? description,
      double? originalPrice,
      DateTime? expiryDate,
      bool? isAvailable,
      bool? isVisible,
      double? productPrice,
      String? imageUrl,
      int? quantity,
      String? storeId})
      : super(
          description: description,
          imageUrl: imageUrl,
          originalPrice: originalPrice,
          productId: productId,
          productName: productName,
          productPrice: productPrice,
          storeId: storeId,
          expiryDate: expiryDate,
          isAvailable: isAvailable,
          isVisible: isVisible,
          quantity: quantity,
        );

  factory ProductModel.fromJson(Map<String, dynamic> data) =>
      _$ProductModelFromJson(data);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
