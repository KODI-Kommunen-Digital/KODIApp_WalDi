import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_comment.dart';
import 'package:heidi/src/data/model/model_result_api.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/post_detail/cubit/post_detail_cubit.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:loggy/loggy.dart';
import 'package:provider/provider.dart';

int? currentCommentId;

class CommentsBottomSheet extends StatefulWidget {
  final int? forumId;
  final int? postId;
  final List<CommentModel> comments;
  final PostDetailCubit postDetailCubit;
  final String? userProfileImage;

  const CommentsBottomSheet({
    Key? key,
    required this.forumId,
    required this.postId,
    required this.comments,
    required this.postDetailCubit,
    required this.userProfileImage,
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
      final updatedComments = await widget.postDetailCubit.getPostComments(
        forumId!,
        postId!,
        currentPage,
      );

      setState(() {
        comments.addAll(updatedComments);
        isLoading = false;
      });
    } catch (e) {
      logError('Failed to load next page of comments', e.toString());
      setState(() {
        isLoading = false;
      });
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
          const SizedBox(height: 8), // Add some spacing
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
        final fetchedReplies = await widget.postDetailCubit.getCommentReplies(
          forumId,
          postId,
          parentId,
          1,
        );

        setState(() {
          replies = fetchedReplies;
        });
      }
    } catch (e) {
      logError('Failed to fetch comment replies', e.toString());
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
                      onPressed: () {
                        setState(() {
                          isAddingReply = !isAddingReply;
                          if (isAddingReply) {
                            currentCommentId = widget.comment.id;
                            widget.toggleAddingReply?.call();
                          } else {
                            currentCommentId = null;
                          }
                        });
                      },
                      child: const Text(
                        'Reply',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
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
                              ? 'Hide Replies'
                              : widget.comment.childrenCount != 0
                                  ? 'View ${widget.comment.childrenCount} Replies'
                                  : 'No Replies Available',
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

class CommentReplyWidget extends StatefulWidget {
  final CommentModel comment;
  final PostDetailCubit postDetailCubit;

  const CommentReplyWidget({
    Key? key,
    required this.comment,
    required this.postDetailCubit,
  }) : super(key: key);

  @override
  CommentReplyWidgetState createState() => CommentReplyWidgetState();
}

class CommentReplyWidgetState extends State<CommentReplyWidget> {
  List<CommentModel>? replies;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(left: 40),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              (widget.comment.userProfileImage == 'Keine Angabe' ||
                      widget.comment.userProfileImage == "")
                  ? Application.defaultPicturesURL
                  : "${Application.picturesURL}${widget.comment.userProfileImage}",
            ),
            radius: 20,
          ),
          title: Text(
            widget.comment.username!,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          subtitle: Text(
            widget.comment.comment!,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        if (replies != null)
          Column(
            children: [
              for (final reply in replies!)
                Column(
                  children: [
                    const Divider(
                      height: 8,
                      thickness: 4,
                    ),
                    CommentReplyWidget(
                      comment: reply,
                      postDetailCubit: widget.postDetailCubit,
                    ),
                  ],
                ),
            ],
          ),
      ],
    );
  }
}

class CommentInputWidget extends StatefulWidget {
  final int? forumId;
  final int? postId;
  final TextEditingController? commentController;
  final TextEditingController? replyController;
  final bool isAddingReply;
  final VoidCallback? toggleAddingReply;
  final String? userProfileImage;
  final PostDetailCubit postDetailCubit;
  final VoidCallback? onCommentAdded;

  const CommentInputWidget({
    Key? key,
    required this.forumId,
    required this.postId,
    required this.commentController,
    required this.replyController,
    required this.isAddingReply,
    required this.toggleAddingReply,
    required this.userProfileImage,
    required this.postDetailCubit,
    this.onCommentAdded,
  }) : super(key: key);

  @override
  CommentInputWidgetState createState() => CommentInputWidgetState();
}

class CommentInputWidgetState extends State<CommentInputWidget> {
  void resetInput() {
    setState(() {
      widget.toggleAddingReply?.call();
      widget.commentController?.clear();
    });
  }

  Future<ResultApiModel> addComment(String value) async {
    final comment = value;
    final response = await widget.postDetailCubit.addPostComments(
      widget.forumId,
      widget.postId,
      comment,
    );
    if (response.success) {
      widget.onCommentAdded?.call();
    }
    return response;
  }

  Future<ResultApiModel> addReply(String value, int parentId) async {
    final reply = value;
    final response = await widget.postDetailCubit.addPostCommentsReply(
      widget.forumId,
      widget.postId,
      reply,
      parentId,
    );
    if (response.success) {
      widget.onCommentAdded?.call();
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const CircleAvatar(
            //profile pic of user is not shown correctly (TODO)
            // backgroundImage: NetworkImage(
            //   (widget.userProfileImage == 'Keine Angabe' ||
            //           widget.userProfileImage == "")
            //       ? Application.defaultPicturesURL
            //       : "${Application.picturesURL}${widget.userProfileImage}",
            // ),
            backgroundImage: NetworkImage(Application.defaultPicturesURL),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: widget.isAddingReply
                  ? widget.replyController
                  : widget.commentController,
              decoration: InputDecoration(
                hintText:
                    widget.isAddingReply ? 'Add a reply' : 'Add a comment',
                hintStyle: const TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
            ),
          ),
          if (widget.isAddingReply)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.white),
              onPressed: resetInput,
            ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: () {
              final value = widget.isAddingReply
                  ? widget.replyController!.text
                  : widget.commentController!.text;

              if (value.isNotEmpty && !widget.isAddingReply) {
                addComment(value);

                widget.commentController!.clear();

                if (widget.isAddingReply) {
                  widget.toggleAddingReply!();
                }
              }
              if (value.isNotEmpty && widget.isAddingReply) {
                addReply(value, currentCommentId!);

                widget.replyController!.clear();

                if (widget.isAddingReply) {
                  widget.toggleAddingReply!();
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
