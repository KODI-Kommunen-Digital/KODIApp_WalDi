import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/utils/configs/preferences.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  dynamic category;
  dynamic location;
  dynamic recent;
  dynamic sliders;
  dynamic categoryCount;

  HomeCubit() : super(const HomeState.loading());

  Future<void> onLoad() async {
    if (!await hasInternet()) {
      emit(const HomeState.error("no_internet"));
    }
    final categoryRequestResponse = await Api.requestHomeCategory();
    final cityRequestResponse = await Api.requestCities();
    final listingsRequestResponse = await Api.requestRecentListings();
    final categoryCountRequestResponse = await Api.requestCategoryCount();

    category = List.from(categoryRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    location = List.from(cityRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    recent = List.from(listingsRequestResponse.data ?? []).map((item) {
      return ProductModel.fromJson(item);
    }).toList();

    categoryCount =
        List.from(categoryCountRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    const banner = Images.slider;

    List<CategoryModel> formattedCategories =
        await formatCategoriesList(category, categoryCount);

    emit(HomeStateLoaded(banner, formattedCategories, location, recent));
  }

  Future<bool> categoryHasContent(int id) async {
    final response = await Api.requestCatList(id);
    if (response.data.toString() == "[]") {
      return false;
    }
    return true;
  }

  Future<List<CategoryModel>> formatCategoriesList(
      List<CategoryModel> categories, List<CategoryModel> categoryCount) async {
    // Sort List
    Map<int, int?> idToCountMap = {};
    for (var obj in categoryCount) {
      idToCountMap[obj.id] = obj.count;
    }
    categories.sort(
        (a, b) => (idToCountMap[b.id] ?? 0).compareTo(idToCountMap[a.id] ?? 0));

    // Hide tag on empty categories
    for (var element in categories) {
      bool hasContent = await categoryHasContent(element.id);
      if (!hasContent) {
        element.hide = true;
      }
    }

    return categories;
  }

  Future<void> saveCityId(int cityId) async {
    final prefs = await Preferences.openBox();
    prefs.setKeyValue(Preferences.cityId, cityId);
  }

  Future<bool> hasInternet() async {
    try {
      final result = await InternetAddress.lookup('dns.google');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  List<CategoryModel> getCategoriesWithoutHidden(List<CategoryModel> categoryList) {
    List<CategoryModel> noHiddenCategoryList = [];
    for (var element in categoryList) {
      if(!element.hide) {
        noHiddenCategoryList.add(element);
      }
    }
    return noHiddenCategoryList;
  }

  Future<CategoryModel?> checkSavedCity(List<CategoryModel> cities) async {
    final prefs = await Preferences.openBox();
    final cityId = prefs.getKeyValue(Preferences.cityId, 0);
    if (cityId != 0) {
      final cityName =
          cities[cities.indexWhere((category) => category.id == cityId)].title;
      return CategoryModel(id: cityId, title: cityName, image: "");
    }
    return null;
  }
}
