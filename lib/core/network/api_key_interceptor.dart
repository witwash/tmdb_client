import 'package:dio/dio.dart';

/// Interceptor that adds the TMDB API key to the query parameters of every request.
class ApiKeyInterceptor extends Interceptor {
  final String apiKey;

  const ApiKeyInterceptor(this.apiKey);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.putIfAbsent('api_key', () => apiKey);
    super.onRequest(options, handler);
  }
}
