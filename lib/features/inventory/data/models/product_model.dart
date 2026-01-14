import 'package:hive/hive.dart';

import '../../domain/entities/product_entity.dart';

part 'product_model.g.dart';

/// Product data model for Hive storage
@HiveType(typeId: 0)
class ProductModel extends ProductEntity {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String name;

  @HiveField(2)
  @override
  final String? imagePath;

  @HiveField(3)
  @override
  final double purchasePrice;

  @HiveField(4)
  @override
  final double sellingPrice;

  @HiveField(5)
  @override
  final int quantity;

  const ProductModel({
    required this.id,
    required this.name,
    this.imagePath,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.quantity,
  }) : super(
         id: id,
         name: name,
         imagePath: imagePath,
         purchasePrice: purchasePrice,
         sellingPrice: sellingPrice,
         quantity: quantity,
       );

  /// Convert from Entity to Model
  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      imagePath: entity.imagePath,
      purchasePrice: entity.purchasePrice,
      sellingPrice: entity.sellingPrice,
      quantity: entity.quantity,
    );
  }

  /// Convert from Model to Entity
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      imagePath: imagePath,
      purchasePrice: purchasePrice,
      sellingPrice: sellingPrice,
      quantity: quantity,
    );
  }

  /// Create a copy with updated fields
  ProductModel copyWith({
    String? id,
    String? name,
    String? imagePath,
    double? purchasePrice,
    double? sellingPrice,
    int? quantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      quantity: quantity ?? this.quantity,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
      'purchasePrice': purchasePrice,
      'sellingPrice': sellingPrice,
      'quantity': quantity,
    };
  }

  /// Create from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imagePath: json['imagePath'] as String?,
      purchasePrice: (json['purchasePrice'] as num).toDouble(),
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );
  }
}
