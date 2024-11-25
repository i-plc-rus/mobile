part of 'email_value_cubit.dart';

@immutable
sealed class EmailValueState {
  const EmailValueState();
}

final class LoadingValueEmailState extends EmailValueState {
  const LoadingValueEmailState();
}

final class LoadedValueEmailState extends EmailValueState {
  final String email;

  const LoadedValueEmailState(this.email);
}

final class EmailValueErrorState extends EmailValueState {
  final bool isCrit;

  const EmailValueErrorState(this.isCrit);
}
