import 'package:json_annotation/json_annotation.dart';

part 'store.g.dart';

@JsonSerializable()
class Store {
  String? id;
  String? storeName;
  String? address;
  String? imageUrl;
  String? category;
  bool isActive;
  bool? isOpen;
  Map<String, dynamic>? pos;

  Store({
    this.id,
    this.storeName,
    this.address,
    this.imageUrl,
    this.isOpen,
    this.pos,
    this.category,
    this.isActive = true,
  });

  factory Store.fromJson(Map<String, dynamic> data) => _$StoreFromJson(data);
  Map<String, dynamic> toJson() => _$StoreToJson(this);
}
