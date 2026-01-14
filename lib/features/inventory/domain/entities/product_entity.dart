import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_constants.dart';

/// Product entity - Core business object
class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String? imagePath;
  final double purchasePrice;
  final double sellingPrice;
  final int quantity;

  const ProductEntity({
    required this.id,
    required this.name,
    this.imagePath,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.quantity,
  });

  /// Calculate profit per unit
  double get profit => sellingPrice - purchasePrice;

  /// Calculate total profit (profit per unit × quantity)
  double get totalProfit => profit * quantity;

  /// Check if product is low in stock
  bool get isLowStock => quantity < AppConstants.lowStockThreshold;

  /// Check if product is out of stock
  bool get isOutOfStock => quantity == 0;

  @override
  List<Object?> get props => [
    id,
    name,
    imagePath,
    purchasePrice,
    sellingPrice,
    quantity,
  ];

  /// Create a copy with updated fields
  ProductEntity copyWith({
    String? id,
    String? name,
    String? imagePath,
    double? purchasePrice,
    double? sellingPrice,
    int? quantity,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  String toString() {
    return 'ProductEntity(id: $id, name: $name, purchasePrice: $purchasePrice, '
        'sellingPrice: $sellingPrice, quantity: $quantity, profit: $profit)';
  }
}
