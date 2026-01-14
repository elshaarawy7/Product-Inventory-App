import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product_entity.dart';

/// Abstract repository interface for product operations
/// This follows the Dependency Inversion Principle - domain layer defines the contract
abstract class ProductRepository {
  /// Get all products
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();

  /// Get a single product by ID
  Future<Either<Failure, ProductEntity>> getProductById(String id);

  /// Add a new product
  Future<Either<Failure, void>> addProduct(ProductEntity product);

  /// Update an existing product
  Future<Either<Failure, void>> updateProduct(ProductEntity product);

  /// Delete a product by ID
  Future<Either<Failure, void>> deleteProduct(String id);

  /// Get products that are low in stock
  Future<Either<Failure, List<ProductEntity>>> getLowStockProducts();

  /// Get total number of products
  Future<Either<Failure, int>> getTotalProductsCount();

  /// Get total profit across all products
  Future<Either<Failure, double>> getTotalProfit();
}
