import 'dart:io';

import 'package:dio/dio.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:http_parser/http_parser.dart';

class ListRepository {
  ListRepository();

//   ///load setting
//   static Future<SettingModel?> loadSetting() async {
//     final response = await Api.requestSetting();
//     if (response.success) {
//       return SettingModel.fromJson(response.data);
//     }
//     AppBloc.messageCubit.onShow(response.message);
//     return null;
//   }
//
//   ///load list
//   static Future<List?> loadList({
//     // int? page,
//     // int? perPage,
//     // FilterModel? filter,
//     // String? keyword,
//     required categoryId,
//     required cityId,
//     required type,
//   }) async {
//     // final prefs = await SharedPreferences.getInstance();
//     // final categoryId = prefs.getInt('categoryId');
//     // final cityId = prefs.getInt('cityId');
//     // final type = prefs.getString('type');
//     if (type == "category") {
//       int params = categoryId;
//       final response = await Api.requestCatList(params);
//       if (response.success) {
//         final list = List.from(response.data ?? []).map((item) {
//           return ProductModel.fromJson(item, setting: Application.setting);
//         }).toList();
//         if (cityId != 0) {
//           list.removeWhere((element) => element.cityId != cityId);
//         }
//         return [list, response.pagination];
//       }
//     } else if (type == "location") {
//       int params = cityId;
//       final response = await Api.requestLocList(params);
//       if (response.success) {
//         final list = List.from(response.data ?? []).map((item) {
//           return ProductModel.fromJson(item, setting: Application.setting);
//         }).toList();
//
//         return [list, response.pagination];
//       }
//     }
    // if (filter != null) {
    //   params.addAll(await filter.getParams());
    // }
    // final response = await Api.requestList(params);
    // if (response.success) {
    //   final list = List.from(response.data ?? []).map((item) {
    //     return ProductModel.fromJson(item, setting: Application.setting);
    //   }).toList();

    //   return [list, response.pagination];
    // }
    // AppBloc.messageCubit.onShow(response.message);
  //   return null;
  // }

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

  // ///add wishList
  // static Future<bool> addWishList(int? userId, ProductModel items) async {
  //   final Map<String, dynamic> params = {};
  //   params['cityId'] = items.cityId;
  //   params['listingId'] = items.id;
  //   final response = await Api.requestAddWishList(userId, params);
  //   // AppBloc.messageCubit.onShow(response.message);
  //   if (response.success) {
  //     return true;
  //   }
  //   return false;
  // }
  //
  // ///remove wishList
  // static Future<bool> removeWishList(int? userId, int listingId) async {
  //   final response = await Api.requestRemoveWishList(userId, listingId);
  //   if (response.success) {
  //     return true;
  //   }
  //   return false;
  // }
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
  //
  // ///load detail
  // static Future<ProductModel?> loadProduct(cityId, id) async {
  //   final response = await Api.requestProduct(cityId, id);
  //   if (response.success) {
  //     UtilLogger.log('ErrorReason', response.data);
  //     return ProductModel.fromJson(response.data, setting: Application.setting);
  //   }
  //   AppBloc.messageCubit.onShow(response.message);
  //   return null;
  // }
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
