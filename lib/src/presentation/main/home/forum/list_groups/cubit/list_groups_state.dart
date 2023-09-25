import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_product.dart';

part 'list_groups_state.freezed.dart';

@freezed
class ListGroupsState with _$ListGroupsState {
  const factory ListGroupsState.initial() = ListGroupsStateInitial;

  const factory ListGroupsState.loading() = ListGroupsStateLoading;

  const factory ListGroupsState.loaded(
    List<ProductModel> list,
  ) = ListGroupsStateLoaded;

  const factory ListGroupsState.updated(
    List<ProductModel> list,
  ) = ListGroupsStateUpdated;

  const factory ListGroupsState.error(String error) = ListGroupsStateError;
}
