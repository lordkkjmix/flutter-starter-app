import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_starter_app/core/errors/exceptions.dart';

abstract class RequestProvider {
  Future<Response> get(
    String url, {
    int dioCacheExpireDays = 1,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    String? customBaseUrl,
    Duration? timeout,
  });
  Future<Response> post(
    String url, {
    required Map<String, dynamic> body,
    encoding,
    Function(int level, int total)? onSendProgress,
    Map<String, dynamic>? headers,
    String? customBaseUrl,
    Duration? timeout,
  });
  Future<Response> patch(
    String url, {
    Map<String, dynamic>? body,
    encoding,
    Function(int level, int total)? onSendProgress,
    Map<String, dynamic>? headers,
    String? customBaseUrl,
    Duration? timeout,
  });
  Future<Response> put(
    String url, {
    Map<String, dynamic>? body,
    encoding,
    Function(int level, int total)? onSendProgress,
    Map<String, dynamic>? headers,
    String? customBaseUrl,
    Duration? timeout,
  });
  Future<Response> delete(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    String? customBaseUrl,
    Duration? timeout,
  });
}

class RequestProviderImpl implements RequestProvider {
  //Implement here your own own http client
  const RequestProviderImpl();

  Future<Dio> apiClientInit(
      {String? apiBaseUrl,
      Map<String, dynamic>? headers,
      Duration? timeout}) async {
    final Dio dio = Dio();
    if (timeout != null) {
      dio.options.connectTimeout = timeout;
      dio.options.receiveTimeout = timeout;
    }
    dio.options.headers = headers;
    dio.options.baseUrl = apiBaseUrl ?? "";
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

  @override
  Future<Response> get(String url,
      {int dioCacheExpireDays = 1,
      String? customBaseUrl,
      bool enableDioCache = false,
      Duration? timeout,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParams}) async {
    try {
      final Dio dio = await apiClientInit(
          apiBaseUrl: customBaseUrl, headers: headers, timeout: timeout);
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

  @override
  Future<Response> post(
    String url, {
    required Map<String, dynamic> body,
    encoding,
    Function(int level, int total)? onSendProgress,
    Map<String, dynamic>? headers,
    String? customBaseUrl,
    Duration? timeout,
  }) async {
    try {
      final Dio dio = await apiClientInit(
          apiBaseUrl: customBaseUrl, headers: headers, timeout: timeout);
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

  @override
  Future<Response> put(
    String url, {
    body,
    encoding,
    Function(int level, int total)? onSendProgress,
    Map<String, dynamic>? headers,
    String? customBaseUrl,
    Duration? timeout,
  }) async {
    try {
      final Dio dio = await apiClientInit(
          apiBaseUrl: customBaseUrl, headers: headers, timeout: timeout);

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

  @override
  Future<Response> patch(
    String url, {
    body,
    encoding,
    Function(int level, int total)? onSendProgress,
    Map<String, dynamic>? headers,
    String? customBaseUrl,
    Duration? timeout,
  }) async {
    try {
      final Dio dio = await apiClientInit(
          apiBaseUrl: customBaseUrl, headers: headers, timeout: timeout);
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

  @override
  Future<Response> delete(
    String url, {
    body,
    Map<String, dynamic>? headers,
    String? customBaseUrl,
    Duration? timeout,
  }) async {
    try {
      final Dio dio = await apiClientInit(
          apiBaseUrl: customBaseUrl, headers: headers, timeout: timeout);
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
