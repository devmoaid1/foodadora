import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:foodadora/features/auth/domain/entities/customer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_model.g.dart';

// after each change in the models run this command =>   flutter pub run build_runner build --delete-conflicting-outputs
@JsonSerializable(explicitToJson: true)
@CopyWith()
class CustomerModel extends Customer {
  const CustomerModel(
      {String? name,
      String? userId,
      String? email,
      String? phoneNumber,
      String? photoUrl,
      List<String>? orders,
      bool? isVerfied})
      : super(
            email: email,
            name: name,
            isVerfied: isVerfied,
            orders: orders,
            phoneNumber: phoneNumber,
            photoUrl: photoUrl,
            userId: userId);

  factory CustomerModel.fromJson(Map<String, dynamic> data) =>
      _$CustomerModelFromJson(data);
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
