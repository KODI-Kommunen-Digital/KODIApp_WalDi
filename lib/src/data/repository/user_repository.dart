import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_favorite.dart';
import 'package:heidi/src/data/model/model_favorites_detail_list.dart';
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
    //prefs.deleteKey(Preferences.cityId);
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
        //List<String> cityIdsList = cityIds.map((i) => i.toString()).toList();

        prefs.setKeyValue(Preferences.userId, userId);
        prefs.setKeyValue(Preferences.token, response.data['accessToken']);
        prefs.setKeyValue(
            Preferences.refreshToken, response.data['refreshToken']);
        //prefs.setKeyValue(Preferences.cityId, cityIdsList);

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

  static Future<UserModel?> requestUserDetails(userId) async {
    final response1 = await Api.requestUser(userId: userId);
    return UserModel.fromJson(response1.data);
  }

  static Future<bool> doesUserExist(userId) async {
    final response = await Api.requestUser(userId: userId);
    return response.success;
  }

  static Future<UserModel?> loadUser() async {
    final prefs = await Preferences.openBox();
    final result = prefs.getKeyValue(Preferences.user, '');
    if (result != '') {
      return UserModel.fromJson(jsonDecode(result));
    }
    return null;
  }

  static Future<int> getLoggedUserId() async {
    final prefs = await Preferences.openBox();
    final userId = prefs.getKeyValue(Preferences.userId, 0);
    return userId;
  }

  static Future<UserModel?> fetchUser(userId) async {
    final response = await Api.requestUser(userId: userId);
    if (response.success) {
      return UserModel.fromJson(response.data);
    }
    return null;
  }

  static Future<UserModel?> getUserDetails(userId, cityId) async {
    final prefs = await Preferences.openBox();
    final cityIdPref = prefs.getKeyValue(Preferences.cityId, 0);
    final response = await Api.getUserDetails(userId, cityId == 0 ? cityIdPref : cityId);
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

  static Future<ResultApiModel> register(
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
      return response;
    } else {
      logError('Register Response Error', response.message);
    }
    return response;
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
      FormData? pickedFile = prefs.getPickedFile();
      final responseImageUpload = await Api.requestUploadImage(pickedFile);
      if(responseImageUpload.success){
        return true;
      }
      else{
        logError('Image Upload Error Response', response.message);

      }
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

  static Future<List<FavoriteDetailsModel>> loadFavoritesListDetail(
      userId) async {
    final Map<String, dynamic> params = {};
    final favoriteList = <FavoriteDetailsModel>[];
    List<CategoryModel> categories = [];
    late CategoryModel categoryDetails;
    final response = await Api.requestFavorites(userId);
    if (response.success) {
      final responseData = response.data;

      final categoryResponse = await Api.requestCategory(params);
      if (categoryResponse.success) {
        categories = List.from(categoryResponse.data ?? []).map((item) {
          return CategoryModel.fromJson(item);
        }).toList();
      }
      for (final data in responseData) {
        final favoriteListResponse = await Api.requestFavoritesDetailsList(
            data['cityId'], data['listingId']);

        if (favoriteListResponse.success) {
          categoryDetails = categories.singleWhere((element) =>
              element.id == favoriteListResponse.data['categoryId']);

          favoriteList.add(FavoriteDetailsModel(
            favoriteListResponse.data['id'],
            favoriteListResponse.data['userId'],
            favoriteListResponse.data['title'],
            favoriteListResponse.data['place'],
            categoryDetails.title,
            favoriteListResponse.data['description'],
            favoriteListResponse.data['media'],
            favoriteListResponse.data['categoryId'],
            favoriteListResponse.data['subcategoryId'] ?? 0,
            favoriteListResponse.data['address'] ?? '',
            favoriteListResponse.data['email'],
            favoriteListResponse.data['phone'],
            favoriteListResponse.data['website'],
            favoriteListResponse.data['price'],
            favoriteListResponse.data['discountPrice'],
            favoriteListResponse.data['logo'],
            favoriteListResponse.data['statusId'],
            favoriteListResponse.data['sourceId'],
            favoriteListResponse.data['longitude'],
            favoriteListResponse.data['latitude'],
            favoriteListResponse.data['villageId'],
            favoriteListResponse.data['startDate'],
            favoriteListResponse.data['endDate'],
            favoriteListResponse.data['createdAt'],
            favoriteListResponse.data['pdf'] ?? '',
            data['cityId'],
          ));
        } else {
          logError('Favorite Response Failed', favoriteListResponse.message);
        }
      }
    } else {
      logError('Request Favorite Response Failed', response.message);
    }
    return favoriteList;
  }
}
