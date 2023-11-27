import 'dart:io';

import 'package:dio/dio.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_comment.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';
import 'package:heidi/src/data/model/model_forum_status.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_request_member.dart';
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
    if (cityId == 0) {
      cityId = 1;
    }
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
      final requestForumResponse = await Api.requestForum(cityId, pageNo);
      if (requestForumResponse.success) {
        final groupList =
            List.from(requestForumResponse.data ?? []).map((item) {
          return ForumGroupModel.fromJson(
            item,
          );
        }).toList();
        if (userId != 0) {
          String forumIds =
              groupList.map((item) => item.id.toString()).join(', ');
          final forumWithStatusResponse =
              await Api.requestForumStatus(userId, cityId, forumIds);

          final forumStatusList =
              List.from(forumWithStatusResponse.data ?? []).map((item) {
            return ForumStatusModel.fromJson(
              item,
            );
          }).toList();

          return [
            userId,
            groupList,
            requestForumResponse.pagination,
            forumStatusList,
          ];
        } else {
          return [
            userId,
            groupList,
          ];
        }
      }
    } else {
      logError('Forum Group List Error');
    }
    return null;
  }

  Future<List?> loadMyForumsList({required pageNo}) async {
    int userId = prefs.getKeyValue(Preferences.userId, 0);
    final usersJoinedForumResponse = await Api.requestUsersForum(userId);

    if (usersJoinedForumResponse.success) {
      final groupList =
          List.from(usersJoinedForumResponse.data ?? []).map((item) {
        return ForumGroupModel.fromJson(
          item,
        );
      }).toList();

      return [
        userId,
        groupList,
      ];
    }

    return null;
  }

  Future<int> getLoggedInUserId() async {
    final prefs = await Preferences.openBox();
    final userId = prefs.getKeyValue(Preferences.userId, 0);
    return userId;
  }

  Future<ResultApiModel?> requestToJoinGroup(forumId) async {
    final cityId = prefs.getKeyValue(Preferences.cityId, 0);
    final response = await Api.requestToJoinGroup(forumId, cityId);
    if (response.success) {
      return response;
    } else {
      logError('Request To Join Group Response Failed', response.message);
      return null;
    }
  }

  Future<ResultApiModel?> requestGroupDetails(forumId, cityId) async {
    int prefCityId = prefs.getKeyValue(Preferences.cityId, 0);
    // if (cityId == 0) {
    //   cityId = 1;
    // }
    final response = await Api.requestGroupDetails(
        forumId, cityId != 0 ? cityId : prefCityId);
    if (response.success) {
      return response;
    } else {
      logError('Request Group Detail Response Failed', response.message);
      return null;
    }
  }

  Future<bool> removeUserFromGroup(forumId, memberId) async {
    final cityId = prefs.getKeyValue(Preferences.cityId, 0);
    final response = await Api.removeUserFromGroup(forumId, cityId, memberId);
    if (response.success) {
      return true;
    } else {
      logError('Request To Remove User From Group Response Failed',
          response.message);
      return false;
    }
  }

  Future<ResultApiModel?> requestGroupPosts(forumId, cityId) async {
    final cityIdPref = prefs.getKeyValue(Preferences.cityId, 0);
    final response =
        await Api.requestGroupPosts(forumId, cityId == 0 ? cityIdPref : cityId);
    if (response.success) {
      return response;
    } else {
      logError('Request Group Detail Response Failed', response.message);
      return null;
    }
  }

  Future<ResultApiModel?> deleteGroupPost(forumId, cityId, postId) async {
    final cityIdPref = prefs.getKeyValue(Preferences.cityId, 0);
    final response = await Api.deleteGroupPost(
        forumId, cityId == 0 ? cityIdPref : cityId, postId);
    if (response.success) {
      return response;
    } else {
      logError('Request Group Detail Response Failed', response.message);
      return null;
    }
  }

  Future<ResultApiModel?> reportGroupPosts(
      forumId, postId, reason, cityId) async {
    final cityIdPref = prefs.getKeyValue(Preferences.cityId, 0);
    final Map<String, dynamic> params = {"Reason": reason};
    final response = await Api.reportGroupPosts(
        forumId, cityId == 0 ? cityIdPref : cityId, postId, params);
    if (response.success) {
      return response;
    } else {
      logError('Report Group Post Response Failed', response.message);
      return null;
    }
  }

  Future<ResultApiModel?> getGroupMembers(forumId, cityId) async {
    final cityIdPref = prefs.getKeyValue(Preferences.cityId, 0);
    final response =
        await Api.getGroupMembers(forumId, cityId == 0 ? cityIdPref : cityId);
    if (response.success) {
      return response;
    } else {
      logError('Request Group Members Response Failed', response.message);
      return null;
    }
  }

  Future<ResultApiModel?> getMemberRequests(forumId, cityId) async {
    final cityIdPref = prefs.getKeyValue(Preferences.cityId, 0);
    final response = await Api.getMemberRequests(
      forumId,
      cityId == 0 ? cityIdPref : cityId,
    );
    if (response.success) {
      return response;
    } else {
      logError('Request Member Requests Response Failed', response.message);
      return null;
    }
  }

  Future<ResultApiModel?> acceptMemberRequests(
    forumId,
    memberRequestId,
    cityId,
  ) async {
    Map<String, dynamic> params = {
      "accept": true,
    };
    final cityIdPref = prefs.getKeyValue(Preferences.cityId, 0);
    final response = await Api.acceptMemberRequests(
        forumId, cityId == 0 ? cityIdPref : cityId, memberRequestId, params);
    if (response.success) {
      return response;
    } else {
      logError(
          'Request Accept Member Requests Response Failed', response.message);
      return null;
    }
  }

  Future<ResultApiModel?> rejectMemberRequests(
      forumId, memberRequestId, reason, cityId) async {
    Map<String, dynamic> params = {
      "accept": false,
      "reason": reason,
    };
    final cityIdPref = prefs.getKeyValue(Preferences.cityId, 0);
    final response = await Api.rejectMemberRequests(
        forumId, cityId == 0 ? cityIdPref : cityId, memberRequestId, params);
    if (response.success) {
      return response;
    } else {
      logError(
          'Request Reject Member Requests Response Failed', response.message);
      return null;
    }
  }

  Future<ResultApiModel?> requestMakeUserAdmin(forumId, memberId) async {
    final cityId = prefs.getKeyValue(Preferences.cityId, 0);
    final Map<String, dynamic> params = {"isAdmin": 1};
    final response =
        await Api.requestMakeUserAdmin(cityId, forumId, memberId, params);
    if (response.success) {
      return response;
    } else {
      logError('Request make User Admin Failed', response.message);
      return null;
    }
  }

  Future<bool> requestRemoveAdmin(forumId, memberId, cityId) async {
    final prefCityId = prefs.getKeyValue(Preferences.cityId, 0);
    final Map<String, dynamic> params = {"isAdmin": 0};
    final response = await Api.requestRemoveAdmin(
        cityId == 0 ? prefCityId : cityId, forumId, memberId, params);
    if (response.success) {
      return true;
    } else {
      logError('Request Remove User Admin Failed', response.message);
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
    final response = await Api.requestCities();
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
    FormData? pickedFile = prefs.getPickedFile();
    final response = await Api.requestSaveForum(cityId, params);
    if (response.success) {
      final forumId = response.id;
      if (pickedFile != null) {
        await Api.requestForumImageUpload(cityId, forumId, pickedFile);
      }
      prefs.deleteKey('pickedFile');
    }
    return response;
  }

  Future<ResultApiModel?> requestDeleteForum(
    forumId,
    cityId,
  ) async {
    int cityIdPref = prefs.getKeyValue(Preferences.cityId, 0);
    final response = await Api.requestDeleteForum(
        cityId == 0 ? cityIdPref : cityId, forumId);
    if (response.success) {
      return response;
    } else {
      logError('Delete Forum Failed', response.message);
      return null;
    }
  }

  Future<ResultApiModel> editForum(
    String title,
    String description,
    String? city,
    String? type,
    isImageChanged,
    forumId,
    String createdDate,
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
      "id": forumId,
      "forumName": title,
      "createdAt": createdDate,
      "description": description,
      "image": image,
      "isPrivate": isPrivate,
      "cityId": cityId,
    };
    final response = await Api.requestEditForum(cityId, forumId, params);

    if (response.success) {
      if (isImageChanged) {
        final prefs = await Preferences.openBox();
        FormData? pickedFile = prefs.getPickedFile();
        if (pickedFile != null) {
          await Api.requestForumImageUpload(cityId, forumId, pickedFile);
        }
      }
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
    final cityIdPref = prefs.getKeyValue(Preferences.cityId, 0);

    Map<String, dynamic> params = {
      "cityId": cityId == 0 ? cityIdPref : cityId,
      "description": description,
      "title": title,
      "image": image,
    };
    final response = await Api.requestSavePost(
        cityId == 0 ? cityIdPref : cityId, forumId, params);
    if (response.success) {
      final postId = response.id;
      final prefs = await Preferences.openBox();
      FormData? pickedFile = prefs.getPickedFile();
      if (pickedFile != null) {
        await Api.requestPostImageUpload(
            cityId == 0 ? cityIdPref : cityId, forumId, postId, pickedFile);
      }
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

  Future<List<CommentModel>> getPostComments(
      int forumId, int postId, page, cityId) async {
    int cityIdPref = prefs.getKeyValue(Preferences.cityId, 0);
    final response = await Api.requestPostComments(
        cityId != 0 ? cityId : cityIdPref, forumId, postId, page);
    if (response.success) {
      final List<CommentModel> comments = [];
      for (final jsonComment in response.data) {
        final comment = CommentModel.fromJson(jsonComment);
        comments.add(comment);
      }
      return comments;
    } else {
      logError('Get Post Comments Failed', response.message);
      return [];
    }
  }

  Future<ResultApiModel> addPostComments(
      int forumId, int postId, String comment, cityId) async {
    int cityIdPref = prefs.getKeyValue(Preferences.cityId, 0);
    Map<String, dynamic> params = {
      "comment": comment,
    };
    final response = await Api.addPostComments(
        cityId != 0 ? cityId : cityIdPref, forumId, postId, params);
    if (response.success) {
      return response;
    } else {
      logError('Add Post Comment Failed', response.message);
      return response;
    }
  }

  Future<ResultApiModel> addPostCommentsReply(
      int forumId, int postId, String comment, int parentId, cityId) async {
    int cityIdPref = prefs.getKeyValue(Preferences.cityId, 0);
    Map<String, dynamic> params = {
      "comment": comment,
      "parentId": parentId,
    };
    final response = await Api.addPostComments(
        cityId != 0 ? cityId : cityIdPref, forumId, postId, params);
    if (response.success) {
      return response;
    } else {
      logError('Get Post Comments Reply Failed', response.message);
      return response;
    }
  }

  Future<List<CommentModel>> getPostCommentsReplies(
      int forumId, int postId, int parentId, int pageNo, cityId) async {
    int cityIdPref = prefs.getKeyValue(Preferences.cityId, 0);
    final response = await Api.requestPostCommentsReplies(
        cityId != 0 ? cityId : cityIdPref, forumId, postId, parentId, pageNo);
    if (response.success) {
      final List<CommentModel> replies = [];
      for (final jsonReply in response.data) {
        final reply = CommentModel.fromJson(jsonReply);
        replies.add(reply);
      }
      return replies;
    } else {
      logError('Get Comment Replies Failed', response.message);
      return [];
    }
  }
}
