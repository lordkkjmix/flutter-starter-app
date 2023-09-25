import 'package:flutter_starter_app/core/providers/request_provider.dart';

const defaultHeader = {
  "requireToken": true, //Used if your project use secure jwt
  "Access-Control-Allow-Origin": "*",
  "content-type": "application/json"
};

class RequestHelper {
  final String apiBaseUrl;
  const RequestHelper({required this.apiBaseUrl});

  RequestHelper.test({required this.apiBaseUrl});
  Future<dynamic> get(String url,
          {Map<String, dynamic>? headers,
          Map<String, dynamic>? queryParams}) async =>
      RequestProvider(
        apiBaseUrl,
        headers: headers,
      ).get(url);
  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async =>
      RequestProvider(
        apiBaseUrl,
        headers: headers,
      ).post(
        url,
        body: body,
      );
  static Future<dynamic> patch(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {}
  static Future<dynamic> put(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {}
  static Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {}
}
