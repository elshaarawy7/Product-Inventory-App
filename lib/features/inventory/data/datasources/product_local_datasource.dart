import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/errors/failures.dart';
import '../models/product_model.dart';

/// Local data source for product operations using Hive
abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(String id);
  Future<void> addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Box<ProductModel> productBox;

  ProductLocalDataSourceImpl(this.productBox);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      return productBox.values.toList();
    } catch (e) {
      throw DatabaseFailure('Failed to get products: $e');
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final product = productBox.get(id);
      if (product == null) {
        throw const NotFoundFailure('Product not found');
      }
      return product;
    } catch (e) {
      if (e is NotFoundFailure) rethrow;
      throw DatabaseFailure('Failed to get product: $e');
    }
  }

  @override
  Future<void> addProduct(ProductModel product) async {
    try {
      await productBox.put(product.id, product);
    } catch (e) {
      throw DatabaseFailure('Failed to add product: $e');
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    try {
      if (!productBox.containsKey(product.id)) {
        throw const NotFoundFailure('Product not found');
      }
      await productBox.put(product.id, product);
    } catch (e) {
      if (e is NotFoundFailure) rethrow;
      throw DatabaseFailure('Failed to update product: $e');
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      if (!productBox.containsKey(id)) {
        throw const NotFoundFailure('Product not found');
      }
      await productBox.delete(id);
    } catch (e) {
      if (e is NotFoundFailure) rethrow;
      throw DatabaseFailure('Failed to delete product: $e');
    }
  }
}
