import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/constants/app_colors.dart';

class UserInfoCard extends StatelessWidget {
  final User? user;
  final String? userRole; // Add role separately since Firebase User doesn't have role

  const UserInfoCard({
    super.key,
    required this.user,
    this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    if (user == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.primary,
            backgroundImage: user!.photoURL != null
                ? NetworkImage(user!.photoURL!)
                : null,
            child: user!.photoURL == null
                ? Text(
              _getInitials(user!.email ?? user!.displayName ?? 'U'),
              style: const TextStyle(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user!.displayName ?? user!.email ?? 'User',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (user!.email != null && user!.displayName != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    user!.email!,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                if (userRole != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: userRole == 'admin'
                          ? AppColors.warning.withOpacity(0.1)
                          : AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      userRole!.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: userRole == 'admin'
                            ? AppColors.warning
                            : AppColors.success,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String text) {
    if (text.isEmpty) return 'U';

    List<String> words = text.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else {
      return text.substring(0, 1).toUpperCase();
    }
  }
}