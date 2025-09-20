import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/services/auth_handler.dart';
import '../../../core/services/navigation_handler.dart';
import '../../../core/services/form_handler.dart';
import '../../../core/utils/validators.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/specific/auth_header.dart';
import '../widgets/specific/role_dropdown.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Form controllers
  late final Map<String, TextEditingController> _controllers;
  String _selectedRole = 'customer';

  @override
  void initState() {
    super.initState();
    _controllers = {
      'email': TextEditingController(),
      'password': TextEditingController(),
      'confirmPassword': TextEditingController(),
    };
  }

  @override
  void dispose() {
    FormHandler.disposeControllers(_controllers);
    super.dispose();
  }

  // Clean signup handling - no repetitive code!
  Future<void> _handleSignup() async {
    final formData = FormHandler.validateAndGetFormData(
      formKey: _formKey,
      controllers: _controllers,
      context: context,
    );

    if (formData != null) {
      // Additional password confirmation validation
      if (formData['password'] != formData['confirmPassword']) {
        return; // Validation already handled by form validator
      }

      await AuthHandler.handleSignup(
        context: context,
        formKey: _formKey,
        email: formData['email']!,
        password: formData['password']!,
        role: _selectedRole,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.createAccount),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                // Reusable header
                const AuthHeader(
                  title: AppStrings.joinPlanto,
                  subtitle: AppStrings.createAccountSubtitle,
                ),

                const SizedBox(height: 40),

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

                const SizedBox(height: 16),

                // Confirm password field
                FormHandler.createTextField(
                  controller: _controllers['confirmPassword']!,
                  label: AppStrings.confirmPassword,
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                  validator: (value) => Validators.validateConfirmPassword(
                    value,
                    _controllers['password']!.text,
                  ),
                ),

                const SizedBox(height: 20),

                // Role selection (reusable widget)
                RoleDropdown(
                  selectedRole: _selectedRole,
                  onChanged: (value) => setState(() => _selectedRole = value!),
                ),

                const SizedBox(height: 30),

                // Signup button
                CustomButton(
                  text: AppStrings.createAccount,
                  onPressed: _handleSignup,
                ),

                const SizedBox(height: 30),

                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.alreadyHaveAccount),
                    TextButton(
                      onPressed: () => NavigationHandler.goBack(context),
                      child: const Text(
                        AppStrings.login,
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