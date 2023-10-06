import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_group_posts.dart';
import 'package:heidi/src/data/model/model_comment.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:loggy/loggy.dart';

import 'post_detail_state.dart';

class PostDetailCubit extends Cubit<PostDetailState> {
  UserModel? userDetail;
  final GroupPostsModel postDetail;
  final ForumRepository repo;

  PostDetailCubit(this.repo, this.postDetail)
      : super(const PostDetailLoading()) {
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

  Future<List<CommentModel>> getPostComments(
      int? forumId, int? postId, int page) async {
    try {
      final comments = await repo.getPostComments(forumId!, postId!, page);
      final commentsWithUserDetails =
          await fetchUserDetailsForComments(comments);
      return commentsWithUserDetails;
    } catch (e) {
      logError('Get Post Comments Failed', e.toString());
      return [];
    }
  }

  Future<ResultApiModel> addPostComments(
      int? forumId, int? postId, String comment) async {
    final response = await repo.addPostComments(forumId!, postId!, comment);
    return response;
  }

  Future<ResultApiModel> addPostCommentsReply(
      int? forumId, int? postId, String comment, int parentId) async {
    final response =
        await repo.addPostCommentsReply(forumId!, postId!, comment, parentId);
    return response;
  }

  Future<List<CommentModel>> getCommentReplies(
      int? forumId, int? postId, int? parentId, int? pageNo) async {
    try {
      final replies = await repo.getPostCommentsReplies(
          forumId!, postId!, parentId!, pageNo!);
      final repliesWithUserDetails = await fetchUserDetailsForComments(replies);
      return repliesWithUserDetails;
    } catch (e) {
      logError('Get Comment Replies Failed', e.toString());
      return [];
    }
  }

  Future<List<CommentModel>> fetchUserDetailsForComments(
      List<CommentModel> comments) async {
    final List<Future<CommentModel>> commentFutures =
        comments.map((comment) async {
      final userDetails =
          await UserRepository.requestUserDetails(comment.cityUserId);
      if (userDetails != null) {
        comment.userName = userDetails.username;
        comment.userProfileImage = userDetails.image;
      }
      return comment;
    }).toList();

    final commentsWithUserDetails = await Future.wait(commentFutures);
    return commentsWithUserDetails;
  }
}
