class ServerException implements Exception {}

class CacheException implements Exception {}

class PlatformException implements Exception {
  final String? message;
  const PlatformException({
    this.message,
  });
}

class RequestException implements Exception {
  final String? message;
  final int? statusCode;
  final dynamic response;

  const RequestException({this.message, this.statusCode, this.response});

  factory RequestException.fromJson(Map<String, dynamic> json) {
    return RequestException(
        message: json['detail'].toString(),
        statusCode: json['statusCode'] as int,
        response: json['response']);
  }

  @override
  String toString() =>
      "RequestException:\n\tcode: $statusCode\n\tmessage:$message \n\response:$response";
}
