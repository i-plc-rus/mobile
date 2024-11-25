part of 'email_notify_cubit.dart';

@immutable
sealed class EmailNotifyState {
  const EmailNotifyState();
}

final class LoadingEmailState extends EmailNotifyState {
  const LoadingEmailState();
}

final class LoadedEmailState extends EmailNotifyState {
  final bool isEnable;

  const LoadedEmailState(this.isEnable);
}

final class EmailErrorState extends EmailNotifyState {
  final bool isCrit;

  const EmailErrorState(this.isCrit);
}
