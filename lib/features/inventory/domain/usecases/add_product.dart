import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

/// Use case for adding a new product
class AddProduct {
  final ProductRepository repository;

  AddProduct(this.repository);

  Future<Either<Failure, void>> call(ProductEntity product) async {
    // Validate product data
    if (product.name.trim().isEmpty) {
      return const Left(ValidationFailure('Product name cannot be empty'));
    }

    if (product.purchasePrice < 0) {
      return const Left(ValidationFailure('Purchase price cannot be negative'));
    }

    if (product.sellingPrice < 0) {
      return const Left(ValidationFailure('Selling price cannot be negative'));
    }

    if (product.quantity < 0) {
      return const Left(ValidationFailure('Quantity cannot be negative'));
    }

    return await repository.addProduct(product);
  }
}
