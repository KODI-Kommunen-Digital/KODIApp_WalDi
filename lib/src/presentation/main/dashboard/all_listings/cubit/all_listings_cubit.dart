import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_result_api.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/presentation/main/dashboard/all_listings/cubit/all_listings_state.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:loggy/loggy.dart';

enum StatusFilter {
  week,
  month,
}

class AllListingsCubit extends Cubit<AllListingsState> {
  AllListingsCubit() : super(const AllListingsState.loading()) {
    onLoad(false);
  }

  dynamic posts;
  StatusFilter? selectedStatusFilter;

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) emit(const AllListingsState.loading());

    List<ProductModel> listDataList = [];
    int status = await getCurrentStatus();
    final ResultApiModel listingsRequestResponse;
    int currentCityFilter = await getCurrentCityFilter();

    if (status == 0 && currentCityFilter == 0) {
      listingsRequestResponse = await Api.requestAllListings(1);
    } else if (status != 0 && currentCityFilter == 0) {
      listingsRequestResponse = await Api.requestStatusListings(status, 1);
    } else if (status != 0 && currentCityFilter != 0) {
      listingsRequestResponse =
          await Api.requestStatusLocList(currentCityFilter, 1, status);
    } else {
      listingsRequestResponse = await Api.requestLocList(currentCityFilter, 1);
    }

    List<ProductModel> productData =
        List.from(listingsRequestResponse.data ?? []).map((item) {
      return ProductModel.fromJson(item);
    }).toList();

    for (final listing in productData) {
      final product = await loadProduct(listing.cityId, listing.id);
      if (product != null) {
        listDataList.add(
          ProductModel(
            id: listing.id,
            cityId: listing.cityId,
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
            externalId: product.externalId,
            description: product.description,
            statusId: product.statusId,
            userId: product.userId,
            sourceId: product.sourceId,
            imageLists: product.imageLists,
            expiryDate: product.expiryDate,
          ),
        );
      }
    }

    posts = listDataList;

    emit(AllListingsState.loaded(
        posts, isRefreshLoader, status, currentCityFilter));
  }

  Future<ProductModel?> loadProduct(cityId, id) async {
    final loadProductResponse = await ListRepository.loadProduct(cityId, id);
    return loadProductResponse;
  }

  Future<dynamic> newListings(int pageNo) async {
    if (pageNo == 1) posts = [];
    final int status = await getCurrentStatus();
    final ResultApiModel listingsRequestResponse;
    List<ProductModel> listDataList = [];
    int currentCityFilter = await getCurrentCityFilter();

    if (status == 0 || currentCityFilter == 0) {
      listingsRequestResponse = await Api.requestAllListings(pageNo);
    } else if (status != 0 && currentCityFilter == 0) {
      listingsRequestResponse = await Api.requestStatusListings(status, pageNo);
    } else if (status != 0 && currentCityFilter != 0) {
      listingsRequestResponse =
          await Api.requestStatusLocList(currentCityFilter, pageNo, status);
    } else {
      listingsRequestResponse =
          await Api.requestLocList(currentCityFilter, pageNo);
    }

    final newProductData =
        List.from(listingsRequestResponse.data ?? []).map((item) {
      return ProductModel.fromJson(item);
    }).toList();
    for (final listing in newProductData) {
      final product = await loadProduct(listing.cityId, listing.id);
      if (product != null) {
        listDataList.add(
          ProductModel(
            id: listing.id,
            cityId: listing.cityId,
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
            externalId: product.externalId,
            description: product.description,
            statusId: product.statusId,
            userId: product.userId,
            sourceId: product.sourceId,
            imageLists: product.imageLists,
            expiryDate: product.expiryDate,
          ),
        );
      }
    }
    posts.addAll(listDataList);
    return posts;
  }

  Future<void> setCurrentCityFilter(int filter) async {
    final prefs = await Preferences.openBox();
    prefs.setKeyValue(Preferences.allListingCityFilter, filter);
  }

  Future<int> getCurrentCityFilter() async {
    final prefs = await Preferences.openBox();
    int filter = prefs.getKeyValue(Preferences.allListingCityFilter, 0);
    return filter;
  }

  Future<int> getCurrentStatusFilter() async {
    final prefs = await Preferences.openBox();
    int filter = prefs.getKeyValue(Preferences.listingStatusFilter, 0);
    return filter;
  }

  Future<List<ProductModel>?> searchListing(content, int pageNo) async {
    int currentListingFilter = await getCurrentStatus();
    int currentCityFilter = await getCurrentCityFilter();
    List<ProductModel>? listDataList = [];
    MultiFilter multiFilter = MultiFilter(
        hasLocationFilter: true,
        hasListingStatusFilter: true,
        currentListingStatus: currentListingFilter,
        currentLocation: currentCityFilter);

    final result = await ListRepository.searchListing(
        content: content, multiFilter: multiFilter, pageNo: pageNo);
    final List<ProductModel>? listUpdated = result?[0];

    if (listUpdated != null) {
      if (pageNo == 1) {
        posts = [];
      }
      posts.addAll(listUpdated);
    }

    for (final product in posts) {
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

  Future<bool> deleteUserList(int? cityId, int listingId) async {
    final response = await Api.deleteUserList(cityId, listingId);
    if (response.success) {
      return true;
    } else {
      logError('Remove UserList Response Failed', response.message);
      return false;
    }
  }

  Future<int> getCurrentStatus() async {
    final prefs = await Preferences.openBox();
    int status = await prefs.getKeyValue(Preferences.listingStatusFilter, 0);
    return status;
  }

  Future<void> setCurrentStatus(int status) async {
    final prefs = await Preferences.openBox();
    prefs.setKeyValue(Preferences.listingStatusFilter, status);
  }
}
