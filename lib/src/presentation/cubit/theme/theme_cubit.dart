import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_theme.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/theme.dart';

class ThemeState {
  final ThemeModel theme;
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final String font;
  final DarkOption darkOption;
  final double? textScaleFactor;

  ThemeState({
    required this.theme,
    required this.lightTheme,
    required this.darkTheme,
    required this.font,
    this.textScaleFactor,
    required this.darkOption,
  });

  factory ThemeState.fromDefault() {
    return ThemeState(
      theme: AppTheme.defaultTheme,
      lightTheme: AppTheme.getTheme(
        theme: AppTheme.defaultTheme,
        brightness: Brightness.light,
        font: AppTheme.defaultFont,
      ),
      darkTheme: AppTheme.getTheme(
        theme: AppTheme.defaultTheme,
        brightness: Brightness.dark,
        font: AppTheme.defaultFont,
      ),
      font: AppTheme.defaultFont,
      darkOption: AppTheme.darkThemeOption,
    );
  }
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.fromDefault());

  void onChangeTheme({
    ThemeModel? theme,
    String? font,
    DarkOption? darkOption,
    double? textScaleFactor,
  }) async {
    ///Setup Theme with setting darkOption
    final currentState = AppBloc.themeCubit.state;
    theme ??= currentState.theme;
    font ??= currentState.font;
    darkOption ??= currentState.darkOption;
    textScaleFactor ??= currentState.textScaleFactor ?? 1.0;
    ThemeState themeState;
    final prefBox = await Preferences.openBox();

    ///Dark mode option
    switch (darkOption) {
      case DarkOption.dynamic:
        prefBox.setKeyValue(Preferences.darkOption, 'dynamic');
        themeState = ThemeState(
          theme: theme,
          lightTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.light,
            font: font,
          ),
          darkTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.dark,
            font: font,
          ),
          font: font,
          darkOption: darkOption,
          textScaleFactor: textScaleFactor,
        );
        break;
      case DarkOption.alwaysOn:
        prefBox.setKeyValue(Preferences.darkOption, 'on');
        themeState = ThemeState(
          theme: theme,
          lightTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.dark,
            font: font,
          ),
          darkTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.dark,
            font: font,
          ),
          font: font,
          darkOption: darkOption,
          textScaleFactor: textScaleFactor,
        );
        break;
      case DarkOption.alwaysOff:
        prefBox.setKeyValue(Preferences.darkOption, 'off');
        themeState = ThemeState(
          theme: theme,
          lightTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.light,
            font: font,
          ),
          darkTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.light,
            font: font,
          ),
          font: font,
          darkOption: darkOption,
          textScaleFactor: textScaleFactor,
        );
        break;
    }

    ///Theme
    prefBox.setKeyValue(
      Preferences.theme,
      jsonEncode(themeState.theme.toJson()),
    );

    ///Font
    prefBox.setKeyValue(Preferences.font, themeState.font);

    ///Text Scale
    if (themeState.textScaleFactor != null) {
      prefBox.setKeyValue(
        Preferences.textScaleFactor,
        textScaleFactor,
      );
    }

    ///Notify
    emit(themeState);
  }
}
