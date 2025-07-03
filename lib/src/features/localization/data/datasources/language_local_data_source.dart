import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LanguageLocalDataSource {
  Future<void> saveLanguage(String languageCode);
  Future<String?> getLanguage();
}

const _kLanguageKey = 'selected_language';

@LazySingleton(as: LanguageLocalDataSource)
class LanguageLocalDataSourceImpl implements LanguageLocalDataSource {
  final SharedPreferences _sharedPreferences;

  LanguageLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<String?> getLanguage() async {
    return _sharedPreferences.getString(_kLanguageKey);
  }

  @override
  Future<void> saveLanguage(String languageCode) async {
    await _sharedPreferences.setString(_kLanguageKey, languageCode);
  }
}
