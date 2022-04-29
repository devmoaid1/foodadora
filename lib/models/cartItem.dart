// ignore_for_file: file_names

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part "cartItem.g.dart";

@JsonSerializable()
@CopyWith()
class CartItem {
  String? productId;
  int? quantity;

  CartItem({this.productId, this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> data) =>
      _$CartItemFromJson(data);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
