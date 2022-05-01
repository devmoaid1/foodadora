// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartItem.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CartItemCWProxy {
  CartItem productId(String? productId);

  CartItem quantity(int? quantity);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CartItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CartItem(...).copyWith(id: 12, name: "My name")
  /// ````
  CartItem call({
    String? productId,
    int? quantity,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCartItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCartItem.copyWith.fieldName(...)`
class _$CartItemCWProxyImpl implements _$CartItemCWProxy {
  final CartItem _value;

  const _$CartItemCWProxyImpl(this._value);

  @override
  CartItem productId(String? productId) => this(productId: productId);

  @override
  CartItem quantity(int? quantity) => this(quantity: quantity);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CartItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CartItem(...).copyWith(id: 12, name: "My name")
  /// ````
  CartItem call({
    Object? productId = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
  }) {
    return CartItem(
      productId: productId == const $CopyWithPlaceholder()
          ? _value.productId
          // ignore: cast_nullable_to_non_nullable
          : productId as String?,
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as int?,
    );
  }
}

extension $CartItemCopyWith on CartItem {
  /// Returns a callable class that can be used as follows: `instanceOfclass CartItem.name.copyWith(...)` or like so:`instanceOfclass CartItem.name.copyWith.fieldName(...)`.
  _$CartItemCWProxy get copyWith => _$CartItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      productId: json['productId'] as String?,
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
    };
