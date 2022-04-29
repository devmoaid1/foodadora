// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CartCWProxy {
  Cart cartItems(List<CartItem>? cartItems);

  Cart storeId(String? storeId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Cart(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Cart(...).copyWith(id: 12, name: "My name")
  /// ````
  Cart call({
    List<CartItem>? cartItems,
    String? storeId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCart.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCart.copyWith.fieldName(...)`
class _$CartCWProxyImpl implements _$CartCWProxy {
  final Cart _value;

  const _$CartCWProxyImpl(this._value);

  @override
  Cart cartItems(List<CartItem>? cartItems) => this(cartItems: cartItems);

  @override
  Cart storeId(String? storeId) => this(storeId: storeId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Cart(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Cart(...).copyWith(id: 12, name: "My name")
  /// ````
  Cart call({
    Object? cartItems = const $CopyWithPlaceholder(),
    Object? storeId = const $CopyWithPlaceholder(),
  }) {
    return Cart(
      cartItems: cartItems == const $CopyWithPlaceholder()
          ? _value.cartItems
          // ignore: cast_nullable_to_non_nullable
          : cartItems as List<CartItem>?,
      storeId: storeId == const $CopyWithPlaceholder()
          ? _value.storeId
          // ignore: cast_nullable_to_non_nullable
          : storeId as String?,
    );
  }
}

extension $CartCopyWith on Cart {
  /// Returns a callable class that can be used as follows: `instanceOfclass Cart.name.copyWith(...)` or like so:`instanceOfclass Cart.name.copyWith.fieldName(...)`.
  _$CartCWProxy get copyWith => _$CartCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      cartItems: (json['cartItems'] as List<dynamic>?)
          ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      storeId: json['storeId'] as String?,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'storeId': instance.storeId,
      'cartItems': instance.cartItems?.map((e) => e.toJson()).toList(),
    };
