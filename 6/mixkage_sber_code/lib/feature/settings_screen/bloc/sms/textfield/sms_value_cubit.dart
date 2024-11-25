import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mixkage_sber_code/api/service/user_settings_cloud_interface.dart';
import 'package:mixkage_sber_code/api/service/user_settings_local.dart';
import 'package:mixkage_sber_code/common/persistence/secure_storage/secure_storage.dart';
import 'package:mixkage_sber_code/common/persistence/secure_storage/ss_keys.dart';
import 'package:mixkage_sber_code/injection_container.dart';

part 'sms_value_state.dart';

class SmsValueCubit extends Cubit<SmsValueState> {
  final InternetService _iserv;

  SmsValueCubit(this._iserv) : super(const LoadingValueSmsState());

  Future<void> setValue(final String number) async {
    try {
      try {
        await _iserv.updateSmsSettings(newPhone: number);
      } catch (e) {
        emit(const SmsValueErrorState(false));
      } finally {
        await getIt<InternetServiceLocal>().updateSmsSettings(newPhone: number);
        emit(LoadedValueSmsState(number));
      }
    } on Object {
      emit(const SmsValueErrorState(true));
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
        emit(const SmsValueErrorState(false));
      } finally {
        final user =
            await getIt<InternetServiceLocal>().getUserById(userId: userId);
        emit(LoadedValueSmsState(user.notificationSettings.sms.number ?? ''));
      }
    } on Object {
      emit(const SmsValueErrorState(true));
    }
  }
}
