part of 'l10n_bloc.dart';

/// Состояние для работы с [L10nBloc]
///
/// Существует в единственном экземпляре и перезаписывается.
/// Такой подход необходим для корректной работы приложения.
final class L10nState extends Equatable {
  final Locale locale;

  const L10nState({
    required this.locale,
  });

  factory L10nState.initial() => const L10nState(locale: Locale('en', 'US'));

  L10nState copyWith(final Locale? locale) =>
      L10nState(locale: locale ?? this.locale);

  @override
  List<Object?> get props => [locale];
}
