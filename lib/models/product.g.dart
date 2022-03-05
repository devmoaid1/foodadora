// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productName: json['productName'] as String?,
      description: json['description'] as String?,
      originalPrice: (json['originalPrice'] as num?)?.toDouble(),
      expiryDate:
          Product._dateTimeFromTimestamp(json['expiryDate'] as Timestamp),
      isAvailable: json['isAvailable'] as bool?,
      productPrice: (json['productPrice'] as num?)?.toDouble(),
      productImages: (json['productImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      quantity: int.parse(json['quantity'].toString()),
      storeId: json['storeId'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'storeId': instance.storeId,
      'productName': instance.productName,
      'description': instance.description,
      'productPrice': instance.productPrice,
      'expiryDate': Product._dateTimeAsIs(instance.expiryDate),
      'quantity': instance.quantity,
      'productImages': instance.productImages,
      'isAvailable': instance.isAvailable,
      'originalPrice': instance.originalPrice,
    };
