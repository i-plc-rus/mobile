import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mixkage_sber_code/api/service/user_settings_cloud_interface.dart';
import 'package:mixkage_sber_code/api/service/user_settings_local.dart';
import 'package:mixkage_sber_code/common/persistence/secure_storage/secure_storage.dart';
import 'package:mixkage_sber_code/common/persistence/secure_storage/ss_keys.dart';
import 'package:mixkage_sber_code/injection_container.dart';

part 'email_value_state.dart';

class EmailValueCubit extends Cubit<EmailValueState> {
  final InternetService _iserv;

  EmailValueCubit(this._iserv) : super(const LoadingValueEmailState());

  Future<void> setValue(final String newEmail) async {
    try {
      try {
        await _iserv.updateEmailSettings(newEmail: newEmail);
      } catch (e) {
        emit(const EmailValueErrorState(false));
      } finally {
        await getIt<InternetServiceLocal>()
            .updateEmailSettings(newEmail: newEmail);
        emit(LoadedValueEmailState(newEmail));
      }
    } on Object {
      emit(const EmailValueErrorState(true));
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
        emit(const EmailValueErrorState(false));
      } finally {
        final user =
            await getIt<InternetServiceLocal>().getUserById(userId: userId);
        emit(LoadedValueEmailState(
            user.notificationSettings.email.address ?? '',),);
      }
    } on Object {
      emit(const EmailValueErrorState(true));
    }
  }
}
