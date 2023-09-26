import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/add_new_post/cubit/add_post_state.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

class AddPostCubit extends Cubit<AddPostState> {
  final ForumRepository _repo;

  AddPostCubit(this._repo) : super(const AddPostState.loaded());

  String? selectedCity;
  int? cityId;
  List listCity = [];
  List listVillage = [];
  List listCategory = [];
  List listSubCategory = [];
  String? selectedCategory;
  String? selectedSubCategory;

  Future<bool> onSubmit(
      {required String title,
      required String description,
      required int cityId,
      required int? forumId}) async {
    try {
      final response = await _repo.savePost(title, description, cityId);
      if (response.success) {
        return true;
      } else {
        logError('Save Post Response Failed', response.message);
        return false;
      }
    } catch (e) {
      logError('Save Post Error', e);
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
          endTime);
      if (response.success) {
        await AppBloc.homeCubit.onLoad(false);
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
      emit(AddPostState.error(e.toString()));
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

  Future<ResultApiModel?> loadSubCategory(value) async {
    try {
      if (value != null) {
        final subCategoryResponse = _repo.loadSubCategory(value);
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

  Future<List<dynamic>?> loadCities() async {
    try {
      final loadForumCitiesResponse = await _repo.loadForumCities();
      if (loadForumCitiesResponse.success) {
        return loadForumCitiesResponse.data;
      }
    } catch (e) {
      logError('load cities error', e.toString());
    }
    return null;
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
