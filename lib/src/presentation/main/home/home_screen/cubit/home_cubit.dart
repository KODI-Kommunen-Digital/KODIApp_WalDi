import 'package:bloc/bloc.dart';
import 'dart:io';
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

    emit(HomeStateLoaded(banner, sortCategoriesCount(category, categoryCount),
        location, recent));
  }

  List<CategoryModel> sortCategoriesCount(
      List<CategoryModel> categories, List<CategoryModel> categoryCount) {
    Map<int, int?> idToCountMap = {};
    for (var obj in categoryCount) {
      idToCountMap[obj.id] = obj.count;
    }

    categories.sort(
        (a, b) => (idToCountMap[b.id] ?? 0).compareTo(idToCountMap[a.id] ?? 0));
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
