import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_inventory_app/features/inventory/presentation/auth/pages/log_in_page.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'features/inventory/data/datasources/product_local_datasource.dart';
import 'features/inventory/data/models/product_model.dart';
import 'features/inventory/data/repositories/product_repository_impl.dart';
import 'features/inventory/domain/entities/product_entity.dart';
import 'features/inventory/domain/repositories/product_repository.dart';
import 'features/inventory/domain/usecases/add_product.dart';
import 'features/inventory/domain/usecases/delete_product.dart';
import 'features/inventory/domain/usecases/get_all_products.dart';
import 'features/inventory/domain/usecases/get_low_stock_products.dart';
import 'features/inventory/domain/usecases/update_product.dart';
import 'features/inventory/presentation/pages/add_edit_product_page.dart';
import 'features/inventory/presentation/pages/dashboard_page.dart';
import 'features/inventory/presentation/pages/splash_page.dart';
import 'features/inventory/presentation/providers/product_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive Adapters
  Hive.registerAdapter(ProductModelAdapter());

  // Open Hive Box
  await Hive.openBox<ProductModel>(AppConstants.productsBoxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dependency Injection Setup
    final productBox = Hive.box<ProductModel>(AppConstants.productsBoxName);
    final ProductLocalDataSource localDataSource = ProductLocalDataSourceImpl(
      productBox,
    );
    final ProductRepository repository = ProductRepositoryImpl(localDataSource);

    // Use Cases
    final getAllProducts = GetAllProducts(repository);
    final addProduct = AddProduct(repository);
    final updateProduct = UpdateProduct(repository);
    final deleteProduct = DeleteProduct(repository);
    final getLowStockProducts = GetLowStockProducts(repository);

    return ChangeNotifierProvider(
      create: (_) => ProductProvider(
        getAllProductsUseCase: getAllProducts,
        addProductUseCase: addProduct,
        updateProductUseCase: updateProduct,
        deleteProductUseCase: deleteProduct,
        getLowStockProductsUseCase: getLowStockProducts,
      ),
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home:  LoginScreen(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/add-product':
              final product = settings.arguments as ProductEntity?;
              return MaterialPageRoute(
                builder: (_) => AddEditProductPage(product: product),
              );
            default:
              return MaterialPageRoute(builder: (_) => const DashboardPage());
          }
        },
      ),
    );
  }
}
