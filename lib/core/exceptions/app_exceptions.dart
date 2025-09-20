// Custom Exceptions for better error handling
class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, [this.code]);

  @override
  String toString() => 'AppException: $message';
}

class NetworkException extends AppException {
  const NetworkException(String message) : super(message, 'NETWORK_ERROR');
}

class AuthenticationException extends AppException {
  const AuthenticationException(String message) : super(message, 'AUTH_ERROR');
}

class ValidationException extends AppException {
  const ValidationException(String message) : super(message, 'VALIDATION_ERROR');
}

class DatabaseException extends AppException {
  const DatabaseException(String message) : super(message, 'DATABASE_ERROR');
}

class PermissionException extends AppException {
  const PermissionException(String message) : super(message, 'PERMISSION_ERROR');
}

// Exception Handler Utility
class ExceptionHandler {
  static String getErrorMessage(Exception exception) {
    if (exception is AppException) {
      return exception.message;
    }

    // Handle Firebase Auth exceptions
    if (exception.toString().contains('user-not-found')) {
      return 'No user found with this email address';
    }
    if (exception.toString().contains('wrong-password')) {
      return 'Incorrect password';
    }
    if (exception.toString().contains('email-already-in-use')) {
      return 'An account already exists with this email';
    }
    if (exception.toString().contains('weak-password')) {
      return 'Password is too weak';
    }
    if (exception.toString().contains('invalid-email')) {
      return 'Invalid email address format';
    }
    if (exception.toString().contains('network-request-failed')) {
      return 'No internet connection';
    }

    // Default message
    return 'An unexpected error occurred';
  }
}