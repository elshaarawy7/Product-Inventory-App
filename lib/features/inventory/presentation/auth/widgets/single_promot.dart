import 'package:flutter/material.dart';
import 'package:product_inventory_app/features/inventory/presentation/auth/pages/sing_in_page.dart';

class SinglePromot extends StatelessWidget {
  const SinglePromot({super.key, required this.text, required this.buttonText, required this.onTap}); 

  final String text;
  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text, // Don't have an account?
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextButton(
                      onPressed: onTap , 
                      child: Text(
                        buttonText, // Sing In
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
  }
}