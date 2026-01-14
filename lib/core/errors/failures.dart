import 'package:equatable/equatable.dart';

/// Base class for all failures
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Database operation failures
class DatabaseFailure extends Failure {
  const DatabaseFailure([String message = 'Database operation failed'])
    : super(message);
}

/// Image picker failures
class ImagePickerFailure extends Failure {
  const ImagePickerFailure([String message = 'Failed to pick image'])
    : super(message);
}

/// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure([String message = 'Validation failed'])
    : super(message);
}

/// File storage failures
class StorageFailure extends Failure {
  const StorageFailure([String message = 'Storage operation failed'])
    : super(message);
}

/// Not found failures
class NotFoundFailure extends Failure {
  const NotFoundFailure([String message = 'Resource not found'])
    : super(message);
}
