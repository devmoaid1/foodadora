// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/features/store_details/domain/entities/product.dart';
import 'package:foodadora/models/utilities/dateTime_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Product {
  ProductModel(
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
