class AppException implements Exception {
  final String message;
  final Object? cause;

  AppException(this.message, {this.cause});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException(String message, {Object? cause}) : super(message, cause: cause);
}

class AuthException extends AppException {
  AuthException(String message, {Object? cause}) : super(message, cause: cause);
}


