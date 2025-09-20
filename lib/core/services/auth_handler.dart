import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation/viewmodels/auth_provider.dart';
import '../utils/toast_utils.dart';
import '../utils/dialog_utils.dart';
import '../constants/app_strings.dart';
import 'navigation_handler.dart';

// Authentication Handler - Centralized auth operations
class AuthHandler {
  AuthHandler._();

  // Handle login process
  static Future<bool> handleLogin({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required String email,
    required String password,
    bool showLoading = true,
  }) async {
    try {
      // Validate form
      if (!formKey.currentState!.validate()) {
        return false;
      }

      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

      // Show loading dialog
      if (showLoading) {
        DialogUtils.showLoading(context, message: 'Signing you in...');
      }

      // Clear previous errors
      authViewModel.clearError();

      // Attempt login
      final success = await authViewModel.signIn(email.trim(), password.trim());

      // Hide loading dialog
      if (showLoading) {
        DialogUtils.hideLoading(context);
      }

      if (success) {
        // Show success message
        ToastUtils.showSuccess(context, AppStrings.loginSuccess);

        // Navigate to appropriate panel
        await _navigateBasedOnRole(context, authViewModel);
        return true;
      } else {
        // Show error message
        _showErrorMessage(context, authViewModel.errorMessage);
        return false;
      }

    } catch (e) {
      // Hide loading dialog
      if (showLoading) {
        DialogUtils.hideLoading(context);
      }

      // Show error
      ToastUtils.showError(context, 'Login failed: ${e.toString()}');
      return false;
    }
  }

  // Handle signup process
  static Future<bool> handleSignup({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required String email,
    required String password,
    required String role,
    bool showLoading = true,
  }) async {
    try {
      // Validate form
      if (!formKey.currentState!.validate()) {
        return false;
      }

      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

      // Show loading dialog
      if (showLoading) {
        DialogUtils.showLoading(context, message: 'Creating your account...');
      }

      // Clear previous errors
      authViewModel.clearError();

      // Attempt signup
      final success = await authViewModel.signUp(email.trim(), password.trim(), role);

      // Hide loading dialog
      if (showLoading) {
        DialogUtils.hideLoading(context);
      }

      if (success) {
        // Show success message
        ToastUtils.showSuccess(context, AppStrings.accountCreatedSuccess);

        // Navigate to appropriate panel
        await _navigateBasedOnRole(context, authViewModel);
        return true;
      } else {
        // Show error message
        _showErrorMessage(context, authViewModel.errorMessage);
        return false;
      }

    } catch (e) {
      // Hide loading dialog
      if (showLoading) {
        DialogUtils.hideLoading(context);
      }

      // Show error
      ToastUtils.showError(context, 'Signup failed: ${e.toString()}');
      return false;
    }
  }

  // Handle logout process
  static Future<void> handleLogout(BuildContext context) async {
    try {
      // Show confirmation dialog
      final confirmed = await DialogUtils.showConfirmation(
        context: context,
        title: 'Logout',
        message: 'Are you sure you want to logout?',
        confirmText: 'Logout',
        cancelText: 'Cancel',
      );

      if (confirmed == true) {
        // Show loading
        DialogUtils.showLoading(context, message: 'Logging out...');

        final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
        await authViewModel.signOut();

        // Hide loading
        DialogUtils.hideLoading(context);

        // Show success message
        ToastUtils.showSuccess(context, AppStrings.logoutSuccess);

        // Navigate to login screen
        NavigationHandler.navigateToLogin(context);
      }

    } catch (e) {
      DialogUtils.hideLoading(context);
      ToastUtils.showError(context, 'Logout failed: ${e.toString()}');
    }
  }

  // Private helper: Navigate based on user role
  static Future<void> _navigateBasedOnRole(
      BuildContext context,
      AuthViewModel authViewModel,
      ) async {
    if (authViewModel.userRole == 'admin') {
      NavigationHandler.navigateToAdminPanel(context);
    } else {
      NavigationHandler.navigateToCustomerPanel(context);
    }
  }

  // Private helper: Show error message
  static void _showErrorMessage(BuildContext context, String? errorMessage) {
    if (errorMessage != null) {
      ToastUtils.showError(context, errorMessage);
    }
  }
}