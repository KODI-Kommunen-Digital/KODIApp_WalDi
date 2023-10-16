import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_group_members.dart';
import 'package:heidi/src/data/model/model_request_member.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/member_requests/cubit/member_request_state.dart';

class MembersRequestsCubit extends Cubit<MemberRequestState> {
  final ForumRepository repo;
  final int groupId;

  MembersRequestsCubit(this.repo, this.groupId)
      : super(const MemberRequestLoading()) {
    onLoad();
  }

  Future<void> onLoad() async {
    final memberRequestList = <RequestMemberModel>[];
    final requestMemberRequestResponse = await repo.getMemberRequests(groupId);
      if (requestMemberRequestResponse?.data != null) {
      for (final member in requestMemberRequestResponse!.data) {
        memberRequestList.add(RequestMemberModel(
          forumId: member['forumId'],
          userId: member['userId'],
          reason: member['reason'],
          statusId: member['statusId'],
          id: member['id'],
          createdAt: member['createdAt'],
          updatedAt: member['updatedAt'],
        ));
      }
    }
  //   emit(GroupMembersState.loaded(groupMembersList, isAdmin));
  }

  Future<int> getLoggedInUserId() async {
    return UserRepository.getLoggedUserId();
  }
}
