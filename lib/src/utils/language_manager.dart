import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LanguageManager extends ChangeNotifier {
  Locale _locale = const Locale('en', 'US');

  Locale get locale => _locale;

  void changeLanguage(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  String translate(String key) {
    return Intl.message(
      key,
      locale: _locale.languageCode,
      name: key,
    );
  }
}
