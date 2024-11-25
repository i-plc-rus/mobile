part of 'push_notify_cubit.dart';

@immutable
sealed class PushNotifyState {
  const PushNotifyState();
}

final class LoadingPushState extends PushNotifyState {
  const LoadingPushState();
}

final class LoadedPushState extends PushNotifyState {
  final bool isEnable;

  const LoadedPushState(this.isEnable);
}

final class PushErrorState extends PushNotifyState {
  final bool isCrit;

  const PushErrorState(this.isCrit);
}
