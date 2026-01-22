import 'package:flutter/material.dart';
import 'package:product_inventory_app/core/theme/app_theme.dart';
import 'package:product_inventory_app/features/inventory/presentation/auth/pages/log_in_page.dart';
import 'package:product_inventory_app/features/inventory/presentation/auth/widgets/custem_batton_auth.dart';
import 'package:product_inventory_app/features/inventory/presentation/auth/widgets/custem_text_fild_auth.dart';
import 'package:product_inventory_app/features/inventory/presentation/auth/widgets/single_promot.dart';
import 'package:product_inventory_app/features/inventory/presentation/home/pages/dashboard_page.dart';

class SingInScreen extends StatefulWidget {
  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController conformPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  // Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Logo/Icon Section
                  Icon(
                    Icons.person_add_rounded,
                    size: 80,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 24),
                  // Welcome Text
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign up to get started',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  // Form Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            hintText: 'Full Name',
                            controller: nameController,
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            hintText: 'Email',
                            controller: emailController,
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            hintText: 'Password',
                            obscureText: true,
                            controller: passwordController,
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            hintText: 'Confirm Password',
                            obscureText: true,
                            controller: conformPasswordController,
                          ),
                          const SizedBox(height: 32),
                          CustomButtonAuth(
                            text: 'Sign Up',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                // Validate password match
                                if (passwordController.text !=
                                    conformPasswordController.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Passwords do not match'),
                                      backgroundColor: AppTheme.errorColor,
                                    ),
                                  );
                                  return;
                                }
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DashboardPage(),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SinglePromot(
                    text: 'Already have an account? ',
                    buttonText: 'Login',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
