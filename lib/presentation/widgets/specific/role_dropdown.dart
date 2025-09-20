import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class RoleDropdown extends StatelessWidget {
  final String selectedRole;
  final ValueChanged<String?> onChanged;

  const RoleDropdown({
    super.key,
    required this.selectedRole,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.selectRole,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: selectedRole,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
          items: const [
            DropdownMenuItem(
              value: 'customer',
              child: Text(AppStrings.customerRole),
            ),
            DropdownMenuItem(
              value: 'admin',
              child: Text(AppStrings.adminRole),
            ),
          ],
          onChanged: onChanged,
        ),
      ],
    );
  }
}