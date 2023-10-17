import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_product.dart';

part 'all_requests_state.freezed.dart';

@freezed
class AllRequestsState with _$AllRequestsState {
  const factory AllRequestsState.initial() = AllRequestsStateInitial;

  const factory AllRequestsState.loading() = AllRequestsStateLoading;

  const factory AllRequestsState.loaded(
      List<ProductModel> recent, bool isRefreshLoader) = AllRequestsStateLoaded;
}
