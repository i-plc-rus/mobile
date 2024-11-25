import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mixkage_sber_code/common/persistence/shared_preferences/current_locale/current_locale_storage.dart';
import 'package:mixkage_sber_code/injection_container.dart';

part 'l10n_event.dart';
part 'l10n_state.dart';

/// [Bloc], который отвечает за работу с локализацией приложения
final class L10nBloc extends Bloc<L10nEvent, L10nState> {
  L10nBloc() : super(L10nState.initial()) {
    on<L10nSave>(_saveLocale);
    on<L10nLoadSaved>(_loadSavedLocale);
  }

  /// Метод, который сохраняет локаль в SharedPreferences
  Future<void> _saveLocale(
    final L10nSave event,
    final Emitter<L10nState> emit,
  ) async {
    if (event.locale == state.locale) {
      return;
    }
    final currentLocaleStorage = CurrentLocaleStorage(getIt());
    await currentLocaleStorage.setSavedLocale(
      locale: event.locale.languageCode,
    );
    emit(L10nState(locale: event.locale));
  }

  /// Метод, который загружает ранее сохраненную локаль из SharedPreferences
  Future<void> _loadSavedLocale(
    final L10nLoadSaved event,
    final Emitter<L10nState> emit,
  ) async {
    final currentLocaleStorage = CurrentLocaleStorage(getIt());
    final languageCode = await currentLocaleStorage.getSavedLocale() ?? 'en';
    emit(L10nState(locale: Locale(languageCode)));
  }
}
