part of 'localization_bloc.dart';

@freezed
class LocalizationEvent with _$LocalizationEvent {
  const factory LocalizationEvent.loadLanguage() = _LoadLanguage;
  const factory LocalizationEvent.changeLanguage(String languageCode) =
      _ChangeLanguage;
}
