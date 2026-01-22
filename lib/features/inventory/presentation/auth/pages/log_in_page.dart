import 'package:flutter/material.dart';
import 'package:product_inventory_app/core/theme/app_theme.dart';
import 'package:product_inventory_app/features/inventory/presentation/auth/pages/sing_in_page.dart';
import 'package:product_inventory_app/features/inventory/presentation/auth/widgets/custem_batton_auth.dart';
import 'package:product_inventory_app/features/inventory/presentation/auth/widgets/custem_text_fild_auth.dart';
import 'package:product_inventory_app/features/inventory/presentation/auth/widgets/single_promot.dart';
import 'package:product_inventory_app/features/inventory/presentation/home/pages/dashboard_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  // Logo/Icon Section
                  Icon(
                    Icons.inventory_2_rounded,
                    size: 80,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 24),
                  // Welcome Text
                  Text(
                    'Welcome Back!',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to manage your inventory',
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
                            hintText: 'Email',
                            controller: emailController,
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            hintText: 'Password',
                            obscureText: true,
                            controller: passwordController,
                          ),
                          const SizedBox(height: 32),
                          CustomButtonAuth(
                            text: 'Login',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
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
                    text: 'Don\'t have an account? ',
                    buttonText: 'Sign Up',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingInScreen(),
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
