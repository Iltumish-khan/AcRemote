import 'package:demo_project/services/exports/utils.dart';

class ApiException implements Exception {
  String? message;
  String? prefix;

  ApiException([
    this.message,
    this.prefix,
  ]);
}

class FetchDataException extends ApiException {
  FetchDataException([String? message])
      : super(message, "Fetch Data Exception");
}

class NoInternetConnetionException extends ApiException {
  NoInternetConnetionException([String? message])
      : super(message, AppStrings.internetConnectionRequired);
}

class InternalServerException extends ApiException {
  InternalServerException([String? message])
      : super(message, "Something went wrong! Please try again later.");
}

class ApiNotRespondingException extends ApiException {
  ApiNotRespondingException([String? message])
      : super(message, "Api Not Responding Exception");
}

class UnAuthorizedException extends ApiException {
  UnAuthorizedException([String? message]) : super(message, "Unauthenticated.");
}

class UserInputError extends ApiException {
  UserInputError(String message)
      : super(message, "The given data was invalid.");
}

class ResourceNotFoundException extends ApiException {
  ResourceNotFoundException(String? message)
      : super(message, "Request resource not found.");
}

class TooManyAttemptsException extends ApiException {
  TooManyAttemptsException(String message) : super("Too Many Attempts.");
}

class AccountDisabledException extends ApiException {
  AccountDisabledException([String? message])
      : super(message, "Your account is disabled for now.");
}
