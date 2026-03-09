import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../config/api_config.dart';
import 'api_key_interceptor.dart';

/// Provides a pre-configured Dio instance for TMDB API calls.
class DioClient {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    final apiKey = dotenv.env['TMDB_API_KEY'];
    if (apiKey != null && apiKey.isNotEmpty) {
      dio.interceptors.add(ApiKeyInterceptor(apiKey));
    }

    // Add logging interceptor for easier debugging during development
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }
}
