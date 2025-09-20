import 'package:flutter/material.dart';
import '../utils/toast_utils.dart';
import '../utils/dialog_utils.dart';
import '../exceptions/app_exceptions.dart';
import '../constants/app_strings.dart';

// Error Handler - Centralized error handling
class ErrorHandler {
  ErrorHandler._();

  // Handle and display errors appropriately
  static void handleError({
    required BuildContext context,
    required dynamic error,
    String? customMessage,
    bool showDialog = false,
    bool showToast = true,
    VoidCallback? onRetry,
  }) {
    final String errorMessage = _getErrorMessage(error, customMessage);

    if (showDialog) {
      _showErrorDialog(context, errorMessage, onRetry);
    } else if (showToast) {
      ToastUtils.showError(context, errorMessage);
    }

    // Log error for debugging
    _logError(error, errorMessage);
  }

  // Handle network errors specifically
  static void handleNetworkError(BuildContext context, {VoidCallback? onRetry}) {
    DialogUtils.showError(
      context: context,
      title: 'Connection Error',
      message: AppStrings.noInternetConnection,
      buttonText: onRetry != null ? 'Retry' : 'OK',
      onPressed: onRetry,
    );
  }

  // Handle validation errors
  static void handleValidationError(BuildContext context, String message) {
    ToastUtils.showWarning(context, message);
  }

  // Handle success operations
  static void handleSuccess(BuildContext context, String message) {
    ToastUtils.showSuccess(context, message);
  }

  // Handle info messages
  static void handleInfo(BuildContext context, String message) {
    ToastUtils.showInfo(context, message);
  }

  // Private: Get user-friendly error message
  static String _getErrorMessage(dynamic error, String? customMessage) {
    if (customMessage != null) {
      return customMessage;
    }

    if (error is AppException) {
      return error.message;
    }

    // Handle common Firebase errors
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('network')) {
      return AppStrings.noInternetConnection;
    }
    if (errorString.contains('user-not-found')) {
      return 'No account found with this email';
    }
    if (errorString.contains('wrong-password')) {
      return 'Incorrect password';
    }
    if (errorString.contains('email-already-in-use')) {
      return 'An account already exists with this email';
    }
    if (errorString.contains('weak-password')) {
      return 'Password is too weak';
    }
    if (errorString.contains('invalid-email')) {
      return 'Invalid email address';
    }
    if (errorString.contains('permission-denied')) {
      return 'Permission denied. Please check your access rights';
    }

    return AppStrings.somethingWentWrong;
  }

  // Private: Show error dialog
  static void _showErrorDialog(BuildContext context, String message, VoidCallback? onRetry) {
    DialogUtils.showError(
      context: context,
      title: 'Error',
      message: message,
      buttonText: onRetry != null ? AppStrings.tryAgain : 'OK',
      onPressed: onRetry,
    );
  }

  // Private: Log error for debugging
  static void _logError(dynamic error, String message) {
    debugPrint('🚨 ERROR: $message');
    debugPrint('🔍 Details: $error');
    // In production, you might want to send this to crash analytics
  }
}