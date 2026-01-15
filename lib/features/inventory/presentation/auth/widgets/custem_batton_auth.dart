import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButtonAuth({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // لون الخلفية
        foregroundColor: Colors.green, // لون النص
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.green),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
