part of 'theme_bloc.dart';

/// Родительский эвент для работы с [ThemeBloc]
sealed class ThemeEvent extends Equatable {
  const ThemeEvent();
}

/// Эвент, который отвечает за сохранение темы
final class ThemeSave extends ThemeEvent {
  final ThemeMode activeTheme;

  const ThemeSave({
    required this.activeTheme,
  });

  @override
  List<Object?> get props => [activeTheme];
}

/// Эвент, который загружает сохраненную ранее тему
final class ThemeLoadSaved extends ThemeEvent {
  const ThemeLoadSaved();

  @override
  List<Object?> get props => [];
}
