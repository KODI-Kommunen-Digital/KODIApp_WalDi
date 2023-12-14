import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'cubit.dart';

enum ProductFilter {
  week,
  month,
}

class ListCubit extends Cubit<ListState> {
  final ListRepository repo;

  ListCubit(this.repo) : super(const ListStateLoading()) {
    // final isEvent = categoryPreferencesCall();
  }

  int pageNo = 1;
  List<ProductModel> list = [];
  PaginationModel? pagination;
  List<ProductModel> listLoaded = [];
  List<ProductModel> filteredList = [];
  List listCity = [];

  Future<void> onLoad(cityId) async {
    pageNo = 1;
    final prefs = await Preferences.openBox();
    final categoryId = prefs.getKeyValue(Preferences.categoryId, '');
    final type = prefs.getKeyValue(Preferences.type, '');
    if (type == 'location') {
      prefs.setKeyValue(Preferences.categoryId, '');
    }
    listCity = await getCityList() ?? [];
    final result = await ListRepository.loadList(
      categoryId: categoryId,
      type: type,
      pageNo: pageNo,
      cityId: cityId,
    );
    if (result != null) {
      list = result[0];
      pagination = result[1];
      listLoaded = list;
      emit(ListStateLoaded(list, listCity));
    }
  }

  Future<List<ProductModel>> newListings(int pageNo, city) async {
    final prefs = await Preferences.openBox();
    final cityId = prefs.getKeyValue(Preferences.cityId, 0);
    final categoryId = prefs.getKeyValue(Preferences.categoryId, '');
    final type = prefs.getKeyValue(Preferences.type, '');
    if (type == 'location') {
      prefs.setKeyValue(Preferences.categoryId, '');
    }

    final result = await ListRepository.loadList(
      categoryId: categoryId,
      type: type,
      pageNo: pageNo,
      cityId: cityId,
    );

    final listUpdated = result?[0];
    if (listUpdated.isNotEmpty) {
      list.addAll(listUpdated);
      return list;
    }
    return list;
  }

  List<ProductModel> getLoadedList() => listLoaded;

  void onProductFilter(ProductFilter? type, List<ProductModel> loadedList) {
    final currentDate = DateTime.now();
    if (type == ProductFilter.month) {
      filteredList = loadedList.where((product) {
        final startDate = _parseDate(product.startDate);
        if (startDate != null) {
          final startMonth = startDate.month;
          final currentMonth = currentDate.month;
          return startMonth == currentMonth;
        }
        return false;
      }).toList();

      emit(ListStateUpdated(filteredList, listCity));
    } else if (type == ProductFilter.week) {
      filteredList = loadedList.where((product) {
        final startDate = _parseDate(product.startDate);
        if (startDate != null) {
          final startWeek = _getWeekNumber(startDate);
          final currentWeek = _getWeekNumber(currentDate);
          return startWeek == currentWeek;
        }
        return false;
      }).toList();

      emit(ListStateUpdated(filteredList, listCity));
    } else {
      emit(ListStateUpdated(loadedList, listCity));
    }
  }

  DateTime? _parseDate(String dateTimeString) {
    try {
      final dateAndTimeParts = dateTimeString.split(' ');
      if (dateAndTimeParts.isNotEmpty) {
        final datePart = dateAndTimeParts[0];
        final dateParts = datePart.split('.');
        if (dateParts.length == 3) {
          final day = int.parse(dateParts[0]);
          final month = int.parse(dateParts[1]);
          final year = int.parse(dateParts[2]);
          return DateTime(year, month, day);
        }
      }
    } catch (e) {
      logError("Error parsing date: $dateTimeString");
    }
    return null;
  }

  Future<List?> getCityList() async {
    ResultApiModel? loadCitiesResponse;
    try {
      loadCitiesResponse = await repo.loadCities();
    } catch (e, stackTrace) {
      await Sentry.captureException(e, stackTrace: stackTrace);
      logError('load cities error', e.toString());
      return null;
    }

    List listCity = loadCitiesResponse.data;
    return listCity;
  }

  String getCityNameFromId(List listCity, int cityId) {
    if (listCity.isNotEmpty) {
      final city = listCity.firstWhere((cityData) => cityData["id"] == cityId);
      return city["name"];
    }
    return "";
  }

  int _getWeekNumber(DateTime date) {
    final startOfYear = DateTime(date.year, 1, 1);
    final daysSinceStartOfYear = date.difference(startOfYear).inDays;
    return (daysSinceStartOfYear / 7).ceil();
  }

  Future<bool?> categoryPreferencesCall() async {
    final prefs = await Preferences.openBox();
    final categoryId = prefs.getKeyValue(Preferences.categoryId, '');
    if (categoryId == 3) {
      return true;
    } else {
      return null;
    }
  }

  Future<String?> getCategory() async {
    final categoryId = await repo.getCategoryId();
    Map<int, String> categories = {
      1: "category_news",
      2: "category_traffic",
      3: "category_events",
      4: "category_clubs",
      5: "category_products",
      6: "category_offer_search",
      7: "category_citizen_info",
      8: "category_defect_report",
      9: "category_lost_found",
      10: "category_companies",
      11: "category_public_transport",
      12: "category_offers",
      13: "category_food"
    };
    return categories[categoryId];
  }
}
