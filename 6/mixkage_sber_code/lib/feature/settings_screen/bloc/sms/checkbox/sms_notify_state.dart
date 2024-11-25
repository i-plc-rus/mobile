part of 'sms_notify_cubit.dart';

@immutable
sealed class SmsNotifyState {
  const SmsNotifyState();
}

final class LoadingSmsState extends SmsNotifyState {
  const LoadingSmsState();
}

final class LoadedSmsState extends SmsNotifyState {
  final bool isEnable;

  const LoadedSmsState(this.isEnable);
}

final class SmsErrorState extends SmsNotifyState {
  final bool isCrit;

  const SmsErrorState(this.isCrit);
}
