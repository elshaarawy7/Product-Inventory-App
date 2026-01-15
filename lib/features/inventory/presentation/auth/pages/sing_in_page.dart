import 'package:flutter/material.dart';
import 'package:product_inventory_app/features/inventory/presentation/auth/pages/log_in_page.dart';
import 'package:product_inventory_app/features/inventory/presentation/auth/widgets/custem_batton_auth.dart';
import 'package:product_inventory_app/features/inventory/presentation/auth/widgets/custem_text_fild_auth.dart';
import 'package:product_inventory_app/features/inventory/presentation/auth/widgets/single_promot.dart';
import 'package:product_inventory_app/features/inventory/presentation/pages/dashboard_page.dart';

class SingInScreen extends StatefulWidget {
  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController conformPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300], // لون الخلفية
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                CustomTextField(hintText: 'Name', controller: nameController),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Conform Password',
                  controller: conformPasswordController,
                ),
                SizedBox(height: 20),
                CustomButtonAuth(
                  text: 'Sing In',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DashboardPage();
                          },
                        ),
                      );
                    }
                  },
                ),

                SinglePromot(
                  text: 'Create an account? ',
                  buttonText: 'Login In',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
