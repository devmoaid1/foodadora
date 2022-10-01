// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CustomerModelCWProxy {
  CustomerModel email(String? email);

  CustomerModel isVerfied(bool? isVerfied);

  CustomerModel name(String? name);

  CustomerModel orders(List<String>? orders);

  CustomerModel phoneNumber(String? phoneNumber);

  CustomerModel photoUrl(String? photoUrl);

  CustomerModel userId(String? userId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CustomerModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CustomerModel(...).copyWith(id: 12, name: "My name")
  /// ````
  CustomerModel call({
    String? email,
    bool? isVerfied,
    String? name,
    List<String>? orders,
    String? phoneNumber,
    String? photoUrl,
    String? userId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCustomerModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCustomerModel.copyWith.fieldName(...)`
class _$CustomerModelCWProxyImpl implements _$CustomerModelCWProxy {
  final CustomerModel _value;

  const _$CustomerModelCWProxyImpl(this._value);

  @override
  CustomerModel email(String? email) => this(email: email);

  @override
  CustomerModel isVerfied(bool? isVerfied) => this(isVerfied: isVerfied);

  @override
  CustomerModel name(String? name) => this(name: name);

  @override
  CustomerModel orders(List<String>? orders) => this(orders: orders);

  @override
  CustomerModel phoneNumber(String? phoneNumber) =>
      this(phoneNumber: phoneNumber);

  @override
  CustomerModel photoUrl(String? photoUrl) => this(photoUrl: photoUrl);

  @override
  CustomerModel userId(String? userId) => this(userId: userId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CustomerModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CustomerModel(...).copyWith(id: 12, name: "My name")
  /// ````
  CustomerModel call({
    Object? email = const $CopyWithPlaceholder(),
    Object? isVerfied = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? orders = const $CopyWithPlaceholder(),
    Object? phoneNumber = const $CopyWithPlaceholder(),
    Object? photoUrl = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
  }) {
    return CustomerModel(
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      isVerfied: isVerfied == const $CopyWithPlaceholder()
          ? _value.isVerfied
          // ignore: cast_nullable_to_non_nullable
          : isVerfied as bool?,
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

extension $CustomerModelCopyWith on CustomerModel {
  /// Returns a callable class that can be used as follows: `instanceOfCustomerModel.copyWith(...)` or like so:`instanceOfCustomerModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CustomerModelCWProxy get copyWith => _$CustomerModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      name: json['name'] as String?,
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      photoUrl: json['photoUrl'] as String?,
      orders:
          (json['orders'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isVerfied: json['isVerfied'] as bool?,
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'userId': instance.userId,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'photoUrl': instance.photoUrl,
      'isVerfied': instance.isVerfied,
      'orders': instance.orders,
    };
