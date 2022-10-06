import 'package:equatable/equatable.dart';

class Store extends Equatable {
  final String? id;
  final String? storeName;
  final String? address;
  final String? imageUrl;
  final String? category;
  final bool isActive;
  final bool? isOpen;
  final Map<String, dynamic>? pos;

  const Store(
      {this.id,
      this.storeName,
      this.address,
      this.imageUrl,
      this.category,
      required this.isActive,
      this.isOpen,
      this.pos});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, storeName, address, imageUrl, category, isActive, isOpen, pos];
}
