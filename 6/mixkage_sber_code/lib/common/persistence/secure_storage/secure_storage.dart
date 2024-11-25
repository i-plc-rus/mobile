import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mixkage_sber_code/api/data/user.dart';
import 'package:mixkage_sber_code/common/persistence/secure_storage/ss_keys.dart';

/// Класс, который представляет обертку над [FlutterSecureStorage]
class SecureStorage {
  final FlutterSecureStorage storage;

  const SecureStorage({
    required this.storage,
  });

  SecureStorage._create(this.storage);

  /// Public factory
  static Future<SecureStorage> initDefaultValue(
      final FlutterSecureStorage storage,) async {
    final component = SecureStorage._create(storage);

    // Так как задачи на регистрации пользователя не стоит
    // Просто инициализируем базовые значения
    final idDefault = await storage.read(key: SSKeys.userId.keyName);
    if (idDefault == null) {
      await storage.write(key: SSKeys.userId.keyName, value: '1');
    }

    final defaultUser = await storage.read(key: SSKeys.user.keyName);
    if (defaultUser == null) {
      await storage.write(
          key: '${SSKeys.user.keyName}/1',
          value: jsonEncode(User.defaultConstructor().toJson()),);
    }

    return component;
  }

  /// Метод, который позволяет добавить одну запись
  Future<void> add({
    required final String key,
    required final String data,
  }) async {
    await storage.write(key: key, value: data);
  }

  /// Метод, который позволяет добавить [Map]
  Future<void> addMap({
    required final String key,
    required final Map<dynamic, dynamic> data,
  }) async {
    await storage.write(key: key, value: jsonEncode(data));
  }

  /// Метод, который позволяет получить одну запись
  Future<String?> get({
    required final String key,
  }) async {
    final data = await storage.read(key: key);
    if (data != null) {
      return data;
    }
    return null;
  }

  /// Метод, который позволяет получить [Map]
  Future<Map<String, dynamic>?> getMap({
    required final String key,
  }) async {
    final data = await storage.read(key: key);
    if (data != null) {
      return jsonDecode(data);
    }
    return null;
  }

  /// Метод, который позволяет удалить одну запись
  Future<void> remove({
    required final String key,
  }) async {
    await storage.delete(key: key);
  }

  /// Метод, который позволяет удалить все записи
  Future<void> removeAll() async {
    await storage.deleteAll();
  }
}
