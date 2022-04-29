// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CustomerCWProxy {
  Customer cart(Cart? cart);

  Customer email(String? email);

  Customer isVerfied(bool isVerfied);

  Customer name(String? name);

  Customer orders(List<String>? orders);

  Customer phoneNumber(String? phoneNumber);

  Customer photoUrl(String? photoUrl);

  Customer userId(String? userId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Customer(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Customer(...).copyWith(id: 12, name: "My name")
  /// ````
  Customer call({
    Cart? cart,
    String? email,
    bool? isVerfied,
    String? name,
    List<String>? orders,
    String? phoneNumber,
    String? photoUrl,
    String? userId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCustomer.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCustomer.copyWith.fieldName(...)`
class _$CustomerCWProxyImpl implements _$CustomerCWProxy {
  final Customer _value;

  const _$CustomerCWProxyImpl(this._value);

  @override
  Customer cart(Cart? cart) => this(cart: cart);

  @override
  Customer email(String? email) => this(email: email);

  @override
  Customer isVerfied(bool isVerfied) => this(isVerfied: isVerfied);

  @override
  Customer name(String? name) => this(name: name);

  @override
  Customer orders(List<String>? orders) => this(orders: orders);

  @override
  Customer phoneNumber(String? phoneNumber) => this(phoneNumber: phoneNumber);

  @override
  Customer photoUrl(String? photoUrl) => this(photoUrl: photoUrl);

  @override
  Customer userId(String? userId) => this(userId: userId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Customer(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Customer(...).copyWith(id: 12, name: "My name")
  /// ````
  Customer call({
    Object? cart = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? isVerfied = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? orders = const $CopyWithPlaceholder(),
    Object? phoneNumber = const $CopyWithPlaceholder(),
    Object? photoUrl = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
  }) {
    return Customer(
      cart: cart == const $CopyWithPlaceholder()
          ? _value.cart
          // ignore: cast_nullable_to_non_nullable
          : cart as Cart?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      isVerfied: isVerfied == const $CopyWithPlaceholder() || isVerfied == null
          ? _value.isVerfied
          // ignore: cast_nullable_to_non_nullable
          : isVerfied as bool,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      orders: orders == const $CopyWithPlaceholder()
          ? _value.orders
          // ignore: cast_nullable_to_non_nullable
          : orders as List<String>?,
      phoneNumber: phoneNumber == const $CopyWithPlaceholder()
          ? _value.phoneNumber
          // ignore: cast_nullable_to_non_nullable
          : phoneNumber as String?,
      photoUrl: photoUrl == const $CopyWithPlaceholder()
          ? _value.photoUrl
          // ignore: cast_nullable_to_non_nullable
          : photoUrl as String?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
    );
  }
}

extension $CustomerCopyWith on Customer {
  /// Returns a callable class that can be used as follows: `instanceOfclass Customer.name.copyWith(...)` or like so:`instanceOfclass Customer.name.copyWith.fieldName(...)`.
  _$CustomerCWProxy get copyWith => _$CustomerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      name: json['name'] as String?,
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      cart: json['cart'] == null
          ? null
          : Cart.fromJson(json['cart'] as Map<String, dynamic>),
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
      'cart': instance.cart?.toJson(),
      'orders': instance.orders,
    };
