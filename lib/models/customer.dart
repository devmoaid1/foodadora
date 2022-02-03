import 'package:json_annotation/json_annotation.dart';
part 'customer.g.dart';

// after each change in the models run this command =>   flutter pub run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class Customer {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? photoUrl;
  final bool isVerfied;
  final List<Map<String, dynamic>>? cart;
  List<String>? orders;

  Customer(
      {this.name,
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
