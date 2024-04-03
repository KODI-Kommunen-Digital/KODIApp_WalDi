import 'package:bloc/bloc.dart';
import 'dart:io';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/data/repository/user_repository.dart';

// import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  dynamic category;
  dynamic location;
  dynamic recent;
  dynamic sliders;
  dynamic categoryCount;
  bool calledExternally = false;
  bool doesScroll = false;

  HomeCubit() : super(const HomeState.loading());

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!await hasInternet()) {
      emit(const HomeState.error("no_internet"));
    }

    final cityRequestResponse = await Api.requestCities();
    location = List.from(cityRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    if (!isRefreshLoader) {
      emit(HomeState.categoryLoading(location));
    }

    final categoryRequestResponse = await Api.requestHomeCategory();
    category = List.from(categoryRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    CategoryModel? savedCity = await checkSavedCity(location);
    if (savedCity != null) {
      final listingsRequestResponse = await Api.requestLocList(savedCity.id, 1);
      recent = List.from(listingsRequestResponse.data ?? []).map((item) {
        return ProductModel.fromJson(item);
      }).toList();
    } else {
      final listingsRequestResponse = await Api.requestRecentListings(1);
      recent = List.from(listingsRequestResponse.data ?? []).map((item) {
        return ProductModel.fromJson(item);
      }).toList();
    }
    final categoryCountRequestResponse =
        await Api.requestCategoryCount(savedCity?.id);
    categoryCount =
        List.from(categoryCountRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    const banner = Images.slider;

    List<CategoryModel> formattedCategories =
        await formatCategoriesList(category, categoryCount, savedCity?.id);

    if (!calledExternally && !isRefreshLoader) {
      await AppBloc.discoveryCubit.onLoad();
    }

    // emit(const HomeState.categoryLoaded());
    emit(HomeStateLoaded(
      banner,
      formattedCategories,
      location,
      recent,
      isRefreshLoader,
    ));
  }

  void scrollUp() {
    emit(const HomeStateLoading());
    const banner = Images.slider;
    emit(HomeStateLoaded(
      banner,
      category,
      location,
      recent,
      false,
    ));
  }

  bool getDoesScroll() {
    return doesScroll;
  }

  void setDoesScroll(bool scroll) {
    doesScroll = scroll;
  }

  bool getCalledExternally() {
    return calledExternally;
  }

  void setCalledExternally(bool called) {
    calledExternally = called;
  }

  Future<List<CategoryModel>> formatCategoriesList(
      List<CategoryModel> categories,
      List<CategoryModel> categoryCount,
      int? cityId) async {
    // Sort List
    Map<int, int?> idToCountMap = {};
    for (var obj in categoryCount) {
      idToCountMap[obj.id] = obj.count;
    }
    categories.sort(
        (a, b) => (idToCountMap[b.id] ?? 0).compareTo(idToCountMap[a.id] ?? 0));

    // Hide tag on empty categories
    for (var element in categories) {
      bool hasContent = await categoryHasContent(element.id, cityId);
      if (!hasContent) {
        element.hide = true;
      }
      if (element.id == 14 || element.id == 15) {
        element.hide = true;
      }
    }

    return categories;
  }

  Future<bool> doesUserExist() async {
    final int userId = await UserRepository.getLoggedUserId();
    if (userId == 0) return true;

    bool doesExist = await UserRepository.doesUserExist(userId);
    return doesExist;
  }

  Future<bool> categoryHasContent(int id, int? cityId) async {
    final response =
        await Api.requestCategoryCount(cityId == 0 ? null : cityId);
    final list = List.from(response.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();
    if (list.any((element) => element.id == id) ||
        (cityId == 0 && list.isNotEmpty)) {
      return true;
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

  String getCityName(List<CategoryModel>? cities, int cityId) {
    if (cities != null) {
      String name =
          cities[cities.indexWhere((category) => category.id == cityId)].title;
      return name;
    }
    return "";
  }

  List<CategoryModel> getCategoriesWithoutHidden(
      List<CategoryModel> categoryList) {
    List<CategoryModel> noHiddenCategoryList = [];
    for (var element in categoryList) {
      if (!element.hide) {
        noHiddenCategoryList.add(element);
      }
    }
    return noHiddenCategoryList;
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

  Future<dynamic> newListings(int pageNo) async {
    if (!await hasInternet()) {
      emit(const HomeState.error("no_internet"));
    }
    final listingsRequestResponse = await Api.requestRecentListings(pageNo);
    final newRecent = List.from(listingsRequestResponse.data ?? []).map((item) {
      return ProductModel.fromJson(item);
    }).toList();
    recent.addAll(newRecent);
    return recent;
  }

  Future<void> saveIgnoreAppVersion(String version) async {
    final prefs = await Preferences.openBox();
    await prefs.setKeyValue(Preferences.ignoredAppVersion, version);
  }

  Future<String> getIgnoreAppVersion() async {
    final prefs = await Preferences.openBox();
    String ignoreVersion =
        await prefs.getKeyValue(Preferences.ignoredAppVersion, '');
    return ignoreVersion;
  }

  Future<List<ProductModel>> searchListing(content, int pageNo) async {
    int currentCityFilter = await getCurrentCityFilter();
    List<ProductModel>? listDataList = [];
    MultiFilter multiFilter = MultiFilter(
        hasLocationFilter: true,
        currentLocation: currentCityFilter);

    final result = await ListRepository.searchListing(
        content: content, multiFilter: multiFilter, pageNo: pageNo);
    final List<ProductModel>? listUpdated = result?[0];

    if (listUpdated != null) {
      if (pageNo == 1) {
        recent = [];
      }
      recent.addAll(listUpdated);
    }

    for (final product in recent) {
      if (product != null) {
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
            externalId: product.externalId,
            expiryDate: product.expiryDate,
          ),
        );
      }
    }

    return listDataList;
  }

  Future<int> getCurrentCityFilter() async {
    final prefs = await Preferences.openBox();
    int filter = prefs.getKeyValue(Preferences.allListingCityFilter, 0);
    return filter;
  }
}
