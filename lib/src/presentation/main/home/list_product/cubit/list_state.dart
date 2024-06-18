import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_product.dart';

part 'list_state.freezed.dart';

@freezed
class ListState with _$ListState {
  const factory ListState.initial() = ListStateInitial;

  const factory ListState.loading() = ListStateLoading;

  const factory ListState.loaded(List<ProductModel> list, List cityList) =
      ListStateLoaded;

  const factory ListState.updated(List<ProductModel> list, List cityList) =
      ListStateUpdated;

  const factory ListState.error(String error) = ListStateError;
}
