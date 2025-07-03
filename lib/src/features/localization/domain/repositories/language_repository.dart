abstract class LanguageRepository {
  Future<void> saveLanguage(String languageCode);
  Future<String?> getLanguage();
}
