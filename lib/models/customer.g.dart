// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      name: json['name'] as String?,
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      cart: (json['cart'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      isVerfied: json['isVerfied'] as bool? ?? true,
      orders:
          (json['orders'] as List<dynamic>?)?.map((e) => e as String).toList(),
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'name': instance.name,
      'userId': instance.userId,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'photoUrl': instance.photoUrl,
      'isVerfied': instance.isVerfied,
      'cart': instance.cart,
      'orders': instance.orders,
    };
