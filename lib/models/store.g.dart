// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) => Store(
      id: json['id'] as String?,
      storeName: json['storeName'] as String?,
      address: json['address'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isOpen: json['isOpen'] as bool?,
      pos: json['pos'] as Map<String, dynamic>?,
      category: json['category'] as String?,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'id': instance.id,
      'storeName': instance.storeName,
      'address': instance.address,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
      'isActive': instance.isActive,
      'isOpen': instance.isOpen,
      'pos': instance.pos,
    };
