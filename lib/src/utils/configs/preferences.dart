import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class Preferences {
  final Box<dynamic> _box;

  static const _preferencesBox = '_preferencesBox';
  static const hasShownSplash  = 'hasShownSplash';
  static const String domain = 'domain';
  static const String reviewIntro = 'review';
  static const String user = 'user';
  static const String language = 'language';
  static const String notification = 'notification';
  static const String theme = 'theme';
  static const String textScaleFactor = 'textScaleFactor';
  static const String darkOption = 'darkOption';
  static const String font = 'font';
  static const String setting = 'setting';
  static const String search = 'search';
  static const String token = 'token';
  static const String refreshToken = 'refreshToken';
  static const String userId = 'userId';
  static const String cityId = 'cityId';
  static const sessionTokenKey = '_sessionTokenKey';
  static const _pickedFileKey = 'pickedFile';
  static const String categoryId = 'categoryId';
  static const String villageId = 'villageId';
  static const String subCategoryId = 'subCategoryId';
  static const String type = 'type';
  static const String path = 'path';
  static const String categoryCount = "categoryCount";

  Preferences._(this._box);

  static Future<Preferences> openBox() async {
    final box = await Hive.openBox<dynamic>(_preferencesBox);
    return Preferences._(box);
  }

  Future<void> setKeyValue(String key, dynamic value) => _setValue(key, value);

  dynamic getKeyValue(String key, dynamic defaultValue) => _getValue(key, defaultValue);

  FormData? getPickedFile() => _getValue<FormData?>(_pickedFileKey, null);

  Future<void> setPickedFile(FormData pickedFile) =>
      _setValue<FormData>(_pickedFileKey, pickedFile);

  Future<void> deleteKey(String key) async{
    await _box.delete(key);
  }

  T _getValue<T>(dynamic key, T defaultValue) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> _setValue<T>(dynamic key, T value) => _box.put(key, value);

  Future<void> setRestoredPurchasedProductsHistory({
    required bool isRestored,
  }) =>
      _setValue(
        'isRestored',
        isRestored,
      );

  bool getRestoredPurchasedProductsHistory() => _getValue('isRestored', false);
}
