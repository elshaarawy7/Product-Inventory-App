import 'package:dartz/dartz.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';
import '../models/product_model.dart';

/// Implementation of ProductRepository
class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      final products = await localDataSource.getAllProducts();
      return Right(products.map((model) => model.toEntity()).toList());
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) async {
    try {
      final product = await localDataSource.getProductById(id);
      return Right(product.toEntity());
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> addProduct(ProductEntity product) async {
    try {
      final model = ProductModel.fromEntity(product);
      await localDataSource.addProduct(model);
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductEntity product) async {
    try {
      final model = ProductModel.fromEntity(product);
      await localDataSource.updateProduct(model);
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      await localDataSource.deleteProduct(id);
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getLowStockProducts() async {
    try {
      final products = await localDataSource.getAllProducts();
      final lowStockProducts = products
          .where((product) => product.quantity < AppConstants.lowStockThreshold)
          .map((model) => model.toEntity())
          .toList();
      return Right(lowStockProducts);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, int>> getTotalProductsCount() async {
    try {
      final products = await localDataSource.getAllProducts();
      return Right(products.length);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, double>> getTotalProfit() async {
    try {
      final products = await localDataSource.getAllProducts();
      final totalProfit = products.fold<double>(
        0.0,
        (sum, product) => sum + product.totalProfit,
      );
      return Right(totalProfit);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error: $e'));
    }
  }
}
