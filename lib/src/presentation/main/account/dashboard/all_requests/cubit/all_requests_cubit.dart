import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_result_api.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_requests/cubit/all_requests_state.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:loggy/loggy.dart';

class AllRequestsCubit extends Cubit<AllRequestsState> {
  AllRequestsCubit() : super(const AllRequestsState.loading()) {
    onLoad(false);
  }

  dynamic posts;

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) emit(const AllRequestsState.loading());

    final ResultApiModel listingsRequestResponse =
        await Api.requestStatusListings(3, 1);

    posts = List.from(listingsRequestResponse.data ?? []).map((item) {
      return ProductModel.fromJson(item);
    }).toList();

    emit(AllRequestsState.loaded(posts, isRefreshLoader));
  }

  Future<dynamic> newListings(int pageNo) async {
    if (pageNo == 1) posts = [];
    final ResultApiModel listingsRequestResponse =
        await Api.requestStatusListings(3, pageNo);

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
