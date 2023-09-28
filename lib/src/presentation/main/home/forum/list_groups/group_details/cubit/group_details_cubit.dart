import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';
import 'package:heidi/src/data/model/model_group_posts.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';

import 'group_details_state.dart';

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  final ForumRepository repo;
  final ForumGroupModel arguments;
  GroupDetailsCubit(this.repo, this.arguments) : super(const GroupDetailsStateLoading()) {
    onLoad();
  }

  Future<void> onLoad() async {
    final groupPostsList = <GroupPostsModel>[];
    final requestGroupPostResponse = await repo.requestGroupPosts(arguments.id);
    if(requestGroupPostResponse?.data != null){
      for(final post in requestGroupPostResponse!.data){
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
}
