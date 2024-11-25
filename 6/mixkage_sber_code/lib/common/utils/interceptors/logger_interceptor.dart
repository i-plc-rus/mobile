import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mixkage_sber_code/common/log/i_logger.dart';

/// Метод, который благодаря интерсепторам записывает информацию через логгер
InterceptorsWrapper loggerInterceptor(final ILogger logger) {
  String prettifyJson(final Object? obj) =>
      const JsonEncoder.withIndent(' ').convert(obj);

  return InterceptorsWrapper(
    onRequest: (final opts, final handler) {
      logger.d(
        'headers: ${opts.headers}\n'
        'path: ${prettifyJson(opts.path)}\n'
        'query: ${prettifyJson(opts.queryParameters)}\n'
        'data: ${prettifyJson(opts.data)}',
      );
      handler.next(opts);
    },
    onResponse: (final res, final handler) {
      logger.d(
        'path: ${prettifyJson(res.requestOptions.path)}\n'
        'data: ${prettifyJson(res.data)}',
      );
      handler.next(res);
    },
    onError: (final error, final handler) {
      logger.e(
        'error: ${prettifyJson(error.error)}\n'
        'message: ${prettifyJson(error.message)}\n'
        'data: ${prettifyJson(error.response?.data)}',
      );
      handler.next(error);
    },
  );
}
