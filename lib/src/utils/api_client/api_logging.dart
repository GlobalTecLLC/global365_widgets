import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:global365_widgets/src/utils/print_log.dart';

class ApiLogging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (kDebugMode) {
      gLogger('REQUEST[${options.method}] => PATH: ${options.path}');
    }

    String token = options.headers['Authorization'] ?? '';
    if (token.isNotEmpty) {
      gLogger('Token: $token');
    }
    if (token.isNotEmpty) {
      options.headers.addAll({"Authorization": "Bearer $token"});
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      gLogger('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      gLogger('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    }
    super.onError(err, handler);
  }
}
