/// Хранит все ключи для shared_prefernces
enum SPKeys {
  /// Ключ, по которому хранится текущая активная тема
  activeTheme('active_theme'),

  /// Ключ, по которому хранится текущая активная локаль
  currentLocale('current_locale');

  final String keyName;

  const SPKeys(this.keyName);
}
