import 'package:mixkage_sber_code/api/data/user.dart';

abstract interface class InternetService {
  Future<User> getUserById({required final int userId});
  Future<void> updateUserName({required final String newName});
  Future<void> updateSmsSettings(
      {final String? newPhone, final bool? newValue,});
  Future<void> updatePushSettings({required final bool newValue});
  Future<void> updateEmailSettings(
      {final String? newEmail, final bool? newValue,});
}
