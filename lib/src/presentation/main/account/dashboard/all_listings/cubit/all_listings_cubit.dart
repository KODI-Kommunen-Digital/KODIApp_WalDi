import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_listings/cubit/all_listings_state.dart';

class AllListingsCubit extends Cubit<AllListingsState> {
  AllListingsCubit() : super(const AllListingsState.loading());

  dynamic posts;

  Future<void> onLoad() async {
    final listingsRequestResponse = await Api.requestRecentListings(1);
    posts = List.from(listingsRequestResponse.data ?? []).map((item) {
      return ProductModel.fromJson(item);
    }).toList();

    emit(AllListingsState.loaded(posts));
  }

  Future<dynamic> newListings(int pageNo) async {
    final listingsRequestResponse = await Api.requestRecentListings(pageNo);
    final newRecent = List.from(listingsRequestResponse.data ?? []).map((item) {
      return ProductModel.fromJson(item);
    }).toList();
    posts.addAll(newRecent);
    return posts;
  }
}
