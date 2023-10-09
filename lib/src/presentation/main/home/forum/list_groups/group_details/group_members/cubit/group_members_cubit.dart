import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_group_members.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';

import 'group_members_state.dart';

class GroupMembersCubit extends Cubit<GroupMembersState> {
  final ForumRepository repo;
  final int groupId;

  GroupMembersCubit(this.repo, this.groupId)
      : super(const GroupMembersLoading()) {
    onLoad();
  }

  Future<void> onLoad() async {
    final groupMembersList = <GroupMembersModel>[];
    bool isAdmin = false;
    final requestGroupMembersResponse = await repo.getGroupMembers(groupId);
    if (requestGroupMembersResponse?.data != null) {
      for (final member in requestGroupMembersResponse!.data) {
        groupMembersList.add(GroupMembersModel(
          userId: member['userId'],
          username: member['username'],
          memberId: member['memberId'],
          firstname: member['firstname'],
          lastname: member['lastname'],
          image: member['image'],
          isAdmin: member['isAdmin'],
          joinedAt: member['joinedAt'],
        ));
      }
    }

    groupMembersList.sort((a, b) {
      if (a.isAdmin == 1 && b.isAdmin != 1) {
        return -1;
      } else if (a.isAdmin != 1 && b.isAdmin == 1) {
        return 1;
      } else {
        return 0;
      }
    });

    final loggedUserId = await UserRepository.getLoggedUserId();
    final groupMember = groupMembersList
        .firstWhere((element) => element.userId == loggedUserId);
    if (groupMember.isAdmin == 1) {
      isAdmin = true;
    } else {
      isAdmin = false;
    }
    emit(GroupMembersState.loaded(groupMembersList, isAdmin));
  }

  Future<int> getLoggedInUserId() async {
    return UserRepository.getLoggedUserId();
  }

  Future<bool> requestMakeUserAdmin(forumId, memberId) async {
    final response = await repo.requestMakeUserAdmin(forumId, memberId);
    if (response!.success) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> removeUserFromGroup(groupId, memberId) async {
    return await repo.removeUserFromGroup(groupId, memberId);
  }

  Future<bool> requestRemoveAdmin(forumId, memberId) async {
    final response = await repo.requestRemoveAdmin(forumId, memberId);
    if (response) {
      return true;
    } else {
      return false;
    }
  }
}
