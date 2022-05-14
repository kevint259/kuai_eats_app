class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

// all other exceptions
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
