import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
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
  bool isSearching = false;
  String? searchTerm;

  Future<void> onLoad(cityId) async {
    pageNo = 1;
    final prefs = await Preferences.openBox();
    final categoryId = prefs.getKeyValue(Preferences.categoryId, 0);
    final type = prefs.getKeyValue(Preferences.type, '');
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

  Future<void> setCategoryFilter(int filter, int? cityId) async {
    final prefs = await Preferences.openBox();

    if (filter == 0) {
      prefs.setKeyValue(Preferences.categoryId, 0);
    } else {
      prefs.setKeyValue(Preferences.categoryId, filter);
    }
    if (cityId != null) {
      onLoad(cityId);
    }
  }

  Future<List<ProductModel>> newListings(int pageNo, city) async {
    final prefs = await Preferences.openBox();
    // final cityId = prefs.getKeyValue(Preferences.cityId, 0);
    final categoryId = prefs.getKeyValue(Preferences.categoryId, 0);
    final type = prefs.getKeyValue(Preferences.type, '');

    final result = await ListRepository.loadList(
      categoryId: (categoryId == 0) ? "" : categoryId,
      type: type,
      pageNo: pageNo,
      cityId: city,
    );

    final listUpdated = result?[0] ?? [];
    if (listUpdated.isNotEmpty) {
      list.addAll(listUpdated);
    }
    return list;
  }

  List<ProductModel> getLoadedList() => listLoaded;

  Future<void> searchListing(content, bool newSearch) async {
    if (newSearch) {
      emit(const ListState.loading());
      pageNo = 1;
    }
    isSearching = true;
    searchTerm = content.toString();
    final prefs = await Preferences.openBox();

    final categoryId = prefs.getKeyValue(Preferences.categoryId, 0);
    final cityId = prefs.getKeyValue(Preferences.cityId, 0);
    List<ProductModel>? listDataList = [];
    MultiFilter multiFilter = MultiFilter(
        hasCategoryFilter: true,
        hasLocationFilter: true,
        currentLocation: cityId,
        currentCategory: categoryId);

    final result = await ListRepository.searchListing(
        content: content, multiFilter: multiFilter, pageNo: pageNo++);
    final List<ProductModel>? listUpdated = result?[0];
    if (listUpdated != null) {
      if (newSearch) {
        list = [];
      }
      list.addAll(listUpdated);
    }
    for (final product in list) {
      listDataList.add(
        ProductModel(
            id: product.id,
            cityId: product.cityId,
            title: product.title,
            image: product.image,
            pdf: product.pdf,
            category: product.category,
            categoryId: product.categoryId,
            subcategoryId: product.subcategoryId,
            startDate: product.startDate,
            endDate: product.endDate,
            createDate: product.createDate,
            favorite: product.favorite,
            address: product.address,
            phone: product.phone,
            email: product.email,
            website: product.website,
            description: product.description,
            statusId: product.statusId,
            userId: product.userId,
            sourceId: product.sourceId,
            imageLists: product.imageLists,
            expiryDate: product.expiryDate,
            externalId: product.externalId),
      );
    }

    emit(ListStateUpdated(listDataList, listCity));
  }

  Future<void> cancelSearch(int cityId) async {
    isSearching = true;
    searchTerm = "";
    pageNo = 0;
    onLoad(cityId);
  }

  void onDateProductFilter(ProductFilter? type, List<ProductModel> loadedList,
      bool filterLocation, int? currentCity) {
    final currentDate = DateTime.now();
    if (type == ProductFilter.month) {
      filteredList = loadedList.where((product) {
        final startDate = _parseDate(product.startDate);
        if (startDate != null) {
          final startMonth = startDate.month;
          final currentMonth = currentDate.month;
          if (filterLocation && (currentCity ?? 0) != 0) {
            return (startMonth == currentMonth) &&
                (product.cityId == currentCity);
          } else {
            return startMonth == currentMonth;
          }
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
          if (filterLocation && (currentCity ?? 0) != 0) {
            return (startWeek == currentWeek) &&
                (product.cityId == currentCity);
          } else {
            return startWeek == currentWeek;
          }
        }
        return false;
      }).toList();

      emit(ListStateUpdated(filteredList, listCity));
    } else if (type == null && filterLocation && (currentCity ?? 0) != 0) {
      filteredList = loadedList.where((product) {
        return product.cityId == currentCity;
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
      logError('load cities error', e.toString());
      await Sentry.captureException(e, stackTrace: stackTrace);
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
      7: "category_free",
      8: "category_defect_report",
      9: "category_lost_found",
      10: "category_companies",
      11: "category_public_transport",
      12: "category_offers",
      13: "category_food",
      14: "category_rathaus",
      15: "category_newsletter",
      16: "category_official_notification",
      18: "category_appointment",
    };
    return categories[categoryId];
  }
}
