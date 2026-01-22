import 'package:flutter/material.dart';
import 'package:product_inventory_app/core/theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  CustomTextField({
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your $hintText';
            }
            // Email validation
            if (hintText.toLowerCase().contains('email') &&
                !value.contains('@')) {
              return 'Please enter a valid email';
            }
            // Password validation
            if (hintText.toLowerCase().contains('password') &&
                value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
      controller: controller,
      obscureText: obscureText,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppTheme.textHint),
        filled: true,
        fillColor: AppTheme.backgroundColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
