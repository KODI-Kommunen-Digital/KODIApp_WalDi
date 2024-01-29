import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_result_api.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/post_detail/cubit/post_detail_cubit.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/translate.dart';

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
  final String? userImage;

  const CommentInputWidget({
    Key? key,
    required this.forumId,
    required this.postId,
    required this.commentController,
    required this.replyController,
    required this.isAddingReply,
    required this.toggleAddingReply,
    required this.userProfileImage,
    required this.userImage,
    required this.postDetailCubit,
    this.onCommentAdded,
  }) : super(key: key);

  @override
  CommentInputWidgetState createState() => CommentInputWidgetState();
}

class CommentInputWidgetState extends State<CommentInputWidget> {
  @override
  void initState() {
    super.initState();
  }

  void resetInput() {
    setState(() {
      widget.toggleAddingReply?.call();
      widget.commentController?.clear();
    });
  }

  Future<ResultApiModel> addComment(String value) async {
    final comment = value;
    final response = await widget.postDetailCubit
        .addPostComments(widget.forumId, widget.postId, comment);
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
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              (widget.userImage == "" || widget.userImage == "Keine Angabe")
                  ? Application.defaultPicturesURL
                  : "${Application.picturesURL}${widget.userImage}",
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: widget.isAddingReply
                  ? widget.replyController
                  : widget.commentController,
              decoration: InputDecoration(
                hintText: widget.isAddingReply
                    ? Translate.of(context).translate('add_reply')
                    : Translate.of(context).translate('add_comment'),
                hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.white),
                border: InputBorder.none,
              ),
            ),
          ),
          if (widget.isAddingReply)
            IconButton(
              icon: Icon(Icons.clear,
                  color: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.white),
              onPressed: resetInput,
            ),
          IconButton(
            icon: Icon(Icons.send,
                color: Theme.of(context).textTheme.bodyLarge?.color ??
                    Colors.white),
            onPressed: () async {
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
                final prefs = await Preferences.openBox();
                final commentId = prefs.getKeyValue(Preferences.commentId, 0);
                addReply(value, commentId!);
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
