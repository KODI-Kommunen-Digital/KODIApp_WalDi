import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';
import 'package:heidi/src/data/model/model_group_members.dart';
import 'package:heidi/src/data/model/model_group_posts.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:intl/intl.dart';

import 'group_details_state.dart';

enum RemoveUser { error, removed, onlyAdmin, onlyUser }

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  final ForumRepository repo;
  final ForumGroupModel arguments;

  GroupDetailsCubit(this.repo, this.arguments)
      : super(const GroupDetailsStateLoading()) {
    onLoad();
  }

  Future<void> onLoad() async {
    final groupPostsList = <GroupPostsModel>[];
    final groupMembersList = <GroupMembersModel>[];
    bool isAdmin = false;
    final requestGroupPostResponse =
        await repo.requestGroupPosts(arguments.id, arguments.cityId);
    final requestGroupDetailResponse =
        await repo.requestGroupDetails(arguments.id);
    final response = requestGroupDetailResponse!.data;
    final group = ForumGroupModel(
      id: response['id'],
      forumName: response['forumName'],
      description: response['description'],
      cityId: arguments.cityId,
      image: response['image'],
      isRequested: arguments.isRequested,
      isJoined: arguments.isJoined,
      isPrivate: response['isPrivate'],
      createdAt: response['createdAt'],
    );
    if (requestGroupPostResponse?.data != null) {
      for (final post in requestGroupPostResponse!.data) {
        groupPostsList.add(GroupPostsModel(
          id: post['id'],
          forumId: post['forumId'],
          title: post['title'],
          description: post['description'],
          userId: post['userId'],
          image: post['image'],
          createdAt: DateFormat('dd.MM.yyyy').format(
            DateTime.parse(
              post['createdAt'],
            ),
          ),
          isHidden: post['isHidden'],
        ));
      }
    }

    final userId = await UserRepository.getLoggedUserId();
    final requestGroupMembersResponse =
          await repo.getGroupMembers(group.id);
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
        GroupMembersModel groupMember =
        groupMembersList.firstWhere((element) => element.userId == userId);
        isAdmin = groupMember.isAdmin == 1 ? true : false;
      }
      emit(GroupDetailsState.loaded(groupPostsList, group, isAdmin, userId));

  }

  Future<void> requestDeleteGroup(forumId, cityId) async {
    await repo.requestDeleteForum(forumId, cityId);
  }

  Future<RemoveUser> removeGroupMember(groupId, cityId) async {
    int adminCount = 0;
    final groupMembersList = <GroupMembersModel>[];
    final requestGroupMembersResponse =
        await repo.getGroupMembers(groupId);
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
        return RemoveUser.removed;
      } else {
        if (groupMembersList.length > 1) {
          if (adminCount > 1) {
            repo.removeUserFromGroup(groupId, groupMemberDetail.memberId);
            return RemoveUser.removed;
          } else {
            return RemoveUser.onlyAdmin;
          }
        } else {
          return RemoveUser.onlyUser;
        }
      }
    } else {
      return RemoveUser.error;
    }
  }
}
