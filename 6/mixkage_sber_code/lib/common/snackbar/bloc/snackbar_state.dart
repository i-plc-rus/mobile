part of 'snackbar_cubit.dart';

@immutable
sealed class SnackBarNotifyState {
  const SnackBarNotifyState();
}

final class DefaultSnackBarState extends SnackBarNotifyState {
  const DefaultSnackBarState();
}

final class ShowSnackBarState extends SnackBarNotifyState {
  final String message;

  const ShowSnackBarState(this.message);
}
