import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_listings/cubit/all_listings_state.dart';
import 'package:loggy/loggy.dart';

class AllListingsCubit extends Cubit<AllListingsState> {
  AllListingsCubit() : super(const AllListingsState.loading()) {
    onLoad();
  }

  dynamic posts;

  Future<void> onLoad() async {
    emit(const AllListingsState.loading());
    final listingsRequestResponse = await Api.requestRecentListings(1);
    posts = List.from(listingsRequestResponse.data ?? []).map((item) {
      return ProductModel.fromJson(item);
    }).toList();

    emit(AllListingsState.loaded(posts));
  }

  Future<dynamic> newListings(int pageNo) async {
    if (pageNo == 1) posts = [];
    final listingsRequestResponse = await Api.requestRecentListings(pageNo);
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
}
