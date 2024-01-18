import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_comment.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/post_detail/cubit/post_detail_cubit.dart';
import 'package:heidi/src/presentation/widget/app_forum_comment_input.dart';
import 'package:heidi/src/presentation/widget/app_forum_comment_reply.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:loggy/loggy.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CommentsBottomSheet extends StatefulWidget {
  final int? forumId;
  final int? postId;
  final List<CommentModel> comments;
  final PostDetailCubit postDetailCubit;
  final String? userProfileImage;
  final String userImage;

  const CommentsBottomSheet({
    Key? key,
    required this.forumId,
    required this.postId,
    required this.comments,
    required this.postDetailCubit,
    required this.userProfileImage,
    required this.userImage,
  }) : super(key: key);

  @override
  CommentsBottomSheetState createState() => CommentsBottomSheetState();
}

class CommentsBottomSheetState extends State<CommentsBottomSheet> {
  List<CommentModel> comments = [];
  bool isAddingReply = false;
  int currentPage = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    comments.addAll(widget.comments);
    scrollController.addListener(_scrollListener);
  }

  TextEditingController commentController = TextEditingController();
  TextEditingController replyController = TextEditingController();

  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void toggleAddingReply() {
    setState(() {
      if (!isAddingReply) {
        replyController.clear();
      }
      isAddingReply = !isAddingReply;
    });
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !isLoading) {
      _loadNextPage();
    }
  }

  void _loadNextPage() async {
    setState(() {
      isLoading = true;
    });

    currentPage++;

    try {
      final forumId = widget.forumId;
      final postId = widget.postId;
      final updatedComments = await widget.postDetailCubit
          .getPostComments(forumId!, postId!, currentPage);

      setState(() {
        comments.addAll(updatedComments);
        isLoading = false;
      });
    } catch (e, stackTrace) {
      logError('Failed to load next page of comments', e.toString());
      setState(() {
        isLoading = false;
      });
      await Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Translate.of(context).translate('comments'),
        ),
        backgroundColor: Colors.grey.shade900,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  controller: scrollController,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return Provider(
                      create: (BuildContext context) {},
                      child: CommentWidget(
                        comment: comments[index],
                        postDetailCubit: widget.postDetailCubit,
                        toggleAddingReply: toggleAddingReply,
                        isAddingReply: isAddingReply,
                      ),
                    );
                  },
                ),
                if (isLoading)
                  const Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
              ],
            ),
          ),
          CommentInputWidget(
            forumId: widget.forumId,
            postId: widget.postId,
            commentController: commentController,
            replyController: replyController,
            isAddingReply: isAddingReply,
            toggleAddingReply: toggleAddingReply,
            userProfileImage: widget.userProfileImage,
            userImage: widget.userImage,
            postDetailCubit: widget.postDetailCubit,
            onCommentAdded: () async {
              currentPage = 1;
              final updatedComments = await widget.postDetailCubit
                  .getPostComments(
                      widget.forumId!, widget.postId!, currentPage);
              setState(() {
                comments = updatedComments;
              });
            },
          ),
        ],
      ),
    );
  }
}

class CommentWidget extends StatefulWidget {
  final CommentModel comment;
  final PostDetailCubit postDetailCubit;
  final VoidCallback? toggleAddingReply;
  final bool isAddingReply;

  const CommentWidget({
    Key? key,
    required this.comment,
    required this.postDetailCubit,
    required this.toggleAddingReply,
    required this.isAddingReply,
  }) : super(key: key);

  @override
  CommentWidgetState createState() => CommentWidgetState();
}

class CommentWidgetState extends State<CommentWidget> {
  bool showReplies = false;
  bool isAddingReply = false;
  List<CommentModel>? replies;

  Future<void> fetchReplies() async {
    try {
      final forumId = widget.comment.forumId;
      final postId = widget.comment.postId;
      final parentId = widget.comment.id;

      if (forumId != null && postId != null && parentId != null) {
        final fetchedReplies = await widget.postDetailCubit
            .getCommentReplies(forumId, postId, parentId, 1);

        setState(() {
          replies = fetchedReplies;
        });
      }
    } catch (e, stackTrace) {
      logError('Failed to fetch comment replies', e.toString());
      await Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              (widget.comment.userProfileImage == 'Keine Angabe' ||
                      widget.comment.userProfileImage == "")
                  ? Application.defaultPicturesURL
                  : "${Application.picturesURL}${widget.comment.userProfileImage}",
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  widget.comment.username!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.comment.comment!,
                style: const TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!widget.isAddingReply)
                    TextButton(
                      onPressed: () async {
                        final prefs = await Preferences.openBox();
                        prefs.setKeyValue(
                            Preferences.commentId, widget.comment.id);
                        setState(() {
                          widget.toggleAddingReply?.call();
                        });
                      },
                      child: Text(
                        Translate.of(context).translate('reply'),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  const SizedBox(width: 8),
                  if (!widget.isAddingReply)
                    if (widget.comment.childrenCount != 0)
                      TextButton(
                        onPressed: () {
                          if (!showReplies) {
                            fetchReplies();
                          }
                          setState(() {
                            showReplies = !showReplies;
                          });
                        },
                        child: Text(
                          showReplies
                              ? Translate.of(context).translate('hide_reply')
                              : widget.comment.childrenCount != 0
                                  ? '${widget.comment.childrenCount} ${Translate.of(context).translate('view_reply')}'
                                  : Translate.of(context).translate('no_reply'),
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                ],
              ),
            ],
          ),
        ),
        if (showReplies && replies != null)
          Column(
            children: [
              const Divider(),
              for (final reply in replies!)
                CommentReplyWidget(
                  comment: reply,
                  postDetailCubit: widget.postDetailCubit,
                ),
            ],
          ),
      ],
    );
  }
}
