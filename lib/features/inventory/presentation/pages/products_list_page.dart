import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../widgets/product_card.dart';

/// Products list page showing all products or low stock products
class ProductsListPage extends StatefulWidget {
  final bool showLowStockOnly;

  const ProductsListPage({super.key, this.showLowStockOnly = false});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.showLowStockOnly ? 'Low Stock Products' : 'All Products',
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          var products = widget.showLowStockOnly
              ? provider.lowStockProducts
              : provider.products;

          // Apply search filter
          if (_searchQuery.isNotEmpty) {
            products = products
                .where(
                  (product) =>
                      product.name.toLowerCase().contains(_searchQuery),
                )
                .toList();
          }

          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.showLowStockOnly
                        ? Icons.check_circle_outline
                        : Icons.inventory_2_outlined,
                    size: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.showLowStockOnly
                        ? 'No low stock products'
                        : 'No products yet',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  if (!widget.showLowStockOnly)
                    Text(
                      'Tap + to add your first product',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
                    ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.loadProducts(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  onTap: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      '/add-product',
                      arguments: product,
                    );
                    if (result == true) {
                      provider.loadProducts();
                    }
                  },
                  onDelete: () async {
                    final confirm = await _showDeleteConfirmation(context);
                    if (confirm == true) {
                      final success = await provider.deleteProduct(product.id);
                      if (success && mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Product deleted successfully'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    }
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: widget.showLowStockOnly
          ? null
          : FloatingActionButton.extended(
              onPressed: () async {
                final result = await Navigator.pushNamed(
                  context,
                  '/add-product',
                );
                if (result == true) {
                  context.read<ProductProvider>().loadProducts();
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Product'),
            ),
    );
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
