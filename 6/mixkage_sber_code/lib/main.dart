import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart' as l;
import 'package:mixkage_sber_code/app/app.dart';
import 'package:mixkage_sber_code/common/config/config.dart';
import 'package:mixkage_sber_code/common/log/logger.dart';
import 'package:mixkage_sber_code/common/log/logger_bloc_observer.dart';
import 'package:mixkage_sber_code/injection_container.dart';
import 'package:motion/motion.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Motion.instance.initialize();
      Motion.instance.setUpdateInterval(60.fps);
      await initInjectionContainer();
      Bloc.observer = LoggerBlocObserver(l.Logger());
      await SentryFlutter.init(
        (final options) {
          options
            ..dsn = Config.sentryDsn
            ..enableAutoPerformanceTracing = true
            ..attachThreads = true
            ..attachViewHierarchy = true
            ..attachStacktrace = true
            ..tracesSampleRate = 0.2
            ..attachScreenshot = true;
        },
        appRunner: () => runApp(
          SentryScreenshotWidget(
            child: DefaultAssetBundle(
              bundle: SentryAssetBundle(),
              child: const MixKageApp(),
            ),
          ),
        ),
      ).then((final value) {});
    },
    (final error, final stackTrace) {
      logger.e(error.toString(), stackTrace: stackTrace);
    },
  );
}
