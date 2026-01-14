/// Application-wide constants
class AppConstants {
  // Prevent instantiation
  AppConstants._();

  // Low Stock Threshold
  static const int lowStockThreshold = 10;

  // Image Quality Settings
  static const int imageQuality = 85;
  static const int maxImageWidth = 1024;
  static const int maxImageHeight = 1024;

  // Database
  static const String productsBoxName = 'products';

  // App Info
  static const String appName = 'Product Inventory';
  static const String appVersion = '1.0.0';

  // Validation
  static const int maxProductNameLength = 100;
  static const double minPrice = 0.0;
  static const double maxPrice = 999999999.99;
  static const int minQuantity = 0;
  static const int maxQuantity = 999999;
}
