// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderEntityCWProxy {
  OrderEntity customerId(String? customerId);

  OrderEntity id(String? id);

  OrderEntity orderDate(DateTime? orderDate);

  OrderEntity products(List<ProductModel>? products);

  OrderEntity status(String? status);

  OrderEntity storeId(String? storeId);

  OrderEntity totalPrice(double? totalPrice);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderEntity call({
    String? customerId,
    String? id,
    DateTime? orderDate,
    List<ProductModel>? products,
    String? status,
    String? storeId,
    double? totalPrice,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrder.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrder.copyWith.fieldName(...)`
class _$OrderEntityCWProxyImpl implements _$OrderEntityCWProxy {
  final OrderEntity _value;

  const _$OrderEntityCWProxyImpl(this._value);

  @override
  OrderEntity customerId(String? customerId) => this(customerId: customerId);

  @override
  OrderEntity id(String? id) => this(id: id);

  @override
  OrderEntity orderDate(DateTime? orderDate) => this(orderDate: orderDate);

  @override
  OrderEntity products(List<ProductModel>? products) =>
      this(products: products);

  @override
  OrderEntity status(String? status) => this(status: status);

  @override
  OrderEntity storeId(String? storeId) => this(storeId: storeId);

  @override
  OrderEntity totalPrice(double? totalPrice) => this(totalPrice: totalPrice);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderEntity call({
    Object? customerId = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? orderDate = const $CopyWithPlaceholder(),
    Object? products = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? storeId = const $CopyWithPlaceholder(),
    Object? totalPrice = const $CopyWithPlaceholder(),
  }) {
    return OrderEntity(
      customerId: customerId == const $CopyWithPlaceholder()
          ? _value.customerId
          // ignore: cast_nullable_to_non_nullable
          : customerId as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      orderDate: orderDate == const $CopyWithPlaceholder()
          ? _value.orderDate
          // ignore: cast_nullable_to_non_nullable
          : orderDate as DateTime?,
      products: products == const $CopyWithPlaceholder()
          ? _value.products
          // ignore: cast_nullable_to_non_nullable
          : products as List<ProductModel>?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String?,
      storeId: storeId == const $CopyWithPlaceholder()
          ? _value.storeId
          // ignore: cast_nullable_to_non_nullable
          : storeId as String?,
      totalPrice: totalPrice == const $CopyWithPlaceholder()
          ? _value.totalPrice
          // ignore: cast_nullable_to_non_nullable
          : totalPrice as double?,
    );
  }
}

extension $OrderEntityCopyWith on OrderEntity {
  /// Returns a callable class that can be used as follows: `instanceOfOrder.copyWith(...)` or like so:`instanceOfOrder.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderEntityCWProxy get copyWith => _$OrderEntityCWProxyImpl(this);
}
