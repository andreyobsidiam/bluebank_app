import 'package:bluebank_app/src/features/localization/data/datasources/language_local_data_source.dart';
import 'package:bluebank_app/src/features/localization/domain/repositories/language_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LanguageRepository)
class LanguageRepositoryImpl implements LanguageRepository {
  final LanguageLocalDataSource _localDataSource;

  LanguageRepositoryImpl(this._localDataSource);

  @override
  Future<String?> getLanguage() {
    return _localDataSource.getLanguage();
  }

  @override
  Future<void> saveLanguage(String languageCode) {
    return _localDataSource.saveLanguage(languageCode);
  }
}
