import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_comment.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/post_detail/cubit/post_detail_cubit.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:loggy/loggy.dart';
import 'package:provider/provider.dart';

class CommentsBottomSheet extends StatefulWidget {
  final int? forumId;
  final int? postId;
  final List<CommentModel> comments;
  final PostDetailCubit postDetailCubit;

  const CommentsBottomSheet({
    Key? key,
    required this.forumId,
    required this.postId,
    required this.comments,
    required this.postDetailCubit,
  }) : super(key: key);

  @override
  CommentsBottomSheetState createState() => CommentsBottomSheetState();
}

class CommentsBottomSheetState extends State<CommentsBottomSheet> {
  List<CommentModel> comments = [];
  bool isAddingReply = false;

  @override
  void initState() {
    super.initState();
    comments.addAll(widget.comments);
  }

  TextEditingController commentController = TextEditingController();
  TextEditingController replyController = TextEditingController();

  void toggleAddingReply() {
    setState(() {
      isAddingReply = !isAddingReply;
      if (!isAddingReply) {
        replyController.clear();
      }
    });
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
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return Provider(
                  create: (BuildContext context) {},
                  child: CommentWidget(
                    comment: comments[index],
                    postDetailCubit: widget.postDetailCubit,
                  ),
                );
              },
            ),
          ),
          CommentInputWidget(
            onCommentAdded: (comment) {
              setState(() {
                comments.insert(0, comment);
              });
            },
            commentController: commentController,
            replyController: replyController,
            isAddingReply: isAddingReply,
            toggleAddingReply: toggleAddingReply,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class CommentWidget extends StatefulWidget {
  final CommentModel comment;
  final PostDetailCubit postDetailCubit;

  const CommentWidget({
    Key? key,
    required this.comment,
    required this.postDetailCubit,
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
          title: Text(
            widget.comment.username!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          subtitle: Text(
            widget.comment.comment!,
            style: const TextStyle(fontSize: 16),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                showReplies ? 'Hide Replies' : 'View Replies',
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(width: 16),
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
          contentPadding:
              const EdgeInsets.only(left: 40), // Indent to the right
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
  final Function(CommentModel) onCommentAdded;
  final TextEditingController? commentController;
  final TextEditingController? replyController;
  final bool isAddingReply;
  final VoidCallback? toggleAddingReply;

  CommentInputWidget({
    Key? key,
    required this.onCommentAdded,
    required this.commentController,
    required this.replyController,
    required this.isAddingReply,
    required this.toggleAddingReply,
  }) : super(key: key);

  @override
  CommentInputWidgetState createState() => CommentInputWidgetState();
}

class CommentInputWidgetState extends State<CommentInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo.png'),
          ),
          const SizedBox(width: 16),
          Expanded(
              child: TextField(
            controller: widget.isAddingReply
                ? widget.replyController
                : widget.commentController,
            enabled: !widget.isAddingReply,
            decoration: InputDecoration(
              hintText: widget.isAddingReply ? 'Add a reply' : 'Add a comment',
              hintStyle: const TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
          )),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: () {
              final value = widget.isAddingReply
                  ? widget.replyController!.text
                  : widget.commentController!.text;

              if (value.isNotEmpty) {
                final newComment = CommentModel(
                  username: 'New User',
                  comment: value,
                );
                widget.onCommentAdded(newComment);

                if (widget.isAddingReply) {
                  widget.replyController!.clear();
                } else {
                  widget.commentController!.clear();
                }

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
