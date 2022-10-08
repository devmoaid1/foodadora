// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String?,
      customerId: json['customerId'] as String?,
      storeId: json['storeId'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      orderDate: json['orderDate'] == null
          ? null
          : DateTimeConverters.dateTimeFromTimestamp(
              json['orderDate'] as Timestamp),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'storeId': instance.storeId,
      'products': instance.products?.map((e) => e.toJson()).toList(),
      'totalPrice': instance.totalPrice,
      'orderDate': DateTimeConverters.dateTimeAsIs(instance.orderDate),
      'status': instance.status,
    };
