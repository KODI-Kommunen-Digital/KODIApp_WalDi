import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';

part 'list_groups_state.freezed.dart';

@freezed
class ListGroupsState with _$ListGroupsState {
  const factory ListGroupsState.initial() = ListGroupsStateInitial;

  const factory ListGroupsState.loading() = ListGroupsStateLoading;

  const factory ListGroupsState.loaded(
    List<ForumGroupModel> list,
    int userId,
  ) = ListGroupsStateLoaded;

  const factory ListGroupsState.updated(
    List<ForumGroupModel> list,
    int userId,
  ) = ListGroupsStateUpdated;

  const factory ListGroupsState.error(String error) = ListGroupsStateError;
}
