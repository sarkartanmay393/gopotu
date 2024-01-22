class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  getMessage() {
    return "$_message";
  }

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message])
      : super(message, "Invalid Request. Try again. ");
}

class UnknownException extends AppException {
  UnknownException([message]) : super(message, "Unknown Exception. ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message])
      : super(message, "Unauthorised request. Try again. ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super(message, "Invalid Input. Try again. ");
}
