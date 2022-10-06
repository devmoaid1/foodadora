// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storemodel.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StoreModelCWProxy {
  StoreModel address(String? address);

  StoreModel category(String? category);

  StoreModel id(String? id);

  StoreModel imageUrl(String? imageUrl);

  StoreModel isActive(bool isActive);

  StoreModel isOpen(bool? isOpen);

  StoreModel pos(Map<String, dynamic>? pos);

  StoreModel storeName(String? storeName);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StoreModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StoreModel(...).copyWith(id: 12, name: "My name")
  /// ````
  StoreModel call({
    String? address,
    String? category,
    String? id,
    String? imageUrl,
    bool? isActive,
    bool? isOpen,
    Map<String, dynamic>? pos,
    String? storeName,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStoreModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStoreModel.copyWith.fieldName(...)`
class _$StoreModelCWProxyImpl implements _$StoreModelCWProxy {
  final StoreModel _value;

  const _$StoreModelCWProxyImpl(this._value);

  @override
  StoreModel address(String? address) => this(address: address);

  @override
  StoreModel category(String? category) => this(category: category);

  @override
  StoreModel id(String? id) => this(id: id);

  @override
  StoreModel imageUrl(String? imageUrl) => this(imageUrl: imageUrl);

  @override
  StoreModel isActive(bool isActive) => this(isActive: isActive);

  @override
  StoreModel isOpen(bool? isOpen) => this(isOpen: isOpen);

  @override
  StoreModel pos(Map<String, dynamic>? pos) => this(pos: pos);

  @override
  StoreModel storeName(String? storeName) => this(storeName: storeName);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StoreModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StoreModel(...).copyWith(id: 12, name: "My name")
  /// ````
  StoreModel call({
    Object? address = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? isOpen = const $CopyWithPlaceholder(),
    Object? pos = const $CopyWithPlaceholder(),
    Object? storeName = const $CopyWithPlaceholder(),
  }) {
    return StoreModel(
      address: address == const $CopyWithPlaceholder()
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String?,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      imageUrl: imageUrl == const $CopyWithPlaceholder()
          ? _value.imageUrl
          // ignore: cast_nullable_to_non_nullable
          : imageUrl as String?,
      isActive: isActive == const $CopyWithPlaceholder() || isActive == null
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      isOpen: isOpen == const $CopyWithPlaceholder()
          ? _value.isOpen
          // ignore: cast_nullable_to_non_nullable
          : isOpen as bool?,
      pos: pos == const $CopyWithPlaceholder()
          ? _value.pos
          // ignore: cast_nullable_to_non_nullable
          : pos as Map<String, dynamic>?,
      storeName: storeName == const $CopyWithPlaceholder()
          ? _value.storeName
          // ignore: cast_nullable_to_non_nullable
          : storeName as String?,
    );
  }
}

extension $StoreModelCopyWith on StoreModel {
  /// Returns a callable class that can be used as follows: `instanceOfStoreModel.copyWith(...)` or like so:`instanceOfStoreModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StoreModelCWProxy get copyWith => _$StoreModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) => StoreModel(
      id: json['id'] as String?,
      storeName: json['storeName'] as String?,
      address: json['address'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isOpen: json['isOpen'] as bool?,
      pos: json['pos'] as Map<String, dynamic>?,
      category: json['category'] as String?,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$StoreModelToJson(StoreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storeName': instance.storeName,
      'address': instance.address,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
      'isActive': instance.isActive,
      'isOpen': instance.isOpen,
      'pos': instance.pos,
    };
