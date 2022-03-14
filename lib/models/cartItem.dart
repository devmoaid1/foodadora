// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

part "cartItem.g.dart";

@JsonSerializable()
class CartItem {
  String? productId;
  int? quantity;

  CartItem({this.productId, this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> data) =>
      _$CartItemFromJson(data);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
