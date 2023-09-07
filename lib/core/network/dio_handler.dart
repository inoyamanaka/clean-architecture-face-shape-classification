import 'package:dio/dio.dart';
import 'package:face_shape/core/env/env_config.dart';

class DioHandler {
  DioHandler({required this.config});

  final EnvConfig config;

  Dio get dio => _getDio();

  Dio _getDio() {
    final options = BaseOptions(
      baseUrl: config.apiBaseUrl ?? '',
      receiveDataWhenStatusError: true,
    );

    final dio = Dio(options);

    return dio;
  }

  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        final headers = {
          'Accept': 'application/json',
        };

        if (options.headers.containsKey('isToken')) {
          options.headers.remove('isToken');
          options.headers.addAll(headers);
        }

        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        return handler.next(response); // continue
      },
      onError: (error, handler) async {
        return handler.next(error); //continue
      },
    );
  }
}
