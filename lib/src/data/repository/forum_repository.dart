import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_favorites_detail_list.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_request_member.dart';
import 'package:heidi/src/data/model/model_users_joined_group.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logger.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:http_parser/http_parser.dart';

class ForumRepository {
  final Preferences prefs;

  ForumRepository(this.prefs);

  Future<List?> loadForumsList({required pageNo}) async {
    final hasForum = await Api.requestHasForum();
    int cityId = prefs.getKeyValue(Preferences.cityId, 0);
    int userId = prefs.getKeyValue(Preferences.userId, 0);

    bool hasForumFlag = false;

    if (hasForum.success) {
      for (var forumData in hasForum.data) {
        if (forumData['hasForum'] == 1) {
          hasForumFlag = true;
          break;
        }
      }
    }

    if (hasForumFlag) {
      final requestForumResponse = await Api.requestForum(cityId);
      if (requestForumResponse.success) {
        final groupList =
            List.from(requestForumResponse.data ?? []).map((item) {
          return ForumGroupModel.fromJson(
            item,
          );
        }).toList();
        final usersJoinedForumResponse = await Api.requestUsersForum(userId);
        final userJoinedList =
            List.from(usersJoinedForumResponse.data ?? []).map((item) {
          return UserJoinedGroupsModel.fromJson(
            item,
          );
        }).toList();

        return [groupList, requestForumResponse.pagination, userJoinedList];
      }
    } else {
      logError('Forum Group List Error');
    }
    return null;
  }

  Future<bool> requestToJoinGroup(forumId) async {
    final cityId = prefs.getKeyValue(Preferences.cityId, 0);
    final response = await Api.requestToJoinGroup(forumId, cityId);
    if (response.success) {
      return true;
    } else {
      logError('Request To Join Group Response Failed', response.message);
      return false;
    }
  }

  Future<List<RequestMemberModel>?> getGroupMemberRequests() async {
    final userId = prefs.getKeyValue(Preferences.userId, 0);
    final requestMemberList = <RequestMemberModel>[];
    final response = await Api.getGroupMemberRequests(userId);
    if (response.success) {
      for (final list in response.data) {
        requestMemberList.add(RequestMemberModel(
          forumId: list['forumId'],
          userId: list['userId'],
          statusId: list['statusId'],
          createdAt: list['createdAt'],
          updatedAt: list['updatedAt'],
          id: list['id'],
          reason: list['reason'],
        ));
      }
      return requestMemberList;
    } else {
      logError(
          'Request To Get Group Members Response Failed', response.message);
    }
    return null;
  }

  static Future<ResultApiModel?> uploadImage(File image, forumGroup) async {
    final prefs = await Preferences.openBox();
    List<String> parts = image.path.split('.');
    String imageExtension = parts.last;
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path,
          filename: image.path,
          contentType: MediaType('image', imageExtension)),
    });
    if (forumGroup) {
      await prefs.setPickedFile(formData);
    }
    return null;
  }

  static Future<bool> addWishList(int? userId, ProductModel items) async {
    final Map<String, dynamic> params = {};
    params['cityId'] = items.cityId;
    params['listingId'] = items.id;
    final response = await Api.requestAddWishList(userId, params);
    if (response.success) {
      return true;
    } else {
      logError('Add Wishlist Response Fail', response.message);
      return false;
    }
  }

  static Future<bool> removeWishList(int? userId, int listingId) async {
    final response = await Api.requestRemoveWishList(userId, listingId);
    if (response.success) {
      logError('Remove Wishlist Response Success', response.message);
      return true;
    } else {
      logError('Remove Wishlist Response Failed', response.message);
      return false;
    }
  }

  Future<bool> deleteUserList(int? cityId, int listingId) async {
    final response = await Api.deleteUserList(cityId, listingId);
    if (response.success) {
      return true;
    } else {
      logError('Remove UserList Response Failed', response.message);
      return false;
    }
  }

  static Future<ResultApiModel?> uploadPdf(File pdf) async {
    final prefs = await Preferences.openBox();
    final formData = FormData.fromMap({
      'pdf': await MultipartFile.fromFile(pdf.path,
          filename: pdf.path, contentType: MediaType('application', 'pdf')),
    });
    await prefs.setPickedFile(formData);
    return null;
  }

  Future<void> deletePdf(cityId, listingId) async {
    await Api.deletePdf(cityId, listingId);
  }

  Future<void> deleteImage(cityId, listingId) async {
    await Api.deleteImage(cityId, listingId);
  }

  static Future<ProductModel?> loadProduct(cityId, id) async {
    final response = await Api.requestProduct(cityId, id);
    if (response.success) {
      UtilLogger.log('ErrorReason', response.data);
      return ProductModel.fromJson(response.data, setting: Application.setting);
    } else {
      logError('Product Request Response', response.message);
    }
    return null;
  }

  Future<List<FavoriteDetailsModel>> loadUserListings(id) async {
    int userId;
    final userList = <FavoriteDetailsModel>[];
    if (id == 0) {
      userId = prefs.getKeyValue('userId', 0);
    } else {
      userId = id;
    }

    final listResponse = await Api.requestUserListings(userId);
    if (listResponse.success) {
      final responseData = listResponse.data;
      if (responseData != []) {
        for (final data in responseData) {
          userList.add(FavoriteDetailsModel(
            data['id'],
            data['userId'],
            data['title'] ?? '',
            data['place'] ?? '',
            '',
            data['description'] ?? '',
            data['media'] ?? '',
            data['categoryId'] ?? 0,
            data['subcategoryId'] ?? 0,
            data['address'] ?? '',
            data['email'] ?? '',
            data['phone'] ?? '',
            data['website'] ?? '',
            data['price'] ?? 0,
            data['discountPrice'] ?? 0,
            data['logo'] ?? '',
            data['statusId'] ?? 0,
            data['sourceId'] ?? 0,
            data['longitude'] ?? 0.0,
            data['latitude'] ?? 0.0,
            data['villageId'] ?? 0,
            data['startDate'] ?? '',
            data['endDate'] ?? '',
            data['createdAt'] ?? '',
            data['pdf'] ?? '',
            data['cityId'] ?? 0,
          ));
        }
      }
      return userList;
    } else {
      logError('Load User Listings Error');
    }
    return userList;
  }

  Future<ResultApiModel> requestVillages(value) async {
    final cityId = prefs.getKeyValue(Preferences.cityId, '');
    final response = await Api.requestVillages(cityId: cityId);
    var jsonCategory = response.data;
    final item = jsonCategory.firstWhere((item) => item['name'] == value);
    final itemId = item['id'];
    final villageId = itemId;
    prefs.setKeyValue(Preferences.villageId, villageId);
    return response;
  }

  void clearVillageId() async {
    prefs.deleteKey(Preferences.villageId);
  }

  void clearCityId() async {
    prefs.deleteKey(Preferences.cityId);
  }

  void clearCategoryId() async {
    prefs.deleteKey(Preferences.categoryId);
  }

  Future<void> clearImagePath() async {
    prefs.deleteKey(Preferences.path);
  }

  Future<ResultApiModel> loadCities() async {
    final response = await Api.requestSubmitCities();
    var jsonCity = response.data;
    final selectedCity = jsonCity.first['name'];
    loadVillages(selectedCity);
    return response;
  }

  Future<ResultApiModel> loadForumCities() async {
    final response = await Api.requestHasForum();
    return response;
  }

  Future<ResultApiModel> loadCategory() async {
    final response = await Api.requestSubmitCategory();
    var jsonCategory = response.data;
    final categoryId = jsonCategory.first['id'];
    prefs.setKeyValue(Preferences.categoryId, categoryId as int);
    return response;
  }

  Future<ResultApiModel> loadSubCategory(value) async {
    final response = await Api.requestSubmitCategory();
    var jsonCategory = response.data;
    final item = jsonCategory.firstWhere((item) => item['name'] == value);
    final itemId = item['id'];
    final categoryId = itemId;
    final requestSubmitResponse =
        await Api.requestSubmitSubCategory(categoryId: categoryId);
    final jsonSubCategory = requestSubmitResponse.data;
    if (!jsonSubCategory.isEmpty) {
      final subCategoryId = jsonSubCategory.first['id'];
      prefs.setKeyValue(Preferences.subCategoryId, subCategoryId as int);
    }
    return requestSubmitResponse;
  }

  Future<ResultApiModel> saveForum(
    String title,
    String description,
    String? city,
    String? type,
  ) async {
    final cityId = await getCityId(city);
    final image = prefs.getKeyValue(Preferences.path, null);
    bool isPrivate = false;
    if (type == 'public') {
      isPrivate = false;
    } else if (type == 'private') {
      isPrivate = true;
    }

    Map<String, dynamic> params = {
      "cityId": cityId,
      "description": description,
      "forumName": title,
      "image": image,
      "isPrivate": isPrivate,
      "removeImage": false,
      "villageId": 0,
      "visibility": "",
    };
    final response = await Api.requestSaveForum(cityId, params);
    if (response.success) {
      prefs.deleteKey('pickedFile');
    }
    return response;
  }

  Future<ResultApiModel> savePost(
    String title,
    String description,
    int? cityId,
  ) async {
    final forumId = 9;
    final image = prefs.getKeyValue(Preferences.path, null);

    Map<String, dynamic> params = {
      "cityId": cityId,
      "description": description,
      "title": title,
      "image": image,
    };
    final response = await Api.requestSavePost(1, forumId, params);
    if (response.success) {
      prefs.deleteKey('pickedFile');
    }
    return response;
  }

  Future<ResultApiModel> editProduct(
    int? listingId,
    int? categoryId,
    cityId,
    String title,
    String description,
    String place,
    CategoryModel? country,
    CategoryModel? state,
    CategoryModel? city,
    int? statusId,
    int? sourceId,
    String address,
    String? zipcode,
    String? phone,
    String? email,
    String? website,
    String? status,
    String? startDate,
    String? endDate,
    String? price,
    bool isImageChanged,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  ) async {
    final subCategoryId = prefs.getKeyValue(Preferences.subCategoryId, null);
    final villageId = prefs.getKeyValue(Preferences.villageId, null);
    final userId = prefs.getKeyValue(Preferences.userId, '');
    final media = prefs.getKeyValue(Preferences.path, null);

    String? combinedStartDateTime;
    String? combinedEndDateTime;

    if (startDate != null) {
      String formattedTime;
      if (startTime!.hour < 10) {
        formattedTime =
            "${startTime.periodOffset}${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}";
        combinedStartDateTime = "${startDate.trim()}T$formattedTime";
      } else {
        formattedTime =
            "${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}";
        combinedStartDateTime = "${startDate.trim()}T$formattedTime";
      }
    }

    if (endDate != null) {
      String formattedTime;
      if (endTime!.hour < 10) {
        formattedTime =
            "${endTime.periodOffset}${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}";
        combinedEndDateTime = "${endDate.trim()}T$formattedTime";
      } else {
        formattedTime =
            "${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}";
        combinedEndDateTime = "${endDate.trim()}T$formattedTime";
      }
    }

    Map<String, dynamic> params = {
      "userId": userId,
      "title": title,
      "place": place,
      "description": description,
      "media": '',
      "categoryId": categoryId,
      "address": address,
      "email": email,
      "phone": phone,
      "website": website,
      "price": 100, //dummy data
      "discountPrice": 100, //dummy data
      "logo": media,
      "statusId": 1, //dummy data
      "sourceId": 1, //dummy data
      "longitude": 245.65, //dummy data
      "latitude": 22.456, //dummy data
      "villageId": villageId ?? 0,
      "cityId": cityId,
      "startDate": combinedStartDateTime,
      "endDate": combinedEndDateTime,
      "subCategoryId": subCategoryId,
    };
    final response =
        await Api.requestEditProduct(cityId, listingId, params, isImageChanged);
    return response;
  }

  Future<void> setImagePrefs(imagePath) async {
    await prefs.setKeyValue(Preferences.path, imagePath);
  }

  Future<ResultApiModel> loadVillages(value) async {
    final response = await Api.requestSubmitCities();
    var jsonCity = response.data;
    final item = jsonCity.firstWhere((item) => item['name'] == value);
    final itemId = item['id'];
    final cityId = itemId;
    //prefs.setKeyValue(Preferences.cityId, cityId);
    final requestVillageResponse = await Api.requestVillages(cityId: cityId);
    if (!requestVillageResponse.data.isEmpty) {
      prefs.setKeyValue(Preferences.villageId,
          requestVillageResponse.data.first['id'] as int);
    }
    return requestVillageResponse;
  }

  void setCategoryId(value) async {
    final response = await Api.requestSubmitCategory();
    var jsonCategory = response.data;
    final item = jsonCategory.firstWhere((item) => item['name'] == value);
    final itemId = item['id'];
    final categoryId = itemId;
    prefs.setKeyValue(Preferences.categoryId, categoryId);
  }

  Future<int> getCityId(cityName) async {
    final response = await Api.requestSubmitCities();
    var jsonCategory = response.data;
    final item = jsonCategory.firstWhere((item) => item['name'] == cityName);
    final itemId = item['id'];
    final cityId = itemId;
    return cityId;
  }

  Future<int> getCategoryId() async {
    return await prefs.getKeyValue(Preferences.categoryId, 0);
  }

  void getSubCategoryId(value) async {
    final categoryId = prefs.getKeyValue(Preferences.categoryId, '');
    final response = await Api.requestSubmitSubCategory(categoryId: categoryId);
    var jsonCategory = response.data;
    final item = jsonCategory.firstWhere((item) => item['name'] == value);
    final itemId = item['id'];
    final subCategoryId = itemId;
    prefs.setKeyValue(Preferences.subCategoryId, subCategoryId);
  }

  void clearSubCategory() async {
    prefs.deleteKey(Preferences.subCategoryId);
  }
}
