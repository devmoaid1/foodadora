// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as String?,
      customerId: json['customerId'] as String?,
      storeId: json['storeId'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      orderDate: json['orderDate'] == null
          ? null
          : DateTime.parse(json['orderDate'] as String),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'storeId': instance.storeId,
      'products': instance.products?.map((e) => e.toJson()).toList(),
      'totalPrice': instance.totalPrice,
      'orderDate': instance.orderDate?.toIso8601String(),
      'status': instance.status,
    };
