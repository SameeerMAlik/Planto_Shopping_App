import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/services/auth_handler.dart';
import '../../../core/services/navigation_handler.dart';
import '../../../core/services/form_handler.dart';
import '../../../core/utils/validators.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/specific/auth_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Form controllers
  late final Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = {
      'email': TextEditingController(),
      'password': TextEditingController(),
    };
  }

  @override
  void dispose() {
    FormHandler.disposeControllers(_controllers);
    super.dispose();
  }

  // Handle login - Clean and simple!
  Future<void> _handleLogin() async {
    final formData = FormHandler.validateAndGetFormData(
      formKey: _formKey,
      controllers: _controllers,
      context: context,
    );

    if (formData != null) {
      await AuthHandler.handleLogin(
        context: context,
        formKey: _formKey,
        email: formData['email']!,
        password: formData['password']!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),

                // Header widget (reusable)
                const AuthHeader(
                  title: AppStrings.welcomeBack,
                  subtitle: AppStrings.signInToContinue,
                ),

                const SizedBox(height: 50),

                // Email field
                FormHandler.createTextField(
                  controller: _controllers['email']!,
                  label: AppStrings.email,
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),

                const SizedBox(height: 16),

                // Password field
                FormHandler.createTextField(
                  controller: _controllers['password']!,
                  label: AppStrings.password,
                  prefixIcon: Icons.lock,
                  obscureText: true,
                  validator: Validators.validatePassword,
                ),

                const SizedBox(height: 30),

                // Login button
                CustomButton(
                  text: AppStrings.login,
                  onPressed: _handleLogin,
                ),

                const SizedBox(height: 30),

                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.dontHaveAccount),
                    TextButton(
                      onPressed: () => NavigationHandler.navigateToSignup(context),
                      child: const Text(
                        AppStrings.signUp,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}