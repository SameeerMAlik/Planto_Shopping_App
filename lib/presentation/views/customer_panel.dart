import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_provider.dart';
import 'login_screen.dart';

// Customer Panel - Screen for customer users
class CustomerPanel extends StatelessWidget {
  const CustomerPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Panel'),
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
                // Shopping icon
                const Icon(
                  Icons.shopping_bag,
                  size: 100,
                  color: Colors.green,
                ),
                const SizedBox(height: 20),

                // Welcome message
                const Text(
                  'Customer Panel',
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
                    'This is where customers will browse and buy fresh fruits & vegetables. Shopping features will be added in upcoming days.',
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
                    // TODO: Navigate to products catalog
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Product catalog coming soon!')),
                    );
                  },
                  icon: const Icon(Icons.store),
                  label: const Text('Browse Products'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                const SizedBox(height: 10),

                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Navigate to shopping cart
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Shopping cart coming soon!')),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('My Cart'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                const SizedBox(height: 10),

                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Navigate to order history
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order history coming soon!')),
                    );
                  },
                  icon: const Icon(Icons.history),
                  label: const Text('My Orders'),
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