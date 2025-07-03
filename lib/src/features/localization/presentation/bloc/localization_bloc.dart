import 'package:bluebank_app/src/features/localization/domain/repositories/language_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'localization_event.dart';
part 'localization_state.dart';
part 'localization_bloc.freezed.dart';

@injectable
class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final LanguageRepository _languageRepository;

  LocalizationBloc(this._languageRepository)
    : super(const LocalizationState.initial()) {
    on<_LoadLanguage>(_onLoadLanguage);
    on<_ChangeLanguage>(_onChangeLanguage);
  }

  Future<void> _onLoadLanguage(
    _LoadLanguage event,
    Emitter<LocalizationState> emit,
  ) async {
    final languageCode = await _languageRepository.getLanguage();
    if (languageCode != null) {
      emit(LocalizationState.loaded(Locale(languageCode)));
    } else {
      emit(const LocalizationState.loaded(Locale('en')));
    }
  }

  Future<void> _onChangeLanguage(
    _ChangeLanguage event,
    Emitter<LocalizationState> emit,
  ) async {
    await _languageRepository.saveLanguage(event.languageCode);
    emit(LocalizationState.loaded(Locale(event.languageCode)));
  }
}
