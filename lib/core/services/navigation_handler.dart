import 'package:flutter/material.dart';
import '../../presentation/views/admin_panel.dart';
import '../../presentation/views/customer_panel.dart';
import '../../presentation/views/login_screen.dart';
import '../../presentation/views/signup_screen.dart';
import '../../presentation/views/splash_screen.dart';

// Navigation Handler - Centralized navigation logic
class NavigationHandler {
  NavigationHandler._();

  // Navigate to login screen
  static void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false, // Remove all previous routes
    );
  }

  // Navigate to signup screen
  static void navigateToSignup(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  // Navigate to admin panel
  static void navigateToAdminPanel(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const AdminPanel()),
          (route) => false, // Remove all previous routes
    );
  }

  // Navigate to customer panel
  static void navigateToCustomerPanel(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const CustomerPanel()),
          (route) => false, // Remove all previous routes
    );
  }

  // Navigate to splash screen
  static void navigateToSplash(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const SplashScreen()),
          (route) => false,
    );
  }

  // Go back to previous screen
  static void goBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  // Navigate with role-based logic
  static void navigateBasedOnRole(BuildContext context, String role) {
    if (role == 'admin') {
      navigateToAdminPanel(context);
    } else {
      navigateToCustomerPanel(context);
    }
  }

  // Navigate with custom route
  static void navigateWithCustomRoute<T>({
    required BuildContext context,
    required Widget destination,
    bool clearStack = false,
    bool allowBack = true,
  }) {
    if (clearStack) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => destination,
        ),
            (route) => false,
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => destination,
        ),
      );
    }
  }
}