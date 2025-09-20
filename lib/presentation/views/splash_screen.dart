import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_provider.dart';
import 'admin_panel.dart';
import 'customer_panel.dart';
import 'login_screen.dart';

// Splash Screen - First screen that appears when app opens
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for authentication state to be determined
    _checkAuthenticationState();
  }

  // Check authentication state properly
  Future<void> _checkAuthenticationState() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Wait for the authentication state to be fully loaded
    // This gives time for Firebase Auth to check if user is logged in
    await Future.delayed(const Duration(seconds: 2));

    // Wait a bit more to ensure user role is fetched from database
    int attempts = 0;
    while (authProvider.isLoggedIn && authProvider.userRole == null && attempts < 10) {
      await Future.delayed(const Duration(milliseconds: 300));
      attempts++;
    }

    // Now navigate based on the authentication state
    if (mounted) {
      _navigateToNextScreen();
    }
  }

  // Navigate to appropriate screen based on auth state
  void _navigateToNextScreen() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.isLoggedIn && authProvider.userRole != null) {
      // User is logged in and role is loaded
      if (authProvider.userRole == 'admin') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AdminPanel()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const CustomerPanel()),
        );
      }
    } else {
      // User not logged in, go to login screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('splash Screen build');

    return Scaffold(
      backgroundColor: Colors.green[50], // Light green background
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: const Icon(
                    Icons.local_grocery_store,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),

                // App Name
                const Text(
                  'Planto',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),

                // App Subtitle
                const Text(
                  'Fresh Fruits & Vegetables',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 50),

                // Loading indicator
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                const SizedBox(height: 20),

                // Status text to show what's happening
                Text(
                  _getStatusText(authProvider),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Show current status to user
  String _getStatusText(AuthProvider authProvider) {
    if (authProvider.isLoggedIn && authProvider.userRole != null) {
      return 'Welcome back! Loading your panel...';
    } else if (authProvider.isLoggedIn && authProvider.userRole == null) {
      return 'Loading user information...';
    } else {
      return 'Initializing app...';
    }
  }
}