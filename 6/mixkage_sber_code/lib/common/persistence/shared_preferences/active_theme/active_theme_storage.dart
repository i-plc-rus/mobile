import 'package:mixkage_sber_code/common/persistence/shared_preferences/active_theme/i_active_theme_storage.dart';
import 'package:mixkage_sber_code/common/persistence/shared_preferences/sp_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActiveThemeStorage implements IActiveThemeStorage {
  final SharedPreferences _prefs;

  const ActiveThemeStorage(this._prefs);

  @override
  Future<String?> getActiveTheme() async =>
      _prefs.getString(SPKeys.activeTheme.keyName);

  @override
  Future<void> saveActiveTheme({required final String mode}) async {
    await _prefs.setString(SPKeys.activeTheme.keyName, mode);
  }
}
