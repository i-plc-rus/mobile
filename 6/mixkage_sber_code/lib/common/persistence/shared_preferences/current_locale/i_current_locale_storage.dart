/// Интерфейс, который описывает взаимодействие с сохранением локали
abstract interface class ICurrentLocaleStorage {
  /// Позволяет получить локаль из SharedPreferences
  Future<String?> getSavedLocale();

  /// Позволяет сохранить локаль через SharedPreferences
  Future<void> setSavedLocale({required final String locale});
}
