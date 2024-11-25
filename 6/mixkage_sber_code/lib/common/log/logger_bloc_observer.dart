import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart' as l;

/// Проводник соединяющий [l.Logger] и [BlocObserver]
///
/// Позволяет записывать изменение состояния в BLoC через логгер
final class LoggerBlocObserver extends BlocObserver {
  final l.Logger logger;

  const LoggerBlocObserver(this.logger);

  @override
  void onCreate(final BlocBase bloc) {
    super.onCreate(bloc);
    logger.i('BLoC | onCreate ${bloc.runtimeType}');
  }

  @override
  void onEvent(final Bloc bloc, final Object? event) {
    super.onEvent(bloc, event);
    logger.i('BLoC | onEvent ${bloc.runtimeType} with event $event');
  }

  @override
  void onChange(final BlocBase bloc, final Change change) {
    super.onChange(bloc, change);
    logger.i(
      'BLoC | onChange ${bloc.runtimeType} '
      'from ${change.currentState} to ${change.nextState}',
    );
  }

  @override
  void onTransition(final Bloc bloc, final Transition transition) {
    super.onTransition(bloc, transition);
    logger.i('BLoC | onTransition ${bloc.runtimeType}: $transition');
  }

  @override
  void onError(
    final BlocBase bloc,
    final Object error,
    final StackTrace stackTrace,
  ) {
    super.onError(bloc, error, stackTrace);
    logger.e(
      'BLoC | onError ${bloc.runtimeType}',
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void onClose(final BlocBase bloc) {
    super.onClose(bloc);
    logger.i('BLoC | onClose ${bloc.runtimeType}');
  }
}
