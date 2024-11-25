import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mixkage_sber_code/api/service/user_settings_cloud_interface.dart';
import 'package:mixkage_sber_code/api/service/user_settings_local.dart';
import 'package:mixkage_sber_code/common/persistence/secure_storage/secure_storage.dart';
import 'package:mixkage_sber_code/common/persistence/secure_storage/ss_keys.dart';
import 'package:mixkage_sber_code/injection_container.dart';

part 'push_notify_state.dart';

class PushNotifyCheckBoxCubit extends Cubit<PushNotifyState> {
  final InternetService _iserv;

  PushNotifyCheckBoxCubit(this._iserv) : super(const LoadingPushState());

  Future<void> setValue(final bool value) async {
    try {
      try {
        await _iserv.updatePushSettings(newValue: value);
      } catch (e) {
        emit(const PushErrorState(false));
      } finally {
        await getIt<InternetServiceLocal>().updatePushSettings(newValue: value);
        emit(LoadedPushState(value));
      }
    } on Object {
      emit(const PushErrorState(true));
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
        emit(const PushErrorState(false));
      } finally {
        final user =
            await getIt<InternetServiceLocal>().getUserById(userId: userId);
        emit(LoadedPushState(user.notificationSettings.push.enabled));
      }
    } on Object {
      emit(const PushErrorState(true));
    }
  }
}
