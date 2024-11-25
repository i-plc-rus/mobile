import 'package:mixkage_sber_code/common/persistence/shared_preferences/current_locale/i_current_locale_storage.dart';
import 'package:mixkage_sber_code/common/persistence/shared_preferences/sp_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class CurrentLocaleStorage implements ICurrentLocaleStorage {
  final SharedPreferences _prefs;

  const CurrentLocaleStorage(this._prefs);

  @override
  Future<String?> getSavedLocale() async =>
      _prefs.getString(SPKeys.currentLocale.keyName);

  @override
  Future<void> setSavedLocale({required final String locale}) async {
    await _prefs.setString(SPKeys.currentLocale.keyName, locale);
  }
}
