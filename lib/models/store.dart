import 'package:json_annotation/json_annotation.dart';

part 'store.g.dart';

@JsonSerializable()
class Store {
  String? id;
  String? storeName;
  String? logoUrl;
  bool isActive;
  Map<String, dynamic>? location;

  Store(
      {this.id,
      this.storeName,
      this.isActive = true,
      this.location,
      this.logoUrl});

  factory Store.fromJson(Map<String, dynamic> data) => _$StoreFromJson(data);
  Map<String, dynamic> toJson() => _$StoreToJson(this);
}
