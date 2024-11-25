import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mixkage_sber_code/api/service/user_settings_cloud_interface.dart';
import 'package:mixkage_sber_code/api/service/user_settings_local.dart';
import 'package:mixkage_sber_code/common/persistence/secure_storage/secure_storage.dart';
import 'package:mixkage_sber_code/common/persistence/secure_storage/ss_keys.dart';
import 'package:mixkage_sber_code/injection_container.dart';

part 'sms_notify_state.dart';

class SmsNotifyCheckBoxCubit extends Cubit<SmsNotifyState> {
  final InternetService _iserv;

  SmsNotifyCheckBoxCubit(this._iserv) : super(const LoadingSmsState());

  Future<void> setValue(final bool value) async {
    try {
      try {
        await _iserv.updateSmsSettings(newValue: value);
      } catch (e) {
        emit(const SmsErrorState(false));
      } finally {
        await getIt<InternetServiceLocal>().updateSmsSettings(newValue: value);
        emit(LoadedSmsState(value));
      }
    } on Object {
      emit(const SmsErrorState(true));
    }
  }

  Future<void> getValue() async {
    try {
      final int userId = int.parse(
          (await getIt<SecureStorage>().get(key: SSKeys.userId.keyName))!,);
      try {
        final user = await _iserv.getUserById(userId: userId);
        await getIt<InternetServiceLocal>().updateAllUser(newUser: user);
      } catch (e) {
        emit(const SmsErrorState(false));
      } finally {
        final user =
            await getIt<InternetServiceLocal>().getUserById(userId: userId);
        emit(LoadedSmsState(user.notificationSettings.sms.enabled));
      }
    } on Object {
      emit(const SmsErrorState(true));
    }
  }
}
