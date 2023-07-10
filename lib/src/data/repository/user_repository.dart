import 'dart:convert';

import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logger.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

class UserRepository {

  UserRepository();

  static Future<UserModel?> login({
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

    final response = await Api.requestLogin(params);
    if (response.success) {
      final userId = response.data['userId'];
      final cityUsers = response.data['cityUsers'];

      for (final cities in cityUsers) {
        cityIds.add(cities['cityId']);
      }

      List<String> cityIdsList = cityIds.map((i) => i.toString()).toList();
      prefs.setKeyValue(Preferences.userId, userId);
      final response1 = await Api.requestUser(userId: userId);
      prefs.setKeyValue(Preferences.token, response.data['accessToken']);
      prefs.setKeyValue(
          Preferences.refreshToken, response.data['refreshToken']);
      prefs.setKeyValue(Preferences.cityId, cityIdsList);
      // setCityIds(prefs, cityIdsList);
      return UserModel.fromJson(response1.data);
    }
    // AppBloc.messageCubit.onShow(response.message);
    UtilLogger.log('Login Response', response.message);
    // setToken(prefs, response.data);
    return null;
  }

  ///Load User
  static Future<UserModel?> loadUser() async {
    final prefs = await Preferences.openBox();
    final result = prefs.getKeyValue(Preferences.user, '');
    if (result != '') {
      return UserModel.fromJson(jsonDecode(result));
    }
    return null;
  }

  ///Fetch User
  static Future<UserModel?> fetchUser(userId) async {
    // final response = await Api.requestUser(
    //     userId: userId, accessToken: accessToken, refreshToken: refreshToken);
    final response = await Api.requestUser(userId: userId);
    if (response.success) {
      return UserModel.fromJson(response.data);
    }
    UtilLogger.log('FetchUserResponse', userId);
    return null;
  }

  static Future<void> saveUser({required UserModel user}) async {
    final prefs = await Preferences.openBox();
    return prefs.setKeyValue(
      Preferences.user,
      jsonEncode(user.toJson()),
    );
  }

  ///Delete User
  static Future<void> deleteUser() async {
    final prefs = await Preferences.openBox();
    return prefs.deleteKey(Preferences.user);
  }

  ///Fetch api register account
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
    }
    else{
      logError('Register ResponseError',response.message);
    }
    return false;
  }

  static Future<bool> forgotPassword({required String username}) async {
    final Map<String, dynamic> params = {"username": username};
    final response = await Api.requestForgotPassword(params);
    // AppBloc.messageCubit.onShow(response.message);
    if (response.success) {
      return true;
    }
    else{
      logError('Forgot Password Response Error');
    }
    return false;
  }

}
