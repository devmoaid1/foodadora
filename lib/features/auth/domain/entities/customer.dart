import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String? name;
  final String? userId;
  final String? email;
  final String? phoneNumber;
  final String? photoUrl;
  final bool? isVerfied;

  final List<String>? orders;

  const Customer(
      {required this.name,
      this.userId,
      required this.email,
      this.phoneNumber,
      this.isVerfied = true,
      this.orders,
      this.photoUrl});

  @override
  List<Object?> get props =>
      [name, email, isVerfied, orders, phoneNumber, photoUrl];
}
