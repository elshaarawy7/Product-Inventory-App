import 'package:flutter/material.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../domain/usecases/get_low_stock_products.dart';
import '../../domain/usecases/update_product.dart';

/// Provider for managing product state
class ProductProvider with ChangeNotifier {
  final GetAllProducts getAllProductsUseCase;
  final AddProduct addProductUseCase;
  final UpdateProduct updateProductUseCase;
  final DeleteProduct deleteProductUseCase;
  final GetLowStockProducts getLowStockProductsUseCase;

  ProductProvider({
    required this.getAllProductsUseCase,
    required this.addProductUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
    required this.getLowStockProductsUseCase,
  });

  // State
  List<ProductEntity> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<ProductEntity> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  // Dashboard Statistics
  int get totalProducts => _products.length;

  double get totalProfit {
    return _products.fold<double>(
      0.0,
      (sum, product) => sum + product.totalProfit,
    );
  }

  int get lowStockCount {
    return _products.where((product) => product.isLowStock).length;
  }

  List<ProductEntity> get lowStockProducts {
    return _products.where((product) => product.isLowStock).toList();
  }

  /// Load all products
  Future<void> loadProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getAllProductsUseCase();

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (products) {
        _products = products;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  /// Add a new product
  Future<bool> addProduct(ProductEntity product) async {
    _errorMessage = null;

    final result = await addProductUseCase(product);

    return result.fold(
      (failure) {
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (_) {
        loadProducts(); // Reload products
        return true;
      },
    );
  }

  /// Update an existing product
  Future<bool> updateProduct(ProductEntity product) async {
    _errorMessage = null;

    final result = await updateProductUseCase(product);

    return result.fold(
      (failure) {
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (_) {
        loadProducts(); // Reload products
        return true;
      },
    );
  }

  /// Delete a product
  Future<bool> deleteProduct(String productId) async {
    _errorMessage = null;

    final result = await deleteProductUseCase(productId);

    return result.fold(
      (failure) {
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (_) {
        loadProducts(); // Reload products
        return true;
      },
    );
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
