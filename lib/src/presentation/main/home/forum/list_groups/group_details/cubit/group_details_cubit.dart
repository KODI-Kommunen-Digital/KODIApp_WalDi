import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';

import 'group_details_state.dart';

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  final ForumRepository repo;
  final ForumGroupModel arguments;
  GroupDetailsCubit(this.repo, this.arguments) : super(const GroupDetailsStateLoading()) {
    onLoad();
  }

  Future<void> onLoad() async {
  }
}
