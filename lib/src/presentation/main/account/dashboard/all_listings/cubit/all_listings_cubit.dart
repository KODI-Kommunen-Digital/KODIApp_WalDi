import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_result_api.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_listings/cubit/all_listings_state.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:loggy/loggy.dart';

enum StatusFilter {
  week,
  month,
}

class AllListingsCubit extends Cubit<AllListingsState> {
  AllListingsCubit() : super(const AllListingsState.loading()) {
    onLoad();
  }

  dynamic posts;
  StatusFilter? selectedStatusFilter;

  Future<void> onLoad() async {
    int status = await getCurrentStatus();
    final ResultApiModel listingsRequestResponse;

    if (status == 0) {
      listingsRequestResponse = await Api.requestAllListings(1);
    } else {
      listingsRequestResponse = await Api.requestStatusListings(status, 1);
    }

    posts = List.from(listingsRequestResponse.data ?? []).map((item) {
      return ProductModel.fromJson(item);
    }).toList();

    emit(AllListingsState.loaded(posts));
  }

  Future<dynamic> newListings(int pageNo) async {
    if (pageNo == 1) posts = [];
    final int status = await getCurrentStatus();
    final ResultApiModel listingsRequestResponse;

    if (status == 0) {
      listingsRequestResponse = await Api.requestAllListings(pageNo);
    } else {
      listingsRequestResponse = await Api.requestStatusListings(status, pageNo);
    }

    final newRecent = List.from(listingsRequestResponse.data ?? []).map((item) {
      return ProductModel.fromJson(item);
    }).toList();
    posts.addAll(newRecent);
    return posts;
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
