import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_product.dart';

part 'all_listings_state.freezed.dart';

@freezed
class AllListingsState with _$AllListingsState {
  const factory AllListingsState.initial() = AllListingsStateInitial;

  const factory AllListingsState.loading() = AllListingsStateLoading;

  const factory AllListingsState.loaded(
      List<ProductModel> recent, bool isRefreshLoader) = AllListingsStateLoaded;
}
