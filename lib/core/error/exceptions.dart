// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServerException implements Exception {}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(
    this.message,
  );
}

class CachedException implements Exception {}
