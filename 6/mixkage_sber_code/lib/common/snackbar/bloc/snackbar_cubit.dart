import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'snackbar_state.dart';

class SnackBarNotifyCubit extends Cubit<SnackBarNotifyState> {
  SnackBarNotifyCubit() : super(const DefaultSnackBarState());

  void showSnackBar(final String message) {
    emit(ShowSnackBarState(message));
  }
}
