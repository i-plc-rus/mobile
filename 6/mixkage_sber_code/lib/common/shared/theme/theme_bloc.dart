import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mixkage_sber_code/common/persistence/shared_preferences/active_theme/active_theme_storage.dart';
import 'package:mixkage_sber_code/injection_container.dart';

part 'theme_event.dart';
part 'theme_state.dart';

/// [Bloc], который отвечает за работу с темой приложения
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ThemeLoadSaved>(_loadSavedTheme);
    on<ThemeSave>(_saveTheme);
  }

  /// Метод, который загружает сохраненную тему из SharedPreferences
  Future<void> _loadSavedTheme(
    final ThemeLoadSaved event,
    final Emitter<ThemeState> emit,
  ) async {
    final activeThemeStorage = ActiveThemeStorage(getIt());
    final themeMode = await activeThemeStorage.getActiveTheme() ?? 'system';
    emit(ThemeState(activeTheme: ThemeMode.values.byName(themeMode)));
  }

  /// Метод, который сохраняет тему в SharedPreferences
  Future<void> _saveTheme(
    final ThemeSave event,
    final Emitter<ThemeState> emit,
  ) async {
    if (event.activeTheme == state.activeTheme) {
      return;
    }
    final activeThemeStorage = ActiveThemeStorage(getIt());
    await activeThemeStorage.saveActiveTheme(mode: event.activeTheme.name);
    emit(ThemeState(activeTheme: event.activeTheme));
  }
}
