import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';
import 'package:heidi/src/data/model/model_group_members.dart';
import 'package:heidi/src/data/model/model_group_posts.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';

import 'group_details_state.dart';

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  final ForumRepository repo;
  final ForumGroupModel arguments;

  GroupDetailsCubit(this.repo, this.arguments)
      : super(const GroupDetailsStateLoading()) {
    onLoad();
  }

  Future<void> onLoad() async {
    final groupPostsList = <GroupPostsModel>[];
    final requestGroupPostResponse = await repo.requestGroupPosts(arguments.id);
    if (requestGroupPostResponse?.data != null) {
      for (final post in requestGroupPostResponse!.data) {
        groupPostsList.add(GroupPostsModel(
          id: post['id'],
          forumId: post['forumId'],
          title: post['title'],
          description: post['description'],
          userId: post['userId'],
          image: post['image'],
          createdAt: post['createdAt'],
          isHidden: post['isHidden'],
        ));
      }

      emit(GroupDetailsState.loaded(groupPostsList));
    }
  }

  Future<bool> removeGroupMember(groupId) async {
    int adminCount = 0;
    final groupMembersList = <GroupMembersModel>[];
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
        if (member['isAdmin'] == 1) {
          adminCount++;
        }
      }

      int userId = await UserRepository.getLoggedUserId();
      final groupMemberDetail =
          groupMembersList.firstWhere((element) => element.userId == userId);
      bool isUserAdmin = groupMemberDetail.isAdmin == 1 ? true : false;
      if (!isUserAdmin) {
        repo.removeUserFromGroup(groupId, groupMemberDetail.memberId);
        return true;
      } else {
        if (adminCount > 1) {
          repo.removeUserFromGroup(groupId, groupMemberDetail.memberId);
          return true;
        } else {
          return false;
        }
      }
    } else {
      return false;
    }
  }
}
