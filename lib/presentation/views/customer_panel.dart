import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/services/auth_handler.dart';
import '../../../core/services/panel_handler.dart';
import '../viewmodels/auth_provider.dart';
import '../widgets/common/panel_header.dart';
import '../widgets/common/user_info_card.dart';

class CustomerPanel extends StatelessWidget {
  const CustomerPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.customerPanel),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => AuthHandler.handleLogout(context),
          ),
        ],
      ),
      body: Consumer<AuthViewModel>(
        builder: (context, authViewModel, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // User info card (reusable)
                // In admin_panel.dart, update this line:
                UserInfoCard(
                  user: authViewModel.user,
                  userRole: authViewModel.userRole,
                ),

                const SizedBox(height: 30),

                // Welcome header (reusable)
                const PanelHeader(
                  icon: Icons.shopping_bag,
                  title: AppStrings.customerPanel,
                  subtitle: 'Browse fresh fruits & vegetables',
                ),

                const SizedBox(height: 40),

                // Customer feature buttons (reusable)
                ...PanelHandler.getCustomerFeatures(context),

                const SizedBox(height: 30),

                // Categories section
                _buildCategories(),

                const SizedBox(height: 30),

                // Recent orders section
                _buildRecentOrders(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shop by Category',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCategoryItem('Fruits', '🍎', AppColors.error),
              _buildCategoryItem('Vegetables', '🥕', AppColors.success),
              _buildCategoryItem('Herbs', '🌿', AppColors.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String name, String emoji, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentOrders() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Orders',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 48,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: 10),
                Text(
                  'No orders yet',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Start shopping to see your orders here',
                  style: TextStyle(
                    color: AppColors.textHint,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}