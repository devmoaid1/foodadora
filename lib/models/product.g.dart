// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductCWProxy {
  Product description(String? description);

  Product expiryDate(DateTime? expiryDate);

  Product imageUrl(String? imageUrl);

  Product isAvailable(bool? isAvailable);

  Product isVisible(bool? isVisible);

  Product originalPrice(double? originalPrice);

  Product productId(String? productId);

  Product productName(String? productName);

  Product productPrice(double? productPrice);

  Product quantity(int? quantity);

  Product storeId(String? storeId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Product(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Product(...).copyWith(id: 12, name: "My name")
  /// ````
  Product call({
    String? description,
    DateTime? expiryDate,
    String? imageUrl,
    bool? isAvailable,
    bool? isVisible,
    double? originalPrice,
    String? productId,
    String? productName,
    double? productPrice,
    int? quantity,
    String? storeId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProduct.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProduct.copyWith.fieldName(...)`
class _$ProductCWProxyImpl implements _$ProductCWProxy {
  final Product _value;

  const _$ProductCWProxyImpl(this._value);

  @override
  Product description(String? description) => this(description: description);

  @override
  Product expiryDate(DateTime? expiryDate) => this(expiryDate: expiryDate);

  @override
  Product imageUrl(String? imageUrl) => this(imageUrl: imageUrl);

  @override
  Product isAvailable(bool? isAvailable) => this(isAvailable: isAvailable);

  @override
  Product isVisible(bool? isVisible) => this(isVisible: isVisible);

  @override
  Product originalPrice(double? originalPrice) =>
      this(originalPrice: originalPrice);

  @override
  Product productId(String? productId) => this(productId: productId);

  @override
  Product productName(String? productName) => this(productName: productName);

  @override
  Product productPrice(double? productPrice) =>
      this(productPrice: productPrice);

  @override
  Product quantity(int? quantity) => this(quantity: quantity);

  @override
  Product storeId(String? storeId) => this(storeId: storeId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Product(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Product(...).copyWith(id: 12, name: "My name")
  /// ````
  Product call({
    Object? description = const $CopyWithPlaceholder(),
    Object? expiryDate = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
    Object? isAvailable = const $CopyWithPlaceholder(),
    Object? isVisible = const $CopyWithPlaceholder(),
    Object? originalPrice = const $CopyWithPlaceholder(),
    Object? productId = const $CopyWithPlaceholder(),
    Object? productName = const $CopyWithPlaceholder(),
    Object? productPrice = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? storeId = const $CopyWithPlaceholder(),
  }) {
    return Product(
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      expiryDate: expiryDate == const $CopyWithPlaceholder()
          ? _value.expiryDate
          // ignore: cast_nullable_to_non_nullable
          : expiryDate as DateTime?,
      imageUrl: imageUrl == const $CopyWithPlaceholder()
          ? _value.imageUrl
          // ignore: cast_nullable_to_non_nullable
          : imageUrl as String?,
      isAvailable: isAvailable == const $CopyWithPlaceholder()
          ? _value.isAvailable
          // ignore: cast_nullable_to_non_nullable
          : isAvailable as bool?,
      isVisible: isVisible == const $CopyWithPlaceholder()
          ? _value.isVisible
          // ignore: cast_nullable_to_non_nullable
          : isVisible as bool?,
      originalPrice: originalPrice == const $CopyWithPlaceholder()
          ? _value.originalPrice
          // ignore: cast_nullable_to_non_nullable
          : originalPrice as double?,
      productId: productId == const $CopyWithPlaceholder()
          ? _value.productId
          // ignore: cast_nullable_to_non_nullable
          : productId as String?,
      productName: productName == const $CopyWithPlaceholder()
          ? _value.productName
          // ignore: cast_nullable_to_non_nullable
          : productName as String?,
      productPrice: productPrice == const $CopyWithPlaceholder()
          ? _value.productPrice
          // ignore: cast_nullable_to_non_nullable
          : productPrice as double?,
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as int?,
      storeId: storeId == const $CopyWithPlaceholder()
          ? _value.storeId
          // ignore: cast_nullable_to_non_nullable
          : storeId as String?,
    );
  }
}

extension $ProductCopyWith on Product {
  /// Returns a callable class that can be used as follows: `instanceOfProduct.copyWith(...)` or like so:`instanceOfProduct.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductCWProxy get copyWith => _$ProductCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: json['productId'] as String?,
      productName: json['productName'] as String?,
      description: json['description'] as String?,
      originalPrice: (json['originalPrice'] as num?)?.toDouble(),
      expiryDate: DateTimeConverters.dateTimeFromTimestamp(
          json['expiryDate'] as Timestamp),
      isAvailable: json['isAvailable'] as bool?,
      isVisible: json['isVisible'] as bool?,
      productPrice: (json['productPrice'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
      quantity: json['quantity'] as int?,
      storeId: json['storeId'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productId': instance.productId,
      'storeId': instance.storeId,
      'productName': instance.productName,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'productPrice': instance.productPrice,
      'originalPrice': instance.originalPrice,
      'expiryDate': DateTimeConverters.dateTimeAsIs(instance.expiryDate),
      'quantity': instance.quantity,
      'isAvailable': instance.isAvailable,
      'isVisible': instance.isVisible,
    };
