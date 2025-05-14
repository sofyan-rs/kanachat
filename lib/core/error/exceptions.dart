class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class LocalException implements Exception {
  final String message;
  LocalException(this.message);
}
