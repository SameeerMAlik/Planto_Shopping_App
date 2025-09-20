import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:planto_ecommerce_app/presentation/viewmodels/auth_provider.dart';
import 'login_screen.dart';

// Admin Panel - Screen for admin users
class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    print('admin Screen build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          // Logout button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Admin icon
                const Icon(
                  Icons.admin_panel_settings,
                  size: 100,
                  color: Colors.green,
                ),
                const SizedBox(height: 20),

                // Welcome message
                const Text(
                  'Admin Panel',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),

                // User info
                if (authProvider.user != null)
                  Text(
                    'Welcome, ${authProvider.user!.email}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                const SizedBox(height: 30),

                // Info text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'This is where admin users will manage products, orders, and customers. More features will be added in upcoming days.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Placeholder buttons for future features
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Navigate to products management
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Products management coming soon!')),
                    );
                  },
                  icon: const Icon(Icons.inventory),
                  label: const Text('Manage Products'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                const SizedBox(height: 10),

                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Navigate to orders management
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Orders management coming soon!')),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('Manage Orders'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Handle logout
  Future<void> _handleLogout(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.signOut();

    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }
}