// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) => Store(
      id: json['id'] as String?,
      storeName: json['storeName'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      location: json['location'] as Map<String, dynamic>?,
      logoUrl: json['logoUrl'] as String?,
    );

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'id': instance.id,
      'storeName': instance.storeName,
      'logoUrl': instance.logoUrl,
      'isActive': instance.isActive,
      'location': instance.location,
    };
