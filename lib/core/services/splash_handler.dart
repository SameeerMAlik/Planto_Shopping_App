import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation/viewmodels/auth_provider.dart';
import '../constants/app_strings.dart';
import 'navigation_handler.dart';

// Splash Handler - Manages app initialization
class SplashHandler {
  SplashHandler._();

  // Initialize app and navigate appropriately
  static Future<void> initializeApp(BuildContext context) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    // Wait for authentication state to load
    await Future.delayed(const Duration(seconds: 2));

    // Wait for user role to be fetched if user is logged in
    int attempts = 0;
    while (authViewModel.isLoggedIn &&
        authViewModel.userRole == null &&
        attempts < 10) {
      await Future.delayed(const Duration(milliseconds: 300));
      attempts++;
    }

    // Navigate based on authentication state
    if (context.mounted) {
      _navigateBasedOnAuthState(context, authViewModel);
    }
  }

  // Get status text for splash screen
  static String getStatusText(AuthViewModel authViewModel) {
    if (authViewModel.isLoggedIn && authViewModel.userRole != null) {
      return AppStrings.welcomeBackLoading;
    } else if (authViewModel.isLoggedIn && authViewModel.userRole == null) {
      return AppStrings.loadingUserInfo;
    } else {
      return AppStrings.initializingApp;
    }
  }

  // Private helper for navigation
  static void _navigateBasedOnAuthState(
      BuildContext context,
      AuthViewModel authViewModel,
      ) {
    if (authViewModel.isLoggedIn && authViewModel.userRole != null) {
      // User is logged in with role
      NavigationHandler.navigateBasedOnRole(
        context,
        authViewModel.userRole.toString(),
      );
    } else {
      // User not logged in
      NavigationHandler.navigateToLogin(context);
    }
  }
}