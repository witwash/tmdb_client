/// EXCEPTIONS (Data Layer)
/// Thrown by data sources, caught by repositories and converted to Failures.
library;

/// Base exception class
abstract class AppException implements Exception {
  final String message;

  const AppException(this.message);
}

/// Thrown when API returns an error response
class ServerException extends AppException {
  const ServerException(super.message);
}

/// Thrown when there's no internet connection or network timeout
class NetworkException extends AppException {
  const NetworkException(super.message);
}

/// Thrown for unexpected errors (parsing, etc.)
class UnexpectedException extends AppException {
  const UnexpectedException(super.message);
}
