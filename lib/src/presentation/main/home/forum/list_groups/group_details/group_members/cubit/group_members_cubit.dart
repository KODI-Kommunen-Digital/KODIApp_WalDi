import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';

import 'group_members_state.dart';

class GroupMembersCubit extends Cubit<GroupMembersState> {
  final ForumRepository repo;
  final int groupId;
  GroupMembersCubit(this.repo, this.groupId) : super(const GroupMembersLoading()) {
    onLoad();
  }

  Future<void> onLoad() async {

  }
}
