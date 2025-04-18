class AppError implements Exception {
  final String message;
  final dynamic originalError;
  final StackTrace? stackTrace;

  AppError(this.message, {this.originalError, this.stackTrace});

  @override
  String toString() => 'AppError: $message';
}

class AuthenticationError extends AppError {
  AuthenticationError(String message, {dynamic originalError, StackTrace? stackTrace})
      : super(message, originalError: originalError, stackTrace: stackTrace);
}

class NetworkError extends AppError {
  NetworkError(String message, {dynamic originalError, StackTrace? stackTrace})
      : super(message, originalError: originalError, stackTrace: stackTrace);
}

class DriveError extends AppError {
  DriveError(String message, {dynamic originalError, StackTrace? stackTrace})
      : super(message, originalError: originalError, stackTrace: stackTrace);
}