import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_theme.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/cubit/application/application_state.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/theme.dart';
import 'package:heidi/src/utils/logger.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(const ApplicationLoading());

  void onSetup() async {
    final prefBox = await Preferences.openBox();

    final oldTheme = prefBox.getKeyValue(Preferences.theme, '');
    final oldFont = prefBox.getKeyValue(Preferences.font, '');
    final oldLanguage = prefBox.getKeyValue(Preferences.language, '');
    final oldDarkOption = prefBox.getKeyValue(Preferences.darkOption, '');
    final oldDomain = prefBox.getKeyValue(Preferences.domain, '');

    DarkOption? darkOption;
    String? font;
    ThemeModel? theme;

    final hasShownSplash =
        prefBox.getKeyValue(Preferences.hasShownSplash, false);

    if (hasShownSplash == false) {
      emit(const ApplicationState.loading());
      prefBox.setKeyValue(Preferences.hasShownSplash, true);
      Timer(const Duration(seconds: 4), () {
        emit(const ApplicationState.loaded());
      });
    } else {
      emit(const ApplicationState.loaded());
    }

    if (oldDomain != '') {
      Application.domain = oldDomain;
    }

    if (oldLanguage != '') {
      AppBloc.languageCubit.onUpdate(Locale(oldLanguage));
    }

    try {
      font = AppTheme.fontSupport.firstWhere((item) {
        return item == oldFont;
      });
    } catch (e) {
      UtilLogger.log("ERROR", e);
    }

    if (oldTheme != '') {
      theme = ThemeModel.fromJson(jsonDecode(oldTheme));
    }

    if (oldDarkOption != '') {
      switch (oldDarkOption) {
        case 'off':
          darkOption = DarkOption.alwaysOff;
          break;
        case 'on':
          darkOption = DarkOption.alwaysOn;
          break;
        default:
          darkOption = DarkOption.alwaysOn;
      }
    }

    AppBloc.themeCubit.onChangeTheme(
      theme: theme,
      font: font,
      darkOption: darkOption,
    );

    AppBloc.authenticateCubit.onCheck();
  }
}
