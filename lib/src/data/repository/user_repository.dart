import 'dart:convert';

import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_favorite.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

class UserRepository {
  UserRepository();

  static Future<ResultApiModel?> login({
    required String username,
    required String password,
  }) async {
    final prefs = await Preferences.openBox();
    prefs.deleteKey(Preferences.cityId);
    List<int> cityIds = [];

    final Map<String, dynamic> params = {
      "username": username,
      "password": password,
    };

    try {
      final response = await Api.requestLogin(params);
      if (response.success) {

      final userId = response.data['userId'];
      final cityUsers = response.data['cityUsers'];
      for (final cities in cityUsers) {
        cityIds.add(cities['cityId']);
      }
      List<String> cityIdsList = cityIds.map((i) => i.toString()).toList();


      prefs.setKeyValue(Preferences.userId, userId);
      prefs.setKeyValue(Preferences.token, response.data['accessToken']);
      prefs.setKeyValue(
          Preferences.refreshToken, response.data['refreshToken']);
      prefs.setKeyValue(Preferences.cityId, cityIdsList);

        return response;
    } else {
      logError('Login Request Error', response.message);
      return response;
    }
    } catch (e) {
      logError('request Login Response Error', e);
    }
    return null;
  }

  static Future<UserModel?> requestUserDetails(userId)async{
    final response1 = await Api.requestUser(userId: userId);
    return UserModel.fromJson(response1.data);
  }

  static Future<UserModel?> loadUser() async {
    final prefs = await Preferences.openBox();
    final result = prefs.getKeyValue(Preferences.user, '');
    if (result != '') {
      return UserModel.fromJson(jsonDecode(result));
    }
    return null;
  }

  static Future<UserModel?> fetchUser(userId) async {
    final response = await Api.requestUser(userId: userId);
    if (response.success) {
      return UserModel.fromJson(response.data);
    }
    return null;
  }

  static Future<void> saveUser({required UserModel user}) async {
    final prefs = await Preferences.openBox();
    return prefs.setKeyValue(
      Preferences.user,
      jsonEncode(user.toJson()),
    );
  }

  static Future<void> deleteUser() async {
    final prefs = await Preferences.openBox();
    return prefs.deleteKey(Preferences.user);
  }

  static Future<bool> register(
      {required String username,
      required String firstname,
      required String lastname,
      required String password,
      required String email,
      required String confirmPassword,
      required String role}) async {
    final Map<String, dynamic> params = {
      "firstname": firstname,
      "lastname": lastname,
      "username": username,
      "password": password,
      "email": email,
      "confirmPassword": confirmPassword,
      "role": "3"
    };
    final response = await Api.requestRegister(params);
    if (response.success) {
      return true;
    } else {
      logError('Register Response Error', response.message);
    }
    return false;
  }

  static Future<bool> forgotPassword({required String username}) async {
    final Map<String, dynamic> params = {"username": username};
    final response = await Api.requestForgotPassword(params);
    if (response.success) {
      return true;
    } else {
      logError('Forgot Password Response Error');
    }
    return false;
  }

  static Future<bool> changeProfile({
    required String username,
    required String firstname,
    required String lastname,
    required String email,
    required String url,
    required String description,
    String? image,
  }) async {
    Map<String, dynamic> params = {
      "username": username,
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "website": url,
      "description": description,
    };
    if (image != null) {
      params['image'] = image;
    }
    final prefs = await Preferences.openBox();
    final userId = prefs.getKeyValue(Preferences.userId, '');
    final response = await Api.requestChangeProfile(params, userId);
    if (response.success) {
      return true;
    }
    return false;
  }

  static Future<bool> changePassword({
    required String currentPassword,
    required String password,
  }) async {
    final prefs = await Preferences.openBox();
    final userId = prefs.getKeyValue(Preferences.userId, 0);
    final Map<String, dynamic> params = {
      "currentPassword": currentPassword,
      "newPassword": password
    };
    final response = await Api.requestChangeProfile(params, userId);
    logError('Change Password Response', response.message);
    if (response.success) {
      return true;
    }
    return false;
  }

  static Future<List<FavoriteModel>> loadFavorites(userId) async {
    final favoriteList = <FavoriteModel>[];
    final response = await Api.requestFavorites(userId);
    if (response.success) {
      final responseData = response.data;
      for (final data in responseData) {
        favoriteList.add(FavoriteModel(
            data['id'], data['userId'], data['cityId'], data['listingId']));
      }
      return favoriteList;
    } else {}
    return favoriteList;
  }
}
