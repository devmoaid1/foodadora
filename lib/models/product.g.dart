// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: json['productId'] as String?,
      productName: json['productName'] as String?,
      description: json['description'] as String?,
      originalPrice: (json['originalPrice'] as num?)?.toDouble(),
      expiryDate: DateTimeConverters.dateTimeFromTimestamp(
          json['expiryDate'] as Timestamp),
      isAvailable: json['isAvailable'] as bool?,
      productPrice: (json['productPrice'] as num?)?.toDouble(),
      productImages: (json['productImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      quantity: json['quantity'] as int?,
      storeId: json['storeId'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productId': instance.productId,
      'storeId': instance.storeId,
      'productName': instance.productName,
      'description': instance.description,
      'productPrice': instance.productPrice,
      'expiryDate': DateTimeConverters.dateTimeAsIs(instance.expiryDate),
      'quantity': instance.quantity,
      'productImages': instance.productImages,
      'isAvailable': instance.isAvailable,
      'originalPrice': instance.originalPrice,
    };
