import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';

part 'my_groups_state.freezed.dart';

@freezed
class MyGroupsState with _$MyGroupsState {
  const factory MyGroupsState.initial() = MyGroupsStateInitial;

  const factory MyGroupsState.loading() = MyGroupsStateLoading;

  const factory MyGroupsState.loaded(
      List<ForumGroupModel> list,
      int userId,
      ) = MyGroupsStateLoaded;

  const factory MyGroupsState.updated(
      List<ForumGroupModel> list,
      int userId,
      ) = MyGroupsStateUpdated;

  const factory MyGroupsState.error(String error) = MyGroupsStateError;
}