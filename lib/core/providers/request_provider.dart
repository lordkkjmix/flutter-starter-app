import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_starter_app/core/errors/exceptions.dart';

class RequestProvider {
  //Implement here your own own http client
  final String apiBaseUrl;
  final Map<String, dynamic>? headers;
  final Duration? timeout;
  const RequestProvider(this.apiBaseUrl, {this.headers, this.timeout});

  Future<Dio> apiClientInit() async {
    final Dio dio = Dio();
    if (timeout != null) {
      dio.options.connectTimeout = timeout;
      dio.options.receiveTimeout = timeout;
    }
    dio.options.headers = headers;
    dio.options.baseUrl = apiBaseUrl;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: RequestInterceptor().onRequest,
        onResponse: RequestInterceptor().onResponse,
        onError: RequestInterceptor().onError,
      ),
    );
    return dio;
  }

  RequestException getRequestExceptionFromHttpClient(DioException error) {
    try {
      if (error.type == DioExceptionType.unknown ||
          error.type == DioExceptionType.badResponse) {
        return RequestException(
            statusCode: error.response?.statusCode ?? 500,
            message: error.message,
            response: error.response?.data);
      } else if ([
        DioExceptionType.connectionTimeout,
        DioExceptionType.receiveTimeout,
        DioExceptionType.sendTimeout,
        DioExceptionType.unknown
      ].contains(error.type)) {
        return const RequestException(
            statusCode: -1, message: 'CONNECTIVITY_ISSUE');
      } else {
        return RequestException(
            statusCode: error.response?.statusCode,
            message: error.response?.data.toString() ??
                error.response?.statusMessage ??
                error.message);
      }
    } on DioException catch (e) {
      return RequestException(
          statusCode: e.response!.statusCode,
          message: e.response!.statusMessage);
    }
  }

  Future<Response> get(
    String url, {
    int dioCacheExpireDays = 1,
    bool enableDioCache = false,
  }) async {
    try {
      final Dio dio = await apiClientInit();
      // AppLogger.printDebug('[App Api Helper - GET $url]');
      if (enableDioCache) {
        // dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
      }
      final response = await dio.get(
        url,
      );
      return response;
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw getRequestExceptionFromHttpClient(e);
    } catch (e) {
      debugPrint(e.toString());
      throw RequestException(statusCode: -1, message: e.toString());
    }
  }

  Future<Response> post(
    String url, {
    required body,
    encoding,
    Function(int level, int total)? onSendProgress,
  }) async {
    try {
      final Dio dio = await apiClientInit();
      debugPrint('[API Helper - POST $url] Server Request: $body');
      final response = await dio.post(
        url,
        data: body,
      );
      return response;
    } on DioException catch (e) {
      throw getRequestExceptionFromHttpClient(e);
    } catch (e) {
      throw RequestException(statusCode: -1, message: e.toString());
    }
  }

  Future<Response> put(
    String url, {
    required body,
    encoding,
    Function(int level, int total)? onSendProgress,
  }) async {
    try {
      final Dio dio = await apiClientInit();

      debugPrint('[API Helper - PUT $url]  Server Request: $body');
      final response = await dio.put(
        url,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw getRequestExceptionFromHttpClient(e);
    } catch (e) {
      debugPrint(e.toString());
      throw RequestException(statusCode: -1, message: e.toString());
    }
  }

  Future<Response> patch(
    String url, {
    required body,
    encoding,
    Function(int level, int total)? onSendProgress,
  }) async {
    try {
      final Dio dio = await apiClientInit();
      debugPrint('[API Helper - PUT $url]  Server Request: $body');
      final response = await dio.patch(
        url,
        data: body,
      );
      return response;
    } on DioException catch (e) {
      throw getRequestExceptionFromHttpClient(e);
    } catch (e) {
      debugPrint(e.toString());
      throw RequestException(statusCode: -1, message: e.toString());
    }
  }
}

class RequestInterceptor extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  FutureOr<dynamic> onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
        "<-- ${err.message} ${(err.response?.requestOptions != null ? ("${err.response?.requestOptions.baseUrl}" "${err.response?.requestOptions.path}") : 'URL')}");
    debugPrint(
        "${err.response != null ? err.response?.data : 'Unknown Error'}");
    debugPrint("<-- End error");
    handler.next(err);
  }

  @override
  FutureOr<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
    return response;
  }
}
