import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_member_request.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/member_requests/cubit/member_request_state.dart';

class MembersRequestsCubit extends Cubit<MemberRequestState> {
  final ForumRepository repo;
  final int groupId;
  final int cityId;

  MembersRequestsCubit(this.repo, this.groupId, this.cityId)
      : super(const MemberRequestLoading()) {
    onLoad();
  }

  Future<void> onLoad() async {
    final memberRequestList = <MemberRequestModel>[];
    final requestMemberRequestResponse = await repo.getMemberRequests(groupId, cityId);
    if (requestMemberRequestResponse?.data != null) {
      for (final member in requestMemberRequestResponse!.data) {
        memberRequestList.add(MemberRequestModel(
          cityUserId: member['cityUserId'],
          image: member['image'],
          username: member['username'],
          firstname: member['firstname'],
          lastname: member['lastname'],
          createdAt: member['createdAt'],
          requestId: member['requestId'],
        ));
      }
    }
    emit(MemberRequestState.loaded(memberRequestList));
  }

  Future<int> getLoggedInUserId() async {
    return UserRepository.getLoggedUserId();
  }

  Future<bool> acceptMemberRequests(memberRequestId) async {
    final response = await repo.acceptMemberRequests(
      groupId,
      memberRequestId,
      cityId,
    );
    if (response!.success) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> rejectMemberRequests(memberRequestId, reason) async {
    final response = await repo.rejectMemberRequests(
      groupId,
      memberRequestId,
      reason,
      cityId
    );
    if (response!.success) {
      return true;
    } else {
      return false;
    }
  }
}
