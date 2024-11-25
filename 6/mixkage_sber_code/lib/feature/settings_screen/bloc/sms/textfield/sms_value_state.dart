part of 'sms_value_cubit.dart';

@immutable
sealed class SmsValueState {
  const SmsValueState();
}

final class LoadingValueSmsState extends SmsValueState {
  const LoadingValueSmsState();
}

final class LoadedValueSmsState extends SmsValueState {
  final String number;

  const LoadedValueSmsState(this.number);
}

final class SmsValueErrorState extends SmsValueState {
  final bool isCrit;

  const SmsValueErrorState(this.isCrit);
}
