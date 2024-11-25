import 'package:mixkage_sber_code/api/data/user.dart';
import 'package:mixkage_sber_code/api/service/user_settings_cloud_interface.dart';

class InternetServiceMock implements InternetService {
  InternetServiceMock();

  @override
  Future<void> updateEmailSettings({
    final String? newEmail,
    final bool? newValue,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<void> updatePushSettings({required final bool newValue}) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<void> updateSmsSettings({
    final String? newPhone,
    final bool? newValue,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<void> updateUserName({required final String newName}) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<User> getUserById({required final int userId}) =>
      Future.value(User.defaultConstructor());
}
