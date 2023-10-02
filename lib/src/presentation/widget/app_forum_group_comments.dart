import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_comment.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/post_detail/cubit/post_detail_cubit.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';

class CommentsBottomSheet extends StatefulWidget {
  final int? forumId;
  final int? postId;

  const CommentsBottomSheet({
    Key? key,
    required this.forumId,
    required this.postId,
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
    fetchComments(context);
  }

  void fetchComments(BuildContext buildContext) async {
    final comments = await context.read<PostDetailCubit>().getPostComments(
          widget.forumId,
          widget.postId,
        );

    if (mounted) {
      setState(() {
        this.comments = comments;
      });
    }
  }

  void fetchCommentsReplies(int? parentId) async {
    final comments = await context.read<PostDetailCubit>().getCommentReplies(
          widget.forumId,
          widget.postId,
          parentId,
          1,
        );

    setState(() {
      this.comments = comments;
    });
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
                return CommentWidget(comment: comments[index]);
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

  const CommentWidget({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  CommentWidgetState createState() => CommentWidgetState();
}

class CommentWidgetState extends State<CommentWidget> {
  bool showReplies = false;
  bool isAddingReply = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              (widget.comment.image == 'Keine Angabe' ||
                      widget.comment.image == "")
                  ? Application.defaultPicturesURL
                  : "${Application.picturesURL}${widget.comment.image}",
            ),
          ),
        ),
        if (showReplies && widget.comment.replies != null)
          Column(
            children: [
              const Divider(),
              for (final reply in widget.comment.replies!)
                CommentWidget(comment: reply),
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
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
            if (!showReplies)
              TextButton(
                onPressed: () {
                  setState(() {
                    showReplies = true;
                    isAddingReply = true;
                  });
                },
                child: const Text('Add Reply', style: TextStyle(fontSize: 12)),
              ),
          ],
        ),
      ],
    );
  }
}

class CommentInputWidget extends StatefulWidget {
  final Function(CommentModel) onCommentAdded;
  final TextEditingController commentController;
  final TextEditingController replyController;
  final bool isAddingReply;
  final VoidCallback toggleAddingReply;

  const CommentInputWidget({
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
                hintText:
                    widget.isAddingReply ? 'Add a reply' : 'Add a comment',
                hintStyle: const TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: () {
              final value = widget.isAddingReply
                  ? widget.replyController.text
                  : widget.commentController.text;

              if (value.isNotEmpty) {
                final newComment = CommentModel(
                  username: 'New User',
                  comment: value,
                );
                widget.onCommentAdded(newComment);

                if (widget.isAddingReply) {
                  widget.replyController.clear();
                } else {
                  widget.commentController.clear();
                }

                if (widget.isAddingReply) {
                  widget.toggleAddingReply();
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
