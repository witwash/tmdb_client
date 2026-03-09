/// FAILURES (Domain Layer)
/// Represents errors at the business logic level.
/// Used in `Either<Failure, Success>` return types.
abstract class Failure {
  final String message;

  const Failure(this.message);
}

/// Server-side errors (5xx, 4xx responses)
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Network connectivity errors
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Unexpected errors
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}
