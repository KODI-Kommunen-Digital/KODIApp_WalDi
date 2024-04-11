import 'dart:async';

import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/remote/api/http_manager.dart';
import 'package:heidi/src/utils/asset.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:loggy/loggy.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class Api {
  static const String login = "/users/login";
  static const String user = "/users/";
  static const String register = "/users/register";
  static const String forgotPassword = "/users/forgotPassword";
  static const String changePassword = "/users/resetPassword";
  static const String categories = "/categories";
  static const String categoriesCount = "/categories/listingsCount";
  static const String list = "/listings";
  static const String uploadImage = "/users/4/imageUpload";
  static const String cities = "/cities";
  static const String listings = "/listings?statusId=1";
  static const String contact = "/contactUs";
  static const String faq = "/moreInfo";
  static const String forum = "/forumapi/cities/1/forums";
  static const String hasForum = "/cities?hasForum=true";
  static const bool showExternalListings = true;

  static Future<ResultApiModel> requestLogin(params) async {
    try {
      final result = await HTTPManager(apiType: APIType.defaultAPI)
          .post(url: login, data: params);

      return ResultApiModel.fromJson(result);
    } catch (e, stackTrace) {
      await Sentry.captureException(e, stackTrace: stackTrace);
      return await HTTPManager(apiType: APIType.defaultAPI)
          .post(url: login, data: params);
    }
  }

  static Future<ResultApiModel> requestRefreshToken(userId, params) async {
    final result = await HTTPManager(apiType: APIType.defaultAPI)
        .post(url: 'users/$userId/refresh', data: params);

    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestFavorites(userId) async {
    try {
      final result = await HTTPManager(apiType: APIType.defaultAPI)
          .get(url: '/users/$userId/favorites?pageNo=1&pageSize=19');
      return ResultApiModel.fromJson(result);
    } catch (e, stackTrace) {
      logError('Load Favorite Error', e);
      await Sentry.captureException(e, stackTrace: stackTrace);

      final result = await HTTPManager(apiType: APIType.defaultAPI)
          .get(url: '/users/$userId/favorites?pageNo=1&pageSize=19');
      return ResultApiModel.fromJson(result);
    }
  }

  static Future<ResultApiModel> requestUserListings(userId, pageNo) async {
    final result = await HTTPManager(apiType: APIType.defaultAPI).get(
        url:
            'users/$userId/listings?pageNo=$pageNo&pageSize=5&showExternalListings=$showExternalListings');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestForum(cityId, pageNo) async {
    final filepath = "/cities/$cityId/forums?pageNo=$pageNo";
    final result = await HTTPManager(apiType: APIType.forum).get(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestForumStatus(
      userId, cityId, forumIds) async {
    final filepath =
        "users/$userId/cities/$cityId/checkMembership?forumIds=$forumIds";
    final result = await HTTPManager(apiType: APIType.forum).get(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestUsersForum(userId) async {
    final filepath = "users/$userId/forums?statusId=1";
    final result = await HTTPManager(apiType: APIType.forum).get(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getGroupMemberRequests(userId) async {
    final filepath = "users/$userId/memberRequests";
    final result = await HTTPManager(apiType: APIType.forum).get(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestToJoinGroup(forumId, cityId) async {
    final filepath = "cities/$cityId/forums/$forumId/memberRequests";
    final result =
        await HTTPManager(apiType: APIType.forum).post(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestGroupDetails(forumId, cityId) async {
    final filepath = "cities/$cityId/forums/$forumId";
    final result = await HTTPManager(apiType: APIType.forum).get(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> removeUserFromGroup(
      forumId, cityId, memberId) async {
    final filepath = "cities/$cityId/forums/$forumId/members/$memberId";
    final result =
        await HTTPManager(apiType: APIType.forum).delete(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestGroupPosts(forumId, cityId) async {
    final filepath = "cities/$cityId/forums/$forumId/posts";
    final result = await HTTPManager(apiType: APIType.forum).get(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> deleteGroupPost(forumId, cityId, postId) async {
    final filepath = "/cities/$cityId/forums/$forumId/posts/$postId";
    final result =
        await HTTPManager(apiType: APIType.forum).delete(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> uploadToken(userId, params) async {
    final filePath = '/users/$userId/storeFirebaseUserToken';
    final result = await HTTPManager(apiType: APIType.forum).post(
      url: filePath,
      data: params,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> reportGroupPosts(
      forumId, cityId, postId, params) async {
    final filepath = "cities/$cityId/forums/$forumId/posts/$postId/reports";
    final result = await HTTPManager(apiType: APIType.forum)
        .post(data: params, url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getGroupMembers(forumId, cityId) async {
    final filepath = "cities/$cityId/forums/$forumId/members";
    final result = await HTTPManager(apiType: APIType.forum).get(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getMemberRequests(forumId, cityId) async {
    final filepath = "cities/$cityId/forums/$forumId/memberRequests?statusId=1";
    final result = await HTTPManager(apiType: APIType.forum).get(url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> acceptMemberRequests(
      forumId, cityId, memberRequestId, params) async {
    final filepath =
        "cities/$cityId/forums/$forumId/memberRequests/$memberRequestId";
    final result = await HTTPManager(apiType: APIType.forum)
        .patch(data: params, url: filepath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> rejectMemberRequests(
      forumId, cityId, memberRequestId, params) async {
    final filepath =
        "cities/$cityId/forums/$forumId/memberRequests/$memberRequestId";
    final result = await HTTPManager(apiType: APIType.forum).patch(
      data: params,
      url: filepath,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestMakeUserAdmin(
      cityId, forumId, memberId, params) async {
    final filepath = "cities/$cityId/forums/$forumId/members/$memberId";
    final result = await HTTPManager(apiType: APIType.forum).patch(
      data: params,
      url: filepath,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestRemoveAdmin(
      cityId, forumId, memberId, params) async {
    final filepath = "cities/$cityId/forums/$forumId/members/$memberId";
    final result = await HTTPManager(apiType: APIType.forum).patch(
      data: params,
      url: filepath,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestHasForum() async {
    final result =
        await HTTPManager(apiType: APIType.defaultAPI).get(url: hasForum);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestFavoritesDetailsList(
      cityId, listingId) async {
    final result = await HTTPManager(apiType: APIType.defaultAPI)
        .get(url: 'cities/$cityId/listings/$listingId');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestForgotPassword(params) async {
    Map<String, dynamic> result =
        await HTTPManager(apiType: APIType.defaultAPI).post(
      url: forgotPassword,
      data: params,
      loading: true,
    );
    result['message'] = result['status'] ?? result['msg'];
    return ResultApiModel.fromJson(result);
  }

  ///Register account
  static Future<ResultApiModel> requestRegister(params) async {
    final result = await HTTPManager(apiType: APIType.defaultAPI).post(
      url: register,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Change Profile
  static Future<ResultApiModel> requestChangeProfile(params, userId) async {
    final filePath = 'users/$userId';
    final result = await HTTPManager(apiType: APIType.defaultAPI).patch(
      url: filePath,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  ///change password
  static Future<ResultApiModel> requestChangePassword(params) async {
    final result = await HTTPManager(apiType: APIType.defaultAPI).post(
      url: changePassword,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestUser({required userId}) async {
    final filePath = 'users/$userId';
    final result =
        await HTTPManager(apiType: APIType.defaultAPI).get(url: filePath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getUserDetails(userId, cityId) async {
    final filePath = 'users/$userId?cityId=$cityId&cityUser=true';
    final result = await HTTPManager(apiType: APIType.defaultAPI).get(
      url: filePath,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Get Category
  static Future<ResultApiModel> requestCategory(params) async {
    final result = await UtilAsset.loadJson("assets/data/category.json");
    // final result = await HTTPManager(apiType: APIType.defaultAPI).get(url: categories, params: params);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestSubmitCategory() async {
    final result =
        await HTTPManager(apiType: APIType.defaultAPI).get(url: categories);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestSubmitSubCategory(
      {required categoryId}) async {
    final filePath = 'categories/$categoryId/subcategories';
    final result =
        await HTTPManager(apiType: APIType.defaultAPI).get(url: filePath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestCategoryCount(int? cityId) async {
    String url = categoriesCount;
    if (cityId != null) {
      url = "$url?cityId=$cityId";
    }
    final result = await HTTPManager(apiType: APIType.defaultAPI).get(url: url);
    return ResultApiModel.fromJson(result);
  }

  ///Get Home Categories
  static Future<ResultApiModel> requestHomeCategory() async {
    final result = await UtilAsset.loadJson("assets/data/category.json");
    // final result = await HTTPManager(apiType: APIType.defaultAPI).get(url: categories);
    return ResultApiModel.fromJson(result);
  }

  ///Get Cities
  static Future<ResultApiModel> requestCities() async {
    // final result = await UtilAsset.loadJson("assets/data/locations.json");
    final result =
        await HTTPManager(apiType: APIType.defaultAPI).get(url: cities);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestVillages({required cityId}) async {
    final filePath = '/cities/$cityId/villages';
    final result =
        await HTTPManager(apiType: APIType.defaultAPI).get(url: filePath);
    return ResultApiModel.fromJson(result);
  }

  ///Get Submit Cities
  static Future<ResultApiModel> requestSubmitCities() async {
    final result =
        await HTTPManager(apiType: APIType.defaultAPI).get(url: cities);
    return ResultApiModel.fromJson(result);
  }

  ///Get Recent Listings
  static Future<ResultApiModel> requestRecentListings(params) async {
    final listings =
        "/listings?statusId=1&pageNo=$params&pageSize=19&showExternalListings=$showExternalListings";
    final result =
        await HTTPManager(apiType: APIType.defaultAPI).get(url: listings);
    return ResultApiModel.fromJson(result);
  }

  ///Get All Listings
  static Future<ResultApiModel> requestAllListings(params) async {
    final listings =
        "/listings?pageNo=$params&pageSize=10&showExternalListings=$showExternalListings";
    final result =
        await HTTPManager(apiType: APIType.defaultAPI).get(url: listings);
    return ResultApiModel.fromJson(result);
  }

  ///Get Listings by status
  static Future<ResultApiModel> requestStatusListings(status, params) async {
    final listings =
        "/listings?statusId=$status&pageNo=$params&pageSize=10&showExternalListings=$showExternalListings";
    final result =
        await HTTPManager(apiType: APIType.defaultAPI).get(url: listings);
    return ResultApiModel.fromJson(result);
  }

  ///Get Listings by status and location
  static Future<ResultApiModel> requestStatusLocList(
      params, pageNo, status) async {
    var list =
        '/listings?cityId=$params&statusId=$status&pageNo=$pageNo&pageSize=19';
    final result =
        await HTTPManager(apiType: APIType.defaultAPI).get(url: list);
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
    final result =
        await HTTPManager(apiType: APIType.defaultAPI).get(url: filePath);
    return ResultApiModel.fromJson(result);
  }

  ///Save Wish List
  static Future<ResultApiModel> requestAddWishList(userId, params) async {
    final String addWishList = "/users/$userId/favorites/";
    final result = await HTTPManager(apiType: APIType.defaultAPI)
        .post(url: addWishList, data: params);
    return ResultApiModel.fromJson(result);
  }

  ///Save Product
  static Future<ResultApiModel> requestSaveProduct(
      cityId, params, isImageChanged) async {
    final filePath = '/cities/$cityId/listings';
    final result = await HTTPManager(apiType: APIType.defaultAPI).post(
      url: filePath,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Save Forum
  static Future<ResultApiModel> requestSaveForum(cityId, params) async {
    final filePath = '/cities/$cityId/forums';
    final result = await HTTPManager(apiType: APIType.forum).post(
      url: filePath,
      data: params,
      loading: true,
    );

    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestEditForum(cityId, id, params) async {
    final filePath = '/cities/$cityId/forums/$id/';
    final result = await HTTPManager(apiType: APIType.forum).patch(
      url: filePath,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestDeleteForum(cityId, id) async {
    final filePath = '/cities/$cityId/forums/$id/';
    final result = await HTTPManager(apiType: APIType.forum).delete(
      url: filePath,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Save Post
  static Future<ResultApiModel> requestSavePost(cityId, fId, params) async {
    final filePath = '/cities/$cityId/forums/$fId/posts';
    final result = await HTTPManager(apiType: APIType.forum).post(
      url: filePath,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestEditProduct(
      cityId, listingId, params, bool isImageChanged) async {
    final filePath = '/cities/$cityId/listings/$listingId';
    final result = await HTTPManager(apiType: APIType.defaultAPI).patch(
      url: filePath,
      data: params,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestEditProductStatus(
    cityId,
    listingId,
    params,
  ) async {
    final filePath = '/cities/$cityId/listings/$listingId';
    final result = await HTTPManager(apiType: APIType.defaultAPI).patch(
      url: filePath,
      data: params,
      loading: true,
    );

    return ResultApiModel.fromJson(result);
  }

  ///Remove Wish List
  static Future<ResultApiModel> requestRemoveWishList(
      userId, int listingId) async {
    final String removeWishList = "/users/$userId/favorites/$listingId";
    final result = await HTTPManager(apiType: APIType.defaultAPI).delete(
      url: removeWishList,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> deletePdf(cityId, listingId) async {
    final result = await HTTPManager(apiType: APIType.defaultAPI).delete(
      url: '/cities/$cityId/listings/$listingId/pdfDelete',
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> deleteImage(cityId, listingId) async {
    final result = await HTTPManager(apiType: APIType.defaultAPI).delete(
      url: '/cities/$cityId/listings/$listingId/imageDelete',
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> deleteUserList(cityId, int listingId) async {
    final String removeList = "/cities/$cityId/listings/$listingId";
    final result = await HTTPManager(apiType: APIType.defaultAPI).delete(
      url: removeList,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Get Product List
  static Future<ResultApiModel> requestCatList(params, cityId, pageNo) async {
    if (params == 3) {
      if (cityId != 0 && cityId != null) {
        var list =
            '/listings?categoryId=$params&statusId=1&pageNo=$pageNo&pageSize=19&sortByStartDate=true&cityId=$cityId&showExternalListings=$showExternalListings';
        final result =
            await HTTPManager(apiType: APIType.defaultAPI).get(url: list);
        return ResultApiModel.fromJson(result);
      } else {
        var list =
            '/listings?categoryId=$params&statusId=1&pageNo=$pageNo&pageSize=19&sortByStartDate=true&showExternalListings=$showExternalListings';
        final result =
            await HTTPManager(apiType: APIType.defaultAPI).get(url: list);
        return ResultApiModel.fromJson(result);
      }
    } else {
      if (cityId != 0 && cityId != null) {
        var list =
            '/listings?categoryId=$params&statusId=1&pageNo=$pageNo&pageSize=19&cityId=$cityId&showExternalListings=$showExternalListings';
        final result =
            await HTTPManager(apiType: APIType.defaultAPI).get(url: list);
        return ResultApiModel.fromJson(result);
      } else {
        var list =
            '/listings?categoryId=$params&statusId=1&pageNo=$pageNo&pageSize=19&showExternalListings=$showExternalListings';
        final result =
            await HTTPManager(apiType: APIType.defaultAPI).get(url: list);
        return ResultApiModel.fromJson(result);
      }
    }
  }

  static Future<ResultApiModel> requestSubCatList(params, pageNo) async {
    var list =
        '/listings?subCategoryId=10&categoryId=1&statusId=1&pageNo=$pageNo&pageSize=19&showExternalListings=$showExternalListings';
    final result =
        await HTTPManager(apiType: APIType.defaultAPI).get(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestLocList(params, pageNo) async {
    var list =
        '/listings?cityId=$params&statusId=1&pageNo=$pageNo&pageSize=19&showExternalListings=$showExternalListings';
    final result =
        await HTTPManager(apiType: APIType.defaultAPI).get(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> contactUs(params) async {
    final result = await HTTPManager(apiType: APIType.defaultAPI).post(
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
    var result = await HTTPManager(apiType: APIType.defaultAPI).post(
      url: filepath,
      formData: formData,
    );

    final convertResponse = {"success": result['id'] != null, "data": result};
    return ResultApiModel.fromJson(convertResponse);
  }

  static Future<void> requestListingUploadMedia(
      listingId, cityId, pickedFile) async {
    var filePath = '';

    if (pickedFile?.files.length != 0) {
      var firstFileEntry = pickedFile?.files[0];
      if (firstFileEntry?.key == 'pdf') {
        filePath = '/cities/$cityId/listings/$listingId/pdfUpload';
      } else if (firstFileEntry?.key == 'image') {
        filePath = '/cities/$cityId/listings/$listingId/imageUpload';
      }
      await HTTPManager(apiType: APIType.defaultAPI).post(
        url: filePath,
        formData: pickedFile,
      );
    }
  }

  static Future<ResultApiModel> requestForumImageUpload(
      cityId, forumId, pickedFile) async {
    var filePath = '';
    filePath = '/cities/$cityId/forums/$forumId/imageUpload';
    var result = await HTTPManager(apiType: APIType.forum).post(
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
    var result = await HTTPManager(apiType: APIType.forum).post(
      url: filePath,
      formData: pickedFile,
    );
    final convertResponse = {"success": result['id'] != null, "data": result};
    return ResultApiModel.fromJson(convertResponse);
  }

  static Future<ResultApiModel> deleteUserAccount(userId) async {
    final String deleteAccount = "/users/$userId";
    final result = await HTTPManager(apiType: APIType.defaultAPI)
        .delete(url: deleteAccount);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestPostComments(
      cityId, forumId, postId, page) async {
    var list =
        '/cities/$cityId/forums/$forumId/posts/$postId/comments?pageNo=$page&pageSize=19';
    final result = await HTTPManager(apiType: APIType.forum).get(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> addPostComments(
      cityId, forumId, postId, params) async {
    var list = '/cities/$cityId/forums/$forumId/posts/$postId/comments';
    final result = await HTTPManager(apiType: APIType.forum).post(
      url: list,
      data: params,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> addPostCommentsReply(
      cityId, forumId, postId, params) async {
    var list = '/cities/$cityId/forums/$forumId/posts/$postId/comments';
    final result = await HTTPManager(apiType: APIType.forum).post(
      url: list,
      data: params,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestPostCommentsReplies(
      cityId, forumId, postId, parentId, pageNo) async {
    var list =
        '/cities/$cityId/forums/$forumId/posts/$postId/comments?pageNo=$pageNo&pageSize=19&parentId=$parentId';
    final result = await HTTPManager(apiType: APIType.forum).get(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> moreInfo() async {
    final result = await HTTPManager(apiType: APIType.defaultAPI).get(url: faq);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestSearchListing(
      content, filter, pageNo) async {
    var list =
        '/listings/search?searchQuery=$content$filter&pageNo=$pageNo&pageSize=10';
    final result =
        await HTTPManager(apiType: APIType.defaultAPI).get(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestUserAppointments(userId, pageNo) async {
    var list = '/users/$userId/appointments?pageNumber=$pageNo&pageSize=10';
    final result =
        await HTTPManager(apiType: APIType.appointment).get(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestAppointmentServices(
      {cityId, listingId, appointmentId}) async {
    var list =
        '/cities/$cityId/listings/$listingId/appointments/$appointmentId/services';
    final result =
        await HTTPManager(apiType: APIType.appointment).get(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestAppointmentSlots(
      {cityId, listingId, appointmentId, date, serviceId}) async {
    var list =
        '/cities/$cityId/listings/$listingId/appointments/$appointmentId/slots?date=$date&serviceId[]=$serviceId';
    final result =
        await HTTPManager(apiType: APIType.appointment).get(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestSaveAppointment(
      cityId, listingId, params) async {
    var list = '/cities/$cityId/listings/$listingId/appointments/';
    final result = await HTTPManager(apiType: APIType.appointment)
        .post(url: list, data: params, loading: false);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestEditAppointment(
      cityId, listingId, appointmentId, params) async {
    var list =
        '/cities/$cityId/listings/$listingId/appointments/$appointmentId';
    final result = await HTTPManager(apiType: APIType.appointment)
        .patch(url: list, data: params);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestDeleteAppointment(
      cityId, listingId, appointmentId) async {
    var list =
        '/cities/$cityId/listings/$listingId/appointments/$appointmentId';
    final result =
        await HTTPManager(apiType: APIType.appointment).delete(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestOwnerBookings(
      userId, appointmentId, pageNo, startDate) async {
    var list =
        '/users/$userId/owner/bookings?$pageNo&pageSize=10&appointmentId=$appointmentId$startDate';
    final result =
        await HTTPManager(apiType: APIType.appointment).get(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestUserBookings(userId) async {
    var list = '/users/$userId/bookings';
    final result =
        await HTTPManager(apiType: APIType.appointment).get(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestDeleteBooking(
      cityId, listingId, appointmentId, bookingId) async {
    var list =
        '/cities/$cityId/listings/$listingId/appointments/$appointmentId/booking/$bookingId';
    final result =
        await HTTPManager(apiType: APIType.appointment).delete(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestSaveBooking(
      cityId, listingId, appointmentId, params) async {
    var list =
        '/cities/$cityId/listings/$listingId/appointments/$appointmentId/book';
    final result = await HTTPManager(apiType: APIType.appointment)
        .post(url: list, data: params);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestTestListings() async {
    var list = '/cities/1/listings';
    final result =
        await HTTPManager(apiType: APIType.defaultAPI).get(url: list);
    return ResultApiModel.fromJson(result);
  }

  ///Singleton factory
  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal();
}
