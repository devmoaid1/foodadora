// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductModelCWProxy {
  ProductModel description(String? description);

  ProductModel expiryDate(DateTime? expiryDate);

  ProductModel imageUrl(String? imageUrl);

  ProductModel isAvailable(bool? isAvailable);

  ProductModel isVisible(bool? isVisible);

  ProductModel originalPrice(double? originalPrice);

  ProductModel productId(String? productId);

  ProductModel productName(String? productName);

  ProductModel productPrice(double? productPrice);

  ProductModel quantity(int? quantity);

  ProductModel storeId(String? storeId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductModel(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductModel call({
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

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProductModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProductModel.copyWith.fieldName(...)`
class _$ProductModelCWProxyImpl implements _$ProductModelCWProxy {
  final ProductModel _value;

  const _$ProductModelCWProxyImpl(this._value);

  @override
  ProductModel description(String? description) =>
      this(description: description);

  @override
  ProductModel expiryDate(DateTime? expiryDate) => this(expiryDate: expiryDate);

  @override
  ProductModel imageUrl(String? imageUrl) => this(imageUrl: imageUrl);

  @override
  ProductModel isAvailable(bool? isAvailable) => this(isAvailable: isAvailable);

  @override
  ProductModel isVisible(bool? isVisible) => this(isVisible: isVisible);

  @override
  ProductModel originalPrice(double? originalPrice) =>
      this(originalPrice: originalPrice);

  @override
  ProductModel productId(String? productId) => this(productId: productId);

  @override
  ProductModel productName(String? productName) =>
      this(productName: productName);

  @override
  ProductModel productPrice(double? productPrice) =>
      this(productPrice: productPrice);

  @override
  ProductModel quantity(int? quantity) => this(quantity: quantity);

  @override
  ProductModel storeId(String? storeId) => this(storeId: storeId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductModel(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductModel call({
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
    return ProductModel(
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

extension $ProductModelCopyWith on ProductModel {
  /// Returns a callable class that can be used as follows: `instanceOfProductModel.copyWith(...)` or like so:`instanceOfProductModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductModelCWProxy get copyWith => _$ProductModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
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

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
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
