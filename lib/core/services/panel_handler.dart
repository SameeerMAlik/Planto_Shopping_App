import 'package:flutter/material.dart';
import '../constants/app_strings.dart';
import '../utils/toast_utils.dart';
import '../../presentation/widgets/common/feature_button.dart';

// Panel Handler - Manages panel features and actions
class PanelHandler {
  PanelHandler._();

  // Get admin panel features
  static List<Widget> getAdminFeatures(BuildContext context) {
    return [
      FeatureButton(
        icon: Icons.inventory,
        title: AppStrings.manageProducts,
        subtitle: 'Add, edit, and manage your products',
        onPressed: () => _showComingSoon(context, AppStrings.manageProductsComingSoon),
      ),
      const SizedBox(height: 15),

      FeatureButton(
        icon: Icons.shopping_cart,
        title: AppStrings.manageOrders,
        subtitle: 'View and process customer orders',
        onPressed: () => _showComingSoon(context, AppStrings.manageOrdersComingSoon),
      ),
      const SizedBox(height: 15),

      FeatureButton(
        icon: Icons.analytics,
        title: 'Analytics',
        subtitle: 'View sales and performance reports',
        onPressed: () => _showComingSoon(context, 'Analytics coming soon!'),
      ),
      const SizedBox(height: 15),

      FeatureButton(
        icon: Icons.people,
        title: 'Customers',
        subtitle: 'Manage customer accounts',
        onPressed: () => _showComingSoon(context, 'Customer management coming soon!'),
      ),
    ];
  }

  // Get customer panel features
  static List<Widget> getCustomerFeatures(BuildContext context) {
    return [
      FeatureButton(
        icon: Icons.store,
        title: AppStrings.browseProducts,
        subtitle: 'Explore fresh fruits and vegetables',
        onPressed: () => _showComingSoon(context, AppStrings.productsComingSoon),
      ),
      const SizedBox(height: 15),

      FeatureButton(
        icon: Icons.shopping_cart,
        title: AppStrings.myCart,
        subtitle: 'View items in your cart',
        onPressed: () => _showComingSoon(context, AppStrings.cartComingSoon),
      ),
      const SizedBox(height: 15),

      FeatureButton(
        icon: Icons.history,
        title: AppStrings.myOrders,
        subtitle: 'Track your order history',
        onPressed: () => _showComingSoon(context, AppStrings.ordersComingSoon),
      ),
      const SizedBox(height: 15),

      FeatureButton(
        icon: Icons.favorite,
        title: 'Wishlist',
        subtitle: 'Your saved favorite items',
        onPressed: () => _showComingSoon(context, 'Wishlist coming soon!'),
      ),
    ];
  }

  // Private helper for coming soon messages
  static void _showComingSoon(BuildContext context, String message) {
    ToastUtils.showInfo(context, message);
  }
}