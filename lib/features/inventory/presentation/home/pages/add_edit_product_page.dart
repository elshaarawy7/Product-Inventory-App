import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/utils/image_helper.dart';
import '../../../domain/entities/product_entity.dart';
import '../../providers/product_provider.dart';
import '../widgets/image_picker_widget.dart';

/// Add or Edit product page
class AddEditProductPage extends StatefulWidget {
  final ProductEntity? product; // null for add, non-null for edit

  const AddEditProductPage({super.key, this.product});

  @override
  State<AddEditProductPage> createState() => _AddEditProductPageState();
}

class _AddEditProductPageState extends State<AddEditProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _quantityController = TextEditingController();
  final ImageHelper _imageHelper = ImageHelper();

  String? _imagePath;
  double _calculatedProfit = 0.0;
  bool _isLoading = false;

  bool get isEditMode => widget.product != null;

  @override
  void initState() {
    super.initState();
    if (isEditMode) {
      _loadProductData();
    }
    _purchasePriceController.addListener(_calculateProfit);
    _sellingPriceController.addListener(_calculateProfit);
  }

  void _loadProductData() {
    final product = widget.product!;
    _nameController.text = product.name;
    _purchasePriceController.text = product.purchasePrice.toString();
    _sellingPriceController.text = product.sellingPrice.toString();
    _quantityController.text = product.quantity.toString();
    _imagePath = product.imagePath;
    _calculateProfit();
  }

  void _calculateProfit() {
    final purchasePrice = double.tryParse(_purchasePriceController.text) ?? 0.0;
    final sellingPrice = double.tryParse(_sellingPriceController.text) ?? 0.0;
    setState(() {
      _calculatedProfit = sellingPrice - purchasePrice;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final result = source == ImageSource.camera
        ? await _imageHelper.pickImageFromCamera()
        : await _imageHelper.pickImageFromGallery();

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message), backgroundColor: Colors.red),
        );
      },
      (imagePath) {
        setState(() {
          _imagePath = imagePath;
        });
      },
    );
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final provider = context.read<ProductProvider>();

    final product = ProductEntity(
      id: isEditMode ? widget.product!.id : const Uuid().v4(),
      name: _nameController.text.trim(),
      imagePath: _imagePath,
      purchasePrice: double.parse(_purchasePriceController.text),
      sellingPrice: double.parse(_sellingPriceController.text),
      quantity: int.parse(_quantityController.text),
    );

    final success = isEditMode
        ? await provider.updateProduct(product)
        : await provider.addProduct(product);

    setState(() {
      _isLoading = false;
    });

    if (success && mounted) {
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEditMode
                ? 'Product updated successfully'
                : 'Product added successfully',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage ?? 'Failed to save product'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _purchasePriceController.dispose();
    _sellingPriceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditMode ? 'Edit Product' : 'Add Product')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Image Picker
            ImagePickerWidget(imagePath: _imagePath, onPickImage: _pickImage),
            const SizedBox(height: 24),

            // Product Name
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                hintText: 'Enter product name',
                prefixIcon: Icon(Icons.inventory_2),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter product name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Purchase Price
            TextFormField(
              controller: _purchasePriceController,
              decoration: const InputDecoration(
                labelText: 'Purchase Price',
                hintText: 'Enter purchase price',
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter purchase price';
                }
                final price = double.tryParse(value);
                if (price == null || price < 0) {
                  return 'Please enter a valid price';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Selling Price
            TextFormField(
              controller: _sellingPriceController,
              decoration: const InputDecoration(
                labelText: 'Selling Price',
                hintText: 'Enter selling price',
                prefixIcon: Icon(Icons.sell),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter selling price';
                }
                final price = double.tryParse(value);
                if (price == null || price < 0) {
                  return 'Please enter a valid price';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Profit Display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _calculatedProfit >= 0
                    ? Colors.green[50]
                    : Colors.red[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _calculatedProfit >= 0
                      ? Colors.green[200]!
                      : Colors.red[200]!,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _calculatedProfit >= 0
                        ? Icons.trending_up
                        : Icons.trending_down,
                    color: _calculatedProfit >= 0
                        ? Colors.green[700]
                        : Colors.red[700],
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Profit per unit: \$${_calculatedProfit.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: _calculatedProfit >= 0
                          ? Colors.green[700]
                          : Colors.red[700],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Quantity
            TextFormField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                hintText: 'Enter quantity in stock',
                prefixIcon: Icon(Icons.numbers),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter quantity';
                }
                final quantity = int.tryParse(value);
                if (quantity == null || quantity < 0) {
                  return 'Please enter a valid quantity';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),

            // Save Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveProduct,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(isEditMode ? 'Update Product' : 'Add Product'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ImageSource { camera, gallery }
