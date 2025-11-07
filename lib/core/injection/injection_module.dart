import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';
import 'package:posts_demo_project/core/constants/api_routes.dart';
import 'package:posts_demo_project/features/posts/data/datasources/post_api_client.dart';

@module
abstract class InjectionModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        // On web, sendTimeout triggers a warning when there is no request body
        // (GET requests). Avoid setting sendTimeout for web builds.
        sendTimeout: kIsWeb ? null : const Duration(seconds: 60),
        // Keeping default headers as fallback;
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'PostsDemo/1.0 (https://example.com) Flutter/Dio',
        },
      ),
    );

    // Adding an interceptor to ensure required headers are present on every request
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Merge headers required by the API. These will overwrite or add.
          options.headers.addAll({
            'Accept': 'application/json',
            'User-Agent': 'PostsDemo/1.0 (https://example.com) Flutter/Dio',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
            'Content-Type':
                options.headers['Content-Type'] ?? 'application/json',
          });

          handler.next(options);
        },
      ),
    );

    // Adding a logger interceptor to help diagnose requests/responses
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: false,
        responseHeader: true,
        responseBody: false,
        error: true,
      ),
    );

    return dio;
  }

  @lazySingleton
  PostApiClient get postApiClient =>
      PostApiClient(dio, baseUrl: ApiRoutes.baseUrl);
}
