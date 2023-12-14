import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_group_posts.dart';
import 'package:heidi/src/data/model/model_comment.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:loggy/loggy.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'post_detail_state.dart';

class PostDetailCubit extends Cubit<PostDetailState> {
  UserModel? userDetail;
  final ForumRepository repo;
  final GroupPostsModel postDetail;
  final int cityId;
  final int userId;
  final bool isAdmin;

  PostDetailCubit(
      this.repo, this.postDetail, this.cityId, this.userId, this.isAdmin)
      : super(const PostDetailLoading()) {
    onLoad();
  }

  void onLoad() async {
    final userDetailResponse =
        await UserRepository.getUserDetails(postDetail.userId, cityId);
    if (userDetailResponse != null) {
      final user = await UserRepository.loadUser();
      final userImage = user!.image;
      emit(PostDetailState.loaded(
          userDetailResponse, userImage, userId, isAdmin));
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
      final comments =
          await repo.getPostComments(forumId!, postId!, page, cityId);
      final commentsWithUserDetails =
          await fetchUserDetailsForComments(comments);
      return commentsWithUserDetails;
    } catch (e, stackTrace) {
      logError('Get Post Comments Failed', e.toString());
      await Sentry.captureException(e, stackTrace: stackTrace);

      return [];
    }
  }

  Future<ResultApiModel> addPostComments(
      int? forumId, int? postId, String comment) async {
    final response =
        await repo.addPostComments(forumId!, postId!, comment, cityId);
    return response;
  }

  Future<ResultApiModel> addPostCommentsReply(
      int? forumId, int? postId, String comment, int parentId) async {
    final response = await repo.addPostCommentsReply(
        forumId!, postId!, comment, parentId, cityId);
    return response;
  }

  Future<List<CommentModel>> getCommentReplies(
      int? forumId, int? postId, int? parentId, int? pageNo) async {
    try {
      final replies = await repo.getPostCommentsReplies(
          forumId!, postId!, parentId!, pageNo!, cityId);
      final repliesWithUserDetails = await fetchUserDetailsForComments(replies);
      return repliesWithUserDetails;
    } catch (e, stackTrace) {
      logError('Get Comment Replies Failed', e.toString());
      await Sentry.captureException(e, stackTrace: stackTrace);

      return [];
    }
  }

  Future<List<CommentModel>> fetchUserDetailsForComments(
      List<CommentModel> comments) async {
    // final prefs = await Preferences.openBox();
    // int cityId = prefs.getKeyValue(Preferences.cityId, 0);
    final List<Future<CommentModel>> commentFutures =
        comments.map((comment) async {
      final userDetails =
          await UserRepository.getUserDetails(comment.cityUserId, cityId);
      if (userDetails != null) {
        comment.userName = userDetails.username;
        comment.userProfileImage = userDetails.image;
      }
      return comment;
    }).toList();

    final commentsWithUserDetails = await Future.wait(commentFutures);
    return commentsWithUserDetails;
  }

  Future<String?> fetchLoggedInUserProfileImage() async {
    final loggedInUserId = await UserRepository.getLoggedUserId();
    final userDetails = await UserRepository.fetchUser(loggedInUserId);
    final loggedInUserProfileImage = userDetails?.image;
    return loggedInUserProfileImage;
  }

  Future<bool> reportGroupPosts(forumId, postId, reason) async {
    final response =
        await repo.reportGroupPosts(forumId, postId, reason, cityId);
    if (response!.success) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteGroupPost(forumId, postId) async {
    final response = await repo.deleteGroupPost(forumId, cityId, postId);
    if (response!.success) {
      return true;
    } else {
      return false;
    }
  }
}
