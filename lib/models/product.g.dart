// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productName: json['productName'] as String?,
      originalPrice: (json['originalPrice'] as num?)?.toDouble(),
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      isAvailable: json['isAvailable'] as bool?,
      productPrice: (json['productPrice'] as num?)?.toDouble(),
      productImages: (json['productImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      quantity: json['quantity'] as int?,
      storeId: json['storeId'] as int?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'storeId': instance.storeId,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'quantity': instance.quantity,
      'productImages': instance.productImages,
      'isAvailable': instance.isAvailable,
      'originalPrice': instance.originalPrice,
    };
