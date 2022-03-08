import 'package:json_annotation/json_annotation.dart';

import 'cartItem.dart';

part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart {
  String? storeId;
  List<CartItem>? cartItems;

  Cart({this.cartItems, this.storeId});

  factory Cart.fromJson(Map<String, dynamic> data) => _$CartFromJson(data);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}
