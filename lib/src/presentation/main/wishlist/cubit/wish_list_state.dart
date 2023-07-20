import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_favorites_detail_list.dart';

part 'wish_list_state.freezed.dart';

@freezed
class WishListState with _$WishListState {
  const factory WishListState.initial() = WishListInitial;

  const factory WishListState.loading() = WishListLoading;

  const factory WishListState.loaded(List<FavoriteDetailsModel> favorites) = WishListLoaded;

  const factory WishListState.error(String errorMessage) = WishListError;
}
