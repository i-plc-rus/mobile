/// Интерфейс, который описывает взаимодействие с сохранением темы
abstract interface class IActiveThemeStorage {
  /// Позволяет получить активную тему из SharedPreferences
  Future<String?> getActiveTheme();

  /// Позволяет сохранить активную тему через SharedPreferences
  Future<void> saveActiveTheme({required final String mode});
}
