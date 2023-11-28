import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/presentation/main/add_listing/cubit/add_listing_state.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';

class AddListingCubit extends Cubit<AddListingState> {
  final ListRepository _repo;
  List<Asset> selectedAssets = [];

  AddListingCubit(this._repo) : super(const AddListingState.loaded());

  String? selectedCity;
  int? cityId;
  int? villageId;
  int? categoryId;
  int? subCategoryId;
  List listCity = [];
  List listVillage = [];
  List listCategory = [];
  List listSubCategory = [];
  String? selectedVillage;
  String? selectedCategory;
  String? selectedSubCategory;

  Future<bool> onSubmit({
    required String title,
    required String description,
    required int cityId,
    CategoryModel? country,
    CategoryModel? state,
    String? city,
    int? statusId,
    int? sourceId,
    required String address,
    required String place,
    String? zipcode,
    required String? phone,
    String? email,
    String? website,
    String? status,
    String? startDate,
    String? endDate,
    String? price,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    List<File>? imagesList,
    isImageChanged,
  }) async {
    try {
      final response = await _repo.saveProduct(
        title,
        description,
        place,
        country,
        state,
        city,
        statusId,
        sourceId,
        address,
        zipcode,
        phone,
        email,
        website,
        status,
        startDate,
        endDate,
        startTime,
        endTime,
        imagesList,
        isImageChanged,
      );
      if (response.success) {
        return true;
      } else {
        logError('save Product Response Failed', response.message);
        return false;
      }
    } catch (e) {
      logError('save Product Error', e);
      return false;
    }
  }

  Future<int?> getCurrentCityId() async {
    final prefs = await Preferences.openBox();
    return prefs.getKeyValue(Preferences.cityId, 0);
  }

  Future<bool> onEdit({
    int? cityId,
    int? categoryId,
    int? listingId,
    required String title,
    required String description,
    CategoryModel? country,
    CategoryModel? state,
    CategoryModel? city,
    int? statusId,
    int? sourceId,
    required String address,
    required String place,
    String? zipcode,
    required String? phone,
    String? email,
    String? website,
    String? status,
    String? startDate,
    String? endDate,
    String? price,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    required bool isImageChanged,
    List<File>? imagesList,
  }) async {
    try {
      final response = await _repo.editProduct(
          listingId,
          categoryId,
          cityId,
          title,
          description,
          place,
          country,
          state,
          city,
          statusId,
          sourceId,
          address,
          zipcode,
          phone,
          email,
          website,
          status,
          startDate,
          endDate,
          price,
          isImageChanged,
          startTime,
          endTime,
          imagesList);
      if (response.success) {
        return true;
      } else {
        logError('edit Product Response Failed', response.message);
        return false;
      }
    } catch (e) {
      logError('edit Product Error', e);
      return false;
    }
  }

  Future<bool> changeStatus(ProductModel item, int newStatus) async {
    int listingId = item.id;
    int? cityId = item.cityId;
    int? statusId = newStatus;

    try {
      final response =
          await _repo.editProductStatus(listingId, cityId, statusId);
      if (response.success) {
        return true;
      } else {
        logError('save Product Response Failed', response.message);
        return false;
      }
    } catch (e) {
      logError('save Product Error', e);
      return false;
    }
  }

  void setImagePref(imagePath) async {
    await _repo.setImagePrefs(imagePath);
  }

  void clearVillage() async {
    _repo.clearVillageId();
  }

  Future<void> deletePdf(cityId, listingId) async {
    await _repo.deletePdf(cityId, listingId);
  }

  Future<void> deleteImage(cityId, listingId) async {
    await _repo.deleteImage(cityId, listingId);
  }

  void clearCityId() async {
    _repo.clearCityId();
  }

  void clearCategoryId() async {
    _repo.clearCategoryId();
  }

  Future<ResultApiModel?> getVillageId(value) async {
    try {
      return _repo.requestVillages(value);
    } catch (e) {
      logError('request Village Error', e);
      emit(AddListingState.error(e.toString()));
      return null;
    }
  }

  void setCategoryId(value) async {
    try {
      _repo.setCategoryId(value);
    } catch (e) {
      logError('request categoryID Error', e);
    }
  }

  void getSubCategoryId(value) async {
    try {
      _repo.getSubCategoryId(value);
    } catch (e) {
      logError('request subCategoryID Error', e);
    }
  }

  void saveAssets(assetList) {
    selectedAssets = assetList;
  }

  void removeAssets(index) {
    if (selectedAssets.isNotEmpty && index <= selectedAssets.length - 1) {
      selectedAssets.removeAt(index);
    }
  }

  void clearAssets() {
    selectedAssets.clear();
  }

  List<Asset> getSelectedAssets() {
    return selectedAssets;
  }

  Future<ResultApiModel?> loadSubCategory(value) async {
    try {
      if (value != null) {
        final subCategoryResponse = await _repo.loadSubCategory(value);
        return subCategoryResponse;
      }
      return null;
    } catch (e) {
      logError('request subCategoryID Error', e);
      return null;
    }
  }

  void clearSubCategory() async {
    _repo.clearSubCategory();
  }

  Future<ResultApiModel?> loadCities() async {
    try {
      final loadCitiesResponse = _repo.loadCities();
      return loadCitiesResponse;
    } catch (e) {
      logError('load cities error', e.toString());
      return null;
    }
  }

  Future<ResultApiModel?> loadCategory() async {
    try {
      final loadCategoryResponse = _repo.loadCategory();
      return loadCategoryResponse;
    } catch (e) {
      logError('load category error', e.toString());
      return null;
    }
  }

  Future<ResultApiModel> loadVillages(value) async {
    final response = await _repo.loadVillages(value);
    return response;
  }

  Future<void> clearImagePath() async {
    _repo.clearImagePath();
  }
}
