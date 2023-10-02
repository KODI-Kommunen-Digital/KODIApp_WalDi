import 'dart:io';

import 'package:dio/dio.dart';
import 'package:heidi/src/data/model/model.dart';
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
    final requestMemberList = <RequestMemberModel>[];

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

        final requestGroupRequestResponse =
            await Api.getGroupMemberRequests(userId);
        if (requestGroupRequestResponse.success) {
          for (final list in requestGroupRequestResponse.data) {
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
        } else {
          logError('Request To Get Group Members Response Failed',
              requestGroupRequestResponse.message);
        }

        final userJoinedList =
            List.from(usersJoinedForumResponse.data ?? []).map((item) {
          return UserJoinedGroupsModel.fromJson(
            item,
          );
        }).toList();

        return [
          groupList,
          requestForumResponse.pagination,
          userJoinedList,
          requestMemberList
        ];
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

  Future<bool> removeUserFromGroup(forumId, memberId) async {
    final cityId = prefs.getKeyValue(Preferences.cityId, 0);
    final response = await Api.removeUserFromGroup(forumId, cityId, memberId) ;
    if (response.success) {
      return true;
    } else {
      logError('Request To Join Group Response Failed', response.message);
      return false;
    }
  }

  Future<ResultApiModel?> requestGroupPosts(forumId) async {
    final cityId = prefs.getKeyValue(Preferences.cityId, 0);
    final response = await Api.requestGroupPosts(forumId, cityId);
    if (response.success) {
      return response;
    } else {
      logError('Request Group Post Response Failed', response.message);
      return null;
    }
  }

  Future<ResultApiModel?> getGroupMembers(forumId) async {
    final cityId = prefs.getKeyValue(Preferences.cityId, 0);
    final response = await Api.getGroupMembers(forumId, cityId);
    if (response.success) {
      return response;
    } else {
      logError('Request Group Post Response Failed', response.message);
      return null;
    }
  }

  Future<ResultApiModel?> requestMakeUserAdmin(forumId, memberId) async {
    final cityId = prefs.getKeyValue(Preferences.cityId, 0);
    final Map<String, dynamic> params = {"isAdmin": 1};
    final response = await Api.requestMakeUserAdmin(cityId, forumId, memberId, params);
    if (response.success) {
      return response;
    } else {
      logError('Request make User Admin Failed', response.message);
      return null;
    }
  }

  Future<ResultApiModel?> requestRemoveAdmin(forumId, memberId) async {
    final cityId = prefs.getKeyValue(Preferences.cityId, 0);
    final Map<String, dynamic> params = {"isAdmin": 0};
    final response = await Api.requestRemoveAdmin(cityId, forumId, memberId, params);
    if (response.success) {
      return response;
    } else {
      logError('Request Remove User Admin Failed', response.message);
      return null;
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

  Future<bool> deleteUserList(int? cityId, int listingId) async {
    final response = await Api.deleteUserList(cityId, listingId);
    if (response.success) {
      return true;
    } else {
      logError('Remove UserList Response Failed', response.message);
      return false;
    }
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

  void clearCityId() async {
    prefs.deleteKey(Preferences.cityId);
  }

  Future<void> clearImagePath() async {
    prefs.deleteKey(Preferences.path);
  }

  Future<ResultApiModel> loadForumCities() async {
    final response = await Api.requestHasForum();
    return response;
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
    int? forumId,
  ) async {
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

  Future<void> setImagePrefs(imagePath) async {
    await prefs.setKeyValue(Preferences.path, imagePath);
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
}
