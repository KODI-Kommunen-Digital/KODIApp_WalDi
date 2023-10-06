import 'dart:async';

import 'package:dio/dio.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/remote/api/http_manager.dart';
import 'package:heidi/src/utils/asset.dart';
import 'package:heidi/src/utils/configs/preferences.dart';

class Api {
  static const String login = "/users/login";
  static const String user = "/users/";
  static const String register = "/users/register";
  static const String forgotPassword = "/users/forgotPassword";
  static const String changePassword = "/users/resetPassword";
  static const String categories = "/categories";
  static const String categoriesCount = "/categories/listingsCount";
  static const String list = "listings";
  static const String uploadImage = "/users/4/imageUpload";
  static const String cities = "/cities";
  static const String listings = "/listings?statusId=1";
  static const String contact = "/contactUs";
  static const String forum = "/forumapi/cities/1/forums";
  static const String hasForum = "/cities?hasForum=true";

  static Future<ResultApiModel> requestLogin(params) async {
    try {
      final result =
          await HTTPManager(forum: false).post(url: login, data: params);

      return ResultApiModel.fromJson(result);
    } catch (e) {
      return await HTTPManager(forum: false).post(url: login, data: params);
    }
  }

  static Future<ResultApiModel> requestFavorites(userId) async {
    final result =
        await HTTPManager(forum: false).get(url: '/users/$userId/favorites/');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestUserListings(userId) async {
    final result =
        await HTTPManager(forum: false).get(url: '/users/$userId/listings/');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestForum(cityId) async {
    ///TODO: CHANGE THIS HARDCODED CITYID
    const filepath = "/cities/1/forums";
    final result = await HTTPManager(forum: true).get(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestUsersForum(userId) async {
    final filepath = "/users/$userId/forums";
    final result = await HTTPManager(forum: true).get(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getGroupMemberRequests(userId) async {
    final filepath = "/users/$userId/memberRequests";
    final result = await HTTPManager(forum: true).get(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestToJoinGroup(forumId, cityId) async {
    ///TODO: CHANGE THIS HARDCODED CITYID
    final filepath = "/cities/1/forums/$forumId/memberRequests";
    final result = await HTTPManager(forum: true).post(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> removeUserFromGroup(
      forumId, cityId, memberId) async {
    ///TODO: CHANGE THIS HARDCODED CITYID
    final filepath = "/cities/1/forums/$forumId/members/$memberId";
    final result = await HTTPManager(forum: true).delete(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestGroupPosts(forumId, cityId) async {
    ///TODO: CHANGE THIS HARDCODED CITYID
    final filepath = "/cities/1/forums/$forumId/posts";
    final result = await HTTPManager(forum: true).get(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getGroupMembers(forumId, cityId) async {
    ///TODO: CHANGE THIS HARDCODED CITYID
    final filepath = "/cities/1/forums/$forumId/members";
    final result = await HTTPManager(forum: true).get(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestHasForum() async {
    final result = await HTTPManager(forum: false).get(url: hasForum);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestFavoritesDetailsList(
      cityId, listingId) async {
    final result = await HTTPManager(forum: false)
        .get(url: '/cities/$cityId/listings/$listingId');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestForgotPassword(params) async {
    Map<String, dynamic> result = await HTTPManager(forum: false).post(
      url: forgotPassword,
      data: params,
      loading: true,
    );
    result['message'] = result['status'] ?? result['msg'];
    return ResultApiModel.fromJson(result);
  }

  ///Register account
  static Future<ResultApiModel> requestRegister(params) async {
    final result = await HTTPManager(forum: false).post(
      url: register,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Change Profile
  static Future<ResultApiModel> requestChangeProfile(params, userId) async {
    final filePath = '/users/$userId';
    final result = await HTTPManager(forum: false).patch(
      url: filePath,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  ///change password
  static Future<ResultApiModel> requestChangePassword(params) async {
    final result = await HTTPManager(forum: false).post(
      url: changePassword,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestUser({required userId}) async {
    final filePath = '/users/$userId';
    final result = await HTTPManager(forum: false).get(url: filePath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getUserDetails(userId, cityId) async {
    final filePath = '/users/$userId?cityId=$cityId&cityUser=true';
    final result = await HTTPManager(forum: false).get(
      url: filePath,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Get Category
  static Future<ResultApiModel> requestCategory(params) async {
    final result = await UtilAsset.loadJson("assets/data/category.json");
    // final result = await HTTPManager(forum: false).get(url: categories, params: params);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestSubmitCategory() async {
    final result = await HTTPManager(forum: false).get(url: categories);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestSubmitSubCategory(
      {required categoryId}) async {
    final filePath = '/categories/$categoryId/subcategories';
    final result = await HTTPManager(forum: false).get(url: filePath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestCategoryCount(int? cityId) async {
    String url = categoriesCount;
    if (cityId != null) {
      url = "$url?cityId=$cityId";
    }
    final result = await HTTPManager(forum: false).get(url: url);
    return ResultApiModel.fromJson(result);
  }

  ///Get Home Categories
  static Future<ResultApiModel> requestHomeCategory() async {
    final result = await UtilAsset.loadJson("assets/data/category.json");
    // final result = await HTTPManager(forum: false).get(url: categories);
    return ResultApiModel.fromJson(result);
  }

  ///Get Cities
  static Future<ResultApiModel> requestCities() async {
    // final result = await UtilAsset.loadJson("assets/data/locations.json");
    final result = await HTTPManager(forum: false).get(url: cities);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestVillages({required cityId}) async {
    final filePath = '/cities/$cityId/villages';
    final result = await HTTPManager(forum: false).get(url: filePath);
    return ResultApiModel.fromJson(result);
  }

  ///Get Submit Cities
  static Future<ResultApiModel> requestSubmitCities() async {
    final result = await HTTPManager(forum: false).get(url: cities);
    return ResultApiModel.fromJson(result);
  }

  ///Get Recent Listings
  static Future<ResultApiModel> requestRecentListings(params) async {
    final listings = "/listings?statusId=1&pageNo=$params&pageSize=19";
    final result = await HTTPManager(forum: false).get(url: listings);
    return ResultApiModel.fromJson(result);
  }

  ///Get Home Slider Images
  static Future<ResultApiModel> requestSliderImages() async {
    final result = await UtilAsset.loadJson("assets/data/sliders.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get ProductDetail
  static Future<ResultApiModel> requestProduct(cityId, id) async {
    final filePath = '/cities/$cityId/listings/$id';
    final result = await HTTPManager(forum: false).get(url: filePath);
    return ResultApiModel.fromJson(result);
  }

  ///Save Wish List
  static Future<ResultApiModel> requestAddWishList(userId, params) async {
    final String addWishList = "/users/$userId/favorites/";
    final result =
        await HTTPManager(forum: false).post(url: addWishList, data: params);
    return ResultApiModel.fromJson(result);
  }

  ///Save Product
  static Future<ResultApiModel> requestSaveProduct(cityId, params) async {
    final filePath = '/cities/$cityId/listings';
    final prefs = await Preferences.openBox();
    FormData? pickedFile = prefs.getPickedFile();
    final result = await HTTPManager(forum: false).post(
      url: filePath,
      data: params,
      loading: true,
    );
    final id = result['id'];
    if (pickedFile != null) {
      Api.requestListingUploadMedia(id, cityId, pickedFile);
    }
    return ResultApiModel.fromJson(result);
  }

  ///Save Forum
  static Future<ResultApiModel> requestSaveForum(cityId, params) async {
    final filePath = '/cities/$cityId/forums';
    final prefs = await Preferences.openBox();
    FormData? pickedFile = prefs.getPickedFile();
    final result = await HTTPManager(forum: true).post(
      url: filePath,
      data: params,
      loading: true,
    );
    final forumId = result['id'];
    if (pickedFile != null) {
      Api.requestForumImageUpload(cityId, forumId, pickedFile);
    }
    return ResultApiModel.fromJson(result);
  }

  ///Save Post
  static Future<ResultApiModel> requestSavePost(cityId, fId, params) async {
    final filePath = '/cities/$cityId/forums/$fId/posts';
    final prefs = await Preferences.openBox();
    FormData? pickedFile = prefs.getPickedFile();
    final result = await HTTPManager(forum: true).post(
      url: filePath,
      data: params,
      loading: true,
    );
    final postId = result['id'];
    if (pickedFile != null) {
      Api.requestPostImageUpload(cityId, fId, postId, pickedFile);
    }
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestEditProduct(
      cityId, listingId, params, bool isImageChanged) async {
    final filePath = '/cities/$cityId/listings/$listingId';
    final prefs = await Preferences.openBox();
    FormData? pickedFile = prefs.getPickedFile();
    final result = await HTTPManager(forum: false).patch(
      url: filePath,
      data: params,
      loading: true,
    );
    if (isImageChanged) {
      if (pickedFile!.files.isNotEmpty) {
        await Api.requestListingUploadMedia(listingId, cityId, pickedFile);
      }
    }
    return ResultApiModel.fromJson(result);
  }

  ///Remove Wish List
  static Future<ResultApiModel> requestRemoveWishList(
      userId, int listingId) async {
    final String removeWishList = "/users/$userId/favorites/$listingId";
    final result = await HTTPManager(forum: false).delete(
      url: removeWishList,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> deletePdf(cityId, listingId) async {
    final result = await HTTPManager(forum: false).delete(
      url: '/cities/$cityId/listings/$listingId/pdfDelete',
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> deleteImage(cityId, listingId) async {
    final result = await HTTPManager(forum: false).delete(
      url: '/cities/$cityId/listings/$listingId/imageDelete',
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> deleteUserList(cityId, int listingId) async {
    final String removeList = "/cities/$cityId/listings/$listingId";
    final result = await HTTPManager(forum: false).delete(
      url: removeList,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Get Product List
  static Future<ResultApiModel> requestCatList(params, pageNo) async {
    if (params == 3) {
      var list =
          '/listings?categoryId=$params&statusId=1&pageNo=$pageNo&pageSize=19&sortByStartDate=true';
      final result = await HTTPManager(forum: false).get(url: list);
      return ResultApiModel.fromJson(result);
    } else {
      var list =
          '/listings?categoryId=$params&statusId=1&pageNo=$pageNo&pageSize=19';
      final result = await HTTPManager(forum: false).get(url: list);
      return ResultApiModel.fromJson(result);
    }
  }

  static Future<ResultApiModel> requestSubCatList(params, pageNo) async {
    var list =
        '/listings?subCategoryId=10&categoryId=1&statusId=1&pageNo=$pageNo&pageSize=19';
    final result = await HTTPManager(forum: false).get(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestLocList(params, pageNo) async {
    var list = '/listings?cityId=$params&statusId=1&pageNo=$pageNo&pageSize=19';
    final result = await HTTPManager(forum: false).get(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> contactUs(params) async {
    final result = await HTTPManager(forum: false).post(
      url: contact,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestUploadImage(formData) async {
    final prefs = await Preferences.openBox();
    final userId = prefs.getKeyValue(Preferences.userId, '');
    var filepath = '/users/$userId/imageUpload';
    var result = await HTTPManager(forum: false).post(
      url: filepath,
      formData: formData,
    );

    final convertResponse = {"success": result['id'] != null, "data": result};
    return ResultApiModel.fromJson(convertResponse);
  }

  static Future<ResultApiModel> requestListingUploadMedia(
      listingId, cityId, pickedFile) async {
    var filePath = '';

    var firstFileEntry = pickedFile?.files[0];
    if (firstFileEntry?.key == 'pdf') {
      filePath = '/cities/$cityId/listings/$listingId/pdfUpload';
    } else if (firstFileEntry?.key == 'image') {
      filePath = '/cities/$cityId/listings/$listingId/imageUpload';
    }
    var result = await HTTPManager(forum: false).post(
      url: filePath,
      formData: pickedFile,
    );
    final convertResponse = {"success": result['id'] != null, "data": result};
    return ResultApiModel.fromJson(convertResponse);
  }

  static Future<ResultApiModel> requestForumImageUpload(
      cityId, forumId, pickedFile) async {
    var filePath = '';
    filePath = '/cities/$cityId/forums/$forumId/imageUpload';
    var result = await HTTPManager(forum: true).post(
      url: filePath,
      formData: pickedFile,
    );
    final convertResponse = {"success": result['id'] != null, "data": result};
    return ResultApiModel.fromJson(convertResponse);
  }

  static Future<ResultApiModel> requestPostImageUpload(
      cityId, forumId, postId, pickedFile) async {
    var filePath = '';
    filePath = '/cities/$cityId/forums/$forumId/posts/$postId/imageUpload';
    var result = await HTTPManager(forum: true).post(
      url: filePath,
      formData: pickedFile,
    );
    final convertResponse = {"success": result['id'] != null, "data": result};
    return ResultApiModel.fromJson(convertResponse);
  }

  static Future<ResultApiModel> deleteUserAccount(userId) async {
    final String deleteAccount = "/users/$userId";
    final result = await HTTPManager(forum: false).delete(url: deleteAccount);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestPostComments(
      cityId, forumId, postId, page) async {
    var list =
        '/cities/$cityId/forums/$forumId/posts/$postId/comments?pageNo=$page&pageSize=19';
    final result = await HTTPManager(forum: true).get(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> addPostComments(
      cityId, forumId, postId, params) async {
    var list = '/cities/$cityId/forums/$forumId/posts/$postId/comments';
    final result = await HTTPManager(forum: true).post(
      url: list,
      data: params,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> addPostCommentsReply(
      cityId, forumId, postId, params) async {
    var list = '/cities/$cityId/forums/$forumId/posts/$postId/comments';
    final result = await HTTPManager(forum: true).post(
      url: list,
      data: params,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestPostCommentsReplies(
      cityId, forumId, postId, parentId, pageNo) async {
    var list =
        '/cities/$cityId/forums/$forumId/posts/$postId/comments?pageNo=$pageNo&pageSize=19&parentId=$parentId';
    final result = await HTTPManager(forum: true).get(url: list);
    return ResultApiModel.fromJson(result);
  }

  ///Singleton factory
  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal();
}
