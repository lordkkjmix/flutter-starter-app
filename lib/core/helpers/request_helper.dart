import 'package:flutter_starter_app/core/providers/injection_provider.dart';
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
      sl<RequestProvider>()
          .get(url, headers: headers, queryParams: queryParams);
  Future<dynamic> post(
    String url,
    Map<String, dynamic> body, {
    Map<String, dynamic>? headers,
  }) async =>
      sl<RequestProvider>().post(url, body: body, headers: headers);
  static Future<dynamic> patch(
    String url,
    Map<String, dynamic> body, {
    Map<String, dynamic>? headers,
  }) async =>
      sl<RequestProvider>().patch(url, body: body, headers: headers);
  static Future<dynamic> put(
    String url,
    Map<String, dynamic> body, {
    Map<String, dynamic>? headers,
  }) async =>
      sl<RequestProvider>().put(url, body: body, headers: headers);
  static Future<dynamic> delete(
    String url,
    Map<String, dynamic> body, {
    Map<String, dynamic>? headers,
  }) async =>
      sl<RequestProvider>().delete(url, body: body, headers: headers);
}
