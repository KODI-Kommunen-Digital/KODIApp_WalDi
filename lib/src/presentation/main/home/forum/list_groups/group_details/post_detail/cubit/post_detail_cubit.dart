import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_group_posts.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:loggy/loggy.dart';

import 'post_detail_state.dart';

class PostDetailCubit extends Cubit<PostDetailState> {
  UserModel? userDetail;
  final GroupPostsModel postDetail;

  PostDetailCubit(this.postDetail) : super(const PostDetailLoading()) {
    onLoad();
  }

  void onLoad() async {
    final userDetailResponse =
        await UserRepository.requestUserDetails(postDetail.userId);
    if (userDetailResponse != null) {
      emit(PostDetailState.loaded(userDetailResponse));
    } else {
      logError('User Detail Response Failed', userDetailResponse);
    }
  }

  Future<int> getLoggedInUserId() async {
    return await UserRepository.getLoggedUserId();
  }
}
