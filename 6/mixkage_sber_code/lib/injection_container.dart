import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mixkage_sber_code/api/dio_configurator.dart';
import 'package:mixkage_sber_code/api/service/user_settings_cloud.dart';
import 'package:mixkage_sber_code/api/service/user_settings_cloud_interface.dart';
import 'package:mixkage_sber_code/api/service/user_settings_cloud_mock.dart';
import 'package:mixkage_sber_code/api/service/user_settings_local.dart';
import 'package:mixkage_sber_code/common/config/config.dart';
import 'package:mixkage_sber_code/common/notification_service/notification_service.dart';
import 'package:mixkage_sber_code/common/persistence/secure_storage/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

/// Регистрирует синглтоны в глобальном контексте через [GetIt]
Future<void> initInjectionContainer() async {
  // Работа с памятью
  const flutterSecureStorage = FlutterSecureStorage();
  getIt.registerLazySingleton(() => flutterSecureStorage);

  final secureStorage =
      await SecureStorage.initDefaultValue(flutterSecureStorage);
  getIt.registerLazySingleton(() => secureStorage);

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  // Работа с сетью режим server/mock
  getIt.registerLazySingleton<InternetService>(() {
    final client = const DioConfigurator().create(
      url: Config.apiUri,
    );
    if (Config.isMockData) {
      return InternetServiceMock();
    } else {
      return InternetServiceDio(
        client,
        secureStorage,
      );
    }
  });

  // Работа с локальным хранилищем
  getIt.registerLazySingleton<InternetServiceLocal>(
    () => InternetServiceLocal(secureStorage),
  );

  // Иницализация сервиса по работе с уведомлениями
  await NotificationService().init();
}
