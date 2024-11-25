part of 'l10n_bloc.dart';

/// Родительский эвент для работы с [L10nBloc]
sealed class L10nEvent extends Equatable {
  const L10nEvent();
}

/// Эвент, который отвечает за сохранение текущей локали
final class L10nSave extends L10nEvent {
  final Locale locale;

  const L10nSave({
    required this.locale,
  });

  @override
  List<Object?> get props => [locale];
}

/// Эвент, который отвечает за загрузку ранее сохраненной локали
final class L10nLoadSaved extends L10nEvent {
  const L10nLoadSaved();

  @override
  List<Object?> get props => [];
}
