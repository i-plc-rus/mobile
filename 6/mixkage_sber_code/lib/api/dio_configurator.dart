import 'package:dio/dio.dart';
import 'package:mixkage_sber_code/common/log/logger.dart';
import 'package:mixkage_sber_code/common/utils/interceptors/logger_interceptor.dart';

final class DioConfigurator {
  const DioConfigurator();

  Dio create({
    required final String url,
  }) {
    const timeout = Duration(seconds: 30);

    final dio = Dio();

    dio.options
      ..baseUrl = url
      ..contentType = 'application/json'
      ..connectTimeout = timeout
      ..receiveTimeout = timeout
      ..sendTimeout = timeout;

    dio.interceptors.addAll([
      loggerInterceptor(logger),
    ]);

    return dio;
  }
}
