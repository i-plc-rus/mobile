import 'package:dio/dio.dart';
import 'package:mixkage_sber_code/api/data/user.dart';
import 'package:mixkage_sber_code/api/service/user_settings_cloud_interface.dart';
import 'package:mixkage_sber_code/common/config/config.dart';
import 'package:mixkage_sber_code/common/log/logger.dart';
import 'package:mixkage_sber_code/common/persistence/secure_storage/secure_storage.dart';
import 'package:mixkage_sber_code/common/persistence/secure_storage/ss_keys.dart';

class InternetServiceDio implements InternetService {
  final Dio _client;
  final SecureStorage _sstorage;

  InternetServiceDio(this._client, this._sstorage);

  @override
  Future<User> getUserById({required final int userId}) async {
    try {
      final int userId =
          int.parse((await _sstorage.get(key: SSKeys.userId.keyName))!);

      final response = await _client.get(
        '${Config.apiUri}users/$userId',
      );

      return User.fromJson(response.data);
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateEmailSettings({
    final String? newEmail,
    final bool? newValue,
  }) async {
    try {
      final int userId =
          int.parse((await _sstorage.get(key: SSKeys.userId.keyName))!);

      final User user = await getUserById(userId: userId);

      await _client.patch(
        '${Config.apiUri}users/$userId',
        data: user
            .copyWith(
              notificationSettings: user.notificationSettings.copyWith(
                email: user.notificationSettings.email
                    .copyWith(address: newEmail, enabled: newValue),
              ),
            )
            .toJson(),
      );
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updatePushSettings({required final bool newValue}) async {
    try {
      final int userId =
          int.parse((await _sstorage.get(key: SSKeys.userId.keyName))!);

      final User user = await getUserById(userId: userId);

      await _client.patch(
        '${Config.apiUri}users/$userId',
        data: user
            .copyWith(
              notificationSettings: user.notificationSettings.copyWith(
                push:
                    user.notificationSettings.push.copyWith(enabled: newValue),
              ),
            )
            .toJson(),
      );
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateSmsSettings({
    final String? newPhone,
    final bool? newValue,
  }) async {
    try {
      final int userId =
          int.parse((await _sstorage.get(key: SSKeys.userId.keyName))!);

      final User user = await getUserById(userId: userId);

      await _client.patch(
        '${Config.apiUri}users/$userId',
        data: user
            .copyWith(
              notificationSettings: user.notificationSettings.copyWith(
                sms: user.notificationSettings.sms
                    .copyWith(number: newPhone, enabled: newValue),
              ),
            )
            .toJson(),
      );
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateUserName({required final String newName}) async {
    try {
      final int userId =
          int.parse((await _sstorage.get(key: SSKeys.userId.keyName))!);

      final user = await getUserById(userId: userId);

      await _client.patch(
        '${Config.apiUri}users/$userId',
        data: user.copyWith(name: newName).toJson(),
      );
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }
}
