import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/validators.dart';
import '../utils/toast_utils.dart';

// Form Handler - Centralized form operations
class FormHandler {
  FormHandler._();

  // Validate and get form data
  static Map<String, String>? validateAndGetFormData({
    required GlobalKey<FormState> formKey,
    required Map<String, TextEditingController> controllers,
    BuildContext? context,
  }) {
    // Validate form
    if (!formKey.currentState!.validate()) {
      if (context != null) {
        ToastUtils.showWarning(context, 'Please fix the errors above');
      }
      return null;
    }

    // Extract data from controllers
    final Map<String, String> formData = {};
    controllers.forEach((key, controller) {
      formData[key] = controller.text.trim();
    });

    return formData;
  }

  // Clear all form controllers
  static void clearForm(Map<String, TextEditingController> controllers) {
    controllers.forEach((key, controller) {
      controller.clear();
    });
  }

  // Dispose all form controllers
  static void disposeControllers(Map<String, TextEditingController> controllers) {
    controllers.forEach((key, controller) {
      controller.dispose();
    });
  }

  // Create text form field with common styling
  static Widget createTextField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    int maxLines = 1,
    String? hintText,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
      ),
      validator: validator,
    );
  }

  // Create dropdown field with common styling
  static Widget createDropdownField<T>({
    required T value,
    required List<DropdownMenuItem<T>> items,
    required void Function(T?) onChanged,
    required String label,
    required IconData prefixIcon,
    String? Function(T?)? validator,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      validator: validator,
    );
  }
}