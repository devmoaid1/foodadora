import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:foodadora/features/stores/domain/entites/store.dart';
import 'package:json_annotation/json_annotation.dart';

part 'storemodel.g.dart';

@JsonSerializable()
@CopyWith()
class StoreModel extends Store {
  const StoreModel({
    String? id,
    String? storeName,
    String? address,
    String? imageUrl,
    bool? isOpen,
    Map<String, dynamic>? pos,
    String? category,
    bool isActive = true,
  }) : super(
            isActive: isActive,
            address: address,
            category: category,
            id: id,
            imageUrl: imageUrl,
            isOpen: isOpen,
            pos: pos,
            storeName: storeName);

  factory StoreModel.fromJson(Map<String, dynamic> data) =>
      _$StoreModelFromJson(data);
  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}
