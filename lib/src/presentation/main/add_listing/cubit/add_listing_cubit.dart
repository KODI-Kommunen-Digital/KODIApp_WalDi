import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/presentation/main/add_listing/cubit/add_listing_state.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

class AddListingCubit extends Cubit<AddListingState> {
  final ListRepository _repo;

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
  }) async {
    try {
      final response = await _repo.saveProduct(
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
          price);
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

  void clearVillage() async {
    _repo.clearVillageId();
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

  void getCategoryId(value) async {
    try {
      _repo.getCategoryId(value);
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
