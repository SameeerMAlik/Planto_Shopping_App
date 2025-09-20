import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';
import 'admin_panel.dart';
import 'customer_panel.dart';

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
    // Wait for 3 seconds then navigate to appropriate screen
    _navigateToNextScreen();
  }

  // Navigate to next screen based on user authentication status
  Future<void> _navigateToNextScreen() async {
    // Wait for 3 seconds to show splash screen
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      // Check if user is already logged in
      if (authProvider.isLoggedIn && authProvider.userRole != null) {
        // Navigate based on user role
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50], // Light green background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo (You can replace with your actual logo)
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
          ],
        ),
      ),
    );
  }
}