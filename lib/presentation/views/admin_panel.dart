import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/services/auth_handler.dart';
import '../../../core/services/panel_handler.dart';
import '../viewmodels/auth_provider.dart';
import '../widgets/common/panel_header.dart';
import '../widgets/common/user_info_card.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.adminPanel),
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
                  icon: Icons.admin_panel_settings,
                  title: AppStrings.adminPanel,
                  subtitle: 'Manage your store and products',
                ),

                const SizedBox(height: 40),

                // Admin feature buttons (reusable)
                ...PanelHandler.getAdminFeatures(context),

                const SizedBox(height: 30),

                // Quick stats section (reusable widget)
                _buildQuickStats(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickStats() {
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
            'Quick Stats',
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
              _buildStatItem('Products', '0', Icons.inventory),
              _buildStatItem('Orders', '0', Icons.shopping_cart),
              _buildStatItem('Revenue', '\$0', Icons.attach_money),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 30),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}