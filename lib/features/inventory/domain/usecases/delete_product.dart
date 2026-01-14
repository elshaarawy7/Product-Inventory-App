import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/product_repository.dart';

/// Use case for deleting a product
class DeleteProduct {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  Future<Either<Failure, void>> call(String productId) async {
    if (productId.trim().isEmpty) {
      return const Left(ValidationFailure('Product ID cannot be empty'));
    }

    return await repository.deleteProduct(productId);
  }
}
