import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import 'cartItem.dart';

part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith()
class Cart {
  String? storeId;
  List<CartItem>? cartItems;

  Cart({this.cartItems, this.storeId});

  factory Cart.fromJson(Map<String, dynamic> data) => _$CartFromJson(data);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}
