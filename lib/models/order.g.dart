// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderCWProxy {
  Order customerId(String? customerId);

  Order id(String? id);

  Order orderDate(DateTime? orderDate);

  Order products(List<Product>? products);

  Order status(String? status);

  Order storeId(String? storeId);

  Order totalPrice(double? totalPrice);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Order(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Order(...).copyWith(id: 12, name: "My name")
  /// ````
  Order call({
    String? customerId,
    String? id,
    DateTime? orderDate,
    List<Product>? products,
    String? status,
    String? storeId,
    double? totalPrice,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrder.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrder.copyWith.fieldName(...)`
class _$OrderCWProxyImpl implements _$OrderCWProxy {
  final Order _value;

  const _$OrderCWProxyImpl(this._value);

  @override
  Order customerId(String? customerId) => this(customerId: customerId);

  @override
  Order id(String? id) => this(id: id);

  @override
  Order orderDate(DateTime? orderDate) => this(orderDate: orderDate);

  @override
  Order products(List<Product>? products) => this(products: products);

  @override
  Order status(String? status) => this(status: status);

  @override
  Order storeId(String? storeId) => this(storeId: storeId);

  @override
  Order totalPrice(double? totalPrice) => this(totalPrice: totalPrice);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Order(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Order(...).copyWith(id: 12, name: "My name")
  /// ````
  Order call({
    Object? customerId = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? orderDate = const $CopyWithPlaceholder(),
    Object? products = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? storeId = const $CopyWithPlaceholder(),
    Object? totalPrice = const $CopyWithPlaceholder(),
  }) {
    return Order(
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
          : products as List<Product>?,
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

extension $OrderCopyWith on Order {
  /// Returns a callable class that can be used as follows: `instanceOfOrder.copyWith(...)` or like so:`instanceOfOrder.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderCWProxy get copyWith => _$OrderCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as String?,
      customerId: json['customerId'] as String?,
      storeId: json['storeId'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      orderDate: DateTimeConverters.dateTimeFromTimestamp(
          json['orderDate'] as Timestamp),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'storeId': instance.storeId,
      'products': instance.products?.map((e) => e.toJson()).toList(),
      'totalPrice': instance.totalPrice,
      'orderDate': DateTimeConverters.dateTimeAsIs(instance.orderDate),
      'status': instance.status,
    };
