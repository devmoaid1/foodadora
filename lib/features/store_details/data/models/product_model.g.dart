// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      productId: json['productId'] as String?,
      productName: json['productName'] as String?,
      description: json['description'] as String?,
      originalPrice: (json['originalPrice'] as num?)?.toDouble(),
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      isAvailable: json['isAvailable'] as bool?,
      isVisible: json['isVisible'] as bool?,
      productPrice: (json['productPrice'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
      quantity: json['quantity'] as int?,
      storeId: json['storeId'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'storeId': instance.storeId,
      'productName': instance.productName,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'productPrice': instance.productPrice,
      'originalPrice': instance.originalPrice,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'quantity': instance.quantity,
      'isAvailable': instance.isAvailable,
      'isVisible': instance.isVisible,
    };
