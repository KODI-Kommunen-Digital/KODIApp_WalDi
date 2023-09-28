import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_group_posts.dart';

part 'group_members_state.freezed.dart';

@freezed
class GroupMembersState with _$GroupMembersState {
  const factory GroupMembersState.initial() = GroupMembersStateInitial;

  const factory GroupMembersState.loading() = GroupMembersLoading;

  const factory GroupMembersState.loaded(
      List<GroupPostsModel> list,
      ) = GroupMembersLoaded;

  const factory GroupMembersState.error(String error) = GroupMembersStateError;
}
