import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import 'cart.dart';

part 'customer.g.dart';

// after each change in the models run this command =>   flutter pub run build_runner build --delete-conflicting-outputs
@JsonSerializable(explicitToJson: true)
@CopyWith()
class Customer {
  final String? name;
  final String? userId;
  final String? email;
  final String? phoneNumber;
  final String? photoUrl;
  final bool isVerfied;
  final Cart? cart;
  List<String>? orders;

  Customer(
      {this.name,
      this.userId,
      this.email,
      this.phoneNumber,
      this.cart,
      this.isVerfied = true,
      this.orders,
      this.photoUrl});

  factory Customer.fromJson(Map<String, dynamic> data) =>
      _$CustomerFromJson(data);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
