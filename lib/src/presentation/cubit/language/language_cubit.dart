import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/utils/configs/language.dart';
import 'package:heidi/src/utils/configs/preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(AppLanguage.defaultLanguage);

  Future<void> onUpdate(Locale locale) async {
    emit(locale);

    final prefBox = await Preferences.openBox();
    prefBox.setKeyValue(
      Preferences.language,
      locale.languageCode,
    );
  }
}
