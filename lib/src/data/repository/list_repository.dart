import 'dart:io';

import 'package:dio/dio.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logger.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:http_parser/http_parser.dart';

class ListRepository {
  ListRepository();

  static Future<List?> loadList({
    required categoryId,
    required cityId,
    required type,
  }) async {
    if (type == "category") {
      int params = categoryId;
      final response = await Api.requestCatList(params);
      if (response.success) {
        final list = List.from(response.data ?? []).map((item) {
          return ProductModel.fromJson(item, setting: Application.setting);
        }).toList();
        if (cityId != 0) {
          list.removeWhere((element) => element.cityId != cityId);
        }
        return [list, response.pagination];
      }
    } else if (type == "location") {
      int params = cityId;
      final response = await Api.requestLocList(params);
      if (response.success) {
        final list = List.from(response.data ?? []).map((item) {
          return ProductModel.fromJson(item, setting: Application.setting);
        }).toList();

        return [list, response.pagination];
      }
    }
    return null;
  }

  ///load wish list
  // static Future<List?> loadWishList({
  //   int? page,
  //   int? perPage,
  // }) async {
  //   Map<String, dynamic> params = {
  //     "page": page,
  //     "per_page": perPage,
  //   };
  //   final response = await Api.requestWishList(params);
  //   if (response.success) {
  //     final list = List.from(response.data ?? []).map((item) {
  //       return ProductModel.fromJson(item, setting: Application.setting);
  //     }).toList();

  //     return [list, response.pagination];
  //   }
  //   AppBloc.messageCubit.onShow(response.message);
  //   return null;
  // }

  static Future<bool> addWishList(int? userId, ProductModel items) async {
    final Map<String, dynamic> params = {};
    params['cityId'] = items.cityId;
    params['listingId'] = items.id;
    final response = await Api.requestAddWishList(userId, params);
    if (response.success) {
      logError('Add Wishlist Response Success', response.message);
      return true;
    }
    else {
      logError('Add Wishlist Response Fail', response.message);
      return false;
    }
  }

  static Future<bool> removeWishList(int? userId, int listingId) async {
    final response = await Api.requestRemoveWishList(userId, listingId);
    if (response.success) {
      logError('Remove Wishlist Response Success', response.message);
      return true;
    }
    else{
      logError('Remove Wishlist Response Success', response.message);
      return false;
    }
  }
  //
  // ///clear wishList
  // static Future<bool> clearWishList() async {
  //   final response = await Api.requestClearWishList();
  //   AppBloc.messageCubit.onShow(response.message);
  //   if (response.success) {
  //     return true;
  //   }
  //   return false;
  // }
  //
  // ///load author post
  // static Future<List?> loadAuthorList({
  //   required int page,
  //   required int perPage,
  //   required String keyword,
  //   required int userID,
  //   required FilterModel filter,
  //   bool? pending,
  // }) async {
  //   Map<String, dynamic> params = {
  //     "page": page,
  //     "per_page": perPage,
  //     "s": keyword,
  //     "user_id": userID,
  //   };
  //   if (pending == true) {
  //     params['post_status'] = 'pending';
  //   }
  //   params.addAll(await filter.getParams());
  //   final response = await Api.requestAuthorList(params);
  //   if (response.success) {
  //     final list = List.from(response.data ?? []).map((item) {
  //       return ProductModel.fromJson(item, setting: Application.setting);
  //     }).toList();
  //     return [list, response.pagination, response.user];
  //   }
  //   AppBloc.messageCubit.onShow(response.message);
  //   return null;
  // }

  ///Upload image
  static Future<ResultApiModel?> uploadImage(File image, origin) async {
    final prefs = await Preferences.openBox();
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path,
          filename: image.path, contentType: MediaType('image', '')),
    });
    if (origin == 'profile') {
      final response = await Api.requestUploadImage(formData);
      return response;
    } else if (origin == 'Upload feature image') {
      await prefs.setPickedFile(formData);
    }
    return null;
  }

  static Future<ProductModel?> loadProduct(cityId, id) async {
    final response = await Api.requestProduct(cityId, id);
    if (response.success) {
      UtilLogger.log('ErrorReason', response.data);
      return ProductModel.fromJson(response.data, setting: Application.setting);
    }else{
      logError('Product Request Response', response.message);
    }
    return null;
  }
  //
  // ///save product
  // static Future<bool> saveProduct(cityId, params) async {
  //   final response = await Api.requestSaveProduct(cityId, params);
  //   AppBloc.messageCubit.onShow(response.message);
  //   if (response.success) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  //
  // ///Delete author item
  // static Future<bool> removeProduct(id) async {
  //   final response = await Api.requestDeleteProduct({"post_id": id});
  //   AppBloc.messageCubit.onShow(response.message);
  //   if (response.success) {
  //     return true;
  //   }
  //   return false;
  // }
  //
  // ///Load tags list with keyword
  // static Future<List<String>?> loadTags(String keyword) async {
  //   final response = await Api.requestTags({"s": keyword});
  //   if (response.success) {
  //     return List.from(response.data ?? []).map((e) {
  //       return e['name'] as String;
  //     }).toList();
  //   }
  //   AppBloc.messageCubit.onShow(response.message);
  //   return [];
  // }
}
