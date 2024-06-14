import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_favorites_detail_list.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logger.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:http_parser/http_parser.dart';

class ListRepository {
  final Preferences prefs;

  ListRepository(this.prefs);

  static Future<List?> loadList({
    required categoryId,
    required type,
    required pageNo,
    cityId,
  }) async {
    final prefs = await Preferences.openBox();
    int selectedCityId = prefs.getKeyValue(Preferences.cityId, 0);

    if (type == "category" || (type == "location" && categoryId != "")) {
      int params = categoryId;
      final response = await Api.requestCatList(params, cityId, pageNo);
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
      final response = await Api.requestLocList(params, pageNo);
      if (response.success) {
        final list = List.from(response.data ?? []).map((item) {
          return ProductModel.fromJson(item, setting: Application.setting);
        }).toList();

        return [list, response.pagination];
      }
    } else if (type == "categoryService") {
      int params = categoryId;
      final response = await Api.requestCatList(params, selectedCityId, pageNo);
      if (response.success) {
        final list = List.from(response.data ?? []).map((item) {
          return ProductModel.fromJson(item, setting: Application.setting);
        }).toList();
        if (selectedCityId != 0) {
          list.removeWhere((element) => element.cityId != selectedCityId);
        }
        return [list, response.pagination];
      }
    } else if (type == "subCategoryService") {
      final response = await Api.requestSubCatList(selectedCityId, pageNo);
      if (response.success) {
        final list = List.from(response.data ?? []).map((item) {
          return ProductModel.fromJson(item, setting: Application.setting);
        }).toList();
        return [list, response.pagination];
      }
    }
    return null;
  }

  static Future<List<List<ProductModel>>?> searchListing(
      {required content,
      required MultiFilter multiFilter,
      int pageNo = 1}) async {
    String linkFilter = "";
    if (multiFilter.hasListingStatusFilter &&
        (multiFilter.currentListingStatus ?? 0) != 0) {
      linkFilter = "$linkFilter&statusId=${multiFilter.currentListingStatus}";
    }
    if (multiFilter.hasLocationFilter &&
        (multiFilter.currentLocation ?? 0) != 0) {
      linkFilter = "$linkFilter&cityId=${multiFilter.currentLocation}";
    }
    if (multiFilter.hasCategoryFilter &&
        (multiFilter.currentCategory ?? 0) != 0) {
      linkFilter = "$linkFilter&categoryId=${multiFilter.currentCategory}";
    }
    final response =
        await Api.requestSearchListing(content, linkFilter, pageNo);
    if (response.success) {
      final list =
          List<Map<String, dynamic>>.from(response.data ?? []).map((item) {
        return ProductModel.fromJson(item, setting: Application.setting);
      }).toList();
      return [list];
    }
    return null;
  }

  Future<List<int>> getCityIds(List<String> cityName) async {
    final response = await Api.requestSubmitCities();
    cityName = cityName.toSet().toList();
    var jsonCategory = response.data;
    List<int> cityIds = [];
    for (var city in cityName) {
      final item = jsonCategory.firstWhere((item) => item['name'] == city);
      final itemId = item['id'];
      cityIds.add(itemId);
    }

    return cityIds;
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

  ///Upload image
  static Future<ResultApiModel?> uploadImage(File image, profile) async {
    final prefs = await Preferences.openBox();
    List<String> parts = image.path.split('.');
    String imageExtension = parts.last;
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path,
          filename: image.path,
          contentType: MediaType('image', imageExtension)),
    });
    await prefs.setPickedFile(formData);
    return null;
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
      return ProductModel.fromJson(response.data,
          setting: Application.setting, cityId: cityId);
    } else {
      logError('Product Request Response', response.message);
    }
    return null;
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
    final item = jsonCategory.firstWhere(
      (item) => item['name'].toString().toLowerCase() == value.toLowerCase(),
      orElse: () => null,
    );
    final itemId = item['id'];
    final categoryId = itemId;
    final requestSubmitResponse =
        await Api.requestSubmitSubCategory(categoryId: categoryId);
    final jsonSubCategory = requestSubmitResponse.data;
    if (!jsonSubCategory.isEmpty) {
      final subCategoryId = jsonSubCategory.last['id'];
      prefs.setKeyValue(Preferences.subCategoryId, subCategoryId as int);
    }
    return requestSubmitResponse;
  }

  Future<ResultApiModel> saveProduct(
    String title,
    String description,
    String place,
    CategoryModel? country,
    CategoryModel? state,
    List<String>? city,
    int? statusId,
    int? sourceId,
    String address,
    String? zipcode,
    String? phone,
    String? email,
    String? website,
    String? status,
    String? expiryDate,
    String? startDate,
    String? endDate,
    String? createdAt,
    TimeOfDay? expiryTime,
    int? timeless,
    TimeOfDay? startTime,
    String? price,
    TimeOfDay? endTime,
    List<File>? imagesList,
    bool isImageChanged,
  ) async {
    int? subCategoryId = prefs.getKeyValue(Preferences.subCategoryId, null);
    final categoryId = prefs.getKeyValue(Preferences.categoryId, '');
    final villageId = prefs.getKeyValue(Preferences.villageId, null);
    final userId = prefs.getKeyValue(Preferences.userId, '');
    final cityId = await getCityIds(city ?? []);
    String? combinedStartDateTime;
    String? combinedEndDateTime;
    String? combinedExpiryDateTime;

    if (expiryDate != null) {
      String formattedTime;
      if (expiryTime!.hour < 10) {
        formattedTime =
            "${expiryTime.periodOffset}${expiryTime.hour}:${expiryTime.minute.toString().padLeft(2, '0')}";
        combinedExpiryDateTime = "${expiryDate.trim()}T$formattedTime";
      } else {
        formattedTime =
            "${expiryTime.hour}:${expiryTime.minute.toString().padLeft(2, '0')}";
        combinedExpiryDateTime = "${expiryDate.trim()}T$formattedTime";
      }
    }

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

    if (endDate != null && endDate != "" && endTime != null) {
      String formattedTime;
      if (endTime.hour < 10) {
        formattedTime =
            "${endTime.periodOffset}${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}";
        combinedEndDateTime = "${endDate.trim()}T$formattedTime";
      } else {
        formattedTime =
            "${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}";
        combinedEndDateTime = "${endDate.trim()}T$formattedTime";
      }
    }

    if (categoryId == 1) {
      subCategoryId = subCategoryId;
    } else {
      subCategoryId = null;
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
      "logo": null,
      "statusId": 1, //dummy data
      "sourceId": 1, //dummy data
      "longitude": 245.65, //dummy data
      "latitude": 22.456, //dummy data
      "villageId": villageId ?? 0,
      "cityIds": cityId,
      "subcategoryId": subCategoryId,
      "expiryDate": combinedExpiryDateTime,
      "startDate": combinedStartDateTime,
      "endDate": combinedEndDateTime, "timeless": timeless
    };
    final response = await Api.requestSaveProduct(params, isImageChanged);
    if (response.success) {
      final prefs = await Preferences.openBox();
      FormData? pickedFile = prefs.getPickedFile();
      final List<dynamic> responseData = response.data;
      var formData = FormData();

      if (pickedFile != null && pickedFile.files.isNotEmpty) {
        if (pickedFile.files[0].key == 'pdf') {
          for (var listing in responseData) {
            await editProduct(
                listing['listingId'],
                categoryId,
                listing['cityId'],
                title,
                description,
                place,
                country,
                state,
                null,
                statusId,
                sourceId,
                address,
                zipcode,
                phone,
                email,
                website,
                status,
                expiryDate,
                startDate,
                endDate,
                createdAt,
                price,
                true,
                expiryTime,
                timeless,
                startTime,
                endTime,
                imagesList);
          }
        } else {
          if (imagesList!.isNotEmpty) {
            for (final image in imagesList) {
              var file = image;

              // Ensure the file extension matches the actual image type
              var fileExtension = file.path.split('.').last.toLowerCase();
              var fileName = '$image.$fileExtension';

              formData.files.add(MapEntry(
                'image',
                await MultipartFile.fromFile(
                  file.path,
                  filename: fileName,
                  contentType: MediaType(
                      'image', fileExtension), // Set the correct content type
                ),
              ));
            }
            for (var listing in responseData) {
              await editProduct(
                  listing['listingId'],
                  categoryId,
                  listing['cityId'],
                  title,
                  description,
                  place,
                  country,
                  state,
                  null,
                  statusId,
                  sourceId,
                  address,
                  zipcode,
                  phone,
                  email,
                  website,
                  status,
                  expiryDate,
                  startDate,
                  endDate,
                  createdAt,
                  price,
                  true,
                  expiryTime,
                  timeless,
                  startTime,
                  endTime,
                  imagesList);
            }
          }
        }
      }
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
    String? expiryDate,
    String? startDate,
    String? endDate,
    String? createdAt,
    String? price,
    bool isImageChanged,
    TimeOfDay? expiryTime,
    int? timeless,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    List<File>? imagesList,
  ) async {
    final categoryId = prefs.getKeyValue(Preferences.categoryId, '');
    int? subCategoryId = prefs.getKeyValue(Preferences.subCategoryId, null);
    final villageId = prefs.getKeyValue(Preferences.villageId, null);
    final userId = prefs.getKeyValue(Preferences.userId, '');
    final media = prefs.getKeyValue(Preferences.path, null);
    String? combinedStartDateTime;
    String? combinedEndDateTime;
    DateTime currentDate = DateTime.now();
    String? combinedExpiryDateTime;

    if (expiryDate != null) {
      String formattedTime;
      if (expiryTime!.hour < 10) {
        formattedTime =
            "${expiryTime.periodOffset}${expiryTime.hour}:${expiryTime.minute.toString().padLeft(2, '0')}";
        combinedExpiryDateTime = "${expiryDate.trim()}T$formattedTime";
      } else {
        formattedTime =
            "${expiryTime.hour}:${expiryTime.minute.toString().padLeft(2, '0')}";
        combinedExpiryDateTime = "${expiryDate.trim()}T$formattedTime";
      }
    }

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

    if (endDate != null && endDate != "" && endTime != null) {
      String formattedTime;
      if (endTime.hour < 10) {
        formattedTime =
            "${endTime.periodOffset}${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}";
        combinedEndDateTime = "${endDate.trim()}T$formattedTime";
      } else {
        formattedTime =
            "${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}";
        combinedEndDateTime = "${endDate.trim()}T$formattedTime";
      }
    } else {
      combinedEndDateTime = "";
    }

    if (categoryId == 1) {
      subCategoryId = subCategoryId;
    } else {
      subCategoryId = null;
    }

    Map<String, dynamic> params = {
      "id": listingId,
      "userId": userId,
      "title": title,
      "place": place,
      "description": description,
      "externalId": null,
      "categoryId": categoryId,
      "subcategoryId": subCategoryId,
      "address": address,
      "email": email,
      "phone": phone,
      "website": website,
      "price": 100, //dummy data
      "discountPrice": 100, //dummy data
      "hasAttachment": isImageChanged ? true : false,
      "statusId": statusId ?? 1, //change 1 to 3 when done
      "sourceId": 1, //dummy data
      "longitude": 245.65, //dummy data
      "latitude": 22.456, //dummy data
      "villageId": villageId ?? 0,
      "expiryDate": combinedExpiryDateTime,
      "timeless": timeless,
      "startDate": combinedStartDateTime,
      "endDate": combinedEndDateTime,
      "createdAt": createdAt,
      "pdf": null,
      "updatedAt": currentDate.toString(),
      "zipcode": null,
      "appointmentId": null,
      "logo": media,
      "otherlogos": [
        {"id": null, "imageOrder": null, "listingId": null, "logo": ""}
      ],
      "cityId": cityId,
    };
    final response =
        await Api.requestEditProduct(cityId, listingId, params, isImageChanged);
    if (response.success) {
      final prefs = await Preferences.openBox();
      FormData? pickedFile = prefs.getPickedFile();
      // if (pickedFile!.files.isNotEmpty) {
      if (pickedFile?.files[0].key == 'pdf') {
        await Api.requestListingUploadMedia(listingId, cityId, pickedFile);
      } else {
        if (isImageChanged) {
          var formData = FormData();

          if (imagesList != null) {
            for (final image in imagesList) {
              var file = image;

              // Ensure the file extension matches the actual image type
              if (file.path.contains('.')) {
                if (file.path.contains('com.')) {
                  var fileName = '$image';
                  formData.files.add(MapEntry(
                    'image',
                    await MultipartFile.fromFile(
                      file.path,
                      filename: fileName,
                      contentType: MediaType(
                          'image', 'png'), // Set the correct content type
                    ),
                  ));
                } else {
                  var fileExtension = file.path.split('.').last.toLowerCase();
                  var fileName = '$image.$fileExtension';
                  formData.files.add(MapEntry(
                    'image',
                    await MultipartFile.fromFile(
                      file.path,
                      filename: fileName,
                      contentType: MediaType('image',
                          fileExtension), // Set the correct content type
                    ),
                  ));
                }
              } else {
                // var fileExtension = file.path.split('.').last.toLowerCase();
                var fileName = '$image';
                formData.files.add(MapEntry(
                  'image',
                  await MultipartFile.fromFile(
                    file.path,
                    filename: fileName,
                    contentType: MediaType(
                        'image', 'png'), // Set the correct content type
                  ),
                ));
              }
            }
            await Api.requestListingUploadMedia(listingId, cityId, formData);
          }
          // if (pickedFile!.files.isNotEmpty) {
          //   await Api.requestListingUploadMedia(listingId, cityId, pickedFile);
          // }
        }
      }
      // }
    }
    return response;
  }

  Future<ResultApiModel> editProductStatus(
    int? listingId,
    cityId,
    int? statusId,
  ) async {
    final userId = prefs.getKeyValue(Preferences.userId, '');

    Map<String, dynamic> params = {
      "userId": userId,
      "statusId": statusId ?? 1,
    };
    final response =
        await Api.requestEditProductStatus(cityId, listingId, params);
    return response;
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
    final item = jsonCategory.firstWhere(
        (item) => (item['name']?.toLowerCase() ?? '') == value.toLowerCase());
    final itemId = item['id'];
    final categoryId = itemId;
    prefs.setKeyValue(Preferences.categoryId, categoryId);
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

  void setSubCategoryId(value) async {
    final response = await Api.requestSubmitSubCategory(categoryId: 1);
    var jsonSubCategory = response.data;
    final item = jsonSubCategory.firstWhere(
        (item) => (item['name']?.toLowerCase() ?? '') == value.toLowerCase());
    final itemId = item['id'];
    final subCategoryId = itemId;
    prefs.setKeyValue(Preferences.subCategoryId, subCategoryId);
  }

  void clearSubCategory() async {
    prefs.deleteKey(Preferences.subCategoryId);
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

  Future<List<FavoriteDetailsModel>> loadUserListings(id, pageNo) async {
    int userId;
    final userList = <FavoriteDetailsModel>[];
    if (id == 0) {
      userId = prefs.getKeyValue('userId', 0);
    } else {
      userId = id;
    }

    final listResponse = await Api.requestUserListings(userId, pageNo);
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
            data['expiryDate'] ?? '',
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
}
