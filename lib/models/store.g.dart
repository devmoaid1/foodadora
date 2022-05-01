// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StoreCWProxy {
  Store address(String? address);

  Store category(String? category);

  Store id(String? id);

  Store imageUrl(String? imageUrl);

  Store isActive(bool isActive);

  Store isOpen(bool? isOpen);

  Store pos(Map<String, dynamic>? pos);

  Store storeName(String? storeName);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Store(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Store(...).copyWith(id: 12, name: "My name")
  /// ````
  Store call({
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

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStore.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStore.copyWith.fieldName(...)`
class _$StoreCWProxyImpl implements _$StoreCWProxy {
  final Store _value;

  const _$StoreCWProxyImpl(this._value);

  @override
  Store address(String? address) => this(address: address);

  @override
  Store category(String? category) => this(category: category);

  @override
  Store id(String? id) => this(id: id);

  @override
  Store imageUrl(String? imageUrl) => this(imageUrl: imageUrl);

  @override
  Store isActive(bool isActive) => this(isActive: isActive);

  @override
  Store isOpen(bool? isOpen) => this(isOpen: isOpen);

  @override
  Store pos(Map<String, dynamic>? pos) => this(pos: pos);

  @override
  Store storeName(String? storeName) => this(storeName: storeName);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Store(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Store(...).copyWith(id: 12, name: "My name")
  /// ````
  Store call({
    Object? address = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? isOpen = const $CopyWithPlaceholder(),
    Object? pos = const $CopyWithPlaceholder(),
    Object? storeName = const $CopyWithPlaceholder(),
  }) {
    return Store(
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

extension $StoreCopyWith on Store {
  /// Returns a callable class that can be used as follows: `instanceOfclass Store.name.copyWith(...)` or like so:`instanceOfclass Store.name.copyWith.fieldName(...)`.
  _$StoreCWProxy get copyWith => _$StoreCWProxyImpl(this);
}

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
