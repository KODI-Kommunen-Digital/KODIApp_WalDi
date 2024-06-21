import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_group_members.dart';

part 'group_members_state.freezed.dart';

@freezed
class GroupMembersState with _$GroupMembersState {
  const factory GroupMembersState.initial() = GroupMembersStateInitial;

  const factory GroupMembersState.loading() = GroupMembersLoading;

  const factory GroupMembersState.loaded(
    List<GroupMembersModel> list,
    bool isAdmin,
  ) = GroupMembersLoaded;

  const factory GroupMembersState.error(String error) = GroupMembersStateError;
}
