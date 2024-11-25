part of 'theme_bloc.dart';

/// Состояние для работы с [ThemeBloc]
///
/// Существует в единственном экземпляре и перезаписывается.
/// Такой подход необходим для корректной работы приложения.
final class ThemeState extends Equatable {
  final ThemeMode activeTheme;

  const ThemeState({
    required this.activeTheme,
  });

  factory ThemeState.initial() =>
      const ThemeState(activeTheme: ThemeMode.system);

  ThemeState copyWith(final ThemeMode? activeTheme) =>
      ThemeState(activeTheme: activeTheme ?? this.activeTheme);

  @override
  List<Object?> get props => [activeTheme];
}
