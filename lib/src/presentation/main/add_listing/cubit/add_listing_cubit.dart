// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_appointment_service.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_holiday.dart';
import 'package:heidi/src/data/model/model_open_time.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/repository/appointment_repository.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/presentation/main/add_listing/cubit/add_listing_state.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
    String? expiryDate,
    String? startDate,
    String? endDate,
    String? price,
    TimeOfDay? expiryTime,
    int? timeless,
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
        expiryDate,
        startDate,
        endDate,
        expiryTime,
        timeless,
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
    } catch (e, stackTrace) {
      logError('save Product Error', e);
      await Sentry.captureException(e, stackTrace: stackTrace);
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
    String? expiryDate,
    String? startDate,
    String? endDate,
    String? createdAt,
    String? price,
    TimeOfDay? expiryTime,
    int? timeless,
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
          expiryDate,
          startDate,
          endDate,
          createdAt,
          price,
          isImageChanged,
          expiryTime,
          timeless,
          startTime,
          endTime,
          imagesList);
      if (response.success) {
        return true;
      } else {
        logError('edit Product Response Failed', response.message);
        return false;
      }
    } catch (e, stackTrace) {
      logError('edit Product Error', e);
      await Sentry.captureException(e, stackTrace: stackTrace);
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
    } catch (e, stackTrace) {
      logError('save Product Error', e);
      await Sentry.captureException(e, stackTrace: stackTrace);
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
    } catch (e, stackTrace) {
      logError('request Village Error', e);
      emit(AddListingState.error(e.toString()));
      await Sentry.captureException(e, stackTrace: stackTrace);
      return null;
    }
  }

  void setCategoryId(value) async {
    try {
      _repo.setCategoryId(value);
    } catch (e, stackTrace) {
      logError('request categoryID Error', e);
      await Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  void getSubCategoryId(value) async {
    try {
      _repo.getSubCategoryId(value);
    } catch (e, stackTrace) {
      logError('request subCategoryID Error', e);
      await Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  void setSubCategoryId(value) async {
    try {
      _repo.setSubCategoryId(value);
    } catch (e, stackTrace) {
      logError('set subCategoryID Error', e);
      await Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  void saveAssets(assetList) {
    selectedAssets = assetList;
  }

  void removeAssetsByIndex(index) {
    if (selectedAssets.isNotEmpty && index <= selectedAssets.length - 1) {
      selectedAssets.removeAt(index);
    }
  }

  void removeAssets(assets) {
    if (selectedAssets.isNotEmpty) {
      selectedAssets.remove(assets);
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
    } catch (e, stackTrace) {
      logError('request subCategoryID Error', e);
      await Sentry.captureException(e, stackTrace: stackTrace);

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
    } catch (e, stackTrace) {
      logError('load cities error', e.toString());
      await Sentry.captureException(e, stackTrace: stackTrace);

      return null;
    }
  }

  Future<ResultApiModel?> loadCategory() async {
    try {
      final loadCategoryResponse = _repo.loadCategory();
      return loadCategoryResponse;
    } catch (e, stackTrace) {
      logError('load category error', e.toString());
      await Sentry.captureException(e, stackTrace: stackTrace);

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

  Future<bool> onSubmitAppointment(
      {List<OpenTimeModel>? openHours,
      List<HolidayModel>? holidays,
      List<AppointmentServiceModel>? services}) async {
    try {
      final prefs = await Preferences.openBox();
      final listindId = prefs.getKeyValue(Preferences.listingId, 1);
      final listingTitle = prefs.getKeyValue(Preferences.listingTitle, '');
      final listingDesc = prefs.getKeyValue(Preferences.listingDesc, '');
      AppointmentRepository repoAppointment = AppointmentRepository(prefs);
      final response = await repoAppointment.saveAppointment(
        listingId: listindId,
        title: listingTitle,
        description: listingDesc,
        startDate: "2024-04-02T12:30:45.000Z",
        maxBookingPerSlot: 8,
        openHours: openHours,
        holidays: holidays,
        services: services,
      );
      if (response.success) {
        return true;
      } else {
        logError('Save Appointment Error', response.message);
        return false;
      }
    } catch (e, stackTrace) {
      logError('save Appointment Error', e);
      await Sentry.captureException(e, stackTrace: stackTrace);
      return false;
    }
  }
}
